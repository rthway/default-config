SELECT 
    first_answers.category AS 'Category',
    first_answers.answer_name AS 'Diseases',
    COUNT(first_concept.person_id) AS 'Total Patient'
FROM
    (SELECT 
        ca.answer_concept AS answer,
        IFNULL(answer_concept_short_name.name, answer_concept_fully_specified_name.name) AS answer_name,
        question_concept_name.name AS category
    FROM
        concept c
    INNER JOIN concept_datatype cd ON c.datatype_id = cd.concept_datatype_id
    INNER JOIN concept_name question_concept_name ON c.concept_id = question_concept_name.concept_id
        AND question_concept_name.concept_name_type = 'FULLY_SPECIFIED'
        AND question_concept_name.voided IS FALSE
    INNER JOIN concept_answer ca ON c.concept_id = ca.concept_id
    INNER JOIN concept_name answer_concept_fully_specified_name ON ca.answer_concept = answer_concept_fully_specified_name.concept_id
        AND answer_concept_fully_specified_name.concept_name_type = 'FULLY_SPECIFIED'
        AND answer_concept_fully_specified_name.voided IS FALSE
    LEFT JOIN concept_name answer_concept_short_name ON ca.answer_concept = answer_concept_short_name.concept_id
        AND answer_concept_short_name.concept_name_type = 'SHORT'
        AND answer_concept_short_name.voided IS FALSE
    WHERE
        question_concept_name.name IN ('Childhood Illness (2-59)-ARI-Classification' , 'Childhood Illness, Dehydration Status', 'Childhood Illness, Diarrhoea present', 'Childhood Illness, Refered-Out')
        AND cd.name = 'Coded'
        AND IFNULL(answer_concept_short_name.name, answer_concept_fully_specified_name.name) NOT IN ('Not present', 'Not applicable','Diarrhea')
    ORDER BY answer_name DESC) first_answers
LEFT OUTER JOIN
    (SELECT 
        o1.person_id,
        cn2.concept_id AS answer,
        cn1.concept_id AS question
    FROM
        obs o1
    INNER JOIN concept_name cn1 ON o1.concept_id = cn1.concept_id
        AND cn1.concept_name_type = 'FULLY_SPECIFIED'
        AND cn1.name IN ('Childhood Illness (2-59)-ARI-Classification' , 'Childhood Illness, Dehydration Status', 'Childhood Illness, Diarrhoea present', 'Childhood Illness, Refered-Out')
        AND o1.voided = 0
        AND cn1.voided = 0
    INNER JOIN concept_name cn2 ON o1.value_coded = cn2.concept_id
        AND cn2.concept_name_type = 'FULLY_SPECIFIED'
        AND cn2.voided = 0
    INNER JOIN encounter e ON o1.encounter_id = e.encounter_id
    INNER JOIN person p1 ON o1.person_id = p1.person_id
    INNER JOIN visit v ON v.visit_id = e.visit_id
    WHERE
        TIMESTAMPDIFF(MONTH, p1.birthdate, v.date_started) > 1
        AND TIMESTAMPDIFF(MONTH, p1.birthdate, v.date_started) < 60
        AND DATE(e.encounter_datetime) BETWEEN DATE('#startDate#') AND DATE('#endDate#')
        AND o1.value_coded IS NOT NULL) first_concept ON first_concept.answer = first_answers.answer
GROUP BY first_answers.answer_name
ORDER BY field(first_answers.answer_name, 'Cough/Cold', 'Pneumonia', 'Severe Pneumonia', 'No Dehydration', 'Some Dehydration', 'Severe Dehydration', 'Chronic Diarrhea', 'Dysentery', 'ARI', 'Diarrhoea', 'Others');

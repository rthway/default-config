
SELECT 
    first_answers.answer_name AS 'ICD name',
    first_answers.icd10_code AS 'ICD CODE',
    IFNULL(SUM(CASE
                WHEN
                    second_concept.gender = 'F'
                        AND second_concept.person_id IS NOT NULL
                THEN
                    1
                ELSE 0
            END),
            0) AS 'FEMALE PATIENT',
    IFNULL(SUM(CASE
                WHEN
                    second_concept.gender = 'M'
                        AND second_concept.person_id IS NOT NULL
                THEN
                    1
                ELSE 0
            END),
            0) AS 'MALE PATIENT'
FROM
    (SELECT 
        concept_full_name AS answer_name, icd10_code
    FROM
        diagnosis_concept_view
    WHERE
        icd10_code IN ('H10.9','A71.9','H26','H54.0','H52.7','H40.9','H53.5','H05.2','H00.0','H00','H11.0','H36.0*','H35','H02.0','H02.1','S05.9','H44.0', 'H53.2',
'H53.9','H50.9','H35.5','H53.6','C62.9')) first_answers
        LEFT OUTER JOIN
    (SELECT DISTINCT
        (p.person_id),
            dcv.concept_full_name,
            icd10_code,
            v.visit_id AS visit_id,
            p.gender AS gender
    FROM
        person p
    INNER JOIN visit v ON p.person_id = v.patient_id
        AND v.voided = 0
    INNER JOIN encounter e ON v.visit_id = e.visit_id AND e.voided = 0
    INNER JOIN obs o ON e.encounter_id = o.encounter_id
        AND o.voided = 0
        AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id
        AND cn.concept_name_type = 'FULLY_SPECIFIED'
        AND cn.name IN ('Coded Diagnosis')
        AND o.voided = 0
        AND cn.voided = 0
     JOIN diagnosis_concept_view dcv ON dcv.concept_id = o.value_coded
        AND dcv.icd10_code IN ('H10.9','A71.9','H26','H54.0','H52.7','H40.9','H53.5','H05.2','H00.0','H00','H11.0','H36.0*','H35','H02.0','H02.1','S05.9','H44.0', 'H53.2',
'H53.9','H50.9','H35.5','H53.6','C62.9')
    WHERE
        p.voided = 0) first_concept ON first_concept.icd10_code = first_answers.icd10_code
        LEFT OUTER JOIN
    (SELECT DISTINCT
        (person.person_id) AS person_id,
            visit.visit_id AS visit_id,
            person.gender AS gender
   FROM person 
     JOIN visit  ON person_id = visit.patient_id 
     JOIN visit_type vt ON visit.visit_type_id = vt.visit_type_id AND vt.name != 'IPD'
    WHERE
        cast(visit.date_started AS DATE) BETWEEN DATE('#startDate#') AND DATE('#endDate#')) second_concept ON first_concept.person_id = second_concept.person_id
        AND first_concept.visit_id = second_concept.visit_id
GROUP BY first_answers.icd10_code
ORDER BY FIELD(first_answers.icd10_code, 'H10.9','A71.9','H26','H54.0','H52.7','H40.9','H53.5','H05.2','H00.0','H00','H11.0','H36.0*','H35','H02.0','H02.1','S05.9','H44.0', 'H53.2',
'H53.9','H50.9','H35.5','H53.6','C62.9')

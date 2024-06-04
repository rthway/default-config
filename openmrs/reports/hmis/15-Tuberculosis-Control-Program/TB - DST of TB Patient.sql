SELECT 
    first_c.case_first AS tb_cases,
    IFNULL(COUNT(DISTINCT CASE
                    WHEN cov.value_concept_full_name = 'HIVTC, Gene Expert TB assessment at enrollment' THEN p.person_id
                END),
            0) AS 'xpert MTB/RIF',
    IFNULL(COUNT(DISTINCT CASE
                    WHEN cov.value_concept_full_name IN ('Sputum Smear' , 'Sputum Culture') THEN p.person_id
                END),
            0) AS 'LPA'
FROM
    visit v
        INNER JOIN
    person p ON p.person_id = v.patient_id
        INNER JOIN
    encounter e ON e.visit_id = v.visit_id AND e.voided = 0
        INNER JOIN
    obs o ON o.encounter_id = e.encounter_id
        AND o.concept_id = (SELECT 
            concept_id
        FROM
            concept_name
        WHERE
            name = 'Tuberculosis intake note'
                AND voided = 0
                AND concept_name_type = 'FULLY_SPECIFIED')
        LEFT JOIN
    coded_obs_view cov ON cov.encounter_id = e.encounter_id
        AND cov.concept_full_name = 'Tuberculosis, Tests ordered'
        AND cov.voided = 0
        LEFT JOIN
    coded_obs_view cov1 ON cov1.encounter_id = e.encounter_id
        AND cov1.concept_full_name = 'TB intake-Diagnosis category'
        AND cov1.value_concept_full_name IN ('New Diagnosis' , 'Relapse')
        AND cov1.voided = 0
   inner join  (SELECT 'New Diagnosis' AS case_first UNION SELECT 'Relapse' AS case_first ) AS first_c on first_c.case_first = cov1.value_concept_full_name
WHERE
    DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
GROUP BY first_c.case_first
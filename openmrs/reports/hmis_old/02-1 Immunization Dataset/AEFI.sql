SELECT
    IFNULL(SUM(CASE WHEN IFNULL(final.Department, '0') IN ('ER', 'IPD') THEN 1 ELSE 0 END), 0) AS Severe,
    IFNULL(SUM(CASE WHEN IFNULL(final.Department, '0') NOT IN ('ER', 'IPD') THEN 1 ELSE 0 END), 0) AS Normal
FROM 
(
    SELECT DISTINCT
        person_id AS ID,
        vt.name AS Department
    FROM obs o 
    INNER JOIN visit v ON v.patient_id = o.person_id
    INNER JOIN visit_type vt ON v.visit_type_id = vt.visit_type_id
    INNER JOIN concept_name cn ON cn.concept_id = o.value_coded
    WHERE o.concept_id = 15 
        AND cn.name = 'Adverse event following immunization (AEFI)'
        AND cn.concept_name_type = 'FULLY_SPECIFIED'
        AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
) AS final;
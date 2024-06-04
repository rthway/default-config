SELECT
    IFNULL(SUM(CASE WHEN final.visit != 'IPD' AND final.Gender = 'F' THEN 1 ELSE 0 END), 0) AS 'Emergency Female',
    IFNULL(SUM(CASE WHEN final.visit != 'IPD' AND final.Gender = 'M' THEN 1 ELSE 0 END), 0) AS 'Emergency Male',
    IFNULL(SUM(CASE WHEN final.visit = 'IPD' AND final.Gender = 'F' THEN 1 ELSE 0 END), 0) AS 'Inpatient Female',
    IFNULL(SUM(CASE WHEN final.visit = 'IPD' AND final.Gender = 'M' THEN 1 ELSE 0 END), 0) AS 'Inpatient Male'
FROM 
    (
        SELECT
            DISTINCT(p.person_id) AS ID,
            vt.name AS 'visit',
            p.gender AS Gender
        FROM
            person p
            INNER JOIN visit v ON v.patient_id = p.person_id AND v.voided = '0'
            INNER JOIN encounter e ON e.visit_id = v.visit_id AND e.voided = '0'
            LEFT JOIN visit_type vt ON vt.visit_type_id = v.visit_type_id
            INNER JOIN obs o ON o.encounter_id = e.encounter_id AND o.voided = '0'
            INNER JOIN concept_name cn ON o.concept_id = cn.concept_id
        WHERE
            cn.name = 'Death Note' AND cn.concept_name_type = 'FULLY_SPECIFIED'
            AND DATE(e.encounter_datetime) BETWEEN '#startDate#' AND '#endDate#'
    ) AS final;

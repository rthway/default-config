SELECT
    IFNULL(COUNT(o.person_id), 0) AS 'Vaccine started on 24-59-Month'
FROM
    obs o
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id
    INNER JOIN concept_name cn1 ON o.value_coded = cn1.concept_id
WHERE
    cn.name = 'Vaccine start from 24-59 month'
    AND cn.concept_name_type = 'FULLY_SPECIFIED' 
    AND cn1.name = 'TRUE' 
    AND cn1.concept_name_type = 'FULLY_SPECIFIED'
    AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#';

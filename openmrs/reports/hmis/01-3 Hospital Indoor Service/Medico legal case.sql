
SELECT 
IFNULL(SUM(CASE WHEN final.Gender = 'M' THEN 1 ELSE 0 END),0) AS Male_count,
IFNULL(SUM(CASE WHEN final.Gender = 'F' THEN 1 ELSE 0 END),0) AS Female_count

from
(SELECT distinct(o.person_id)as ID,p.gender as Gender
FROM
    obs o
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id
    INNER JOIN concept_name cn1 ON o.value_coded = cn1.concept_id
    INNER JOIN person p ON o.person_id=p.person_id
WHERE
    cn.name = 'Medico legal Case'
    AND cn.concept_name_type = 'FULLY_SPECIFIED' 
    AND cn1.name = 'TRUE' 
    AND cn1.concept_name_type = 'FULLY_SPECIFIED'
    AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#') as final;

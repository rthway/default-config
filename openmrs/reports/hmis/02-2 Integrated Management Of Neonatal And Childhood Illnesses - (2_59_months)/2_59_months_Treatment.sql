select first_answers.answer_name  as 'Treatment_with',
ifnull(count(drug.person_id),0) as 'Count'
 from 
(SELECT 'Retinol (Vitamin A)' AS answer_name
   UNION SELECT 'Childhood Illness - Treatment - Treated with - Other Antibiotics' AS answer_name
   UNION -- select  'ORS only'  as answer_name union
 SELECT 'ORS and Zinc' AS answer_name
   UNION SELECT 'IV Fluid' AS answer_name
   UNION SELECT 'Anti-helminthes' AS answer_name
   UNION SELECT 'Amoxicillin' AS answer_name
   UNION SELECT 'Contrim' AS answer_name
   ORDER BY answer_name DESC) first_answers
left join 
(select 
n.person_id,
CASE
    WHEN n.name in  ('ORS and Zinc','ORS only') THEN "ORS and Zinc"
    else n.name
END as 'Treatment_with'
from (select o.person_id,
cn.name as 'name'
 from obs o
 inner join concept_name cn on cn.concept_id = o.value_coded  and cn.voided =0 and cn.concept_name_type =  'FULLY_SPECIFIED'
 where o.concept_id in (select concept_id from concept_name where name = 'Childhood Illness-Treatment-Treated with 2-59' and voided =0 and concept_name_type =  'FULLY_SPECIFIED' )  and date(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#' and o.value_coded is not null and o.value_coded not in (select concept_id from concept_name where name = 'Not applicable' and voided =0 and concept_name_type =  'FULLY_SPECIFIED' )  and o.voided =0 ) n ) as drug 
 on drug.Treatment_with = first_answers.answer_name
 group by drug.Treatment_with
 ORDER BY FIELD(first_answers.answer_name,'Amoxicillin','ORS and Zinc','IV Fluid','Anti-helminthes','Retinol (Vitamin A)','Childhood Illness - Treatment - Treated with - Other Antibiotics')
 
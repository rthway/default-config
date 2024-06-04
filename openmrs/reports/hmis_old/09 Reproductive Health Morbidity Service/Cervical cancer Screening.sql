 
 select 
age_grp ,
 SUM( final_data.`HIPV Screened`) as 'HIPV Screened',
 SUM( final_data.`HIPV Positive`) as 'HIPV Positive',
 SUM( final_data.`VIA Screened`) as 'VIA Screened',
 SUM( final_data.`VIA Positive`) as 'VIA Positive',
 SUM( final_data.`PAP Screened`) as 'PAP Screened',
 SUM( final_data.`PAP Positive`) as 'PAP Positive'
 from
 
 (
select 

(
    CASE 
        WHEN age >=30 && age <=49 THEN '30-49'
        WHEN age >=50 THEN '50+'
        ELSE 'Other'
    END) AS age_grp,
    age  ,
SUM(IF((hipv = 'RHCC - Screened'), 1, 0)) AS 'HIPV Screened',
SUM(IF((hipv = 'RHCC - Positive'), 1, 0)) AS 'HIPV Positive',
SUM(IF((via = 'RHCC - Screened'), 1, 0)) AS 'VIA Screened',
SUM(IF((via = 'RHCC - Positive'), 1, 0)) AS 'VIA Positive',
SUM(IF((pap = 'RHCC - Screened'), 1, 0)) AS 'PAP Screened',
SUM(IF((pap = 'RHCC - Positive'), 1, 0)) AS 'PAP Positive'
 from

(
SELECT 
 DISTINCT
  TIMESTAMPDIFF(YEAR, p.birthdate, v.date_started) AS age,
 oAdtType.answer_full_name AS hipv,
 oAnsdtType.answer_full_name AS via ,
 oAnsdtTypePap.answer_full_name AS pap 
  FROM 
(
person p 
JOIN visit v ON p.person_id = v.patient_id  and p.gender = 'F'
JOIN encounter e ON v.visit_id = e.visit_id
JOIN nonVoidedQuestionAnswerObs oAdtType ON e.encounter_id = oAdtType.encounter_id
)
 left join nonVoidedQuestionAnswerObs oAnsdtType 
 on  oAnsdtType.question_full_name IN ('RHCC - VIA')
 and  e.encounter_id = oAnsdtType.encounter_id 
 
 left join nonVoidedQuestionAnswerObs oAnsdtTypePap 
 on  oAnsdtTypePap.question_full_name IN ('RHCC - Pap smear & other')
 and  e.encounter_id = oAnsdtTypePap.encounter_id 
WHERE
! p.voided AND ! v.voided AND ! e.voided
AND DATE(oAdtType.obs_datetime) BETWEEN '#startDate#' AND '#endDate#' 
AND oAdtType.question_full_name IN ('RHCC - HIPV DNA')  

Union Select '32',0,0,0
Union Select '55',0,0,0
Union Select '20',0,0,0
) raw_data

group by raw_data.age
order by raw_data.age 
 ) final_data
 
 group by final_data.age_grp
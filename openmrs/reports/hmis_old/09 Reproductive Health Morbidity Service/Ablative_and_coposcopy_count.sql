SELECT  
IFNULL(SUM(IF((oAdtType.answer_full_name = 'TRUE'), 1, 0)),0) AS 'ablative',
IFNULL(SUM(IF((oAnsdtType.answer_full_name = 'TRUE'), 1, 0)),0) AS 'colposcopy'
  FROM 
(
person p 
JOIN visit v ON p.person_id = v.patient_id  and p.gender = 'F'
JOIN encounter e ON v.visit_id = e.visit_id
JOIN nonVoidedQuestionAnswerObs oAdtType ON e.encounter_id = oAdtType.encounter_id
)
 left join nonVoidedQuestionAnswerObs oAnsdtType 
 on  oAnsdtType.question_full_name IN ('RHCC - Colposcopy')
 and  e.encounter_id = oAnsdtType.encounter_id  
WHERE
! p.voided AND ! v.voided AND ! e.voided
AND DATE(oAdtType.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
AND oAdtType.question_full_name IN ('RHCC - Ablative treatment')  
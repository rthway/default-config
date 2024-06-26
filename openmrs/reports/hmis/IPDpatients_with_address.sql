SELECT
  COALESCE(pn.given_name, pn.family_name) as 'Name',
  pi.identifier as 'Patient Identifier',
  person.birthdate as 'DOB',
  person.gender as 'Gender',
  pa.city_village as 'Village',
  pa.county_district as 'District',
  va.value_reference AS visit_status,
  visit.date_started AS 'Visit Start Date'


FROM visit
  INNER JOIN patient ON visit.patient_id = patient.patient_id AND
                        DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                        AND patient.voided = 0 AND visit.voided = 0
  INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
  INNER JOIN person_name pn
    ON pn.person_id = person.person_id
  INNER JOIN person_address pa
    ON pa.person_id = person.person_id
  INNER JOIN patient_identifier pi
    ON pi.patient_id = person.person_id
  INNER JOIN visit_attribute va
    ON visit.visit_id = va.visit_id
       AND va.value_reference = 'IPD'
  LEFT JOIN person_attribute ON pn.person_id = person_attribute.person_id
  INNER JOIN person_attribute_type ON person_attribute.person_attribute_type_id = person_attribute_type.person_attribute_type_id
                                      AND person_attribute_type.name = 'Caste'
  LEFT JOIN visit_attribute_type vat ON vat.visit_attribute_type_id = va.attribute_type_id
                                        AND vat.name = 'Visit Status'
  LEFT JOIN confirmed_diagnosis_view_new AS visit_diagnosis ON visit.visit_id = visit_diagnosis.visit_id
  GROUP BY visit.visit_id
 ORDER BY visit.date_started ASC;

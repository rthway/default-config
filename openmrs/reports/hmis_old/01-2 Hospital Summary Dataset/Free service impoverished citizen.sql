SELECT
    -- Heart 
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Congenital malformation of heart, unspecified", "Malignant neoplasm of heart, mediastinum and pleura", "Rheumatic fever without mention of heart involvement", "Acute rheumatic heart disease, unspecified", "Rheumatic heart disease, unspecified", "Hypertensive heart disease with (congestive) heart failure", "Hypertensive heart and renal disease, unspecified", "Acute ischaemic heart disease, unspecified", "Chronic ischaemic heart disease, unspecified", "Pulmonary heart disease, unspecified", "Heart failure", "Complications and ill-defined descriptions of heart disease", "Heartburn", "Injury of heart, unspecified", "Congestive heart failure") AND result.gender = 'F', 1, 0))) AS 'Heart Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Congenital malformation of heart, unspecified", "Malignant neoplasm of heart, mediastinum and pleura", "Rheumatic fever without mention of heart involvement", "Acute rheumatic heart disease, unspecified", "Rheumatic heart disease, unspecified", "Hypertensive heart disease with (congestive) heart failure", "Hypertensive heart and renal disease, unspecified", "Acute ischaemic heart disease, unspecified", "Chronic ischaemic heart disease, unspecified", "Pulmonary heart disease, unspecified", "Heart failure", "Complications and ill-defined descriptions of heart disease", "Heartburn", "Injury of heart, unspecified", "Congestive heart failure") AND result.gender = 'M', 1, 0))) AS 'Heart Patient-Male',
    -- Kidney
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Calculus of kidney (Renal stone)", "Malignant neoplasm of kidney, except renal pelvis", "Secondary malignant neoplasm of kidney and renal pelvis", "Unspecified contracted kidney", "Small kidney of unknown cause", "Other disorders of kidney and ureter, not elsewhere classified", "Renal agenesis and other reduction defects of kidney", "Cystic kidney disease", "Other congenital malformations of kidney", "Injury of kidney") AND result.gender = 'F', 1, 0))) AS 'Kidney Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Calculus of kidney (Renal stone)", "Malignant neoplasm of kidney, except renal pelvis", "Secondary malignant neoplasm of kidney and renal pelvis", "Unspecified contracted kidney", "Small kidney of unknown cause", "Other disorders of kidney and ureter, not elsewhere classified", "Renal agenesis and other reduction defects of kidney", "Cystic kidney disease", "Other congenital malformations of kidney", "Injury of kidney") AND result.gender = 'M', 1, 0))) AS 'Kidney Patient-Male',
    -- cancer 
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Colorectal cancer", "Liver Cancer", "Bone / Bone Marrow Cancer") AND result.gender = 'F', 1, 0))) AS 'Cancer Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Colorectal cancer", "Liver Cancer", "Bone / Bone Marrow Cancer") AND result.gender = 'M', 1, 0))) AS 'Cancer Patient-Male',
    -- Head Injury    
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Head Injury", "Injury of muscle and tendon of long head of biceps", "Burn and corrosion of head and neck") AND result.gender = 'F', 1, 0))) AS 'Head Injury Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Head Injury", "Injury of muscle and tendon of long head of biceps", "Burn and corrosion of head and neck") AND result.gender = 'M', 1, 0))) AS 'Head Injury Patient-Male',
    -- Spinal Injury 
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Injury of spinal cord, level unspecified", "Injury of unspecified nerve, spinal nerve root and plexus of trunk") AND result.gender = 'F', 1, 0))) AS 'Spinal Injury Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Injury of spinal cord, level unspecified", "Injury of unspecified nerve, spinal nerve root and plexus of trunk") AND result.gender = 'M', 1, 0))) AS 'Spinal Injury Patient-Male',
    -- Alzheimer 
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Alzheimer disease", "Dementia in Alzheimer disease, unspecified (G30.9†)", "Alzheimers disease") AND result.gender = 'F', 1, 0))) AS 'Alzheimer Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Alzheimer disease", "Dementia in Alzheimer disease, unspecified (G30.9†)", "Alzheimers disease") AND result.gender = 'M', 1, 0))) AS 'Alzheimer Patient-Male',
    -- Parkinson 
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Parkinson's disease", "Dementia in Parkinson disease (G20†)", "Secondary parkinsonism", "Poisoning by antiepileptic, sedative-hypnotic and antiparkinsonism drugs", "Accidental poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Intentional self-poisoning by and exposure to nonopioid analgesics, antipyretics and antirheumatics", "Intentional self-poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified, undetermined intent", "Antiepileptics and antiparkinsonism drugs") AND result.gender = 'F', 1, 0))) AS 'Parkinson Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Parkinson's disease", "Dementia in Parkinson disease (G20†)", "Secondary parkinsonism", "Poisoning by antiepileptic, sedative-hypnotic and antiparkinsonism drugs", "Accidental poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Intentional self-poisoning by and exposure to nonopioid analgesics, antipyretics and antirheumatics", "Intentional self-poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified, undetermined intent", "Antiepileptics and antiparkinsonism drugs") AND result.gender = 'M', 1, 0))) AS 'Parkinson Patient-Male',
    -- Sickle Cell Anaemia     
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Sickle-cell anaemia with crisis", "Sickle-cell anaemia without crisis") AND result.gender = 'F', 1, 0))) AS 'Sickle Cell Anaemia Patient-Female',
    IF(result.person_id IS NULL, 0, SUM(IF(result.diag IN ("Sickle-cell anaemia with crisis", "Sickle-cell anaemia without crisis") AND result.gender = 'M', 1, 0))) AS 'Sickle Cell Anaemia Patient-Male'
FROM
    (SELECT DISTINCT
        p.person_id,
        p.gender,
        o.value_coded,
        (SELECT name FROM concept_name WHERE concept_id = o.value_coded AND o.voided IS FALSE AND concept_name_type = 'FULLY_SPECIFIED' AND voided = '0') AS Diag
    FROM
        person p
    INNER JOIN
        patient_identifier pi ON p.person_id = pi.patient_id
        AND pi.identifier != 'BAH200052'
        AND pi.voided = '0'
    INNER JOIN
        visit v ON v.patient_id = p.person_id
    INNER JOIN
        obs o ON o.person_id = p.person_id
        AND o.voided = '0'
        AND o.concept_id = '15'
    INNER JOIN
        concept_name cn ON cn.concept_id = o.value_coded
    WHERE
        p.voided = '0'
        AND cn.name IN ("Alzheimer disease", "Head Injury", "Calculus of kidney (Renal stone)", "Parkinson's disease", "Congenital malformation of heart, unspecified", "Malignant neoplasm of heart, mediastinum and pleura", "Malignant neoplasm of kidney, except renal pelvis", "Secondary malignant neoplasm of kidney and renal pelvis", "Sickle-cell anaemia with crisis", "Sickle-cell anaemia without crisis", "Dementia in Alzheimer disease, unspecified (G30.9†)", "Dementia in Parkinson disease (G20†)", "Secondary parkinsonism", "Alzheimers disease", "Rheumatic fever without mention of heart involvement", "Acute rheumatic heart disease, unspecified", "Rheumatic heart disease, unspecified", "Hypertensive heart disease with (congestive) heart failure", "Hypertensive heart and renal disease, unspecified", "Acute ischaemic heart disease, unspecified", "Chronic ischaemic heart disease, unspecified", "Pulmonary heart disease, unspecified", "Heart failure", "Complications and ill-defined descriptions of heart disease", "Unspecified contracted kidney", "Small kidney of unknown cause", "Other disorders of kidney and ureter, not elsewhere classified", "Renal agenesis and other reduction defects of kidney", "Cystic kidney disease", "Other congenital malformations of kidney", "Heartburn", "Injury of heart, unspecified", "Injury of kidney", "Injury of muscle and tendon of long head of biceps", "Injury of spinal cord, level unspecified", "Injury of unspecified nerve, spinal nerve root and plexus of trunk", "Burn and corrosion of head and neck", "Poisoning by antiepileptic, sedative-hypnotic and antiparkinsonism drugs", "Accidental poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Intentional self-poisoning by and exposure to nonopioid analgesics, antipyretics and antirheumatics", "Intentional self-poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified", "Poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkinsonism and psychotropic drugs, not elsewhere classified, undetermined intent", "Antiepileptics and antiparkinsonism drugs", "Congestive heart failure", "Colorectal cancer", "Liver Cancer", "Bone / Bone Marrow Cancer")
        AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#') AS result
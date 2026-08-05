use hospital_admin;

CREATE TABLE nhis_claims (
    claim_id VARCHAR(15) PRIMARY KEY,
    hospital_name VARCHAR(100),
    geopolitical_zone VARCHAR(50),
    diagnosis VARCHAR(100),
    billed_amount_naira INT,
    nhis_payout_naira INT,
    claim_status VARCHAR(30),
    rejection_reason VARCHAR(100),
    submission_date DATE
);


SELECT 
    hospital_name,
    geopolitical_zone,
    COUNT(claim_id) AS total_claims_submitted,
    SUM(CASE WHEN claim_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_claims_count,
    SUM(CASE WHEN claim_status = 'Rejected' THEN billed_amount_naira ELSE 0 END) AS total_lost_value_naira
FROM nhis_claims
GROUP BY hospital_name, geopolitical_zone
ORDER BY total_lost_value_naira DESC;

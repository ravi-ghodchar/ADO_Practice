CREATE OR REPLACE PROCEDURE `spartan-buckeye-415104.output.ExtractAndProcessDataFromRemainingTables`()
BEGIN
  CREATE OR REPLACE TABLE output.CandidateContributions AS
  SELECT 
    cm.CAND_ID,
    cm.CAND_NAME,
    COUNT(*) AS NumContributions,
    SUM(cc.TRANSACTION_AMT) AS TotalContributionAmount
  FROM 
    Task2.Contribution_individuals cc
  JOIN 
    Task2.Candidate_master cm ON cc.NAME = cm.CAND_NAME -- Assuming we can link by candidate name
  GROUP BY 
    cm.CAND_ID,
    cm.CAND_NAME;

  CREATE OR REPLACE TABLE output.PACSummary AS
  SELECT 
    ps.CMTE_ID,
    ps.CMTE_NM,
    COUNT(*) AS NumTransactions,
    SUM(ps.TTL_RECEIPTS) AS TotalReceipts,
    SUM(ps.TTL_DISB) AS TotalDisbursements
  FROM 
    Task2.PAC_summary ps
  GROUP BY 
    ps.CMTE_ID,
    ps.CMTE_NM;
END;


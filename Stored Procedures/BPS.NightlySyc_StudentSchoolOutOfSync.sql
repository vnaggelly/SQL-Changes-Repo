SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:  Vijay.N 
-- Create date: 12/18/2017  
-- Description: Sync All those student school records out of sync with SIS
-- =============================================  

CREATE  PROCEDURE [BPS].[NightlySyc_StudentSchoolOutOfSync]
AS
BEGIN
SET NOCOUNT ON;


UPDATE BPS.Student
SET stdScaIdCurrent = scaId,
    STD_LastUpdate = GETDATE()
FROM
(  
    SELECT STD_ID_LOCAL COLLATE DATABASE_DEFAULT AS STD_ID_LOCAL,  
          ISNULL(TransferSchool.SKL_SCHOOL_ID,CurrentSchool.SKL_SCHOOL_ID) COLLATE DATABASE_DEFAULT AS BPSstudent_SCH 
    FROM ASPENDB.x2data.dbo.STUDENT  
        LEFT JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY CurrentCap  
            ON CurrentCap.SCA_OID = STD_SCA_OID  
        LEFT JOIN ASPENDB.x2data.dbo.SCHOOL CurrentSchool  
            ON CurrentSchool.SKL_OID = CurrentCap.SCA_SKL_OID 
        LEFT JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY TransferCap  
            ON TransferCap.SCA_OID = STD_SCA_OID_TRANSFER 
       LEFT  JOIN ASPENDB.x2data.dbo.SCHOOL TransferSchool  
            ON TransferSchool.SKL_OID = TransferCap.SCA_SKL_OID  			 
    WHERE STD_ENROLLMENT_STATUS IN ( 'Active', 'Registered' )
	AND ISNULL(TransferSchool.SKL_SCHOOL_ID,ISNULL(CurrentSchool.SKL_SCHOOL_ID,''))  <>'' 
    EXCEPT  
    SELECT STD_LocalID,  
           CurrentCap.scaSchId SchoolCurrent
    FROM BPS.Student  
        JOIN Eligibility.SchoolCapacity CurrentCap  
            ON CurrentCap.scaId = Student.stdScaIdCurrent  
    WHERE STD_Type IN ( 'Active', 'Registered' )  
) p  
JOIN BPS.Student  ON STD_LocalID = p.STD_ID_LOCAL 
JOIN ASPENDB.x2data.dbo.STUDENT s ON s.STD_ID_LOCAL = p.STD_ID_LOCAL  
LEFT JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY CurrentCap    ON CurrentCap.SCA_OID = STD_SCA_OID  
LEFT JOIN ASPENDB.x2data.dbo.SCHOOL CurrentSchool  ON CurrentSchool.SKL_OID = CurrentCap.SCA_SKL_OID 
LEFT JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY TransferCap ON TransferCap.SCA_OID = STD_SCA_OID_TRANSFER 
LEFT  JOIN ASPENDB.x2data.dbo.SCHOOL TransferSchool ON TransferSchool.SKL_OID = TransferCap.SCA_SKL_OID  
JOIN ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT ON CTX_OID = ISNULL(TransferCap.SCA_CTX_OID,CurrentCap.SCA_CTX_OID)   
JOIN Eligibility.SchoolCapacity e ON scaYearContext = CTX_CONTEXT_ID COLLATE DATABASE_DEFAULT  
							AND scaSchId = ISNULL(TransferSchool.SKL_SCHOOL_ID,CurrentSchool.SKL_SCHOOL_ID)  COLLATE DATABASE_DEFAULT  
							AND scaGradeLevel = ISNULL(TransferCap.SCA_GRADE_LEVEL,CurrentCap.SCA_GRADE_LEVEL) COLLATE DATABASE_DEFAULT  
							AND scaProgramId = ISNULL(TransferCap.SCA_PROGRAM_CODE,CurrentCap.SCA_PROGRAM_CODE) COLLATE DATABASE_DEFAULT  
WHERE ISNULL(TransferSchool.SKL_SCHOOL_ID,ISNULL(CurrentSchool.SKL_SCHOOL_ID,''))  <>'' 




------------------------------------------- still needed modification as there are few cases where below logic getting failed
--UPDATE BPS.Student
--SET STD_Type = 'Deleted',
--    STD_LastUpdate = GETDATE()
--FROM 
--(
-- SELECT STD_LocalID,
--           CurrentCap.scaSchId SchoolCurrent
--    FROM BPS.Student
--        JOIN Eligibility.SchoolCapacity CurrentCap
--            ON CurrentCap.scaId = Student.stdScaIdCurrent
--    WHERE STD_Type IN ( 'Active', 'Registered' )
--    EXCEPT
--    SELECT STD_ID_LOCAL COLLATE DATABASE_DEFAULT,
--           CurrentSchool.SKL_SCHOOL_ID COLLATE DATABASE_DEFAULT AS BPSstudent_SCH
--    FROM ASPENDB.x2data.dbo.STUDENT
--        LEFT JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY CurrentCap
--            ON CurrentCap.SCA_OID = STD_SCA_OID
--        JOIN ASPENDB.x2data.dbo.SCHOOL CurrentSchool
--            ON CurrentSchool.SKL_OID = CurrentCap.SCA_SKL_OID
--    WHERE STD_ENROLLMENT_STATUS IN ( 'Active', 'Registered' )

--)A
--JOIN BPS.Student S ON S.STD_LocalID = A.STD_LocalID;


END;

GO

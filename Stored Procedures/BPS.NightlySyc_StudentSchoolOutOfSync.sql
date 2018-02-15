SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================  
-- Author:  Vijay.N 
-- Create date: 12/18/2017  
-- Description: Sync All those student school records out of sync with SIS
-- =============================================  

CREATE PROCEDURE [BPS].[NightlySyc_StudentSchoolOutOfSync]
AS
BEGIN
    SET NOCOUNT ON;


    UPDATE BPS.Student
    SET stdScaIdCurrent = scaId,
        STD_LastUpdate = GETDATE()
    FROM
    (
        SELECT STD_ID_LOCAL COLLATE DATABASE_DEFAULT AS STD_ID_LOCAL,
               CurrentSchool.SKL_SCHOOL_ID COLLATE DATABASE_DEFAULT AS BPSstudent_SCH
        FROM ASPENDB.x2data.dbo.STUDENT
            INNER JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY CurrentCap
                ON CurrentCap.SCA_OID = ISNULL(STD_SCA_OID_TRANSFER, STD_SCA_OID)
            INNER JOIN ASPENDB.x2data.dbo.SCHOOL CurrentSchool
                ON CurrentSchool.SKL_OID = CurrentCap.SCA_SKL_OID
        WHERE STD_ENROLLMENT_STATUS IN ( 'Active', 'Registered' )
              AND ISNULL(CurrentSchool.SKL_SCHOOL_ID, '') <> ''
        EXCEPT
        SELECT STD_LocalID,
               CurrentCap.scaSchId SchoolCurrent
        FROM BPS.Student
            INNER JOIN Eligibility.SchoolCapacity CurrentCap
                ON CurrentCap.scaId = Student.stdScaIdCurrent
        WHERE STD_Type IN ( 'Active', 'Registered' )
    ) p
        INNER JOIN BPS.Student
            ON STD_LocalID = p.STD_ID_LOCAL
        INNER JOIN ASPENDB.x2data.dbo.STUDENT s
            ON s.STD_ID_LOCAL = p.STD_ID_LOCAL
        INNER JOIN ASPENDB.x2data.dbo.SCHOOL_CAPACITY CurrentCap
            ON CurrentCap.SCA_OID = ISNULL(STD_SCA_OID_TRANSFER, STD_SCA_OID)
        INNER JOIN ASPENDB.x2data.dbo.SCHOOL CurrentSchool
            ON CurrentSchool.SKL_OID = CurrentCap.SCA_SKL_OID
        INNER JOIN ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT
            ON CTX_OID = CurrentCap.SCA_CTX_OID
        INNER JOIN Eligibility.SchoolCapacity e
            ON scaYearContext = CTX_CONTEXT_ID COLLATE DATABASE_DEFAULT
               AND scaSchId = CurrentSchool.SKL_SCHOOL_ID COLLATE DATABASE_DEFAULT
               AND scaGradeLevel = CurrentCap.SCA_GRADE_LEVEL COLLATE DATABASE_DEFAULT
               AND scaProgramId = CurrentCap.SCA_PROGRAM_CODE COLLATE DATABASE_DEFAULT
    WHERE ISNULL(CurrentSchool.SKL_SCHOOL_ID, '') <> '';



-- Query To update student exsited in BPSInterface and not in Aspen


    UPDATE S
    SET STD_Type = 'Deleted',
        STD_LastUpdate = GETDATE()
    FROM
    (
        SELECT STD_LocalID
        FROM BPS.Student
        WHERE STD_Type IN ( 'Active', 'Registered' )
        EXCEPT
        SELECT STD_ID_LOCAL COLLATE DATABASE_DEFAULT
        FROM ASPENDB.x2data.dbo.STUDENT
        WHERE STD_ENROLLMENT_STATUS IN ( 'Active', 'Registered' )
    ) A
        JOIN BPS.Student S
            ON S.STD_LocalID = A.STD_LocalID;


END;

GO

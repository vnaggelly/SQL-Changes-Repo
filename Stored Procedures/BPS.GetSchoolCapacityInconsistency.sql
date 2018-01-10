SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*-- ====================================================================================
-- Author:		P Bryce Avery
-- Create date: 12/5/2016
-- Description:	Check BPS.SchoolCapacity against Aspen's SCHOOL_CAPACITY for inconsistencies

ModifiedBY   ModifiedOn    description
Vijay.N     2018-01-09    added scaYearContext in where clause and modified 
                          (ac.SCA_GRADE_LEVEL,10) as datatype size got modified

-- ======================================================================================*/
CREATE PROCEDURE [BPS].[GetSchoolCapacityInconsistency]
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  scaYearContext ,
                scaSchId ,
                scaGradeLevel ,
                scaProgramId ,
				'BPS Interface' AS InconsistencyIn
        FROM    Eligibility.SchoolCapacity
                LEFT JOIN ( SELECT  SCA_OID ,
                                    CTX_CONTEXT_ID ,
                                    SKL_SCHOOL_ID ,
                                    SCA_GRADE_LEVEL ,
                                    SCA_PROGRAM_CODE
                            FROM    ASPENDB.x2data.dbo.SCHOOL_CAPACITY
                                    JOIN ASPENDB.x2data.dbo.SCHOOL ON SKL_OID = SCA_SKL_OID
                                    JOIN ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT ON CTX_OID = SCA_CTX_OID
                                                              AND CTX_SCHOOL_YEAR > 2015
                          ) ac ON LTRIM(RTRIM(ac.CTX_CONTEXT_ID)) = LTRIM(RTRIM(scaYearContext)) COLLATE DATABASE_DEFAULT
                                  AND ac.SKL_SCHOOL_ID = scaSchId COLLATE DATABASE_DEFAULT
                                  AND LEFT(ac.SCA_GRADE_LEVEL,10) = scaGradeLevel COLLATE DATABASE_DEFAULT
                                  AND ac.SCA_PROGRAM_CODE = scaProgramId COLLATE DATABASE_DEFAULT
		WHERE ac.SCA_OID IS NULL
		AND LTRIM(RTRIM(scaYearContext))>='2017-2018'
        UNION
        SELECT  CTX_CONTEXT_ID  COLLATE DATABASE_DEFAULT ,
                SKL_SCHOOL_ID  COLLATE DATABASE_DEFAULT ,
                SCA_GRADE_LEVEL  COLLATE DATABASE_DEFAULT ,
                SCA_PROGRAM_CODE  COLLATE DATABASE_DEFAULT ,
				'SIS' AS InconsistencyIn
        FROM    ( SELECT    CTX_OID ,
                            CTX_CONTEXT_ID ,
                            SKL_SCHOOL_ID ,
                            SCA_GRADE_LEVEL ,
                            SCA_PROGRAM_CODE
                  FROM      ASPENDB.x2data.dbo.SCHOOL_CAPACITY
                            JOIN ASPENDB.x2data.dbo.SCHOOL ON SKL_OID = SCA_SKL_OID
                            JOIN ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT ON CTX_OID = SCA_CTX_OID
                                                              AND CTX_SCHOOL_YEAR > 2015
                ) ac
                LEFT JOIN Eligibility.SchoolCapacity ON LTRIM(RTRIM(ac.CTX_CONTEXT_ID)) = LTRIM(RTRIM(scaYearContext)) COLLATE DATABASE_DEFAULT
                                                        AND scaSchId = ac.SKL_SCHOOL_ID COLLATE DATABASE_DEFAULT
                                                        AND scaGradeLevel = LEFT(ac.SCA_GRADE_LEVEL, 10) COLLATE DATABASE_DEFAULT
                                                        AND scaProgramId = ac.SCA_PROGRAM_CODE COLLATE DATABASE_DEFAULT
        WHERE   scaId IS NULL
	   AND LTRIM(RTRIM(ac.CTX_CONTEXT_ID))>='2017-2018'
    END;
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		P Bryce Avery
-- Create date: 2017-08-09
-- Description:	Inserts or updates StudentTransportationEligibility
-- Modified on: 2017-12-28
-- Modified by: Vijay Nagelly & Tim Reed
-- Description: added ls.STD_LastUpdate > '1991-01-01' to ON ls.STD_LocalID = STD_ID_LOCAL COLLATE DATABASE_DEFAULT AND ls.STD_LastUpdate > '1991-01-01'
--              this was to deal with duplicate records that created outside the normal web service process, and which were causing the procedure to fail
-- =============================================
CREATE PROCEDURE [Transportation].[MergeStudentTransportationEligibility]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO Transportation.StudentTransportationEligibility WITH (HOLDLOCK) AS target
    USING
    (
        SELECT STR_OID,
               CAST(CASE
                        WHEN STR_END_DATE IS NULL THEN
                            1
                        ELSE
                            0
                    END AS BIT) stiisCurrent,
               CTX_CONTEXT_ID stiAcademicYearDesignator,
               STD_ID_LOCAL stiStudentLocalId,
               CASE
                   WHEN ls.stdId IS NOT NULL THEN
                       ls.stdId
                   ELSE
                       42
               END stdId,
               SKL_SCHOOL_ID stiSchoolLocalId,
               CAST(CASE
                        WHEN ISNUMERIC(STR_FIELDA_017) = 1 THEN
                            STR_FIELDA_017
                        ELSE
                            NULL
                    END AS INT) steAddressId,
               STR_FIELDB_008 steWalkDistance,
               STR_FIELDA_006 stiStudentTransportationEligibility,
               CASE
                   WHEN NULLIF(STR_FIELDB_004, '') IS NOT NULL THEN
                       STR_FIELDB_004
                   ELSE
                       'BPS'
               END steProvider,
               CAST(STR_START_DATE AS DATE) stdStudentTransportationEligiblityStartDate,
               CAST(STR_END_DATE AS DATE) stdStudentTransportationEligiblityEndDate
        FROM ASPENDB.x2data.dbo.STUDENT_TRANSPORTATION
            JOIN ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT
                ON CTX_OID = STR_CTX_OID
            JOIN ASPENDB.x2data.dbo.STUDENT
                ON STD_OID = STR_STD_OID
            LEFT JOIN BPS.Student ls
                ON ls.STD_LocalID = STD_ID_LOCAL COLLATE DATABASE_DEFAULT AND ls.STD_LastUpdate > '1991-01-01'
            JOIN ASPENDB.x2data.dbo.SCHOOL
                ON SKL_OID = STR_SKL_OID
    ) AS source
    ON
	(
		target.steSourceId = source.STR_OID
		--AND target.steStudentLocalId = source.stiStudentLocalId COLLATE DATABASE_DEFAULT
	)
    WHEN NOT MATCHED BY SOURCE THEN
        UPDATE SET target.steisCurrent = 0,
                   target.steEligiblityEndDate = GETDATE(),
                   target.steLastUpdated = GETDATE()
    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            steisCurrent,
            steSourceId,
            steStdId,
            steAcademicYearDesignator,
            steStudentLocalId,
            steSchoolLocalId,
            steAddressId,
            steWalkDistance,
            steEligibility,
            steEligiblityStartDate,
            steEligiblityEndDate
        )
        VALUES
        (stiisCurrent,
         source.STR_OID,
         stdId,
         stiAcademicYearDesignator,
         stiStudentLocalId,
         stiSchoolLocalId,
         steAddressId,
         steWalkDistance,
         stiStudentTransportationEligibility,
         stdStudentTransportationEligiblityStartDate,
         stdStudentTransportationEligiblityEndDate
        )
    WHEN MATCHED AND (
                         NOT target.steisCurrent = source.stiisCurrent
                         OR NOT target.steStdId = source.stdId
                         OR NOT target.steAcademicYearDesignator = source.stiAcademicYearDesignator COLLATE DATABASE_DEFAULT
                         OR NOT target.steStudentLocalId = source.stiStudentLocalId COLLATE DATABASE_DEFAULT
                         OR NOT target.steSchoolLocalId = source.stiSchoolLocalId COLLATE DATABASE_DEFAULT
                         OR NOT target.steAddressId = source.steAddressId
                         OR NOT target.steWalkDistance = source.steWalkDistance COLLATE DATABASE_DEFAULT
                         OR NOT target.steEligibility = source.stiStudentTransportationEligibility COLLATE DATABASE_DEFAULT
                         OR NOT target.steEligiblityStartDate = source.stdStudentTransportationEligiblityStartDate
                         OR NOT target.steEligiblityEndDate = source.stdStudentTransportationEligiblityEndDate
                     ) THEN
        UPDATE SET target.steisCurrent = source.stiisCurrent,
                   target.steStdId = source.stdId,
                   target.steAcademicYearDesignator = source.stiAcademicYearDesignator COLLATE DATABASE_DEFAULT,
                   target.steStudentLocalId = source.stiStudentLocalId COLLATE DATABASE_DEFAULT,
                   target.steSchoolLocalId = source.stiSchoolLocalId COLLATE DATABASE_DEFAULT,
                   target.steAddressId = source.steAddressId,
                   target.steWalkDistance = source.steWalkDistance COLLATE DATABASE_DEFAULT,
                   target.steEligibility = source.stiStudentTransportationEligibility COLLATE DATABASE_DEFAULT,
                   target.steEligiblityStartDate = source.stdStudentTransportationEligiblityStartDate,
                   target.steEligiblityEndDate = source.stdStudentTransportationEligiblityEndDate;

END;
GO

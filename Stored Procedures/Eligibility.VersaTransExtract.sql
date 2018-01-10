SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Vijay .N
-- Create date: 2017-11-30
-- Description: Used to extact the versa trans data 
-- =============================================

CREATE PROCEDURE [Eligibility].[VersaTransExtract]
As
Begin
(
SELECT          ESC.SCaID,         
                S.skl_school_Id as scaSchId,
               SC.SCA_OID as scaSCA_OID,
               SC.SCA_Grade_Level collate SQL_Latin1_General_CP1_CI_AS as scaGradeLevel,
	           SC.SCA_Program_Code  collate SQL_Latin1_General_CP1_CI_AS as ScaProgramId ,
               DS.CTX_CONTEXT_ID COLLATE SQL_Latin1_General_CP1_CI_AS   as scaYearContext,
	           SC.SCA_Assign_Limit as scaAssignLimit,
	           SC.SCA_Actual_Total as ScaActualToTal,
	           isnull(null,0) as scaPendingTotal,
               SC.SCA_WAITLIST_Total as scaWaitlistTotal,
               ISNULL(SC.SCA_FIELDA_007,0) as ScaIsSpecialAdmission

from ASPENDB.x2data.dbo.SCHOOL_CAPACITY SC
JOIN    ASPENDB.x2data.dbo.DISTRICT_SCHOOL_YEAR_CONTEXT  DS ON DS.CTX_CONTEXT_ID >= '2017-2018' AND DS.CTX_OID = SC.SCA_CTX_OID 
JOIN    ASPENDB.x2data.dbo.SCHOOL S ON S.SKL_OID = SCA_SKL_OID   
left join Eligibility.SchoolCapacity ESC on ESC.scaSCA_OID=SC.SCA_OID AND  ESC.scaSchId=s.skl_school_Id COLLATE SQL_Latin1_General_CP1_CI_AS 
																	  and ESC.scaGradeLevel= SC.SCA_Grade_Level COLLATE SQL_Latin1_General_CP1_CI_AS 
																	  and   LTRIM(RTRIM(ESC.scaYearContext))=LTRIM(RTRIM(DS.CTX_CONTEXT_ID)) collate SQL_Latin1_General_CP1_CI_AS
)
END



GO

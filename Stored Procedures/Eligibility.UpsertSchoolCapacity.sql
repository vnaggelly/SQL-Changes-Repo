SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Vijay.N
-- Create date: 2017-10-18
-- Description:	Update / Insert data into Schools Capacity
-- =============================================
CREATE PROCEDURE [Eligibility].[UpsertSchoolCapacity]
     @scaId  INT
    ,@scaSchId  VARCHAR(20)
    ,@scaSCA_OID  NCHAR(14)
    ,@scaGradeLevel  CHAR(10)
    ,@scaProgramId  CHAR(10)
    ,@scaYearContext  CHAR(10)
    ,@scaAssignLimit  INT
    ,@scaActualTotal  INT
    ,@scaPendingTotal  INT
    ,@scaWaitlistTotal  INT
    ,@scaIsSpecialAdmission  BIT
    
AS
BEGIN

    UPDATE [Eligibility].[SchoolCapacity]
    SET 
         
         [scaSchId] = @scaSchId
        ,[scaSCA_OID] = @scaSCA_OID
        ,[scaLastUpdated] = getDate()
        ,[scaGradeLevel] = @scaGradeLevel
        ,[scaProgramId] = @scaProgramId
        ,[scaYearContext] = @scaYearContext
        ,[scaAssignLimit] = @scaAssignLimit
        ,[scaActualTotal] = @scaActualTotal
        ,[scaPendingTotal] = @scaPendingTotal
        ,[scaWaitlistTotal] = @scaWaitlistTotal
        ,[scaIsSpecialAdmission] = ISNULL(@scaIsSpecialAdmission,0)
        Where [scaId] = @scaId
    
   
END
GO

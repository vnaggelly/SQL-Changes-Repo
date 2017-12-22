CREATE TABLE [BPS].[Student]
(
[stdId] [int] NOT NULL IDENTITY(1, 1),
[stdSTD_OID] [nvarchar] (14) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[stdScaIdCurrent] [int] NULL,
[stdScaIdNext] [int] NULL,
[STD_LastUpdate] [datetime] NOT NULL CONSTRAINT [DF__Student__STD_Las__39044A60] DEFAULT (getdate()),
[stdToken] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Student__stdToke__371C01EE] DEFAULT (newid()),
[STD_LocalID] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_FamilyName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STD_GivenName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STD_MiddleName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_BirthDate] [date] NOT NULL,
[STD_GradeLevel] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STD_AddressID] [int] NULL,
[stuAddressOutOfBoston] [bit] NOT NULL CONSTRAINT [DF__Student__stuAddr__2E1CA799] DEFAULT ((0)),
[STD_EmailAddress] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_PhoneNumber] [nchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_IsAWC] [bit] NULL,
[STD_IsBAS] [bit] NULL,
[STD_SNCode] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_LEPStatus] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_ELDLevel] [nchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_SIFEStatus] [nchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_FirstLang] [nchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_RankedChoicesReceievedDate] [datetime] NULL,
[STD_Type] [nchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STD_EmailAddress2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STD_RankedChoicesUsrID] [uniqueidentifier] NULL,
[STDCorrespLang] [nchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[stdPromotionStatus] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stdWithDrawalCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stuCurr] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stuVocEd] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StuIsHomeless] [bit] NOT NULL CONSTRAINT [DF__Student__StuIsHo__151BEFA5] DEFAULT ((0)),
[stuCohortGraduationYear] [int] NULL,
[stuRandomNumber] [nchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stuRsvpCode] [int] NULL,
[StuCurrentTrasportationOverride] [bit] NULL,
[StuNextTransportationOverride] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [BPS].[Student] ADD CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED  ([stdId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BPSStudentSTD_LocalID] ON [BPS].[Student] ([STD_LocalID]) INCLUDE ([stdId]) ON [PRIMARY]
GO
ALTER TABLE [BPS].[Student] ADD CONSTRAINT [FK_BPSusrUserSession_STD_RankedChoicesUsrID] FOREIGN KEY ([STD_RankedChoicesUsrID]) REFERENCES [BPS].[usrUserSession] ([usrID])
GO
ALTER TABLE [BPS].[Student] ADD CONSTRAINT [FK_Student_SchoolCapacity] FOREIGN KEY ([stdScaIdCurrent]) REFERENCES [Eligibility].[SchoolCapacity] ([scaId])
GO
ALTER TABLE [BPS].[Student] ADD CONSTRAINT [FK_Student_SchoolCapacity1] FOREIGN KEY ([stdScaIdNext]) REFERENCES [Eligibility].[SchoolCapacity] ([scaId])
GO

CREATE TABLE [Eligibility].[SchoolCapacity]
(
[scaId] [int] NOT NULL IDENTITY(1, 1),
[scaSchId] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[scaSCA_OID] [nchar] (14) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[scaLastUpdated] [datetime] NOT NULL CONSTRAINT [DF_SchoolCapacity_scaLastUpdated] DEFAULT (getdate()),
[scaGradeLevel] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[scaProgramId] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[scaYearContext] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[scaAssignLimit] [int] NOT NULL CONSTRAINT [DF__SchoolCap__scaAs__49C4C20E] DEFAULT ((0)),
[scaActualTotal] [int] NOT NULL CONSTRAINT [DF__SchoolCap__scaAc__4AB8E647] DEFAULT ((0)),
[scaPendingTotal] [int] NOT NULL CONSTRAINT [DF__SchoolCap__scaPe__4BAD0A80] DEFAULT ((0)),
[scaWaitlistTotal] [int] NOT NULL CONSTRAINT [DF__SchoolCap__scaWa__4CA12EB9] DEFAULT ((0)),
[scaIsSpecialAdmission] [bit] NOT NULL CONSTRAINT [DF_SchoolCapacity_scaIsSpecialAdmission] DEFAULT ((0)),
[scaIdPathway] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Eligibility].[SchoolCapacity] ADD CONSTRAINT [PK_BPS.SchoolCapacity] PRIMARY KEY CLUSTERED  ([scaId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SchoolCapacity] ON [Eligibility].[SchoolCapacity] ([scaYearContext], [scaSchId], [scaGradeLevel], [scaProgramId]) ON [PRIMARY]
GO

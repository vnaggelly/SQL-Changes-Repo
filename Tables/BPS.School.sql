CREATE TABLE [BPS].[School]
(
[SchID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SchName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SchName_f] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[LowGrade] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[HighGrade] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SchLevel] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SpecialAdmInd] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[IsCityWide] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[ExamSchoolInd] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[ISEECChoice] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[Pathway] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SchoolGroup] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SharedSchoolID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[Network] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[Zone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[ELLCluster] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SPEDCluster] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[SchType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[UseTierForHMB] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[LastUpdatedDt] [datetime] NOT NULL,
[schZipCode] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchHours] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[schAddress] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[schCity] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[schPhone] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AspenUpdatedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [BPS].[School] ADD CONSTRAINT [pk_School_SchoolID] PRIMARY KEY CLUSTERED  ([SchID]) ON [PRIMARY]
GO

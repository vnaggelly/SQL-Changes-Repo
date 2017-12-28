CREATE TABLE [Transportation].[StudentTransportationEligibility]
(
[steId] [int] NOT NULL IDENTITY(1, 1),
[steStdId] [int] NOT NULL,
[steLastUpdated] [datetime] NOT NULL CONSTRAINT [DF__StudentTr__steLa__5808BFC4] DEFAULT (getdate()),
[steSourceId] [nchar] (14) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[steisCurrent] [bit] NOT NULL CONSTRAINT [DF_Table_1_steisCurrent] DEFAULT ((1)),
[steAcademicYearDesignator] [char] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[steStudentLocalId] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[steSchoolLocalId] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[steAddressId] [int] NULL,
[steWalkDistance] [float] NULL,
[steEligibility] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[steProvider] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Table_1_steProvider] DEFAULT ('BPS'),
[steEligiblityStartDate] [date] NULL,
[steEligiblityEndDate] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Transportation].[StudentTransportationEligibility] ADD CONSTRAINT [PK_StudentTransportationEligibility] PRIMARY KEY CLUSTERED  ([steId]) ON [PRIMARY]
GO
ALTER TABLE [Transportation].[StudentTransportationEligibility] ADD CONSTRAINT [FK_StudentStudentTransportationEligibility] FOREIGN KEY ([steStdId]) REFERENCES [BPS].[Student] ([stdId])
GO

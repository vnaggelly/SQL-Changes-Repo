CREATE TABLE [dbo].[EDPlanToAspen]
(
[EDPlanToAspenId] [int] NOT NULL IDENTITY(1, 1),
[Student Number] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Special Education Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current IEP Begin Date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current IEP End Date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Next Evaluation Date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Next Review Date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Special Education Exit Date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Program] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Related Services] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Related Service Minutes General Ed Setting (B Grid)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Related Service Minutes Other Setting (C Grid)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Special Ed Service Minutes General Ed Setting (B Grid)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Special Ed Service Minutes Other Setting (C Grid)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Transportation Code] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Transportation Accomodation(s)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Transportation Monitor (Y/N)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Utilize Proposed Trans] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_EDPlanToAspen_CreatedDate] DEFAULT (getdate()),
[LRE Setting] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

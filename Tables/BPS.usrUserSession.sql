CREATE TABLE [BPS].[usrUserSession]
(
[usrID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_usrUserSession_usrID] DEFAULT (newid()),
[usrStdId] [int] NOT NULL,
[usrSTD_EmailAddress] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[usrAuthenticationRequest] [datetime] NOT NULL,
[usrPasscode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[usrAuthenticationApprove] [datetime] NULL,
[usrVerification] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[usrRND_RoundNum] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [BPS].[usrUserSession] ADD CONSTRAINT [PK_usrUserSession] PRIMARY KEY CLUSTERED  ([usrID]) ON [PRIMARY]
GO

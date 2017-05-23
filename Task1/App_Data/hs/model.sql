CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName]        NVARCHAR (256)   NOT NULL,
    [LoweredApplicationName] NVARCHAR (256)   NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Description]            NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([ApplicationId] ASC),
    UNIQUE NONCLUSTERED ([ApplicationName] ASC),
    UNIQUE NONCLUSTERED ([LoweredApplicationName] ASC)
);

GO
CREATE TABLE [dbo].[aspnet_Membership] (
    [ApplicationId]                          UNIQUEIDENTIFIER NOT NULL,
    [UserId]                                 UNIQUEIDENTIFIER NOT NULL,
    [Password]                               NVARCHAR (128)   NOT NULL,
    [PasswordFormat]                         INT              DEFAULT ((0)) NOT NULL,
    [PasswordSalt]                           NVARCHAR (128)   NOT NULL,
    [MobilePIN]                              NVARCHAR (16)    NULL,
    [Email]                                  NVARCHAR (256)   NULL,
    [LoweredEmail]                           NVARCHAR (256)   NULL,
    [PasswordQuestion]                       NVARCHAR (256)   NULL,
    [PasswordAnswer]                         NVARCHAR (128)   NULL,
    [IsApproved]                             BIT              NOT NULL,
    [IsLockedOut]                            BIT              NOT NULL,
    [CreateDate]                             DATETIME         NOT NULL,
    [LastLoginDate]                          DATETIME         NOT NULL,
    [LastPasswordChangedDate]                DATETIME         NOT NULL,
    [LastLockoutDate]                        DATETIME         NOT NULL,
    [FailedPasswordAttemptCount]             INT              NOT NULL,
    [FailedPasswordAttemptWindowStart]       DATETIME         NOT NULL,
    [FailedPasswordAnswerAttemptCount]       INT              NOT NULL,
    [FailedPasswordAnswerAttemptWindowStart] DATETIME         NOT NULL,
    [Comment]                                NTEXT            NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_Membership]', @OptionName = N'text in row', @OptionValue = N'3000';

GO
CREATE TABLE [dbo].[aspnet_Paths] (
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    [PathId]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Path]          NVARCHAR (256)   NOT NULL,
    [LoweredPath]   NVARCHAR (256)   NOT NULL,
    PRIMARY KEY NONCLUSTERED ([PathId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);

GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers] (
    [PathId]          UNIQUEIDENTIFIER NOT NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([PathId] ASC),
    FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationAllUsers]', @OptionName = N'text in row', @OptionValue = N'6000';

GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser] (
    [Id]              UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PathId]          UNIQUEIDENTIFIER NULL,
    [UserId]          UNIQUEIDENTIFIER NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC),
    FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationPerUser]', @OptionName = N'text in row', @OptionValue = N'6000';

GO
CREATE TABLE [dbo].[aspnet_Profile] (
    [UserId]               UNIQUEIDENTIFIER NOT NULL,
    [PropertyNames]        NTEXT            NOT NULL,
    [PropertyValuesString] NTEXT            NOT NULL,
    [PropertyValuesBinary] IMAGE            NOT NULL,
    [LastUpdatedDate]      DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_Profile]', @OptionName = N'text in row', @OptionValue = N'6000';

GO
CREATE TABLE [dbo].[aspnet_Roles] (
    [ApplicationId]   UNIQUEIDENTIFIER NOT NULL,
    [RoleId]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [RoleName]        NVARCHAR (256)   NOT NULL,
    [LoweredRoleName] NVARCHAR (256)   NOT NULL,
    [Description]     NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([RoleId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);

GO
CREATE TABLE [dbo].[aspnet_SchemaVersions] (
    [Feature]                 NVARCHAR (128) NOT NULL,
    [CompatibleSchemaVersion] NVARCHAR (128) NOT NULL,
    [IsCurrentVersion]        BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Feature] ASC, [CompatibleSchemaVersion] ASC)
);

GO
CREATE TABLE [dbo].[aspnet_Users] (
    [ApplicationId]    UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [UserName]         NVARCHAR (256)   NOT NULL,
    [LoweredUserName]  NVARCHAR (256)   NOT NULL,
    [MobileAlias]      NVARCHAR (16)    DEFAULT (NULL) NULL,
    [IsAnonymous]      BIT              DEFAULT ((0)) NOT NULL,
    [LastActivityDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);

GO
CREATE TABLE [dbo].[aspnet_UsersInRoles] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);

GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events] (
    [EventId]                CHAR (32)       NOT NULL,
    [EventTimeUtc]           DATETIME        NOT NULL,
    [EventTime]              DATETIME        NOT NULL,
    [EventType]              NVARCHAR (256)  NOT NULL,
    [EventSequence]          DECIMAL (19)    NOT NULL,
    [EventOccurrence]        DECIMAL (19)    NOT NULL,
    [EventCode]              INT             NOT NULL,
    [EventDetailCode]        INT             NOT NULL,
    [Message]                NVARCHAR (1024) NULL,
    [ApplicationPath]        NVARCHAR (256)  NULL,
    [ApplicationVirtualPath] NVARCHAR (256)  NULL,
    [MachineName]            NVARCHAR (256)  NOT NULL,
    [RequestUrl]             NVARCHAR (1024) NULL,
    [ExceptionType]          NVARCHAR (256)  NULL,
    [Details]                NTEXT           NULL,
    PRIMARY KEY CLUSTERED ([EventId] ASC)
);

GO
CREATE TABLE [dbo].[checks] (
    [cId]    INT           IDENTITY (1, 1) NOT NULL,
    [cpssn]  CHAR (14)     NOT NULL,
    [cdrssn] CHAR (14)     NOT NULL,
    [cdsid]  NVARCHAR (20) NOT NULL,
    [csts]   NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([cId] ASC)
);

GO
CREATE TABLE [dbo].[departments] (
    [dname] NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([dname] ASC)
);

GO
CREATE TABLE [dbo].[diseases] (
    [dsname] NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([dsname] ASC)
);

GO
CREATE TABLE [dbo].[doctors] (
    [drssn]     CHAR (14)     NOT NULL,
    [drname]    NVARCHAR (20) NOT NULL,
    [draddress] NVARCHAR (30) NOT NULL,
    [drtelno]   VARCHAR (13)  NOT NULL,
    [drdname]   NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([drssn] ASC)
);

GO
CREATE TABLE [dbo].[patients] (
    [pssn]     CHAR (14)     NOT NULL,
    [pname]    NVARCHAR (20) NOT NULL,
    [paddress] NVARCHAR (30) NOT NULL,
    [ptelno]   VARCHAR (13)  NOT NULL,
    PRIMARY KEY CLUSTERED ([pssn] ASC)
);

GO
CREATE TABLE [dbo].[statuses] (
    [sts] NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([sts] ASC)
);

GO
CREATE VIEW [dbo].[vw_aspnet_Applications]
AS
SELECT [dbo].[aspnet_Applications].[ApplicationName],
       [dbo].[aspnet_Applications].[LoweredApplicationName],
       [dbo].[aspnet_Applications].[ApplicationId],
       [dbo].[aspnet_Applications].[Description]
FROM   [dbo].[aspnet_Applications];

GO
CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
AS
SELECT [dbo].[aspnet_Membership].[UserId],
       [dbo].[aspnet_Membership].[PasswordFormat],
       [dbo].[aspnet_Membership].[MobilePIN],
       [dbo].[aspnet_Membership].[Email],
       [dbo].[aspnet_Membership].[LoweredEmail],
       [dbo].[aspnet_Membership].[PasswordQuestion],
       [dbo].[aspnet_Membership].[PasswordAnswer],
       [dbo].[aspnet_Membership].[IsApproved],
       [dbo].[aspnet_Membership].[IsLockedOut],
       [dbo].[aspnet_Membership].[CreateDate],
       [dbo].[aspnet_Membership].[LastLoginDate],
       [dbo].[aspnet_Membership].[LastPasswordChangedDate],
       [dbo].[aspnet_Membership].[LastLockoutDate],
       [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
       [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
       [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
       [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
       [dbo].[aspnet_Membership].[Comment],
       [dbo].[aspnet_Users].[ApplicationId],
       [dbo].[aspnet_Users].[UserName],
       [dbo].[aspnet_Users].[MobileAlias],
       [dbo].[aspnet_Users].[IsAnonymous],
       [dbo].[aspnet_Users].[LastActivityDate]
FROM   [dbo].[aspnet_Membership]
       INNER JOIN
       [dbo].[aspnet_Users]
       ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId];

GO
CREATE VIEW [dbo].[vw_aspnet_Profiles]
AS
SELECT [dbo].[aspnet_Profile].[UserId],
       [dbo].[aspnet_Profile].[LastUpdatedDate],
       DATALENGTH([dbo].[aspnet_Profile].[PropertyNames]) + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString]) + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary]) AS [DataSize]
FROM   [dbo].[aspnet_Profile];

GO
CREATE VIEW [dbo].[vw_aspnet_Roles]
AS
SELECT [dbo].[aspnet_Roles].[ApplicationId],
       [dbo].[aspnet_Roles].[RoleId],
       [dbo].[aspnet_Roles].[RoleName],
       [dbo].[aspnet_Roles].[LoweredRoleName],
       [dbo].[aspnet_Roles].[Description]
FROM   [dbo].[aspnet_Roles];

GO
CREATE VIEW [dbo].[vw_aspnet_Users]
AS
SELECT [dbo].[aspnet_Users].[ApplicationId],
       [dbo].[aspnet_Users].[UserId],
       [dbo].[aspnet_Users].[UserName],
       [dbo].[aspnet_Users].[LoweredUserName],
       [dbo].[aspnet_Users].[MobileAlias],
       [dbo].[aspnet_Users].[IsAnonymous],
       [dbo].[aspnet_Users].[LastActivityDate]
FROM   [dbo].[aspnet_Users];

GO
CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
AS
SELECT [dbo].[aspnet_UsersInRoles].[UserId],
       [dbo].[aspnet_UsersInRoles].[RoleId]
FROM   [dbo].[aspnet_UsersInRoles];

GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
AS
SELECT [dbo].[aspnet_Paths].[ApplicationId],
       [dbo].[aspnet_Paths].[PathId],
       [dbo].[aspnet_Paths].[Path],
       [dbo].[aspnet_Paths].[LoweredPath]
FROM   [dbo].[aspnet_Paths];

GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
AS
SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId],
       DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]) AS [DataSize],
       [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
FROM   [dbo].[aspnet_PersonalizationAllUsers];

GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
AS
SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId],
       [dbo].[aspnet_PersonalizationPerUser].[UserId],
       DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]) AS [DataSize],
       [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
FROM   [dbo].[aspnet_PersonalizationPerUser];

GO
ALTER TABLE [dbo].[doctors]
    ADD CONSTRAINT [depart] FOREIGN KEY ([drdname]) REFERENCES [dbo].[departments] ([dname]);

GO
ALTER TABLE [dbo].[checks]
    ADD CONSTRAINT [sidcd] FOREIGN KEY ([cdsid]) REFERENCES [dbo].[diseases] ([dsname]);

GO
ALTER TABLE [dbo].[checks]
    ADD CONSTRAINT [ssndr] FOREIGN KEY ([cdrssn]) REFERENCES [dbo].[doctors] ([drssn]);

GO
ALTER TABLE [dbo].[checks]
    ADD CONSTRAINT [ssnp] FOREIGN KEY ([cpssn]) REFERENCES [dbo].[patients] ([pssn]);

GO
ALTER TABLE [dbo].[checks]
    ADD CONSTRAINT [stscs] FOREIGN KEY ([csts]) REFERENCES [dbo].[statuses] ([sts]);

GO
ALTER TABLE [dbo].[doctors]
    ADD CONSTRAINT [drssn] CHECK (NOT [drssn] LIKE '%[^0-9]%');

GO
ALTER TABLE [dbo].[doctors]
    ADD CONSTRAINT [drtel] CHECK (NOT [drtelno] LIKE '%[^0-9]%');

GO
ALTER TABLE [dbo].[patients]
    ADD CONSTRAINT [pssn] CHECK (NOT [pssn] LIKE '%[^0-9]%');

GO
ALTER TABLE [dbo].[patients]
    ADD CONSTRAINT [ptel] CHECK (NOT [ptelno] LIKE '%[^0-9]%');

GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index]
    ON [dbo].[aspnet_Applications]([LoweredApplicationName] ASC);

GO
CREATE CLUSTERED INDEX [aspnet_Membership_index]
    ON [dbo].[aspnet_Membership]([ApplicationId] ASC, [LoweredEmail] ASC);

GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index]
    ON [dbo].[aspnet_Paths]([ApplicationId] ASC, [LoweredPath] ASC);

GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1]
    ON [dbo].[aspnet_PersonalizationPerUser]([PathId] ASC, [UserId] ASC);

GO
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2]
    ON [dbo].[aspnet_PersonalizationPerUser]([UserId] ASC, [PathId] ASC);

GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1]
    ON [dbo].[aspnet_Roles]([ApplicationId] ASC, [LoweredRoleName] ASC);

GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LoweredUserName] ASC);

GO
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LastActivityDate] ASC);

GO
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index]
    ON [dbo].[aspnet_UsersInRoles]([RoleId] ASC);

GO
CREATE ROLE [aspnet_Membership_BasicAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Membership_FullAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Membership_ReportingAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Personalization_BasicAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Personalization_FullAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Personalization_ReportingAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Profile_BasicAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Profile_FullAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Profile_ReportingAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Roles_BasicAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Roles_FullAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_Roles_ReportingAccess]
    AUTHORIZATION [dbo];

GO
CREATE ROLE [aspnet_WebEvent_FullAccess]
    AUTHORIZATION [dbo];

GO
ALTER ROLE [aspnet_Membership_BasicAccess] ADD MEMBER [aspnet_Membership_FullAccess];

GO
ALTER ROLE [aspnet_Membership_ReportingAccess] ADD MEMBER [aspnet_Membership_FullAccess];

GO
ALTER ROLE [aspnet_Profile_BasicAccess] ADD MEMBER [aspnet_Profile_FullAccess];

GO
ALTER ROLE [aspnet_Profile_ReportingAccess] ADD MEMBER [aspnet_Profile_FullAccess];

GO
ALTER ROLE [aspnet_Roles_BasicAccess] ADD MEMBER [aspnet_Roles_FullAccess];

GO
ALTER ROLE [aspnet_Roles_ReportingAccess] ADD MEMBER [aspnet_Roles_FullAccess];

GO
ALTER ROLE [aspnet_Personalization_BasicAccess] ADD MEMBER [aspnet_Personalization_FullAccess];

GO
ALTER ROLE [aspnet_Personalization_ReportingAccess] ADD MEMBER [aspnet_Personalization_FullAccess];

GO
CREATE PROCEDURE [dbo].[aspnet_AnyDataInTables]
@TablesToCheck INT NULL
AS
BEGIN
    IF ((@TablesToCheck & 1) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_MembershipUsers')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_Membership))
                BEGIN
                    SELECT N'aspnet_Membership';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 2) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_Roles')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 RoleId
                        FROM   dbo.aspnet_Roles))
                BEGIN
                    SELECT N'aspnet_Roles';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 4) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_Profiles')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_Profile))
                BEGIN
                    SELECT N'aspnet_Profile';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 8) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_WebPartState_User')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_PersonalizationPerUser))
                BEGIN
                    SELECT N'aspnet_PersonalizationPerUser';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 16) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'aspnet_WebEvent_LogEvent')
                            AND (type = 'P'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 *
                        FROM   dbo.aspnet_WebEvent_Events))
                BEGIN
                    SELECT N'aspnet_WebEvent_Events';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 1) <> 0
        AND (@TablesToCheck & 2) <> 0
        AND (@TablesToCheck & 4) <> 0
        AND (@TablesToCheck & 8) <> 0
        AND (@TablesToCheck & 32) <> 0
        AND (@TablesToCheck & 128) <> 0
        AND (@TablesToCheck & 256) <> 0
        AND (@TablesToCheck & 512) <> 0
        AND (@TablesToCheck & 1024) <> 0)
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_Users))
                BEGIN
                    SELECT N'aspnet_Users';
                    RETURN;
                END
            IF (EXISTS (SELECT TOP 1 ApplicationId
                        FROM   dbo.aspnet_Applications))
                BEGIN
                    SELECT N'aspnet_Applications';
                    RETURN;
                END
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_Applications_CreateApplication]
@ApplicationName NVARCHAR (256) NULL, @ApplicationId UNIQUEIDENTIFIER NULL OUTPUT
AS
BEGIN
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        BEGIN
            DECLARE @TranStarted AS BIT;
            SET @TranStarted = 0;
            IF (@@TRANCOUNT = 0)
                BEGIN
                    BEGIN TRANSACTION;
                    SET @TranStarted = 1;
                END
            ELSE
                SET @TranStarted = 0;
            SELECT @ApplicationId = ApplicationId
            FROM   dbo.aspnet_Applications WITH (UPDLOCK, HOLDLOCK)
            WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
            IF (@ApplicationId IS NULL)
                BEGIN
                    SELECT @ApplicationId = NEWID();
                    INSERT  dbo.aspnet_Applications (ApplicationId, ApplicationName, LoweredApplicationName)
                    VALUES                         (@ApplicationId, @ApplicationName, LOWER(@ApplicationName));
                END
            IF (@TranStarted = 1)
                BEGIN
                    IF (@@ERROR = 0)
                        BEGIN
                            SET @TranStarted = 0;
                            COMMIT TRANSACTION;
                        END
                    ELSE
                        BEGIN
                            SET @TranStarted = 0;
                            ROLLBACK;
                        END
                END
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_CheckSchemaVersion]
@Feature NVARCHAR (128) NULL, @CompatibleSchemaVersion NVARCHAR (128) NULL
AS
BEGIN
    IF (EXISTS (SELECT *
                FROM   dbo.aspnet_SchemaVersions
                WHERE  Feature = LOWER(@Feature)
                       AND CompatibleSchemaVersion = @CompatibleSchemaVersion))
        RETURN 0;
    RETURN 1;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @NewPasswordQuestion NVARCHAR (256) NULL, @NewPasswordAnswer NVARCHAR (128) NULL
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        BEGIN
            RETURN (1);
        END
    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion,
           PasswordAnswer   = @NewPasswordAnswer
    WHERE  UserId = @UserId;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_CreateUser]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @Password NVARCHAR (128) NULL, @PasswordSalt NVARCHAR (128) NULL, @Email NVARCHAR (256) NULL, @PasswordQuestion NVARCHAR (256) NULL, @PasswordAnswer NVARCHAR (128) NULL, @IsApproved BIT NULL, @CurrentTimeUtc DATETIME NULL, @CreateDate DATETIME NULL=NULL, @UniqueEmail INT NULL=0, @PasswordFormat INT NULL=0, @UserId UNIQUEIDENTIFIER NULL OUTPUT
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    DECLARE @NewUserId AS UNIQUEIDENTIFIER;
    SELECT @NewUserId = NULL;
    DECLARE @IsLockedOut AS BIT;
    SET @IsLockedOut = 0;
    DECLARE @LastLockoutDate AS DATETIME;
    SET @LastLockoutDate = CONVERT (DATETIME, '17540101', 112);
    DECLARE @FailedPasswordAttemptCount AS INT;
    SET @FailedPasswordAttemptCount = 0;
    DECLARE @FailedPasswordAttemptWindowStart AS DATETIME;
    SET @FailedPasswordAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    SET @FailedPasswordAnswerAttemptCount = 0;
    DECLARE @FailedPasswordAnswerAttemptWindowStart AS DATETIME;
    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
    DECLARE @NewUserCreated AS BIT;
    DECLARE @ReturnValue AS INT;
    SET @ReturnValue = 0;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    EXECUTE dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    SET @CreateDate = @CurrentTimeUtc;
    SELECT @NewUserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  LOWER(@UserName) = LoweredUserName
           AND @ApplicationId = ApplicationId;
    IF (@NewUserId IS NULL)
        BEGIN
            SET @NewUserId = @UserId;
            EXECUTE @ReturnValue = dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CreateDate, @NewUserId OUTPUT;
            SET @NewUserCreated = 1;
        END
    ELSE
        BEGIN
            SET @NewUserCreated = 0;
            IF (@NewUserId <> @UserId
                AND @UserId IS NOT NULL)
                BEGIN
                    SET @ErrorCode = 6;
                    GOTO Cleanup;
                END
        END
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@ReturnValue = -1)
        BEGIN
            SET @ErrorCode = 10;
            GOTO Cleanup;
        END
    IF (EXISTS (SELECT UserId
                FROM   dbo.aspnet_Membership
                WHERE  @NewUserId = UserId))
        BEGIN
            SET @ErrorCode = 6;
            GOTO Cleanup;
        END
    SET @UserId = @NewUserId;
    IF (@UniqueEmail = 1)
        BEGIN
            IF (EXISTS (SELECT *
                        FROM   dbo.aspnet_Membership AS m WITH (UPDLOCK, HOLDLOCK)
                        WHERE  ApplicationId = @ApplicationId
                               AND LoweredEmail = LOWER(@Email)))
                BEGIN
                    SET @ErrorCode = 7;
                    GOTO Cleanup;
                END
        END
    IF (@NewUserCreated = 0)
        BEGIN
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CreateDate
            WHERE  @UserId = UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
        END
    INSERT  INTO dbo.aspnet_Membership (ApplicationId, UserId, Password, PasswordSalt, Email, LoweredEmail, PasswordQuestion, PasswordAnswer, PasswordFormat, IsApproved, IsLockedOut, CreateDate, LastLoginDate, LastPasswordChangedDate, LastLockoutDate, FailedPasswordAttemptCount, FailedPasswordAttemptWindowStart, FailedPasswordAnswerAttemptCount, FailedPasswordAnswerAttemptWindowStart)
    VALUES                            (@ApplicationId, @UserId, @Password, @PasswordSalt, @Email, LOWER(@Email), @PasswordQuestion, @PasswordAnswer, @PasswordFormat, @IsApproved, @IsLockedOut, @CreateDate, @CreateDate, @CreateDate, @LastLockoutDate, @FailedPasswordAttemptCount, @FailedPasswordAttemptWindowStart, @FailedPasswordAnswerAttemptCount, @FailedPasswordAnswerAttemptWindowStart);
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN 0;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByEmail]
@ApplicationName NVARCHAR (256) NULL, @EmailToMatch NVARCHAR (256) NULL, @PageIndex INT NULL, @PageSize INT NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN 0;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndexForUsers (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        UserId  UNIQUEIDENTIFIER
    );
    IF (@EmailToMatch IS NULL)
        INSERT INTO #PageIndexForUsers (UserId)
        SELECT   u.UserId
        FROM     dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE    u.ApplicationId = @ApplicationId
                 AND m.UserId = u.UserId
                 AND m.Email IS NULL
        ORDER BY m.LoweredEmail;
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
        SELECT   u.UserId
        FROM     dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE    u.ApplicationId = @ApplicationId
                 AND m.UserId = u.UserId
                 AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
        ORDER BY m.LoweredEmail;
    SELECT   u.UserName,
             m.Email,
             m.PasswordQuestion,
             m.Comment,
             m.IsApproved,
             m.CreateDate,
             m.LastLoginDate,
             u.LastActivityDate,
             m.LastPasswordChangedDate,
             u.UserId,
             m.IsLockedOut,
             m.LastLockoutDate
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, #PageIndexForUsers AS p
    WHERE    u.UserId = p.UserId
             AND u.UserId = m.UserId
             AND p.IndexId >= @PageLowerBound
             AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail;
    SELECT @TotalRecords = COUNT(*)
    FROM   #PageIndexForUsers;
    RETURN @TotalRecords;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByName]
@ApplicationName NVARCHAR (256) NULL, @UserNameToMatch NVARCHAR (256) NULL, @PageIndex INT NULL, @PageSize INT NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN 0;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndexForUsers (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        UserId  UNIQUEIDENTIFIER
    );
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT   u.UserId
    FROM     dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
    WHERE    u.ApplicationId = @ApplicationId
             AND m.UserId = u.UserId
             AND u.LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName;
    SELECT   u.UserName,
             m.Email,
             m.PasswordQuestion,
             m.Comment,
             m.IsApproved,
             m.CreateDate,
             m.LastLoginDate,
             u.LastActivityDate,
             m.LastPasswordChangedDate,
             u.UserId,
             m.IsLockedOut,
             m.LastLockoutDate
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, #PageIndexForUsers AS p
    WHERE    u.UserId = p.UserId
             AND u.UserId = m.UserId
             AND p.IndexId >= @PageLowerBound
             AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName;
    SELECT @TotalRecords = COUNT(*)
    FROM   #PageIndexForUsers;
    RETURN @TotalRecords;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetAllUsers]
@ApplicationName NVARCHAR (256) NULL, @PageIndex INT NULL, @PageSize INT NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN 0;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndexForUsers (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        UserId  UNIQUEIDENTIFIER
    );
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT   u.UserId
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u
    WHERE    u.ApplicationId = @ApplicationId
             AND u.UserId = m.UserId
    ORDER BY u.UserName;
    SELECT @TotalRecords = @@ROWCOUNT;
    SELECT   u.UserName,
             m.Email,
             m.PasswordQuestion,
             m.Comment,
             m.IsApproved,
             m.CreateDate,
             m.LastLoginDate,
             u.LastActivityDate,
             m.LastPasswordChangedDate,
             u.UserId,
             m.IsLockedOut,
             m.LastLockoutDate
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, #PageIndexForUsers AS p
    WHERE    u.UserId = p.UserId
             AND u.UserId = m.UserId
             AND p.IndexId >= @PageLowerBound
             AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName;
    RETURN @TotalRecords;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetNumberOfUsersOnline]
@ApplicationName NVARCHAR (256) NULL, @MinutesSinceLastInActive INT NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @DateActive AS DATETIME;
    SELECT @DateActive = DATEADD(minute, -(@MinutesSinceLastInActive), @CurrentTimeUtc);
    DECLARE @NumOnline AS INT;
    SELECT @NumOnline = COUNT(*)
    FROM   dbo.aspnet_Users AS u WITH (NOLOCK), dbo.aspnet_Applications AS a WITH (NOLOCK), dbo.aspnet_Membership AS m WITH (NOLOCK)
    WHERE  u.ApplicationId = a.ApplicationId
           AND LastActivityDate > @DateActive
           AND a.LoweredApplicationName = LOWER(@ApplicationName)
           AND u.UserId = m.UserId;
    RETURN (@NumOnline);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPassword]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @MaxInvalidPasswordAttempts INT NULL, @PasswordAttemptWindow INT NULL, @CurrentTimeUtc DATETIME NULL, @PasswordAnswer NVARCHAR (128) NULL=NULL
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @PasswordFormat AS INT;
    DECLARE @Password AS NVARCHAR (128);
    DECLARE @passAns AS NVARCHAR (128);
    DECLARE @IsLockedOut AS BIT;
    DECLARE @LastLockoutDate AS DATETIME;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAttemptWindowStart AS DATETIME;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptWindowStart AS DATETIME;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    SELECT @UserId = u.UserId,
           @Password = m.Password,
           @passAns = m.PasswordAnswer,
           @PasswordFormat = m.PasswordFormat,
           @IsLockedOut = m.IsLockedOut,
           @LastLockoutDate = m.LastLockoutDate,
           @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m WITH (UPDLOCK)
    WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.ApplicationId = a.ApplicationId
           AND u.UserId = m.UserId
           AND LOWER(@UserName) = u.LoweredUserName;
    IF (@@rowcount = 0)
        BEGIN
            SET @ErrorCode = 1;
            GOTO Cleanup;
        END
    IF (@IsLockedOut = 1)
        BEGIN
            SET @ErrorCode = 99;
            GOTO Cleanup;
        END
    IF (NOT (@PasswordAnswer IS NULL))
        BEGIN
            IF ((@passAns IS NULL)
                OR (LOWER(@passAns) <> LOWER(@PasswordAnswer)))
                BEGIN
                    IF (@CurrentTimeUtc > DATEADD(minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart))
                        BEGIN
                            SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc;
                            SET @FailedPasswordAnswerAttemptCount = 1;
                        END
                    ELSE
                        BEGIN
                            SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1;
                            SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc;
                        END
                    BEGIN
                        IF (@FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts)
                            BEGIN
                                SET @IsLockedOut = 1;
                                SET @LastLockoutDate = @CurrentTimeUtc;
                            END
                    END
                    SET @ErrorCode = 3;
                END
            ELSE
                BEGIN
                    IF (@FailedPasswordAnswerAttemptCount > 0)
                        BEGIN
                            SET @FailedPasswordAnswerAttemptCount = 0;
                            SET @FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                        END
                END
            UPDATE dbo.aspnet_Membership
            SET    IsLockedOut                            = @IsLockedOut,
                   LastLockoutDate                        = @LastLockoutDate,
                   FailedPasswordAttemptCount             = @FailedPasswordAttemptCount,
                   FailedPasswordAttemptWindowStart       = @FailedPasswordAttemptWindowStart,
                   FailedPasswordAnswerAttemptCount       = @FailedPasswordAnswerAttemptCount,
                   FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
            WHERE  @UserId = UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    IF (@ErrorCode = 0)
        SELECT @Password,
               @PasswordFormat;
    RETURN @ErrorCode;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPasswordWithFormat]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @UpdateLastLoginActivityDate BIT NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @IsLockedOut AS BIT;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @Password AS NVARCHAR (128);
    DECLARE @PasswordSalt AS NVARCHAR (128);
    DECLARE @PasswordFormat AS INT;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @IsApproved AS BIT;
    DECLARE @LastActivityDate AS DATETIME;
    DECLARE @LastLoginDate AS DATETIME;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId,
           @IsLockedOut = m.IsLockedOut,
           @Password = Password,
           @PasswordFormat = PasswordFormat,
           @PasswordSalt = PasswordSalt,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @IsApproved = IsApproved,
           @LastActivityDate = LastActivityDate,
           @LastLoginDate = LastLoginDate
    FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
    WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.ApplicationId = a.ApplicationId
           AND u.UserId = m.UserId
           AND LOWER(@UserName) = u.LoweredUserName;
    IF (@UserId IS NULL)
        RETURN 1;
    IF (@IsLockedOut = 1)
        RETURN 99;
    SELECT @Password,
           @PasswordFormat,
           @PasswordSalt,
           @FailedPasswordAttemptCount,
           @FailedPasswordAnswerAttemptCount,
           @IsApproved,
           @LastLoginDate,
           @LastActivityDate;
    IF (@UpdateLastLoginActivityDate = 1
        AND @IsApproved = 1)
        BEGIN
            UPDATE dbo.aspnet_Membership
            SET    LastLoginDate = @CurrentTimeUtc
            WHERE  UserId = @UserId;
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            WHERE  @UserId = UserId;
        END
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByEmail]
@ApplicationName NVARCHAR (256) NULL, @Email NVARCHAR (256) NULL
AS
BEGIN
    IF (@Email IS NULL)
        SELECT u.UserName
        FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
               AND u.ApplicationId = a.ApplicationId
               AND u.UserId = m.UserId
               AND m.ApplicationId = a.ApplicationId
               AND m.LoweredEmail IS NULL;
    ELSE
        SELECT u.UserName
        FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
               AND u.ApplicationId = a.ApplicationId
               AND u.UserId = m.UserId
               AND m.ApplicationId = a.ApplicationId
               AND LOWER(@Email) = m.LoweredEmail;
    IF (@@rowcount = 0)
        RETURN (1);
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByName]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @CurrentTimeUtc DATETIME NULL, @UpdateLastActivity BIT NULL=0
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    IF (@UpdateLastActivity = 1)
        BEGIN
            SELECT TOP 1 @UserId = u.UserId
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
                   AND u.ApplicationId = a.ApplicationId
                   AND LOWER(@UserName) = u.LoweredUserName
                   AND u.UserId = m.UserId;
            IF (@@ROWCOUNT = 0)
                RETURN -1;
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            WHERE  @UserId = UserId;
            SELECT m.Email,
                   m.PasswordQuestion,
                   m.Comment,
                   m.IsApproved,
                   m.CreateDate,
                   m.LastLoginDate,
                   u.LastActivityDate,
                   m.LastPasswordChangedDate,
                   u.UserId,
                   m.IsLockedOut,
                   m.LastLockoutDate
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  @UserId = u.UserId
                   AND u.UserId = m.UserId;
        END
    ELSE
        BEGIN
            SELECT TOP 1 m.Email,
                         m.PasswordQuestion,
                         m.Comment,
                         m.IsApproved,
                         m.CreateDate,
                         m.LastLoginDate,
                         u.LastActivityDate,
                         m.LastPasswordChangedDate,
                         u.UserId,
                         m.IsLockedOut,
                         m.LastLockoutDate
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
                   AND u.ApplicationId = a.ApplicationId
                   AND LOWER(@UserName) = u.LoweredUserName
                   AND u.UserId = m.UserId;
            IF (@@ROWCOUNT = 0)
                RETURN -1;
        END
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByUserId]
@UserId UNIQUEIDENTIFIER NULL, @CurrentTimeUtc DATETIME NULL, @UpdateLastActivity BIT NULL=0
AS
BEGIN
    IF (@UpdateLastActivity = 1)
        BEGIN
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            FROM   dbo.aspnet_Users
            WHERE  @UserId = UserId;
            IF (@@ROWCOUNT = 0)
                RETURN -1;
        END
    SELECT m.Email,
           m.PasswordQuestion,
           m.Comment,
           m.IsApproved,
           m.CreateDate,
           m.LastLoginDate,
           u.LastActivityDate,
           m.LastPasswordChangedDate,
           u.UserName,
           m.IsLockedOut,
           m.LastLockoutDate
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
    WHERE  @UserId = u.UserId
           AND u.UserId = m.UserId;
    IF (@@ROWCOUNT = 0)
        RETURN -1;
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ResetPassword]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @NewPassword NVARCHAR (128) NULL, @MaxInvalidPasswordAttempts INT NULL, @PasswordAttemptWindow INT NULL, @PasswordSalt NVARCHAR (128) NULL, @CurrentTimeUtc DATETIME NULL, @PasswordFormat INT NULL=0, @PasswordAnswer NVARCHAR (128) NULL=NULL
AS
BEGIN
    DECLARE @IsLockedOut AS BIT;
    DECLARE @LastLockoutDate AS DATETIME;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAttemptWindowStart AS DATETIME;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptWindowStart AS DATETIME;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SET @UserId = NULL;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a, dbo.aspnet_Membership AS m
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        BEGIN
            SET @ErrorCode = 1;
            GOTO Cleanup;
        END
    SELECT @IsLockedOut = IsLockedOut,
           @LastLockoutDate = LastLockoutDate,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = FailedPasswordAnswerAttemptWindowStart
    FROM   dbo.aspnet_Membership WITH (UPDLOCK)
    WHERE  @UserId = UserId;
    IF (@IsLockedOut = 1)
        BEGIN
            SET @ErrorCode = 99;
            GOTO Cleanup;
        END
    UPDATE dbo.aspnet_Membership
    SET    Password                = @NewPassword,
           LastPasswordChangedDate = @CurrentTimeUtc,
           PasswordFormat          = @PasswordFormat,
           PasswordSalt            = @PasswordSalt
    WHERE  @UserId = UserId
           AND ((@PasswordAnswer IS NULL)
                OR (LOWER(PasswordAnswer) = LOWER(@PasswordAnswer)));
    IF (@@ROWCOUNT = 0)
        BEGIN
            IF (@CurrentTimeUtc > DATEADD(minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart))
                BEGIN
                    SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAnswerAttemptCount = 1;
                END
            ELSE
                BEGIN
                    SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1;
                END
            BEGIN
                IF (@FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts)
                    BEGIN
                        SET @IsLockedOut = 1;
                        SET @LastLockoutDate = @CurrentTimeUtc;
                    END
            END
            SET @ErrorCode = 3;
        END
    ELSE
        BEGIN
            IF (@FailedPasswordAnswerAttemptCount > 0)
                BEGIN
                    SET @FailedPasswordAnswerAttemptCount = 0;
                    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                END
        END
    IF (NOT (@PasswordAnswer IS NULL))
        BEGIN
            UPDATE dbo.aspnet_Membership
            SET    IsLockedOut                            = @IsLockedOut,
                   LastLockoutDate                        = @LastLockoutDate,
                   FailedPasswordAttemptCount             = @FailedPasswordAttemptCount,
                   FailedPasswordAttemptWindowStart       = @FailedPasswordAttemptWindowStart,
                   FailedPasswordAnswerAttemptCount       = @FailedPasswordAnswerAttemptCount,
                   FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
            WHERE  @UserId = UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN @ErrorCode;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_SetPassword]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @NewPassword NVARCHAR (128) NULL, @PasswordSalt NVARCHAR (128) NULL, @CurrentTimeUtc DATETIME NULL, @PasswordFormat INT NULL=0
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a, dbo.aspnet_Membership AS m
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        RETURN (1);
    UPDATE dbo.aspnet_Membership
    SET    Password                = @NewPassword,
           PasswordFormat          = @PasswordFormat,
           PasswordSalt            = @PasswordSalt,
           LastPasswordChangedDate = @CurrentTimeUtc
    WHERE  @UserId = UserId;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UnlockUser]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a, dbo.aspnet_Membership AS m
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        RETURN 1;
    UPDATE dbo.aspnet_Membership
    SET    IsLockedOut                            = 0,
           FailedPasswordAttemptCount             = 0,
           FailedPasswordAttemptWindowStart       = CONVERT (DATETIME, '17540101', 112),
           FailedPasswordAnswerAttemptCount       = 0,
           FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112),
           LastLockoutDate                        = CONVERT (DATETIME, '17540101', 112)
    WHERE  @UserId = UserId;
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUser]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @Email NVARCHAR (256) NULL, @Comment NTEXT NULL, @IsApproved BIT NULL, @LastLoginDate DATETIME NULL, @LastActivityDate DATETIME NULL, @UniqueEmail INT NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId,
           @ApplicationId = a.ApplicationId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a, dbo.aspnet_Membership AS m
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        RETURN (1);
    IF (@UniqueEmail = 1)
        BEGIN
            IF (EXISTS (SELECT *
                        FROM   dbo.aspnet_Membership WITH (UPDLOCK, HOLDLOCK)
                        WHERE  ApplicationId = @ApplicationId
                               AND @UserId <> UserId
                               AND LoweredEmail = LOWER(@Email)))
                BEGIN
                    RETURN (7);
                END
        END
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET    LastActivityDate = @LastActivityDate
    WHERE  @UserId = UserId;
    IF (@@ERROR <> 0)
        GOTO Cleanup;
    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET    Email         = @Email,
           LoweredEmail  = LOWER(@Email),
           Comment       = @Comment,
           IsApproved    = @IsApproved,
           LastLoginDate = @LastLoginDate
    WHERE  @UserId = UserId;
    IF (@@ERROR <> 0)
        GOTO Cleanup;
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN 0;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN -1;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUserInfo]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @IsPasswordCorrect BIT NULL, @UpdateLastLoginActivityDate BIT NULL, @MaxInvalidPasswordAttempts INT NULL, @PasswordAttemptWindow INT NULL, @CurrentTimeUtc DATETIME NULL, @LastLoginDate DATETIME NULL, @LastActivityDate DATETIME NULL
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @IsApproved AS BIT;
    DECLARE @IsLockedOut AS BIT;
    DECLARE @LastLockoutDate AS DATETIME;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAttemptWindowStart AS DATETIME;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptWindowStart AS DATETIME;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    SELECT @UserId = u.UserId,
           @IsApproved = m.IsApproved,
           @IsLockedOut = m.IsLockedOut,
           @LastLockoutDate = m.LastLockoutDate,
           @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u WITH (UPDLOCK, ROWLOCK), dbo.aspnet_Membership AS m WITH (UPDLOCK, ROWLOCK)
    WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.ApplicationId = a.ApplicationId
           AND u.UserId = m.UserId
           AND LOWER(@UserName) = u.LoweredUserName;
    IF (@@rowcount = 0)
        BEGIN
            SET @ErrorCode = 1;
            GOTO Cleanup;
        END
    IF (@IsLockedOut = 1)
        BEGIN
            GOTO Cleanup;
        END
    IF (@IsPasswordCorrect = 0)
        BEGIN
            IF (@CurrentTimeUtc > DATEADD(minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart))
                BEGIN
                    SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAttemptCount = 1;
                END
            ELSE
                BEGIN
                    SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1;
                END
            BEGIN
                IF (@FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts)
                    BEGIN
                        SET @IsLockedOut = 1;
                        SET @LastLockoutDate = @CurrentTimeUtc;
                    END
            END
        END
    ELSE
        BEGIN
            IF (@FailedPasswordAttemptCount > 0
                OR @FailedPasswordAnswerAttemptCount > 0)
                BEGIN
                    SET @FailedPasswordAttemptCount = 0;
                    SET @FailedPasswordAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                    SET @FailedPasswordAnswerAttemptCount = 0;
                    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                    SET @LastLockoutDate = CONVERT (DATETIME, '17540101', 112);
                END
        END
    IF (@UpdateLastLoginActivityDate = 1)
        BEGIN
            UPDATE dbo.aspnet_Users WITH (ROWLOCK)
            SET    LastActivityDate = @LastActivityDate
            WHERE  @UserId = UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
            UPDATE dbo.aspnet_Membership
            SET    LastLoginDate = @LastLoginDate
            WHERE  UserId = @UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
        END
    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET    IsLockedOut                            = @IsLockedOut,
           LastLockoutDate                        = @LastLockoutDate,
           FailedPasswordAttemptCount             = @FailedPasswordAttemptCount,
           FailedPasswordAttemptWindowStart       = @FailedPasswordAttemptWindowStart,
           FailedPasswordAnswerAttemptCount       = @FailedPasswordAnswerAttemptCount,
           FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE  @UserId = UserId;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN @ErrorCode;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Paths_CreatePath]
@ApplicationId UNIQUEIDENTIFIER NULL, @Path NVARCHAR (256) NULL, @PathId UNIQUEIDENTIFIER NULL OUTPUT
AS
BEGIN
    BEGIN TRANSACTION;
    IF (NOT EXISTS (SELECT *
                    FROM   dbo.aspnet_Paths
                    WHERE  LoweredPath = LOWER(@Path)
                           AND ApplicationId = @ApplicationId))
        BEGIN
            INSERT  dbo.aspnet_Paths (ApplicationId, Path, LoweredPath)
            VALUES                  (@ApplicationId, @Path, LOWER(@Path));
        END
    COMMIT TRANSACTION;
    SELECT @PathId = PathId
    FROM   dbo.aspnet_Paths
    WHERE  LOWER(@Path) = LoweredPath
           AND ApplicationId = @ApplicationId;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Personalization_GetApplicationId]
@ApplicationName NVARCHAR (256) NULL, @ApplicationId UNIQUEIDENTIFIER NULL OUTPUT
AS
BEGIN
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_DeleteAllState]
@AllUsersScope BIT NULL, @ApplicationName NVARCHAR (256) NULL, @Count INT NULL OUTPUT
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0;
    ELSE
        BEGIN
            IF (@AllUsersScope = 1)
                DELETE aspnet_PersonalizationAllUsers
                WHERE  PathId IN (SELECT Paths.PathId
                                  FROM   dbo.aspnet_Paths AS Paths
                                  WHERE  Paths.ApplicationId = @ApplicationId);
            ELSE
                DELETE aspnet_PersonalizationPerUser
                WHERE  PathId IN (SELECT Paths.PathId
                                  FROM   dbo.aspnet_Paths AS Paths
                                  WHERE  Paths.ApplicationId = @ApplicationId);
            SELECT @Count = @@ROWCOUNT;
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_FindState]
@AllUsersScope BIT NULL, @ApplicationName NVARCHAR (256) NULL, @PageIndex INT NULL, @PageSize INT NULL, @Path NVARCHAR (256) NULL=NULL, @UserName NVARCHAR (256) NULL=NULL, @InactiveSinceDate DATETIME NULL=NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        RETURN;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndex (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        ItemId  UNIQUEIDENTIFIER
    );
    IF (@AllUsersScope = 1)
        BEGIN
            INSERT INTO #PageIndex (ItemId)
            SELECT   Paths.PathId
            FROM     dbo.aspnet_Paths AS Paths, ((SELECT Paths.PathId
                                                  FROM   dbo.aspnet_PersonalizationAllUsers AS AllUsers, dbo.aspnet_Paths AS Paths
                                                  WHERE  Paths.ApplicationId = @ApplicationId
                                                         AND AllUsers.PathId = Paths.PathId
                                                         AND (@Path IS NULL
                                                              OR Paths.LoweredPath LIKE LOWER(@Path))) AS SharedDataPerPath
                                                 FULL OUTER JOIN
                                                 (SELECT DISTINCT Paths.PathId
                                                  FROM   dbo.aspnet_PersonalizationPerUser AS PerUser, dbo.aspnet_Paths AS Paths
                                                  WHERE  Paths.ApplicationId = @ApplicationId
                                                         AND PerUser.PathId = Paths.PathId
                                                         AND (@Path IS NULL
                                                              OR Paths.LoweredPath LIKE LOWER(@Path))) AS UserDataPerPath
                                                 ON SharedDataPerPath.PathId = UserDataPerPath.PathId)
            WHERE    Paths.PathId = SharedDataPerPath.PathId
                     OR Paths.PathId = UserDataPerPath.PathId
            ORDER BY Paths.Path ASC;
            SELECT @TotalRecords = @@ROWCOUNT;
            SELECT   Paths.Path,
                     SharedDataPerPath.LastUpdatedDate,
                     SharedDataPerPath.SharedDataLength,
                     UserDataPerPath.UserDataLength,
                     UserDataPerPath.UserCount
            FROM     dbo.aspnet_Paths AS Paths, ((SELECT PageIndex.ItemId AS PathId,
                                                         AllUsers.LastUpdatedDate AS LastUpdatedDate,
                                                         DATALENGTH(AllUsers.PageSettings) AS SharedDataLength
                                                  FROM   dbo.aspnet_PersonalizationAllUsers AS AllUsers, #PageIndex AS PageIndex
                                                  WHERE  AllUsers.PathId = PageIndex.ItemId
                                                         AND PageIndex.IndexId >= @PageLowerBound
                                                         AND PageIndex.IndexId <= @PageUpperBound) AS SharedDataPerPath
                                                 FULL OUTER JOIN
                                                 (SELECT   PageIndex.ItemId AS PathId,
                                                           SUM(DATALENGTH(PerUser.PageSettings)) AS UserDataLength,
                                                           COUNT(*) AS UserCount
                                                  FROM     aspnet_PersonalizationPerUser AS PerUser, #PageIndex AS PageIndex
                                                  WHERE    PerUser.PathId = PageIndex.ItemId
                                                           AND PageIndex.IndexId >= @PageLowerBound
                                                           AND PageIndex.IndexId <= @PageUpperBound
                                                  GROUP BY PageIndex.ItemId) AS UserDataPerPath
                                                 ON SharedDataPerPath.PathId = UserDataPerPath.PathId)
            WHERE    Paths.PathId = SharedDataPerPath.PathId
                     OR Paths.PathId = UserDataPerPath.PathId
            ORDER BY Paths.Path ASC;
        END
    ELSE
        BEGIN
            INSERT INTO #PageIndex (ItemId)
            SELECT   PerUser.Id
            FROM     dbo.aspnet_PersonalizationPerUser AS PerUser, dbo.aspnet_Users AS Users, dbo.aspnet_Paths AS Paths
            WHERE    Paths.ApplicationId = @ApplicationId
                     AND PerUser.UserId = Users.UserId
                     AND PerUser.PathId = Paths.PathId
                     AND (@Path IS NULL
                          OR Paths.LoweredPath LIKE LOWER(@Path))
                     AND (@UserName IS NULL
                          OR Users.LoweredUserName LIKE LOWER(@UserName))
                     AND (@InactiveSinceDate IS NULL
                          OR Users.LastActivityDate <= @InactiveSinceDate)
            ORDER BY Paths.Path ASC, Users.UserName ASC;
            SELECT @TotalRecords = @@ROWCOUNT;
            SELECT   Paths.Path,
                     PerUser.LastUpdatedDate,
                     DATALENGTH(PerUser.PageSettings),
                     Users.UserName,
                     Users.LastActivityDate
            FROM     dbo.aspnet_PersonalizationPerUser AS PerUser, dbo.aspnet_Users AS Users, dbo.aspnet_Paths AS Paths, #PageIndex AS PageIndex
            WHERE    PerUser.Id = PageIndex.ItemId
                     AND PerUser.UserId = Users.UserId
                     AND PerUser.PathId = Paths.PathId
                     AND PageIndex.IndexId >= @PageLowerBound
                     AND PageIndex.IndexId <= @PageUpperBound
            ORDER BY Paths.Path ASC, Users.UserName ASC;
        END
    RETURN @TotalRecords;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_GetCountOfState]
@Count INT NULL OUTPUT, @AllUsersScope BIT NULL, @ApplicationName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL=NULL, @UserName NVARCHAR (256) NULL=NULL, @InactiveSinceDate DATETIME NULL=NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0;
    ELSE
        IF (@AllUsersScope = 1)
            SELECT @Count = COUNT(*)
            FROM   dbo.aspnet_PersonalizationAllUsers AS AllUsers, dbo.aspnet_Paths AS Paths
            WHERE  Paths.ApplicationId = @ApplicationId
                   AND AllUsers.PathId = Paths.PathId
                   AND (@Path IS NULL
                        OR Paths.LoweredPath LIKE LOWER(@Path));
        ELSE
            SELECT @Count = COUNT(*)
            FROM   dbo.aspnet_PersonalizationPerUser AS PerUser, dbo.aspnet_Users AS Users, dbo.aspnet_Paths AS Paths
            WHERE  Paths.ApplicationId = @ApplicationId
                   AND PerUser.UserId = Users.UserId
                   AND PerUser.PathId = Paths.PathId
                   AND (@Path IS NULL
                        OR Paths.LoweredPath LIKE LOWER(@Path))
                   AND (@UserName IS NULL
                        OR Users.LoweredUserName LIKE LOWER(@UserName))
                   AND (@InactiveSinceDate IS NULL
                        OR Users.LastActivityDate <= @InactiveSinceDate);
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetSharedState]
@Count INT NULL OUTPUT, @ApplicationName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0;
    ELSE
        BEGIN
            DELETE dbo.aspnet_PersonalizationAllUsers
            WHERE  PathId IN (SELECT AllUsers.PathId
                              FROM   dbo.aspnet_PersonalizationAllUsers AS AllUsers, dbo.aspnet_Paths AS Paths
                              WHERE  Paths.ApplicationId = @ApplicationId
                                     AND AllUsers.PathId = Paths.PathId
                                     AND Paths.LoweredPath = LOWER(@Path));
            SELECT @Count = @@ROWCOUNT;
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetUserState]
@Count INT NULL OUTPUT, @ApplicationName NVARCHAR (256) NULL, @InactiveSinceDate DATETIME NULL=NULL, @UserName NVARCHAR (256) NULL=NULL, @Path NVARCHAR (256) NULL=NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0;
    ELSE
        BEGIN
            DELETE dbo.aspnet_PersonalizationPerUser
            WHERE  Id IN (SELECT PerUser.Id
                          FROM   dbo.aspnet_PersonalizationPerUser AS PerUser, dbo.aspnet_Users AS Users, dbo.aspnet_Paths AS Paths
                          WHERE  Paths.ApplicationId = @ApplicationId
                                 AND PerUser.UserId = Users.UserId
                                 AND PerUser.PathId = Paths.PathId
                                 AND (@InactiveSinceDate IS NULL
                                      OR Users.LastActivityDate <= @InactiveSinceDate)
                                 AND (@UserName IS NULL
                                      OR Users.LoweredUserName = LOWER(@UserName))
                                 AND (@Path IS NULL
                                      OR Paths.LoweredPath = LOWER(@Path)));
            SELECT @Count = @@ROWCOUNT;
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT p.PageSettings
    FROM   dbo.aspnet_PersonalizationAllUsers AS p
    WHERE  p.PathId = @PathId;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            RETURN;
        END
    DELETE dbo.aspnet_PersonalizationAllUsers
    WHERE  PathId = @PathId;
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL, @PageSettings IMAGE NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    EXECUTE dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT;
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            EXECUTE dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT;
        END
    IF (EXISTS (SELECT PathId
                FROM   dbo.aspnet_PersonalizationAllUsers
                WHERE  PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationAllUsers
        SET    PageSettings    = @PageSettings,
               LastUpdatedDate = @CurrentTimeUtc
        WHERE  PathId = @PathId;
    ELSE
        INSERT  INTO dbo.aspnet_PersonalizationAllUsers (PathId, PageSettings, LastUpdatedDate)
        VALUES                                         (@PathId, @PageSettings, @CurrentTimeUtc);
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_GetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    SELECT @UserId = NULL;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredUserName = LOWER(@UserName);
    IF (@UserId IS NULL)
        BEGIN
            RETURN;
        END
    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET    LastActivityDate = @CurrentTimeUtc
    WHERE  UserId = @UserId;
    IF (@@ROWCOUNT = 0)
        RETURN;
    SELECT p.PageSettings
    FROM   dbo.aspnet_PersonalizationPerUser AS p
    WHERE  p.PathId = @PathId
           AND p.UserId = @UserId;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    SELECT @UserId = NULL;
    EXECUTE dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT;
    IF (@ApplicationId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            RETURN;
        END
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredUserName = LOWER(@UserName);
    IF (@UserId IS NULL)
        BEGIN
            RETURN;
        END
    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET    LastActivityDate = @CurrentTimeUtc
    WHERE  UserId = @UserId;
    IF (@@ROWCOUNT = 0)
        RETURN;
    DELETE dbo.aspnet_PersonalizationPerUser
    WHERE  PathId = @PathId
           AND UserId = @UserId;
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_SetPageSettings]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @Path NVARCHAR (256) NULL, @PageSettings IMAGE NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    DECLARE @PathId AS UNIQUEIDENTIFIER;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @PathId = NULL;
    SELECT @UserId = NULL;
    EXECUTE dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT;
    SELECT @PathId = u.PathId
    FROM   dbo.aspnet_Paths AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredPath = LOWER(@Path);
    IF (@PathId IS NULL)
        BEGIN
            EXECUTE dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT;
        END
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u
    WHERE  u.ApplicationId = @ApplicationId
           AND u.LoweredUserName = LOWER(@UserName);
    IF (@UserId IS NULL)
        BEGIN
            EXECUTE dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT;
        END
    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET    LastActivityDate = @CurrentTimeUtc
    WHERE  UserId = @UserId;
    IF (@@ROWCOUNT = 0)
        RETURN;
    IF (EXISTS (SELECT PathId
                FROM   dbo.aspnet_PersonalizationPerUser
                WHERE  UserId = @UserId
                       AND PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationPerUser
        SET    PageSettings    = @PageSettings,
               LastUpdatedDate = @CurrentTimeUtc
        WHERE  UserId = @UserId
               AND PathId = @PathId;
    ELSE
        INSERT  INTO dbo.aspnet_PersonalizationPerUser (UserId, PathId, PageSettings, LastUpdatedDate)
        VALUES                                        (@UserId, @PathId, @PageSettings, @CurrentTimeUtc);
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteInactiveProfiles]
@ApplicationName NVARCHAR (256) NULL, @ProfileAuthOptions INT NULL, @InactiveSinceDate DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        BEGIN
            SELECT 0;
            RETURN;
        END
    DELETE dbo.aspnet_Profile
    WHERE  UserId IN (SELECT UserId
                      FROM   dbo.aspnet_Users AS u
                      WHERE  ApplicationId = @ApplicationId
                             AND (LastActivityDate <= @InactiveSinceDate)
                             AND ((@ProfileAuthOptions = 2)
                                  OR (@ProfileAuthOptions = 0
                                      AND IsAnonymous = 1)
                                  OR (@ProfileAuthOptions = 1
                                      AND IsAnonymous = 0)));
    SELECT @@ROWCOUNT;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteProfiles]
@ApplicationName NVARCHAR (256) NULL, @UserNames NVARCHAR (4000) NULL
AS
BEGIN
    DECLARE @UserName AS NVARCHAR (256);
    DECLARE @CurrentPos AS INT;
    DECLARE @NextPos AS INT;
    DECLARE @NumDeleted AS INT;
    DECLARE @DeletedUser AS INT;
    DECLARE @TranStarted AS BIT;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    SET @CurrentPos = 1;
    SET @NumDeleted = 0;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    WHILE (@CurrentPos <= LEN(@UserNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @UserNames, @CurrentPos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@UserNames) + 1;
            SELECT @UserName = SUBSTRING(@UserNames, @CurrentPos, @NextPos - @CurrentPos);
            SELECT @CurrentPos = @NextPos + 1;
            IF (LEN(@UserName) > 0)
                BEGIN
                    SELECT @DeletedUser = 0;
                    EXECUTE dbo.aspnet_Users_DeleteUser @ApplicationName, @UserName, 4, @DeletedUser OUTPUT;
                    IF (@@ERROR <> 0)
                        BEGIN
                            SET @ErrorCode = -1;
                            GOTO Cleanup;
                        END
                    IF (@DeletedUser <> 0)
                        SELECT @NumDeleted = @NumDeleted + 1;
                END
        END
    SELECT @NumDeleted;
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    SET @TranStarted = 0;
    RETURN 0;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]
@ApplicationName NVARCHAR (256) NULL, @ProfileAuthOptions INT NULL, @InactiveSinceDate DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        BEGIN
            SELECT 0;
            RETURN;
        END
    SELECT COUNT(*)
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Profile AS p
    WHERE  ApplicationId = @ApplicationId
           AND u.UserId = p.UserId
           AND (LastActivityDate <= @InactiveSinceDate)
           AND ((@ProfileAuthOptions = 2)
                OR (@ProfileAuthOptions = 0
                    AND IsAnonymous = 1)
                OR (@ProfileAuthOptions = 1
                    AND IsAnonymous = 0));
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetProfiles]
@ApplicationName NVARCHAR (256) NULL, @ProfileAuthOptions INT NULL, @PageIndex INT NULL, @PageSize INT NULL, @UserNameToMatch NVARCHAR (256) NULL=NULL, @InactiveSinceDate DATETIME NULL=NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndexForUsers (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        UserId  UNIQUEIDENTIFIER
    );
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT   u.UserId
    FROM     dbo.aspnet_Users AS u, dbo.aspnet_Profile AS p
    WHERE    ApplicationId = @ApplicationId
             AND u.UserId = p.UserId
             AND (@InactiveSinceDate IS NULL
                  OR LastActivityDate <= @InactiveSinceDate)
             AND ((@ProfileAuthOptions = 2)
                  OR (@ProfileAuthOptions = 0
                      AND IsAnonymous = 1)
                  OR (@ProfileAuthOptions = 1
                      AND IsAnonymous = 0))
             AND (@UserNameToMatch IS NULL
                  OR LoweredUserName LIKE LOWER(@UserNameToMatch))
    ORDER BY UserName;
    SELECT u.UserName,
           u.IsAnonymous,
           u.LastActivityDate,
           p.LastUpdatedDate,
           DATALENGTH(p.PropertyNames) + DATALENGTH(p.PropertyValuesString) + DATALENGTH(p.PropertyValuesBinary)
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Profile AS p, #PageIndexForUsers AS i
    WHERE  u.UserId = p.UserId
           AND p.UserId = i.UserId
           AND i.IndexId >= @PageLowerBound
           AND i.IndexId <= @PageUpperBound;
    SELECT COUNT(*)
    FROM   #PageIndexForUsers;
    DROP TABLE #PageIndexForUsers;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_GetProperties]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId
           AND LoweredUserName = LOWER(@UserName);
    IF (@UserId IS NULL)
        RETURN;
    SELECT TOP 1 PropertyNames,
                 PropertyValuesString,
                 PropertyValuesBinary
    FROM   dbo.aspnet_Profile
    WHERE  UserId = @UserId;
    IF (@@ROWCOUNT > 0)
        BEGIN
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            WHERE  UserId = @UserId;
        END
END

GO
CREATE PROCEDURE [dbo].[aspnet_Profile_SetProperties]
@ApplicationName NVARCHAR (256) NULL, @PropertyNames NTEXT NULL, @PropertyValuesString NTEXT NULL, @PropertyValuesBinary IMAGE NULL, @UserName NVARCHAR (256) NULL, @IsUserAnonymous BIT NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    EXECUTE dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @LastActivityDate AS DATETIME;
    SELECT @UserId = NULL;
    SELECT @LastActivityDate = @CurrentTimeUtc;
    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId
           AND LoweredUserName = LOWER(@UserName);
    IF (@UserId IS NULL)
        EXECUTE dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, @IsUserAnonymous, @LastActivityDate, @UserId OUTPUT;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    UPDATE dbo.aspnet_Users
    SET    LastActivityDate = @CurrentTimeUtc
    WHERE  UserId = @UserId;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (EXISTS (SELECT *
                FROM   dbo.aspnet_Profile
                WHERE  UserId = @UserId))
        UPDATE dbo.aspnet_Profile
        SET    PropertyNames        = @PropertyNames,
               PropertyValuesString = @PropertyValuesString,
               PropertyValuesBinary = @PropertyValuesBinary,
               LastUpdatedDate      = @CurrentTimeUtc
        WHERE  UserId = @UserId;
    ELSE
        INSERT  INTO dbo.aspnet_Profile (UserId, PropertyNames, PropertyValuesString, PropertyValuesBinary, LastUpdatedDate)
        VALUES                         (@UserId, @PropertyNames, @PropertyValuesString, @PropertyValuesBinary, @CurrentTimeUtc);
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN 0;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_RegisterSchemaVersion]
@Feature NVARCHAR (128) NULL, @CompatibleSchemaVersion NVARCHAR (128) NULL, @IsCurrentVersion BIT NULL, @RemoveIncompatibleSchema BIT NULL
AS
BEGIN
    IF (@RemoveIncompatibleSchema = 1)
        BEGIN
            DELETE dbo.aspnet_SchemaVersions
            WHERE  Feature = LOWER(@Feature);
        END
    ELSE
        BEGIN
            IF (@IsCurrentVersion = 1)
                BEGIN
                    UPDATE dbo.aspnet_SchemaVersions
                    SET    IsCurrentVersion = 0
                    WHERE  Feature = LOWER(@Feature);
                END
        END
    INSERT  dbo.aspnet_SchemaVersions (Feature, CompatibleSchemaVersion, IsCurrentVersion)
    VALUES                           (LOWER(@Feature), @CompatibleSchemaVersion, @IsCurrentVersion);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Roles_CreateRole]
@ApplicationName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    EXECUTE dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (EXISTS (SELECT RoleId
                FROM   dbo.aspnet_Roles
                WHERE  LoweredRoleName = LOWER(@RoleName)
                       AND ApplicationId = @ApplicationId))
        BEGIN
            SET @ErrorCode = 1;
            GOTO Cleanup;
        END
    INSERT  INTO dbo.aspnet_Roles (ApplicationId, RoleName, LoweredRoleName)
    VALUES                       (@ApplicationId, @RoleName, LOWER(@RoleName));
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN (0);
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Roles_DeleteRole]
@ApplicationName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL, @DeleteOnlyIfRoleIsEmpty BIT NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    DECLARE @RoleId AS UNIQUEIDENTIFIER;
    SELECT @RoleId = NULL;
    SELECT @RoleId = RoleId
    FROM   dbo.aspnet_Roles
    WHERE  LoweredRoleName = LOWER(@RoleName)
           AND ApplicationId = @ApplicationId;
    IF (@RoleId IS NULL)
        BEGIN
            SELECT @ErrorCode = 1;
            GOTO Cleanup;
        END
    IF (@DeleteOnlyIfRoleIsEmpty <> 0)
        BEGIN
            IF (EXISTS (SELECT RoleId
                        FROM   dbo.aspnet_UsersInRoles
                        WHERE  @RoleId = RoleId))
                BEGIN
                    SELECT @ErrorCode = 2;
                    GOTO Cleanup;
                END
        END
    DELETE dbo.aspnet_UsersInRoles
    WHERE  @RoleId = RoleId;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    DELETE dbo.aspnet_Roles
    WHERE  @RoleId = RoleId
           AND ApplicationId = @ApplicationId;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN (0);
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Roles_GetAllRoles]
@ApplicationName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN;
    SELECT   RoleName
    FROM     dbo.aspnet_Roles
    WHERE    ApplicationId = @ApplicationId
    ORDER BY RoleName;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Roles_RoleExists]
@ApplicationName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (0);
    IF (EXISTS (SELECT RoleName
                FROM   dbo.aspnet_Roles
                WHERE  LOWER(@RoleName) = LoweredRoleName
                       AND ApplicationId = @ApplicationId))
        RETURN (1);
    ELSE
        RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_Setup_RemoveAllRoleMembers]
@name [sysname] NULL
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers (
        Group_name     sysname ,
        Group_id       SMALLINT,
        Users_in_group sysname ,
        User_id        SMALLINT
    );
    INSERT INTO #aspnet_RoleMembers
    EXECUTE sp_helpuser @name;
    DECLARE @user_id AS SMALLINT;
    DECLARE @cmd AS NVARCHAR (500);
    DECLARE c1 CURSOR FORWARD_ONLY
        FOR SELECT User_id
            FROM   #aspnet_RoleMembers;
    OPEN c1;
    FETCH c1 INTO @user_id;
    WHILE (@@fetch_status = 0)
        BEGIN
            SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + '''';
            EXECUTE (@cmd);
            FETCH c1 INTO @user_id;
        END
    CLOSE c1;
    DEALLOCATE c1;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Setup_RestorePermissions]
@name [sysname] NULL
AS
BEGIN
    DECLARE @object AS sysname;
    DECLARE @protectType AS CHAR (10);
    DECLARE @action AS VARCHAR (60);
    DECLARE @grantee AS sysname;
    DECLARE @cmd AS NVARCHAR (500);
    DECLARE c1 CURSOR FORWARD_ONLY
        FOR SELECT Object,
                   ProtectType,
                   [Action],
                   Grantee
            FROM   #aspnet_Permissions
            WHERE  Object = @name;
    OPEN c1;
    FETCH c1 INTO @object, @protectType, @action, @grantee;
    WHILE (@@fetch_status = 0)
        BEGIN
            SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']';
            EXECUTE (@cmd);
            FETCH c1 INTO @object, @protectType, @action, @grantee;
        END
    CLOSE c1;
    DEALLOCATE c1;
END

GO
CREATE PROCEDURE [dbo].[aspnet_UnRegisterSchemaVersion]
@Feature NVARCHAR (128) NULL, @CompatibleSchemaVersion NVARCHAR (128) NULL
AS
BEGIN
    DELETE dbo.aspnet_SchemaVersions
    WHERE  Feature = LOWER(@Feature)
           AND @CompatibleSchemaVersion = CompatibleSchemaVersion;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Users_CreateUser]
@ApplicationId UNIQUEIDENTIFIER NULL, @UserName NVARCHAR (256) NULL, @IsUserAnonymous BIT NULL, @LastActivityDate DATETIME NULL, @UserId UNIQUEIDENTIFIER NULL OUTPUT
AS
BEGIN
    IF (@UserId IS NULL)
        SELECT @UserId = NEWID();
    ELSE
        BEGIN
            IF (EXISTS (SELECT UserId
                        FROM   dbo.aspnet_Users
                        WHERE  @UserId = UserId))
                RETURN -1;
        END
    INSERT  dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
    VALUES                  (@ApplicationId, @UserId, @UserName, LOWER(@UserName), @IsUserAnonymous, @LastActivityDate);
    RETURN 0;
END

GO
CREATE PROCEDURE [dbo].[aspnet_Users_DeleteUser]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @TablesToDeleteFrom INT NULL, @NumTablesDeletedFrom INT NULL OUTPUT
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @NumTablesDeletedFrom = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    DECLARE @ErrorCode AS INT;
    DECLARE @RowCount AS INT;
    SET @ErrorCode = 0;
    SET @RowCount = 0;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a
    WHERE  u.LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName;
    IF (@UserId IS NULL)
        BEGIN
            GOTO Cleanup;
        END
    IF ((@TablesToDeleteFrom & 1) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_MembershipUsers')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_Membership
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 2) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_UsersInRoles')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_UsersInRoles
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 4) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_Profiles')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_Profile
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 8) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_WebPartState_User')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_PersonalizationPerUser
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 1) <> 0
        AND (@TablesToDeleteFrom & 2) <> 0
        AND (@TablesToDeleteFrom & 4) <> 0
        AND (@TablesToDeleteFrom & 8) <> 0
        AND (EXISTS (SELECT UserId
                     FROM   dbo.aspnet_Users
                     WHERE  @UserId = UserId)))
        BEGIN
            DELETE dbo.aspnet_Users
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN 0;
    Cleanup:
    SET @NumTablesDeletedFrom = 0;
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_AddUsersToRoles]
@ApplicationName NVARCHAR (256) NULL, @UserNames NVARCHAR (4000) NULL, @RoleNames NVARCHAR (4000) NULL, @CurrentTimeUtc DATETIME NULL
AS
BEGIN
    DECLARE @AppId AS UNIQUEIDENTIFIER;
    SELECT @AppId = NULL;
    SELECT @AppId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@AppId IS NULL)
        RETURN (2);
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    DECLARE @tbNames TABLE (
        Name NVARCHAR (256) NOT NULL PRIMARY KEY);
    DECLARE @tbRoles TABLE (
        RoleId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @tbUsers TABLE (
        UserId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @Num AS INT;
    DECLARE @Pos AS INT;
    DECLARE @NextPos AS INT;
    DECLARE @Name AS NVARCHAR (256);
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@RoleNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @RoleNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@RoleNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbRoles
    SELECT RoleId
    FROM   dbo.aspnet_Roles AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredRoleName
           AND ar.ApplicationId = @AppId;
    IF (@@ROWCOUNT <> @Num)
        BEGIN
            SELECT TOP 1 Name
            FROM   @tbNames
            WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName
                                       FROM   dbo.aspnet_Roles AS ar, @tbRoles AS r
                                       WHERE  r.RoleId = ar.RoleId);
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (2);
        END
    DELETE @tbNames
    WHERE  1 = 1;
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@UserNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @UserNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@UserNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbUsers
    SELECT UserId
    FROM   dbo.aspnet_Users AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredUserName
           AND ar.ApplicationId = @AppId;
    IF (@@ROWCOUNT <> @Num)
        BEGIN
            DELETE @tbNames
            WHERE  LOWER(Name) IN (SELECT LoweredUserName
                                   FROM   dbo.aspnet_Users AS au, @tbUsers AS u
                                   WHERE  au.UserId = u.UserId);
            INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
            SELECT @AppId,
                   NEWID(),
                   Name,
                   LOWER(Name),
                   0,
                   @CurrentTimeUtc
            FROM   @tbNames;
            INSERT INTO @tbUsers
            SELECT UserId
            FROM   dbo.aspnet_Users AS au, @tbNames AS t
            WHERE  LOWER(t.Name) = au.LoweredUserName
                   AND au.ApplicationId = @AppId;
        END
    IF (EXISTS (SELECT *
                FROM   dbo.aspnet_UsersInRoles AS ur, @tbUsers AS tu, @tbRoles AS tr
                WHERE  tu.UserId = ur.UserId
                       AND tr.RoleId = ur.RoleId))
        BEGIN
            SELECT TOP 1 UserName,
                         RoleName
            FROM   dbo.aspnet_UsersInRoles AS ur, @tbUsers AS tu, @tbRoles AS tr, aspnet_Users AS u, aspnet_Roles AS r
            WHERE  u.UserId = tu.UserId
                   AND r.RoleId = tr.RoleId
                   AND tu.UserId = ur.UserId
                   AND tr.RoleId = ur.RoleId;
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (3);
        END
    INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
    SELECT UserId,
           RoleId
    FROM   @tbUsers, @tbRoles;
    IF (@TranStarted = 1)
        COMMIT TRANSACTION;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_FindUsersInRole]
@ApplicationName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL, @UserNameToMatch NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @RoleId AS UNIQUEIDENTIFIER;
    SELECT @RoleId = NULL;
    SELECT @RoleId = RoleId
    FROM   dbo.aspnet_Roles
    WHERE  LOWER(@RoleName) = LoweredRoleName
           AND ApplicationId = @ApplicationId;
    IF (@RoleId IS NULL)
        RETURN (1);
    SELECT   u.UserName
    FROM     dbo.aspnet_Users AS u, dbo.aspnet_UsersInRoles AS ur
    WHERE    u.UserId = ur.UserId
             AND @RoleId = ur.RoleId
             AND u.ApplicationId = @ApplicationId
             AND LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetRolesForUser]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  LoweredUserName = LOWER(@UserName)
           AND ApplicationId = @ApplicationId;
    IF (@UserId IS NULL)
        RETURN (1);
    SELECT   r.RoleName
    FROM     dbo.aspnet_Roles AS r, dbo.aspnet_UsersInRoles AS ur
    WHERE    r.RoleId = ur.RoleId
             AND r.ApplicationId = @ApplicationId
             AND ur.UserId = @UserId
    ORDER BY r.RoleName;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetUsersInRoles]
@ApplicationName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @RoleId AS UNIQUEIDENTIFIER;
    SELECT @RoleId = NULL;
    SELECT @RoleId = RoleId
    FROM   dbo.aspnet_Roles
    WHERE  LOWER(@RoleName) = LoweredRoleName
           AND ApplicationId = @ApplicationId;
    IF (@RoleId IS NULL)
        RETURN (1);
    SELECT   u.UserName
    FROM     dbo.aspnet_Users AS u, dbo.aspnet_UsersInRoles AS ur
    WHERE    u.UserId = ur.UserId
             AND @RoleId = ur.RoleId
             AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_IsUserInRole]
@ApplicationName NVARCHAR (256) NULL, @UserName NVARCHAR (256) NULL, @RoleName NVARCHAR (256) NULL
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (2);
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    DECLARE @RoleId AS UNIQUEIDENTIFIER;
    SELECT @RoleId = NULL;
    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  LoweredUserName = LOWER(@UserName)
           AND ApplicationId = @ApplicationId;
    IF (@UserId IS NULL)
        RETURN (2);
    SELECT @RoleId = RoleId
    FROM   dbo.aspnet_Roles
    WHERE  LoweredRoleName = LOWER(@RoleName)
           AND ApplicationId = @ApplicationId;
    IF (@RoleId IS NULL)
        RETURN (3);
    IF (EXISTS (SELECT *
                FROM   dbo.aspnet_UsersInRoles
                WHERE  UserId = @UserId
                       AND RoleId = @RoleId))
        RETURN (1);
    ELSE
        RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]
@ApplicationName NVARCHAR (256) NULL, @UserNames NVARCHAR (4000) NULL, @RoleNames NVARCHAR (4000) NULL
AS
BEGIN
    DECLARE @AppId AS UNIQUEIDENTIFIER;
    SELECT @AppId = NULL;
    SELECT @AppId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@AppId IS NULL)
        RETURN (2);
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    DECLARE @tbNames TABLE (
        Name NVARCHAR (256) NOT NULL PRIMARY KEY);
    DECLARE @tbRoles TABLE (
        RoleId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @tbUsers TABLE (
        UserId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @Num AS INT;
    DECLARE @Pos AS INT;
    DECLARE @NextPos AS INT;
    DECLARE @Name AS NVARCHAR (256);
    DECLARE @CountAll AS INT;
    DECLARE @CountU AS INT;
    DECLARE @CountR AS INT;
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@RoleNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @RoleNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@RoleNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbRoles
    SELECT RoleId
    FROM   dbo.aspnet_Roles AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredRoleName
           AND ar.ApplicationId = @AppId;
    SELECT @CountR = @@ROWCOUNT;
    IF (@CountR <> @Num)
        BEGIN
            SELECT TOP 1 N'',
                         Name
            FROM   @tbNames
            WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName
                                       FROM   dbo.aspnet_Roles AS ar, @tbRoles AS r
                                       WHERE  r.RoleId = ar.RoleId);
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (2);
        END
    DELETE @tbNames
    WHERE  1 = 1;
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@UserNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @UserNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@UserNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbUsers
    SELECT UserId
    FROM   dbo.aspnet_Users AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredUserName
           AND ar.ApplicationId = @AppId;
    SELECT @CountU = @@ROWCOUNT;
    IF (@CountU <> @Num)
        BEGIN
            SELECT TOP 1 Name,
                         N''
            FROM   @tbNames
            WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName
                                       FROM   dbo.aspnet_Users AS au, @tbUsers AS u
                                       WHERE  u.UserId = au.UserId);
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (1);
        END
    SELECT @CountAll = COUNT(*)
    FROM   dbo.aspnet_UsersInRoles AS ur, @tbUsers AS u, @tbRoles AS r
    WHERE  ur.UserId = u.UserId
           AND ur.RoleId = r.RoleId;
    IF (@CountAll <> @CountU * @CountR)
        BEGIN
            SELECT TOP 1 UserName,
                         RoleName
            FROM   @tbUsers AS tu, @tbRoles AS tr, dbo.aspnet_Users AS u, dbo.aspnet_Roles AS r
            WHERE  u.UserId = tu.UserId
                   AND r.RoleId = tr.RoleId
                   AND tu.UserId NOT IN (SELECT ur.UserId
                                         FROM   dbo.aspnet_UsersInRoles AS ur
                                         WHERE  ur.RoleId = tr.RoleId)
                   AND tr.RoleId NOT IN (SELECT ur.RoleId
                                         FROM   dbo.aspnet_UsersInRoles AS ur
                                         WHERE  ur.UserId = tu.UserId);
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (3);
        END
    DELETE dbo.aspnet_UsersInRoles
    WHERE  UserId IN (SELECT UserId
                      FROM   @tbUsers)
           AND RoleId IN (SELECT RoleId
                          FROM   @tbRoles);
    IF (@TranStarted = 1)
        COMMIT TRANSACTION;
    RETURN (0);
END

GO
CREATE PROCEDURE [dbo].[aspnet_WebEvent_LogEvent]
@EventId CHAR (32) NULL, @EventTimeUtc DATETIME NULL, @EventTime DATETIME NULL, @EventType NVARCHAR (256) NULL, @EventSequence DECIMAL (19) NULL, @EventOccurrence DECIMAL (19) NULL, @EventCode INT NULL, @EventDetailCode INT NULL, @Message NVARCHAR (1024) NULL, @ApplicationPath NVARCHAR (256) NULL, @ApplicationVirtualPath NVARCHAR (256) NULL, @MachineName NVARCHAR (256) NULL, @RequestUrl NVARCHAR (1024) NULL, @ExceptionType NVARCHAR (256) NULL, @Details NTEXT NULL
AS
BEGIN
    INSERT  dbo.aspnet_WebEvent_Events (EventId, EventTimeUtc, EventTime, EventType, EventSequence, EventOccurrence, EventCode, EventDetailCode, Message, ApplicationPath, ApplicationVirtualPath, MachineName, RequestUrl, ExceptionType, Details)
    VALUES                            (@EventId, @EventTimeUtc, @EventTime, @EventType, @EventSequence, @EventOccurrence, @EventCode, @EventDetailCode, @Message, @ApplicationPath, @ApplicationVirtualPath, @MachineName, @RequestUrl, @ExceptionType, @Details);
END

GO
CREATE SCHEMA [aspnet_Membership_BasicAccess]
    AUTHORIZATION [aspnet_Membership_BasicAccess];

GO
CREATE SCHEMA [aspnet_Membership_FullAccess]
    AUTHORIZATION [aspnet_Membership_FullAccess];

GO
CREATE SCHEMA [aspnet_Membership_ReportingAccess]
    AUTHORIZATION [aspnet_Membership_ReportingAccess];

GO
CREATE SCHEMA [aspnet_Personalization_BasicAccess]
    AUTHORIZATION [aspnet_Personalization_BasicAccess];

GO
CREATE SCHEMA [aspnet_Personalization_FullAccess]
    AUTHORIZATION [aspnet_Personalization_FullAccess];

GO
CREATE SCHEMA [aspnet_Personalization_ReportingAccess]
    AUTHORIZATION [aspnet_Personalization_ReportingAccess];

GO
CREATE SCHEMA [aspnet_Profile_BasicAccess]
    AUTHORIZATION [aspnet_Profile_BasicAccess];

GO
CREATE SCHEMA [aspnet_Profile_FullAccess]
    AUTHORIZATION [aspnet_Profile_FullAccess];

GO
CREATE SCHEMA [aspnet_Profile_ReportingAccess]
    AUTHORIZATION [aspnet_Profile_ReportingAccess];

GO
CREATE SCHEMA [aspnet_Roles_BasicAccess]
    AUTHORIZATION [aspnet_Roles_BasicAccess];

GO
CREATE SCHEMA [aspnet_Roles_FullAccess]
    AUTHORIZATION [aspnet_Roles_FullAccess];

GO
CREATE SCHEMA [aspnet_Roles_ReportingAccess]
    AUTHORIZATION [aspnet_Roles_ReportingAccess];

GO
CREATE SCHEMA [aspnet_WebEvent_FullAccess]
    AUTHORIZATION [aspnet_WebEvent_FullAccess];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetNumberOfUsersOnline] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetPassword] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetPasswordWithFormat] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByEmail] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByName] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByUserId] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_UpdateUserInfo] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Membership_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_CreateUser] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_ResetPassword] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_SetPassword] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_UnlockUser] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_UpdateUser] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Users_DeleteUser] TO [aspnet_Membership_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_FindUsersByEmail] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_FindUsersByName] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetAllUsers] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetNumberOfUsersOnline] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByEmail] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByName] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Membership_GetUserByUserId] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Paths_CreatePath] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Personalization_GetApplicationId] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAllUsers_GetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAllUsers_SetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationPerUser_GetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationPerUser_ResetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationPerUser_SetPageSettings] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAdministration_DeleteAllState] TO [aspnet_Personalization_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAdministration_ResetSharedState] TO [aspnet_Personalization_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAdministration_ResetUserState] TO [aspnet_Personalization_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAdministration_FindState] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_PersonalizationAdministration_GetCountOfState] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Profile_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_GetProperties] TO [aspnet_Profile_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_SetProperties] TO [aspnet_Profile_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Profile_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Profile_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_DeleteInactiveProfiles] TO [aspnet_Profile_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_DeleteProfiles] TO [aspnet_Profile_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_GetNumberOfInactiveProfiles] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Profile_GetProfiles] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Roles_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Roles_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Roles_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_GetRolesForUser] TO [aspnet_Roles_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_IsUserInRole] TO [aspnet_Roles_BasicAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Roles_CreateRole] TO [aspnet_Roles_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Roles_DeleteRole] TO [aspnet_Roles_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_AddUsersToRoles] TO [aspnet_Roles_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles] TO [aspnet_Roles_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Roles_GetAllRoles] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Roles_RoleExists] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_FindUsersInRole] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_GetRolesForUser] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_GetUsersInRoles] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UsersInRoles_IsUserInRole] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_UnRegisterSchemaVersion] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_WebEvent_LogEvent] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Applications] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_MembershipUsers] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Applications] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_WebPartState_Paths] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_WebPartState_Shared] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_WebPartState_User] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Applications] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Profiles] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Applications] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Roles] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_UsersInRoles] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO PUBLIC;

GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO PUBLIC;

GO

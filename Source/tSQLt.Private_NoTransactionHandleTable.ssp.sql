IF OBJECT_ID('tSQLt.Private_NoTransactionHandleTable') IS NOT NULL DROP PROCEDURE tSQLt.Private_NoTransactionHandleTable;
GO
---Build+
GO
CREATE PROCEDURE tSQLt.Private_NoTransactionHandleTable
@Action NVARCHAR(MAX),
@FullTableName NVARCHAR(MAX),
@TableAction NVARCHAR(MAX)
AS
BEGIN
  IF (@Action = 'Save')
  BEGIN
    DECLARE @NewQuotedName NVARCHAR(MAX) = '[tSQLt].'+QUOTENAME(tSQLt.Private::CreateUniqueObjectName());
    DECLARE @Cmd NVARCHAR(MAX) = 'SELECT * INTO '+@NewQuotedName+' FROM '+@FullTableName+';';
    EXEC (@Cmd);
    INSERT INTO #TableBackupLog (OriginalName, BackupName) VALUES (@FullTableName, @NewQuotedName);
  END;
  ELSE
  BEGIN
    RAISERROR('Invalid Action. @Action parameter must be one of the following: Save, Reset.',16,10);
  END;
END;
GO

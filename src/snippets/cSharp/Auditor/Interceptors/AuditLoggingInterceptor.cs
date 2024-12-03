using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;

namespace Auditor.Interceptors;

public class AuditLoggingInterceptor(ILogger<AuditLoggingInterceptor> logger, IAuditLogger<DbContext>? auditLogger = null) : ISaveChangesInterceptor
{
    
    private IAuditLogger<DbContext> auditLogger = auditLogger ?? new AuditLogger(logger);
    private IAuditLogger<DbContext> AuditLogger => this.auditLogger;
    private readonly ILogger<AuditLoggingInterceptor> logger;

    public void ExcludeTables(ICollection<string> tablesToExclude)
    {
        this.auditLogger.SetExcludedEntities(tablesToExclude);
    }

    #region SavingChanges
    public async ValueTask<InterceptionResult<int>> SavingChangesAsync(DbContextEventData eventData, InterceptionResult<int> result, CancellationToken cancellationToken = default)
    {
        await Task.Run(SavingChanges(eventData, result), cancellationToken).ConfigureAwait(true);
        return result;
    }

    public InterceptionResult<int> SavingChanges(DbContextEventData eventData, InterceptionResult<int> result)
    {
        try
        {
            auditLogger.StartEntry(eventData.Context);
        }
        catch (Exception ex) { 
            auditLogger.Failed();
            this.logger.ExceptionOccurred(ex, auditLogger.InstanceId, "Error occurred gather audit details", nameof(auditLogger.StartEntry));
        }
        return result;
    }
    #endregion

    #region SavedChanges
    public int SavedChanges(SaveChangesCompletedEventData eventData, int result)
    {
        auditLogger.EndEntry();
        return result;
    }

    public async ValueTask<int> SavedChangesAsync(SaveChangesCompletedEventData eventData, int result, CancellationToken cancellationToken = default)
    {
        await Task.Run(SavedChanges(eventData, result), cancellationToken).ConfigureAwait(true);
        return result;
    }
    #endregion

}
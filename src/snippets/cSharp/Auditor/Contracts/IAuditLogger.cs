namespace Auditor.Contracts;

public interface IAuditLogger<T> where T : class
{

    public Guid InstanceId { get; }

    /// <summary>
    /// Start of audit this is where the elements are gather 
    /// </summary>
    /// <param name="context"></param>
    public void StartEntry(T? context);

    /// <summary>
    /// Finalize the audit details
    /// </summary>
    public void EndEntry();

    /// <summary>
    /// method to excluded entities from auditing
    /// </summary>
    /// <param name="excludedEntities"></param>
    public void SetExcludedEntities(ICollection<string> excludedEntities);

    /// <summary>
    /// Failed to gather audit details
    /// </summary>
    public void Failed();

}
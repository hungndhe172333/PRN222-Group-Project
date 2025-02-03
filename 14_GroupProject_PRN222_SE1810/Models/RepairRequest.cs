using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class RepairRequest
{
    public long RequestId { get; set; }

    public long WarrantyId { get; set; }

    public long UserId { get; set; }

    public DateTime RequestDate { get; set; }

    public string ProblemDescription { get; set; } = null!;

    public string Status { get; set; } = null!;

    public string? TechnicianNote { get; set; }

    public decimal? EstimatedCost { get; set; }

    public DateTime? CompletionDate { get; set; }

    public virtual Warranty Warranty { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class Warranty
{
    public long WarrantyId { get; set; }

    public string ProductId { get; set; } = null!;

    public long BillId { get; set; }

    public DateOnly WarrantyStartDate { get; set; }

    public DateOnly WarrantyEndDate { get; set; }

    public string SerialNumber { get; set; } = null!;

    public string WarrantyStatus { get; set; } = null!;

    public string? WarrantyNote { get; set; }

    public virtual Bill Bill { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;

    public virtual ICollection<RepairRequest> RepairRequests { get; set; } = new List<RepairRequest>();
}

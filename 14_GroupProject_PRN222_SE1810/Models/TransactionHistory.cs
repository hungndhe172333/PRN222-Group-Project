using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class TransactionHistory
{
    public long TransactionId { get; set; }

    public long? BillId { get; set; }

    public long UserId { get; set; }

    public string TransactionType { get; set; } = null!;

    public decimal Amount { get; set; }

    public DateTime TransactionDate { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public string Status { get; set; } = null!;

    public string? ReferenceNumber { get; set; }

    public string? Description { get; set; }

    public virtual Bill? Bill { get; set; }

    public virtual User User { get; set; } = null!;
}

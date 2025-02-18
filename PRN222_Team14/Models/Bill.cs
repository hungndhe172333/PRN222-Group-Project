using System;
using System.Collections.Generic;

namespace ElectronicShopTeam14.Models;

public partial class Bill
{
    public long BillId { get; set; }

    public long UserId { get; set; }

    public decimal Total { get; set; }

    public string Payment { get; set; } = null!;

    public string Address { get; set; } = null!;

    public DateOnly Date { get; set; }

    public long Phone { get; set; }

    public virtual ICollection<BillDetail> BillDetails { get; set; } = new List<BillDetail>();

    public virtual ICollection<Shipping> Shippings { get; set; } = new List<Shipping>();

    public virtual ICollection<TransactionHistory> TransactionHistories { get; set; } = new List<TransactionHistory>();

    public virtual User User { get; set; } = null!;

    public virtual ICollection<Warranty> Warranties { get; set; } = new List<Warranty>();
}

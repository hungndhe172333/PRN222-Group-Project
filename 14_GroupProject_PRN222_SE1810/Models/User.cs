using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class User
{
    public long UserId { get; set; }

    public string? UserName { get; set; }

    public string UserEmail { get; set; } = null!;

    public string UserPass { get; set; } = null!;

    public string? IsAdmin { get; set; }

    public string? DateOfBirth { get; set; }

    public string? Address { get; set; }

    public string? PhoneNumber { get; set; }

    public bool? Banned { get; set; }

    public string? AdminReason { get; set; }

    public string? IsStoreStaff { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual ICollection<ProductComment> ProductComments { get; set; } = new List<ProductComment>();

    public virtual ICollection<Report> Reports { get; set; } = new List<Report>();

    public virtual ICollection<TransactionHistory> TransactionHistories { get; set; } = new List<TransactionHistory>();
}

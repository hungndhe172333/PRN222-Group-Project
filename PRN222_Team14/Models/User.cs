using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ElectronicShopTeam14.Models;

public partial class User
{
    [Column("user_id")]
    public long UserId { get; set; }

    [Column("user_name")]
    public string? UserName { get; set; }

    [Column("user_email")]
    public string UserEmail { get; set; } = null!;

    [Column("user_pass")]
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

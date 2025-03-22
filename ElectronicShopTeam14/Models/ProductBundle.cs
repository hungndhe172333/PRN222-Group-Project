using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class ProductBundle
{
    [Key]
    public long BundleId { get; set; }

    public string BundleName { get; set; } = null!;

    public string? BundleDescription { get; set; }

    public decimal DiscountPercentage { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}

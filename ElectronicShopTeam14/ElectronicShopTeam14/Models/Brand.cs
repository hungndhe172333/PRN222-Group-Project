using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class Brand
{
    [Key]
    public int BrandId { get; set; }

    public string BrandName { get; set; } = null!;

    public string? BrandDescription { get; set; }

    public string? BrandCountry { get; set; }

    public string? BrandLogo { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}

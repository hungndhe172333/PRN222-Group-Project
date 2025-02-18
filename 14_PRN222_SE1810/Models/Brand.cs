using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class Brand
{
    public int BrandId { get; set; }

    public string BrandName { get; set; } = null!;

    public string? BrandDescription { get; set; }

    public string? BrandCountry { get; set; }

    public string? BrandLogo { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}

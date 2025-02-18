using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class ProductSaleOff
{
    public int SaleId { get; set; }

    public string? ProductId { get; set; }

    public decimal? DiscountPercentage { get; set; }

    public DateOnly? StartDate { get; set; }

    public DateOnly? EndDate { get; set; }

    public virtual Product? Product { get; set; }
}

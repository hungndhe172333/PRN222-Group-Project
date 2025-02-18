using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class ProductSaleOff
{
    [Key]
    public int SaleId { get; set; }

    public string? ProductId { get; set; }

    public decimal? DiscountPercentage { get; set; }

    public DateOnly? StartDate { get; set; }

    public DateOnly? EndDate { get; set; }

    public virtual Product? Product { get; set; }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class ProductActive
{
    [Key]
    public string ProductId { get; set; } = null!;

    public string Active { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

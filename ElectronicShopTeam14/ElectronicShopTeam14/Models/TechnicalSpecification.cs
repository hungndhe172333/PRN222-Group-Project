using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class TechnicalSpecification
{
    [Key]
    public long SpecId { get; set; }

    public string ProductId { get; set; } = null!;

    public string SpecName { get; set; } = null!;

    public string SpecValue { get; set; } = null!;

    public string SpecGroup { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

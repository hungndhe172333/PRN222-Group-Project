using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class TechnicalSpecification
{
    public long SpecId { get; set; }

    public string ProductId { get; set; } = null!;

    public string SpecName { get; set; } = null!;

    public string SpecValue { get; set; } = null!;

    public string SpecGroup { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

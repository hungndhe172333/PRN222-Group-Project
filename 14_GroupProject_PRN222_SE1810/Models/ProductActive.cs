using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class ProductActive
{
    public string ProductId { get; set; } = null!;

    public string Active { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class ProductColor
{
    public string ProductId { get; set; } = null!;

    public string Color { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

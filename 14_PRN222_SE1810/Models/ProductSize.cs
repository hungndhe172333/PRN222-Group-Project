using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class ProductSize
{
    public string ProductId { get; set; } = null!;

    public string Size { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

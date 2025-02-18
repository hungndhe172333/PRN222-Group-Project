using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class Cart
{
    public long CartId { get; set; }

    public string ProductId { get; set; } = null!;

    public string ProductName { get; set; } = null!;

    public string ProductImg { get; set; } = null!;

    public double ProductPrice { get; set; }

    public double Total { get; set; }

    public int Quantity { get; set; }

    public virtual Product Product { get; set; } = null!;
}

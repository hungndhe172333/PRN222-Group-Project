using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class BillDetail
{
    public long DetailId { get; set; }

    public long BillId { get; set; }

    public string ProductId { get; set; } = null!;

    public int Quantity { get; set; }

    public string Size { get; set; } = null!;

    public string Color { get; set; } = null!;

    public decimal Price { get; set; }

    public virtual Bill Bill { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

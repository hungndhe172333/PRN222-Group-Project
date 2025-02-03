using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class Category
{
    public int CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}

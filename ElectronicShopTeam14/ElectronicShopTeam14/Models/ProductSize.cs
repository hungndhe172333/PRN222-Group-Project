﻿using System;
using System.Collections.Generic;

namespace ElectronicShopTeam14.Models;

public partial class ProductSize
{
    public string ProductId { get; set; } = null!;

    public string Size { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}

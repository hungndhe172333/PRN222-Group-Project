using System;
using System.Collections.Generic;

namespace ElectronicShopTeam14.Models;

public partial class About
{
    public int AboutId { get; set; }

    public string? Title { get; set; }

    public string? ImageUrl { get; set; }

    public string? Content { get; set; }
}

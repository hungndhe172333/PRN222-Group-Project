using System;
using System.Collections.Generic;

namespace ElectronicShopTeam14.Models;

public partial class ProductComment
{
    public int Id { get; set; }

    public string? ProductId { get; set; }

    public long? UserId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int? Rating { get; set; }

    public string? Comment { get; set; }

    public string? UserName { get; set; }

    public virtual Product? Product { get; set; }

    public virtual User? User { get; set; }
}

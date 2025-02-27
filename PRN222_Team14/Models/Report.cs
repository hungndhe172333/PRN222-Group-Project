using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models;

public partial class Report
{
    [Key]
    public long IdReport { get; set; }

    public long? UserId { get; set; }

    public string? ContentReport { get; set; }

    public string? SubjectReport { get; set; }

    public string? UserEmail { get; set; }

    public virtual User? User { get; set; }
}

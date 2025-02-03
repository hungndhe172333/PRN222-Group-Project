using System;
using System.Collections.Generic;

namespace _14_GroupProject_PRN222_SE1810.Models;

public partial class Report
{
    public long IdReport { get; set; }

    public long? UserId { get; set; }

    public string? ContentReport { get; set; }

    public string? SubjectReport { get; set; }

    public string? UserEmail { get; set; }

    public virtual User? User { get; set; }
}

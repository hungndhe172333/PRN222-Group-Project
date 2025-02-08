using System;
using System.Collections.Generic;

namespace _14_PRN222_SE1810.Models;

public partial class Shipping
{
    public long ShippingId { get; set; }

    public long BillId { get; set; }

    public string ShippingMethod { get; set; } = null!;

    public string ShippingStatus { get; set; } = null!;

    public string? TrackingNumber { get; set; }

    public DateOnly? EstimatedDeliveryDate { get; set; }

    public DateOnly? ActualDeliveryDate { get; set; }

    public decimal ShippingFee { get; set; }

    public string ShippingAddress { get; set; } = null!;

    public string ReceiverName { get; set; } = null!;

    public string ReceiverPhone { get; set; } = null!;

    public virtual Bill Bill { get; set; } = null!;
}

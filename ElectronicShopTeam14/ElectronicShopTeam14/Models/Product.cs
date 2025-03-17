using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ElectronicShopTeam14.Models;

public partial class Product
{
    public string ProductId { get; set; } = null!;

    public int CategoryId { get; set; }

    public string ProductName { get; set; } = null!;

    public decimal ProductPrice { get; set; }

    public string ProductDescribe { get; set; } = null!;

    public int Quantity { get; set; }

    public string Img { get; set; } = null!;

    public int? BrandId { get; set; }

    public int? WarrantyMonths { get; set; }

    public string? TechnicalSpecs { get; set; }

    public string? ModelNumber { get; set; }

    [JsonIgnore]
    public virtual ICollection<BillDetail> BillDetails { get; set; } = new List<BillDetail>();

    public virtual Brand? Brand { get; set; }

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();

    public virtual Category Category { get; set; } = null!;

    public virtual ProductActive? ProductActive { get; set; }

    public virtual ICollection<ProductComment> ProductComments { get; set; } = new List<ProductComment>();

    public virtual ICollection<ProductSaleOff> ProductSaleOffs { get; set; } = new List<ProductSaleOff>();

    public virtual ICollection<TechnicalSpecification> TechnicalSpecifications { get; set; } = new List<TechnicalSpecification>();

    public virtual ICollection<Warranty> Warranties { get; set; } = new List<Warranty>();

    public virtual ICollection<ProductBundle> Bundles { get; set; } = new List<ProductBundle>();
}

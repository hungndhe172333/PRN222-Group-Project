using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ElectronicShopTeam14.Models;

public partial class Product
{
    [Column("product_id")] // Map đúng tên cột trong SQL
    public int ProductId { get; set; }

    [Column("category_id")]
    public int CategoryId { get; set; }

    [Column("product_name")]
    public string ProductName { get; set; } = string.Empty;

    [Column("product_price")]
    public decimal ProductPrice { get; set; }

    [Column("product_describe")]
    public string? ProductDescribe { get; set; }

    [Column("quantity")]
    public int Quantity { get; set; }

    [Column("img")]
    public string? Img { get; set; }

    [Column("brand_id")]
    public int? BrandId { get; set; }

    [Column("warranty_months")]
    public int? WarrantyMonths { get; set; }

    [Column("technical_specs")]
    public string? TechnicalSpecs { get; set; }

    [Column("model_number")]
    public string? ModelNumber { get; set; }



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

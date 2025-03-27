using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ElectronicShopTeam14.Models;

public partial class ElectronicShopTeam14Context : DbContext
{
    public ElectronicShopTeam14Context()
    {
    }

    public ElectronicShopTeam14Context(DbContextOptions<ElectronicShopTeam14Context> options)
        : base(options)
    {
    }

    public virtual DbSet<About> Abouts { get; set; }

    public virtual DbSet<Bill> Bills { get; set; }

    public virtual DbSet<BillDetail> BillDetails { get; set; }

    public virtual DbSet<Brand> Brands { get; set; }

    public virtual DbSet<Cart> Carts { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductActive> ProductActives { get; set; }

    public virtual DbSet<ProductBundle> ProductBundles { get; set; }

    public virtual DbSet<ProductColor> ProductColors { get; set; }

    public virtual DbSet<ProductComment> ProductComments { get; set; }

    public virtual DbSet<ProductSaleOff> ProductSaleOffs { get; set; }

    public virtual DbSet<ProductSize> ProductSizes { get; set; }

    public virtual DbSet<RepairRequest> RepairRequests { get; set; }

    public virtual DbSet<Report> Reports { get; set; }

    public virtual DbSet<Shipping> Shippings { get; set; }

    public virtual DbSet<TechnicalSpecification> TechnicalSpecifications { get; set; }

    public virtual DbSet<TransactionHistory> TransactionHistories { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<Warranty> Warranties { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectionStrings:ElectronicShopTeam14DB");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<About>(entity =>
        {
            entity.HasKey(e => e.AboutId).HasName("PK__About__717FC93CEBEF2512");

            entity.ToTable("About");

            entity.Property(e => e.ImageUrl)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("ImageURL");
            entity.Property(e => e.Title).HasMaxLength(255);
        });

        modelBuilder.Entity<Bill>(entity =>
        {
            entity.ToTable("bill");

            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.Address)
                .HasColumnType("ntext")
                .HasColumnName("address");
            entity.Property(e => e.Date).HasColumnName("date");
            entity.Property(e => e.Payment)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("payment");
            entity.Property(e => e.Phone).HasColumnName("phone");
            entity.Property(e => e.Total)
                .HasColumnType("money")
                .HasColumnName("total");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Bills)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_bill_users");
        });

        modelBuilder.Entity<BillDetail>(entity =>
        {
            entity.HasKey(e => e.DetailId);

            entity.ToTable("bill_detail");

            entity.Property(e => e.DetailId).HasColumnName("detail_id");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.Color)
                .HasMaxLength(150)
                .HasColumnName("color");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.Size)
                .HasMaxLength(10)
                .IsFixedLength()
                .HasColumnName("size");

            entity.HasOne(d => d.Bill).WithMany(p => p.BillDetails)
                .HasForeignKey(d => d.BillId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_bill_detail_bill");

            entity.HasOne(d => d.Product).WithMany(p => p.BillDetails)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_bill_detail_product");
        });

        modelBuilder.Entity<Brand>(entity =>
        {
            entity.ToTable("brand");

            entity.Property(e => e.BrandId).HasColumnName("brand_id");
            entity.Property(e => e.BrandCountry)
                .HasMaxLength(100)
                .HasColumnName("brand_country");
            entity.Property(e => e.BrandDescription).HasColumnName("brand_description");
            entity.Property(e => e.BrandLogo)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("brand_logo");
            entity.Property(e => e.BrandName)
                .HasMaxLength(255)
                .HasColumnName("brand_name");
        });

        modelBuilder.Entity<Cart>(entity =>
        {
            entity.ToTable("cart");

            entity.Property(e => e.CartId)
                .ValueGeneratedNever()
                .HasColumnName("cart_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.ProductImg)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("product_img");
            entity.Property(e => e.ProductName)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("product_name");
            entity.Property(e => e.ProductPrice).HasColumnName("product_price");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.Total).HasColumnName("total");

            entity.HasOne(d => d.Product).WithMany(p => p.Carts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_cart_product");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.ToTable("category");

            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(255)
                .HasColumnName("category_name");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.ToTable("product");

            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.BrandId).HasColumnName("brand_id");
            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.Img)
                .HasMaxLength(50)
                .HasColumnName("img");
            entity.Property(e => e.ModelNumber)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("model_number");
            entity.Property(e => e.ProductDescribe).HasColumnName("product_describe");
            entity.Property(e => e.ProductName).HasColumnName("product_name");
            entity.Property(e => e.ProductPrice)
                .HasColumnType("money")
                .HasColumnName("product_price");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.TechnicalSpecs).HasColumnName("technical_specs");
            entity.Property(e => e.WarrantyMonths).HasColumnName("warranty_months");

            entity.HasOne(d => d.Brand).WithMany(p => p.Products)
                .HasForeignKey(d => d.BrandId)
                .HasConstraintName("FK_product_brand");

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_product_category");
        });

        modelBuilder.Entity<ProductActive>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__product___47027DF5DC6D8D18");

            entity.ToTable("product_active");

            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Active)
                .HasMaxLength(255)
                .HasColumnName("active");

            entity.HasOne(d => d.Product).WithOne(p => p.ProductActive)
                .HasForeignKey<ProductActive>(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ProductActive_Product");
        });

        modelBuilder.Entity<ProductBundle>(entity =>
        {
            entity.HasKey(e => e.BundleId);

            entity.ToTable("product_bundle");

            entity.Property(e => e.BundleId).HasColumnName("bundle_id");
            entity.Property(e => e.BundleDescription).HasColumnName("bundle_description");
            entity.Property(e => e.BundleName)
                .HasMaxLength(255)
                .HasColumnName("bundle_name");
            entity.Property(e => e.DiscountPercentage)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("discount_percentage");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.StartDate).HasColumnName("start_date");

            entity.HasMany(d => d.Products).WithMany(p => p.Bundles)
                .UsingEntity<Dictionary<string, object>>(
                    "BundleDetail",
                    r => r.HasOne<Product>().WithMany()
                        .HasForeignKey("ProductId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_bundle_detail_product"),
                    l => l.HasOne<ProductBundle>().WithMany()
                        .HasForeignKey("BundleId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_bundle_detail_bundle"),
                    j =>
                    {
                        j.HasKey("BundleId", "ProductId");
                        j.ToTable("bundle_detail");
                        j.IndexerProperty<long>("BundleId").HasColumnName("bundle_id");
                        j.IndexerProperty<string>("ProductId")
                            .HasMaxLength(100)
                            .IsUnicode(false)
                            .HasColumnName("product_id");
                    });
        });

        modelBuilder.Entity<ProductColor>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("product_color");

            entity.Property(e => e.Color)
                .HasMaxLength(50)
                .HasColumnName("color");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_product_color_product");
        });

        modelBuilder.Entity<ProductComment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__product___3213E83F2CF1DE7B");

            entity.ToTable("product_comment");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Comment)
                .HasMaxLength(255)
                .HasColumnName("comment");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.UserName)
                .HasMaxLength(255)
                .HasColumnName("user_name");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductComments)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__product_c__produ__7A672E12");

            entity.HasOne(d => d.User).WithMany(p => p.ProductComments)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__product_c__user___7B5B524B");
        });

        modelBuilder.Entity<ProductSaleOff>(entity =>
        {
            entity.HasKey(e => e.SaleId).HasName("PK__product___E1EB00B2A73E104C");

            entity.ToTable("product_saleOFF");

            entity.Property(e => e.SaleId)
                .ValueGeneratedNever()
                .HasColumnName("sale_id");
            entity.Property(e => e.DiscountPercentage)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("discount_percentage");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.StartDate).HasColumnName("start_date");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductSaleOffs)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__product_s__produ__7C4F7684");
        });

        modelBuilder.Entity<ProductSize>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("product_size");

            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Size)
                .HasMaxLength(50)
                .HasColumnName("size");

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_product_size_product");
        });

        modelBuilder.Entity<RepairRequest>(entity =>
        {
            entity.HasKey(e => e.RequestId);

            entity.ToTable("repair_request");

            entity.Property(e => e.RequestId).HasColumnName("request_id");
            entity.Property(e => e.CompletionDate)
                .HasColumnType("datetime")
                .HasColumnName("completion_date");
            entity.Property(e => e.EstimatedCost)
                .HasColumnType("money")
                .HasColumnName("estimated_cost");
            entity.Property(e => e.ProblemDescription).HasColumnName("problem_description");
            entity.Property(e => e.RequestDate)
                .HasColumnType("datetime")
                .HasColumnName("request_date");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.TechnicianNote).HasColumnName("technician_note");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.WarrantyId).HasColumnName("warranty_id");

            entity.HasOne(d => d.Warranty).WithMany(p => p.RepairRequests)
                .HasForeignKey(d => d.WarrantyId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_repair_request_warranty");
        });

        modelBuilder.Entity<Report>(entity =>
        {
            entity.HasKey(e => e.IdReport).HasName("PK__report__D8639F52C8DC8CF0");

            entity.ToTable("report");

            entity.Property(e => e.IdReport).HasColumnName("id_report");
            entity.Property(e => e.ContentReport).HasColumnName("content_report");
            entity.Property(e => e.SubjectReport)
                .HasMaxLength(255)
                .HasColumnName("subject_report");
            entity.Property(e => e.UserEmail)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("user_email");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Reports)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_user_id");
        });

        modelBuilder.Entity<Shipping>(entity =>
        {
            entity.ToTable("shipping");

            entity.Property(e => e.ShippingId).HasColumnName("shipping_id");
            entity.Property(e => e.ActualDeliveryDate).HasColumnName("actual_delivery_date");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.EstimatedDeliveryDate).HasColumnName("estimated_delivery_date");
            entity.Property(e => e.ReceiverName)
                .HasMaxLength(200)
                .HasColumnName("receiver_name");
            entity.Property(e => e.ReceiverPhone)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("receiver_phone");
            entity.Property(e => e.ShippingAddress).HasColumnName("shipping_address");
            entity.Property(e => e.ShippingFee)
                .HasColumnType("money")
                .HasColumnName("shipping_fee");
            entity.Property(e => e.ShippingMethod)
                .HasMaxLength(100)
                .HasColumnName("shipping_method");
            entity.Property(e => e.ShippingStatus)
                .HasMaxLength(50)
                .HasColumnName("shipping_status");
            entity.Property(e => e.TrackingNumber)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("tracking_number");

            entity.HasOne(d => d.Bill).WithMany(p => p.Shippings)
                .HasForeignKey(d => d.BillId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_shipping_bill");
        });

        modelBuilder.Entity<TechnicalSpecification>(entity =>
        {
            entity.HasKey(e => e.SpecId);

            entity.ToTable("technical_specifications");

            entity.Property(e => e.SpecId).HasColumnName("spec_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.SpecGroup)
                .HasMaxLength(50)
                .HasColumnName("spec_group");
            entity.Property(e => e.SpecName)
                .HasMaxLength(100)
                .HasColumnName("spec_name");
            entity.Property(e => e.SpecValue)
                .HasMaxLength(255)
                .HasColumnName("spec_value");

            entity.HasOne(d => d.Product).WithMany(p => p.TechnicalSpecifications)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_technical_specifications_product");
        });

        modelBuilder.Entity<TransactionHistory>(entity =>
        {
            entity.HasKey(e => e.TransactionId);

            entity.ToTable("transaction_history");

            entity.Property(e => e.TransactionId).HasColumnName("transaction_id");
            entity.Property(e => e.Amount)
                .HasColumnType("money")
                .HasColumnName("amount");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(100)
                .HasColumnName("payment_method");
            entity.Property(e => e.ReferenceNumber)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("reference_number");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.TransactionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("transaction_date");
            entity.Property(e => e.TransactionType)
                .HasMaxLength(50)
                .HasColumnName("transaction_type");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Bill).WithMany(p => p.TransactionHistories)
                .HasForeignKey(d => d.BillId)
                .HasConstraintName("FK_transaction_history_bill");

            entity.HasOne(d => d.User).WithMany(p => p.TransactionHistories)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_transaction_history_user");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("users");

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.Address)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("address");
            entity.Property(e => e.AdminReason)
                .HasMaxLength(50)
                .HasColumnName("adminReason");
            entity.Property(e => e.Banned)
                .HasDefaultValue(false)
                .HasColumnName("banned");
            entity.Property(e => e.DateOfBirth)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("dateOfBirth");
            entity.Property(e => e.IsAdmin)
                .HasMaxLength(50)
                .HasColumnName("isAdmin");
            entity.Property(e => e.IsStoreStaff)
                .HasMaxLength(50)
                .HasColumnName("isStoreStaff");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("phoneNumber");
            entity.Property(e => e.UserEmail)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("user_email");
            entity.Property(e => e.UserName)
                .HasMaxLength(200)
                .HasColumnName("user_name");
            entity.Property(e => e.UserPass)
                .HasMaxLength(255)
                .HasColumnName("user_pass");
        });

        modelBuilder.Entity<Warranty>(entity =>
        {
            entity.ToTable("warranty");

            entity.Property(e => e.WarrantyId).HasColumnName("warranty_id");
            entity.Property(e => e.BillId).HasColumnName("bill_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.SerialNumber)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("serial_number");
            entity.Property(e => e.WarrantyEndDate).HasColumnName("warranty_end_date");
            entity.Property(e => e.WarrantyNote).HasColumnName("warranty_note");
            entity.Property(e => e.WarrantyStartDate).HasColumnName("warranty_start_date");
            entity.Property(e => e.WarrantyStatus)
                .HasMaxLength(50)
                .HasColumnName("warranty_status");

            entity.HasOne(d => d.Bill).WithMany(p => p.Warranties)
                .HasForeignKey(d => d.BillId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_warranty_bill");

            entity.HasOne(d => d.Product).WithMany(p => p.Warranties)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_warranty_product");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

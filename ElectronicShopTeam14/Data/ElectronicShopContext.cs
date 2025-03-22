using Microsoft.EntityFrameworkCore;

namespace ElectronicShopTeam14.Models
{
    public class ElectronicShopContext : DbContext
    {
        public ElectronicShopContext(DbContextOptions<ElectronicShopContext> options)
            : base(options)
        {
        }

        // Định nghĩa các DbSet tương ứng với các bảng trong database
        public DbSet<User> Users { get; set; }
        public DbSet<Bill> Bills { get; set; }
        public DbSet<ProductComment> ProductComments { get; set; }
        public DbSet<Report> Reports { get; set; }
        public DbSet<TransactionHistory> TransactionHistories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Cấu hình các ràng buộc hoặc quan hệ giữa các bảng (nếu cần)
            base.OnModelCreating(modelBuilder);
        }
    }
}
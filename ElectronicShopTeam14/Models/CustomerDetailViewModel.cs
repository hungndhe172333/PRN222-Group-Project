namespace ElectronicShopTeam14.Models
{
    public class CustomerDetailViewModel : CustomerViewModel
    {
        public int TotalBills { get; set; }
        public int TotalComments { get; set; }
        public int TotalTransactions { get; set; }
        public List<Bill> RecentBills { get; set; }
        public List<ProductComment> RecentComments { get; set; }
    }
}

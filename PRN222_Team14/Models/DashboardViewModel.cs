namespace ElectronicShopTeam14.Models
{
    public class DashboardViewModel
    {
        public int ProductCount { get; set; }
        public int UserCount { get; set; }
        public int BillCount { get; set; }
        public int LowStockProductCount { get; set; }
        public List<Bill> BillsToday { get; set; }
        public List<Bill> Bills { get; set; }
    }
}
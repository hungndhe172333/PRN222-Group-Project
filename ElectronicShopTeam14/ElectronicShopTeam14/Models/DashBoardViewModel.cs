using X.PagedList;

namespace ElectronicShopTeam14.Models
{
    public class DashBoardViewModel
    {
        public int TotalOrders { get; set; }
        public int TotalProducts { get; set; }
        public int TotalCustomers { get; set; }
        public decimal TotalMoney { get; set; }
        public decimal OrdersLastWeekPercentage { get; set; }
        public decimal ProductsLastMonthPercentage { get; set; }
        public decimal CustomersLastMonthPercentage { get; set; }
        public decimal MoneyLastMonthPercentage { get; set; }
        public List<CategoryChartData> CategoryData { get; set; }
        public List<BrandChartData> BrandData { get; set; }
        public List<MonthlyRevenueChartData> MonthlyRevenueData { get; set; }
        public List<PaymentMethodChartData> PaymentMethodData { get; set; }
		public IPagedList<Bill> Bills { get; set; }
	}
}

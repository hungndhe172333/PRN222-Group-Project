using X.PagedList;
namespace ElectronicShopTeam14.Models
{
    public class TransactionHistoryViewModel
    {
        public List<TransactionHistory> TransactionHistories { get; set; }
        public List<Bill> Bills { get; set; }
    }
}

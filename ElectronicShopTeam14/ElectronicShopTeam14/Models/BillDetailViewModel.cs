using X.PagedList;
namespace ElectronicShopTeam14.Models
{
    public class BillDetailViewModel
    {
        public Bill Bill { get; set; }
        public List<BillDetail> BillDetails { get; set; }
        public List<Product> Products { get; set; }
    }
}

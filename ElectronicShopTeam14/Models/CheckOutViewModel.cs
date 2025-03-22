namespace ElectronicShopTeam14.Models
{
    public class CheckOutViewModel
    {
        public List<Cart> CartItems { get; set; }
        public decimal SubTotal { get; set; }
        public decimal ShippingFee { get; set; }
        public decimal Total { get; set; }
    }
}

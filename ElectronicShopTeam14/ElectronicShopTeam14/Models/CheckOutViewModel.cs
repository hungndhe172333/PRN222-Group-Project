namespace ElectronicShopTeam14.Models
{
    public class CheckOutViewModel
    {
        public List<CartItem> CartItems { get; set; }
        public decimal SubTotal { get; set; }
        public decimal ShippingFee { get; set; }
        public decimal Total { get; set; }
        public string UserName { get; set; }

    }
}

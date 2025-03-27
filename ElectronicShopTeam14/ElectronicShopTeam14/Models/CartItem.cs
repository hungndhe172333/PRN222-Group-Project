namespace ElectronicShopTeam14.Models
{
    public class CartItem
    {
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImg { get; set; }
        public double ProductPrice { get; set; }
        public int Quantity { get; set; }
        public double Total { get; set; }
        public string Size { get; set; }
        public string Color { get; set; }


        // Optional: Reference to Product if needed
        public Product Product { get; set; }
    }
}

namespace ElectronicShopTeam14.Models
{
    public class ProductViewModel
    {
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal ProductPrice { get; set; }
        public string ProductDescribe { get; set; }
        public int Quantity { get; set; }
        public string Img { get; set; }
        public bool IsActive { get; set; }
        public string BrandLogo { get; set; }
    }
}

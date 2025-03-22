namespace ElectronicShopTeam14.Models
{
    public class BrandViewModel
    {
        public int BrandId { get; set; }
        public string BrandName { get; set; }
        public string? BrandDescription { get; set; }
        public string? BrandCountry { get; set; }
        public string? BrandLogo { get; set; }
        public int ProductCount { get; set; }
        public IFormFile? ImageFile { get; set; }

    }
}

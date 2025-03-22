using X.PagedList;
namespace ElectronicShopTeam14.Models
{
    public class ShopViewModel
    {
        public List<Category> Categories { get; set; }
        public List<Brand> Brands { get; set; }
        public List<ProductColor> Colors { get; set; }
        public List<Product> RecommendedProducts { get; set; }
        public List<Product> TopSmartphones { get; set; }
        public IPagedList<Product> AllProducts { get; set; }
        public int? SelectedCategoryId { get; set; }
        public List<int> SelectedBrandId { get; set; }
        public List<String> SelectedColor { get; set; }
        public decimal MinPrice { get; set; }
        public decimal MaxPrice { get; set; }


    }
}

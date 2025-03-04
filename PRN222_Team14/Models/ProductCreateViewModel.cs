using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models
{
    public class ProductCreateViewModel
    {
        [Required(ErrorMessage = "Product ID is required")]
        public string ProductId { get; set; }

        [Required(ErrorMessage = "Product name is required")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Category is required")]
        public int CategoryId { get; set; }

        [Required(ErrorMessage = "Price is required")]
        [Range(0.01, double.MaxValue, ErrorMessage = "Price must be greater than 0")]
        public decimal ProductPrice { get; set; }

        [Required(ErrorMessage = "Description is required")]
        public string ProductDescribe { get; set; }

        [Required(ErrorMessage = "Quantity is required")]
        [Range(1, int.MaxValue, ErrorMessage = "Quantity must be at least 1")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Please upload an image")]
        public IFormFile ImageFile { get; set; }

        public int? BrandId { get; set; }
        public string BrandName { get; set; } 

        public int? WarrantyMonths { get; set; }
        public string ModelNumber { get; set; }
        public string TechnicalSpecs { get; set; }
        [Required(ErrorMessage = "Active status is required")]
        public string Active { get; set; } = "Yes";

        // Color and Size selections
        public List<string> SelectedColors { get; set; }
        public List<string> SelectedSizes { get; set; }

        // Discount info
        public decimal? Discount { get; set; }
    }
}

using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Security.Claims;
using X.PagedList.Extensions;

namespace ElectronicShopTeam14.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ElectronicShopTeam14Context _context;

        public HomeController(ILogger<HomeController> logger, ElectronicShopTeam14Context context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }


        public IActionResult Privacy()
        {
            return View();
        }
        public IActionResult About()
        {
            return View();
        }

        public IActionResult Contact()
        {
            return View();
        }

        public IActionResult FAQ()
        {
            return View();
        }
        public IActionResult TermsAndConditions()
        {
            return View();
        }
        public IActionResult Error404()
        {
            return View();
        }
        public IActionResult TrackOrder()
        {
            return View();
        }
        public IActionResult Product_detail(string id)
        {
            var product = _context.Products
        .Include(p => p.Category)
        .FirstOrDefault(p => p.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }
            // Get colors for this product
            var productColors = _context.ProductColors
                .Where(pc => pc.ProductId == id)
                .ToList();
            // Get comments/reviews for this product
            var productComments = _context.ProductComments
                .Where(c => c.ProductId == id)
                .OrderByDescending(c => c.CreatedAt)
                .ToList();

            // Calculate average rating
            double averageRating = 0;
            if (productComments.Any() && productComments.Any(c => c.Rating.HasValue))
            {
                averageRating = Math.Round(productComments.Where(c => c.Rating.HasValue).Average(c => c.Rating.Value), 1);
            }

            // Count reviews by rating
            var ratingCounts = new int[5];
            for (int i = 0; i < 5; i++)
            {
                int ratingValue = 5 - i;
                ratingCounts[i] = productComments.Count(c => c.Rating == ratingValue);
            }

            // Pass both the product and its colors to the view
            ViewBag.ProductColors = productColors;
            ViewBag.ProductComments = productComments;
            ViewBag.AverageRating = averageRating;
            ViewBag.RatingCounts = ratingCounts;
            ViewBag.TotalReviews = productComments.Count;
            return View("Product_detail",product);
        }

        [HttpPost]
        public IActionResult AddComment(ProductComment comment)
        {
            if (ModelState.IsValid)
            {
                
                comment.CreatedAt = DateTime.Now;

                
                if (User.Identity.IsAuthenticated)
                {
                    comment.UserId = long.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
                }

                _context.ProductComments.Add(comment);
                _context.SaveChanges();

                return RedirectToAction("Product_detail", new { id = comment.ProductId });
            }

            
            return RedirectToAction("Product_detail", new { id = comment.ProductId });
        }
        public IActionResult Cart()
        {
            return View();
        }

        public IActionResult Checkout()
        {
            return View();
        }

		public IActionResult Shop1(int? page, int? categoryId, int[] brandId, string[] colorString, decimal? minPrice, decimal? maxPrice, string searchTerm)
        {
            int pageSize = 20;
            int pageNumber = (page ?? 1);

            var categories = _context.Categories
                .Include(c => c.Products)
                .ToList();

            var brands = _context.Brands
                .Include(c => c.Products)
                .ToList();

            var colors = _context.ProductColors
                .GroupBy(pc => pc.Color)
                .Select(g => g.First())
                .ToList();

            var viewModel = new ShopViewModel
            {
                Categories = categories,
                Brands = brands,
                Colors = colors,
				SelectedBrandId = brandId.ToList(),
                SelectedColor = colorString.ToList(),
                MinPrice = minPrice ?? 0,
                MaxPrice = maxPrice ?? 99999999
            };

            // Query sản phẩm
            var query = _context.Products.AsQueryable();

            if (categoryId.HasValue)
			{
				query = query.Where(p => p.CategoryId == categoryId.Value);
			}
			if (brandId != null && brandId.Any())
			{
				query = query.Where(p => p.BrandId.HasValue && brandId.Contains(p.BrandId.Value));
			}
            if (colorString != null && colorString.Any())
            {
                // Lọc sản phẩm có màu nằm trong danh sách chọn
                var productIdsWithSelectedColors = _context.ProductColors
                    .Where(pc => colorString.Contains(pc.Color))
                    .Select(pc => pc.ProductId)
                    .Distinct();

                query = query.Where(p => productIdsWithSelectedColors.Contains(p.ProductId));
            }
			if (!string.IsNullOrEmpty(searchTerm))
			{
				searchTerm = searchTerm.ToLower();
				query = query.Where(p =>
					p.ProductId.ToLower().Contains(searchTerm) ||
					p.ProductName.ToLower().Contains(searchTerm)
				);
			}

			// Lọc theo khoảng giá
			query = query.Where(p => p.ProductPrice >= viewModel.MinPrice && p.ProductPrice <= viewModel.MaxPrice);

            viewModel.AllProducts = query.OrderBy(p => p.ProductName).ToPagedList(pageNumber, pageSize);

			var tvCategory = _context.Categories
                .Include(c => c.Products)
                .FirstOrDefault(c => c.CategoryName == "TV");

            var recommendedTvs = tvCategory?.Products.ToList() ?? new List<Product>();

            var smartphoneCategory = _context.Categories
                .Include(c => c.Products)
                .FirstOrDefault(c => c.CategoryName == "SMARTPHONE");

            //Get 5 product smartphone have highest price
            var topSmartphones = smartphoneCategory?.Products
                .OrderByDescending(p => p.ProductPrice)
                .Take(5)
                .ToList() ?? new List<Product>();
            

            viewModel.RecommendedProducts = recommendedTvs;
            viewModel.TopSmartphones = topSmartphones;
            
            return View("Shop1", viewModel);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

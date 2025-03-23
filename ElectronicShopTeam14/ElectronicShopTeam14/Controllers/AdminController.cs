using ElectronicShopTeam14.Models;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Text;
using X.PagedList.Extensions;


namespace ElectronicShopTeam14.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly ElectronicShopTeam14Context _context;
        private readonly IWebHostEnvironment _hostEnvironment;

        public AdminController(ElectronicShopTeam14Context context, IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            _hostEnvironment = hostEnvironment;
        }
        public IActionResult Index()
        {
            return View();
        }

        //DASHBOARD//

        public IActionResult DashBoard()
        {
            var categories = _context.Categories.ToList();
            var totalProducts = _context.Products.Count();
            var categoryData = new List<CategoryChartData>();

            //categories
            foreach (var category in categories)
            {
                var productCount = _context.Products.Count(p => p.CategoryId == category.CategoryId);
                var percentage = totalProducts > 0 ? (decimal)productCount / totalProducts * 100 : 0;

                categoryData.Add(new CategoryChartData
                {
                    CategoryName = category.CategoryName,
                    ProductCount = productCount,
                    Percentage = Math.Round(percentage, 2)
                });
            }

            //Brand
            var brands = _context.Brands.ToList();

            var brandData = new List<BrandChartData>();
            foreach (var brand in brands)
            {
                var productCount = _context.Products.Count(p => p.BrandId == brand.BrandId);
                var percentage = totalProducts > 0 ? (decimal)productCount / totalProducts * 100 : 0;

                brandData.Add(new BrandChartData
                {
                    BrandName = brand.BrandName,
                    ProductCount = productCount,
                    Percentage = Math.Round(percentage, 2)
                });
            }

			//Revenue Month
			var currentYear = DateTime.Now.Year;

			var monthlyRevenue = _context.Bills
				.Where(b => b.Date.Year == currentYear) // Lọc hóa đơn trong năm hiện tại
				.GroupBy(b => b.Date.Month)
				.Select(g => new
				{
					Month = g.Key,
					TotalRevenue = g.Sum(b => b.Total),
                    OrderCount = g.Count()
				})
				.OrderBy(g => g.Month)
				.ToList();

			var monthlyRevenueData = new List<MonthlyRevenueChartData>();
			for (int i = 1; i <= 12; i++)
			{
				var data = monthlyRevenue.FirstOrDefault(m => m.Month == i);
				monthlyRevenueData.Add(new MonthlyRevenueChartData
				{
					Month = i,
					TotalRevenue = data != null ? data.TotalRevenue : 0,
					OrderCount = data != null ? data.OrderCount : 0
				});
			}

			//Payment
			var allBills = _context.Bills.ToList();
            var totalBills = allBills.Count;

            var paymentMethodData = new List<PaymentMethodChartData>();

            if (totalBills > 0)
            {
                var paymentMethods = allBills.GroupBy(b => b.Payment)
                                            .Select(g => new { Method = g.Key, Count = g.Count() })
                                            .ToList();

                foreach (var method in paymentMethods)
                {
                    var percentage = (decimal)method.Count / totalBills * 100;

                    paymentMethodData.Add(new PaymentMethodChartData
                    {
                        PaymentMethod = method.Method,
                        Count = method.Count,
                        Percentage = Math.Round(percentage, 2)
                    });
                }
            }

            //ViewModel
            var model = new DashBoardViewModel
            {
                TotalOrders = _context.Bills.Count(),
                TotalProducts = _context.Products.Count(),
                TotalCustomers = _context.Users.Count(u => u.IsAdmin != "true" && u.IsStoreStaff != "true"),


                OrdersLastWeekPercentage = CalculateOrdersPercentageChange(7),
                ProductsLastMonthPercentage = CalculateProductsPercentageChange(30),
                CustomersLastMonthPercentage = CalculateCustomersPercentageChange(30),
                MoneyLastMonthPercentage = CalculateMoneyPercentageChange(30),

                CategoryData = categoryData,
                BrandData = brandData,
				MonthlyRevenueData = monthlyRevenueData,
				PaymentMethodData = paymentMethodData
            };

            return View("DashBoardManager/Dashboard", model);
        }

        private decimal CalculateOrdersPercentageChange(int days)
        {
            var currentPeriod = _context.Bills
                .Where(b => b.Date >= DateOnly.FromDateTime(DateTime.Now.AddDays(-days)))
                .Count();

            var previousPeriod = _context.Bills
                .Where(b => b.Date < DateOnly.FromDateTime(DateTime.Now.AddDays(-days))
                    && b.Date >= DateOnly.FromDateTime(DateTime.Now.AddDays(-days * 2)))
                .Count();

            return CalculatePercentageChange(currentPeriod, previousPeriod);
        }

        private decimal CalculateProductsPercentageChange(int days)
        {

            return 8.1m;
        }

        private decimal CalculateCustomersPercentageChange(int days)
        {
            var currentPeriod = _context.Users
                .Where(u => u.IsAdmin != "true" && u.IsStoreStaff != "true")
                .Count();


            return -0.3m;
        }

        private decimal CalculateMoneyPercentageChange(int days)
        {
            var currentPeriod = _context.Bills
                .Where(b => b.Date >= DateOnly.FromDateTime(DateTime.Now.AddDays(-days)))
                .Sum(b => b.Total);

            var previousPeriod = _context.Bills
                .Where(b => b.Date < DateOnly.FromDateTime(DateTime.Now.AddDays(-days))
                    && b.Date >= DateOnly.FromDateTime(DateTime.Now.AddDays(-days * 2)))
                .Sum(b => b.Total);

            return CalculatePercentageChange(currentPeriod, previousPeriod);
        }

        private decimal CalculatePercentageChange(decimal current, decimal previous)
        {
            if (previous == 0) return current > 0 ? 100 : 0;
            return ((current - previous) / previous) * 100;
        }
        //MANAGER USER//
        public IActionResult ListCustomer(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var customers = _context.Users
                .Select(u => new CustomerViewModel
                {
                    UserId = u.UserId,
                    UserName = u.UserName,
                    UserEmail = u.UserEmail,
                    PhoneNumber = u.PhoneNumber,
                    Address = u.Address,
                    DateOfBirth = string.IsNullOrEmpty(u.DateOfBirth) ? "N/A" : u.DateOfBirth,
                    Banned = u.Banned
                }).ToList()
        .ToPagedList(pageNumber, pageSize);
            ViewBag.TotalUsers = _context.Users.Count();
            ViewBag.BannedUsers = _context.Users.Count(u => u.Banned == true);
            return View("UserManager/ListCustomer", customers);

        }

        // GET: Admin/CreateCustomer
        public IActionResult CreateCustomer()
        {
            return View();
        }

        // POST: Admin/CreateCustomer
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateCustomer(CustomerViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new User
                {
                    UserName = model.UserName,
                    UserEmail = model.UserEmail,
                    PhoneNumber = model.PhoneNumber,
                    Address = model.Address,
                    DateOfBirth = model.DateOfBirth,
                    Banned = false
                };

                _context.Users.Add(user);
                await _context.SaveChangesAsync();
                TempData["Success"] = "Khách hàng đã được tạo thành công!";
                return RedirectToAction(nameof(ListCustomer));
            }
            return View(model);
        }

        // GET: Admin/EditCustomer/5
        public async Task<IActionResult> EditCustomer(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            try
            {
                // First try to find the user asynchronously
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => u.UserId == id);

                if (user == null)
                {
                    return NotFound();
                }

                // Map the user to view model
                var viewModel = new CustomerViewModel
                {
                    UserId = user.UserId,
                    UserName = user.UserName,
                    UserEmail = user.UserEmail,
                    PhoneNumber = user.PhoneNumber,
                    Address = user.Address,
                    DateOfBirth = user.DateOfBirth,
                    Banned = user.Banned
                };

                return View(viewModel);
            }
            catch (Exception ex)
            {
                // Log the exception details if needed
                TempData["Error"] = "Có lỗi xảy ra khi tải thông tin khách hàng.";
                return RedirectToAction(nameof(ListCustomer));
            }
        }

        // POST: Admin/EditCustomer/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditCustomer(int id, CustomerViewModel model)
        {
            if (id != model.UserId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var user = await _context.Users
                        .FirstOrDefaultAsync(u => u.UserId == id);

                    if (user == null)
                    {
                        return NotFound();
                    }

                    // Update user properties
                    user.UserName = model.UserName;
                    user.UserEmail = model.UserEmail;
                    user.PhoneNumber = model.PhoneNumber;
                    user.Address = model.Address;
                    user.DateOfBirth = model.DateOfBirth;
                    user.Banned = model.Banned;

                    _context.Update(user);
                    await _context.SaveChangesAsync();

                    TempData["Success"] = "Cập nhật thông tin khách hàng thành công!";
                    return RedirectToAction(nameof(ListCustomer));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!await UserExistsAsync(id))
                    {
                        return NotFound();
                    }
                    throw;
                }
                catch (Exception ex)
                {
                    // Log the exception details if needed
                    ModelState.AddModelError("", "Có lỗi xảy ra khi cập nhật thông tin khách hàng.");
                }
            }

            return View(model);
        }

        // Helper method to check if user exists
        private async Task<bool> UserExistsAsync(int id)
        {
            return await _context.Users.AnyAsync(e => e.UserId == id);
        }



        // POST: Admin/DeleteCustomer/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteCustomer(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            TempData["Success"] = "Khách hàng đã được xóa thành công!";
            return RedirectToAction(nameof(ListCustomer));
        }

        // POST: Admin/ToggleBanStatus/5
        [HttpPost]
        public async Task<IActionResult> ToggleBanStatus(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            user.Banned = !user.Banned;
            await _context.SaveChangesAsync();
            return Json(new { success = true, banned = user.Banned });
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }


        public IActionResult DetailCustomer()
        {
            return View("UserManager/DetailCustomer");
        }


        public JsonResult UpdateUserPermission(long userId, string permissionType, bool value)
        {
            try
            {
                var user = _context.Users.Find(userId);
                if (user == null)
                {
                    return Json(new { success = false, message = "User not found" });
                }

                // Update the appropriate permission
                if (permissionType == "IsAdmin")
                {
                    user.IsAdmin = value ? "True" : "False";
                }
                else if (permissionType == "IsStoreStaff")
                {
                    user.IsStoreStaff = value ? "True" : "False";
                }
                else
                {
                    return Json(new { success = false, message = "Invalid permission type" });
                }


                _context.Entry(user).State = EntityState.Modified;
                _context.SaveChanges();

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        // Existing Permission action method remains unchanged
        public IActionResult Permission(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var users = _context.Users
                .Select(u => new PermissionViewModel
                {
                    UserId = u.UserId,
                    UserEmail = u.UserEmail,
                    IsAdmin = u.IsAdmin == "True",
                    IsStoreStaff = u.IsStoreStaff == "True"
                }).ToList()
                .ToPagedList(pageNumber, pageSize);

            ViewBag.TotalUsers = _context.Users.Count();
            ViewBag.AdminUsers = _context.Users.Count(u => u.IsAdmin == "True");
            ViewBag.StaffUsers = _context.Users.Count(u => u.IsStoreStaff == "True");

            return View("UserManager/Permission", users);
        }

        //MANAGER USER//

        //-------------------------------------------------------------------//


        //MANAGER PRODUCT//
        public IActionResult SearchProducts(string searchTerm, int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);

            // Start with all products
            var productsQuery = _context.Products.AsQueryable();


            if (!string.IsNullOrEmpty(searchTerm))
            {
                searchTerm = searchTerm.ToLower();
                productsQuery = productsQuery.Where(p =>
                    p.ProductId.ToLower().Contains(searchTerm) ||
                    p.ProductName.ToLower().Contains(searchTerm) ||
                    p.ProductDescribe.ToLower().Contains(searchTerm)
                );
            }


            var products = productsQuery
                .Select(p => new ProductViewModel
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    ProductPrice = p.ProductPrice,
                    ProductDescribe = p.ProductDescribe,
                    Quantity = p.Quantity,
                    Img = p.Img
                })
                .ToList().ToPagedList(pageNumber, pageSize);


            ViewBag.SearchTerm = searchTerm;

            return View("ProductManager/ListProduct", products);
        }
        public IActionResult ListProduct(string searchTerm, int? page)
        {
            if (!string.IsNullOrEmpty(searchTerm))
            {
                return RedirectToAction("SearchProducts", new { searchTerm, page });
            }

            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var products = _context.Products
                .Select(p => new ProductViewModel
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    ProductPrice = p.ProductPrice,
                    ProductDescribe = p.ProductDescribe,
                    Quantity = p.Quantity,
                    Img = p.Img
                })
                .ToList().ToPagedList(pageNumber, pageSize);
            return View("ProductManager/ListProduct", products);
        }



        public IActionResult DownloadProducts()
        {
            var products = _context.Products
                .Select(p => new ProductViewModel
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    ProductPrice = p.ProductPrice,
                    ProductDescribe = p.ProductDescribe,
                    Quantity = p.Quantity,
                    Img = p.Img
                })
                .ToList();

            var csv = new StringBuilder();
            var separator = ",";


            csv.AppendLine($"ID{separator}Tên{separator}Giá{separator}Mô tả{separator}Số lượng{separator}Ảnh");

            foreach (var product in products)
            {

                string productId = product.ProductId?.ToString() ?? "";
                string productName = product.ProductName?.Replace("\"", "\"\"") ?? "";
                string description = product.ProductDescribe?.Replace("\"", "\"\"").Replace("\r\n", " ") ?? "";
                string img = product.Img?.Replace("\"", "\"\"") ?? "";
                string price = product.ProductPrice.ToString("N0");
                string quantity = product.Quantity.ToString();


                string line = $"\"{productId}\"{separator}\"{productName}\"{separator}\"{price}\"{separator}\"{description}\"{separator}\"{quantity}\"{separator}\"{img}\"";
                csv.AppendLine(line);
            }



            byte[] bom = Encoding.UTF8.GetPreamble();
            byte[] body = Encoding.UTF8.GetBytes(csv.ToString());
            byte[] fileContents = bom.Concat(body).ToArray();


            Response.Headers.Add("Content-Disposition", "attachment; filename=DanhSachSanPham.csv");

            return File(fileContents, "text/csv", "DanhSachSanPham.csv");
        }


        public IActionResult ActiveProduct(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var products = _context.Products
                .Select(p => new ProductViewModel
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    Img = p.Img,
                    IsActive = p.ProductActive != null

                })
                .ToList().ToPagedList(pageNumber, pageSize); ;

            return View("ProductManager/ActiveProduct", products);
        }

        public IActionResult EditProduct(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var product = _context.Products.FirstOrDefault(p => p.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            var productViewModel = new ProductViewModel
            {
                ProductId = product.ProductId,
                ProductName = product.ProductName,
                ProductPrice = product.ProductPrice,
                ProductDescribe = product.ProductDescribe,
                Quantity = product.Quantity,
                Img = product.Img
            };
            foreach (var key in ModelState.Keys)
            {
                foreach (var error in ModelState[key].Errors)
                {
                    Console.WriteLine($"Error in {key}: {error.ErrorMessage}");
                }
            }


            return View("ProductManager/EditProduct", productViewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditProduct(ProductViewModel model, IFormFile imageFile)
        {

            if (!ModelState.IsValid)
            {

                var errors = ModelState.Values.SelectMany(v => v.Errors);
                foreach (var error in errors)
                {
                    Console.WriteLine(error.ErrorMessage);
                }


                return View("ProductManager/EditProduct", model);
            }


            var product = _context.Products.FirstOrDefault(p => p.ProductId == model.ProductId);
            if (product == null)
            {
                return NotFound();
            }


            product.ProductName = model.ProductName;
            product.ProductPrice = model.ProductPrice;
            product.ProductDescribe = model.ProductDescribe;
            product.Quantity = model.Quantity;


            if (imageFile != null && imageFile.Length > 0)
            {
                string uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images");

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                string fileName = imageFile.FileName;
                string filePath = Path.Combine(uploadsFolder, fileName);

                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    imageFile.CopyTo(fileStream);
                }


                product.Img = "images/" + fileName; // images/laptop11.jpg
            }


            _context.Update(product);
            _context.SaveChanges();

            return RedirectToAction("ListProduct", "Admin");
        }


        // GET: Product/Create
        public IActionResult CreateProduct()
        {
            var model = new ProductCreateViewModel
            {
                SelectedColors = new List<string>(),
                SelectedSizes = new List<string>()
            };
            // Prepare all data needed for the form
            ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName");
            ViewBag.Brands = new SelectList(_context.Brands, "BrandId", "BrandName");
            ViewBag.Colors = new List<string> { "Black", "White", "Red", "Blue", "Green", "Yellow", "Gray" };
            ViewBag.Sizes = new List<string> { "40 inch", "43 inch", "50 inch", "55 inch", "60 inch", "6.5 inch", "5.5 inch" };

            return View("ProductManager/CreateProduct");
        }

        // POST: Product/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateProduct(ProductCreateViewModel model)
        {

            ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName");
            ViewBag.Brands = new SelectList(_context.Brands, "BrandId", "BrandName");
            ViewBag.Colors = new List<string> { "Black", "White", "Red", "Blue", "Green", "Yellow", "Gray" };
            ViewBag.Sizes = new List<string> { "40 inch", "43 inch", "50 inch", "55 inch", "60 inch", "6.5 inch", "5.5 inch" };

            if (ModelState.IsValid)
            {
                try
                {

                    if (model.BrandId == null && !string.IsNullOrEmpty(model.BrandName))
                    {
                        var newBrand = new Brand { BrandName = model.BrandName };
                        _context.Brands.Add(newBrand);
                        await _context.SaveChangesAsync();
                        model.BrandId = newBrand.BrandId;
                    }


                    string imageFileName = await SaveImage(model.ImageFile);


                    var product = new Product
                    {
                        ProductId = model.ProductId,
                        ProductName = model.ProductName,
                        CategoryId = model.CategoryId,
                        ProductPrice = model.ProductPrice,
                        ProductDescribe = model.ProductDescribe,
                        Quantity = model.Quantity,
                        Img = imageFileName ?? "images/default.jpg",
                        BrandId = model.BrandId,
                        WarrantyMonths = model.WarrantyMonths,
                        TechnicalSpecs = model.TechnicalSpecs,
                        ModelNumber = model.ModelNumber,

                    };

                    _context.Products.Add(product);
                    await _context.SaveChangesAsync();


                    if (model.SelectedColors != null && model.SelectedColors.Any())
                    {
                        foreach (var color in model.SelectedColors)
                        {

                            _context.Database.ExecuteSqlRaw(
                                "INSERT INTO product_color (product_id, color) VALUES ({0}, {1})",
                                product.ProductId, color);
                        }
                    }


                    if (model.SelectedSizes != null && model.SelectedSizes.Any())
                    {
                        foreach (var size in model.SelectedSizes)
                        {

                            _context.Database.ExecuteSqlRaw(
                                "INSERT INTO product_size (product_id, size) VALUES ({0}, {1})",
                                product.ProductId, size);
                        }
                    }

                    await _context.SaveChangesAsync();

                    var productActive = new ProductActive
                    {
                        ProductId = product.ProductId,
                        Active = model.Active
                    };

                    _context.ProductActives.Add(productActive);
                    await _context.SaveChangesAsync();


                    return RedirectToAction("ListProduct", "Admin");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Error creating product: " + ex.Message);
                }
            }


            return View("ProductManager/CreateProduct", model);
        }

        private async Task<string> SaveImage(IFormFile imageFile)
        {
            if (imageFile == null || imageFile.Length == 0)
            {
                return null;
            }

            try
            {

                string fileName = imageFile.FileName;
                string uploadsFolder = Path.Combine(_hostEnvironment.WebRootPath, "images");
                string filePath = Path.Combine(uploadsFolder, fileName);

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }


                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await imageFile.CopyToAsync(fileStream);
                }

                return "images/" + fileName;
            }

            catch (Exception ex)
            {
                Console.WriteLine("Error saving image: " + ex.Message);
                return null;
            }
        }

        public async Task<IActionResult> DeleteProduct(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            try
            {

                _context.Database.ExecuteSqlRaw(
                    "DELETE FROM product_color WHERE product_id = {0}", id);
                _context.Database.ExecuteSqlRaw(
                    "DELETE FROM product_size WHERE product_id = {0}", id);


                var productActive = await _context.ProductActives.FirstOrDefaultAsync(pa => pa.ProductId == id);
                if (productActive != null)
                {
                    _context.ProductActives.Remove(productActive);
                }


                if (!string.IsNullOrEmpty(product.Img) && product.Img != "images/default.jpg")
                {
                    string imagePath = Path.Combine(_hostEnvironment.WebRootPath, product.Img);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
                }


                _context.Products.Remove(product);
                await _context.SaveChangesAsync();

                return RedirectToAction("ListProduct");
            }
            catch (Exception ex)
            {

                Console.WriteLine($"Error deleting product: {ex.Message}");

                TempData["ErrorMessage"] = $"Could not delete product: {ex.Message}";
                return RedirectToAction("ListProduct");
            }
        }

        public IActionResult DetailProduct(string id)
        {

            var product = _context.Products.FirstOrDefault(p => p.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }


            var productViewModel = new ProductViewModel
            {
                ProductId = product.ProductId,
                ProductName = product.ProductName,
                ProductPrice = product.ProductPrice,
                ProductDescribe = product.ProductDescribe,
                Quantity = product.Quantity,
                Img = product.Img,

            };


            return View("ProductManager/DetailProduct", productViewModel);
        }


        //END MANAGER PRODUCT//

        //-------------------------------------------------------------------------------------------//

        //MANAGER CATEGORY//
        public IActionResult ListCategory(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var category = _context.Categories.Include(c => c.Products)
                .Select(c => new CategoryViewModel
                {
                    CategoryId = c.CategoryId,
                    CategoryName = c.CategoryName,
                    StartingPrice = $"{c.Products.Min(p => p.ProductPrice):N0} VNĐ đến {c.Products.Max(p => p.ProductPrice):N0} VNĐ",

                    ProductStock = c.Products.Sum(p => p.Quantity),
                    /*CreatedBy = "Admin",*/
                    CategoryCode = $"CAT{c.CategoryId:D5}"

                }).ToList().ToPagedList(pageNumber, pageSize); ;
            return View("CategoryManager/ListCategory", category);
        }

        public IActionResult EditCategory(int id)
        {
            var category = _context.Categories
                .Where(c => c.CategoryId == id)
                .Select(c => new CategoryViewModel
                {
                    CategoryId = c.CategoryId,
                    CategoryName = c.CategoryName,

                })
                .FirstOrDefault();

            if (category == null)
            {
                return NotFound();
            }

            return View("CategoryManager/EditCategory", category);
        }




        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditCategory([Bind("CategoryId, CategoryName")] CategoryViewModel model)
        {
            Console.WriteLine($"Received - CategoryId: {model.CategoryId}, CategoryName: {model.CategoryName}");

            if (!ModelState.IsValid)
            {
                Console.WriteLine("ModelState invalid. Errors:");
                foreach (var state in ModelState)
                {
                    foreach (var error in state.Value.Errors)
                    {
                        Console.WriteLine($"Field: {state.Key}, Error: {error.ErrorMessage}");
                    }
                }
                return View("CategoryManager/EditCategory", model);
            }

            var category = _context.Categories
                .Where(c => c.CategoryId == model.CategoryId)
                .Select(c => new { c.CategoryId })
                .FirstOrDefault();

            if (category == null)
            {
                return NotFound();
            }


            _context.Categories.Where(c => c.CategoryId == model.CategoryId)
                .ExecuteUpdate(setters => setters.SetProperty(c => c.CategoryName, model.CategoryName));

            return RedirectToAction("ListCategory", "Admin");


        }



        public IActionResult CreateCategory()
        {
            return View("CategoryManager/CreateCategory");
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CreateCategory(CategoryViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View("CategoryManager/CreateCategory", model);
            }

            var category = new Category
            {
                CategoryName = model.CategoryName
            };

            _context.Categories.Add(category);
            _context.SaveChanges();


            TempData["SuccessMessage"] = $"Category '{model.CategoryName}' was successfully created.";

            return RedirectToAction("ListCategory", "Admin");
        }

        //END MANAGER CATEGORY//

        //----------------------------------------------------------------------//

        //MANAGER BILL//
        public IActionResult ListBill(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var bills = _context.Bills
                 .Include(b => b.User)
            .Include(b => b.BillDetails)
            .Include(b => b.Shippings)
            .Select(b => new BillViewModel
            {
                OrderId = $"#{b.BillId:D6}/80",
                Date = DateTime.Parse(b.Date.ToString()),
                CustomerName = b.User.UserName,
                Phone = b.Phone.ToString(),
                Address = b.Address,
                Total = b.Total,
                Payment = b.Payment,

                OrderStatus = !b.Shippings.Any() ? "Draft" :
                            b.Shippings.OrderByDescending(s => s.ShippingId).First().ShippingMethod,
                ItemCount = b.BillDetails.Count,
                DeliveryNumber = b.Shippings.Any() ?
                    $"#D-{b.Shippings.OrderByDescending(s => s.ShippingId).First().ShippingId}" : "-",
                Priority = "Normal"
            }).ToList().ToPagedList(pageNumber, pageSize); ;
            return View("BillManager/ListBill", bills);
        }

        //END MANAGER BILL//

        //-----------------------------------------------------------------------//

        //MANAGER REVIEW//


        public IActionResult ListReview(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var comments = _context.ProductComments.Include(pc => pc.Product).Include(pc => pc.User).ToList().ToPagedList(pageNumber, pageSize);
            return View("ReviewManager/ListReview", comments);
        }

        //MANAGER BRAND//
        public IActionResult ListBrand(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);

            var brands = _context.Brands
                .Select(b => new BrandViewModel
                {
                    BrandId = b.BrandId,
                    BrandName = b.BrandName,
                    BrandDescription = b.BrandDescription,
                    BrandCountry = b.BrandCountry,
                    BrandLogo = b.BrandLogo,
                    ProductCount = b.Products.Count
                })
                .OrderBy(b => b.BrandId)
                .ToList().ToPagedList(pageNumber, pageSize);

            return View("BrandManager/ListBrand", brands);
        }

        [HttpGet]
        public IActionResult CreateBrand()
        {
            return View("BrandManager/CreateBrand");
        }
        [HttpPost]
        public IActionResult CreateBrand(BrandViewModel model)
        {
            if (ModelState.IsValid)
            {
                string? fileName = null;

                if (model.ImageFile != null)
                {

                    string uploadDir = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images/brands");
                    if (!Directory.Exists(uploadDir))
                    {
                        Directory.CreateDirectory(uploadDir);
                    }

                    // Generate unique file name
                    fileName = fileName = Path.GetFileName(model.ImageFile.FileName);

                    string filePath = Path.Combine(uploadDir, fileName);

                    // Save the file
                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        model.ImageFile.CopyTo(fileStream);
                    }
                }

                var brand = new Brand
                {
                    BrandName = model.BrandName,
                    BrandDescription = model.BrandDescription,
                    BrandCountry = model.BrandCountry,
                    BrandLogo = fileName
                };

                _context.Brands.Add(brand);
                _context.SaveChanges();

                return RedirectToAction("ListBrand");
            }
            return View("BrandManager/CreateBrand", model);
        }

        [HttpPost]
        public IActionResult DeleteBrand(int id)
        {
            var brand = _context.Brands.Find(id);
            if (brand == null)
            {
                return NotFound();
            }


            _context.Brands.Remove(brand);
            _context.SaveChanges();

            return RedirectToAction("ListBrand");
        }
        [HttpGet]
        public IActionResult EditBrand(int id)
        {
            var brand = _context.Brands.Find(id);
            if (brand == null)
            {
                return NotFound();
            }

            var model = new BrandViewModel
            {
                BrandId = brand.BrandId,
                BrandName = brand.BrandName,
                BrandDescription = brand.BrandDescription,
                BrandCountry = brand.BrandCountry,
                BrandLogo = brand.BrandLogo
            };

            return View("BrandManager/EditBrand", model);
        }

        [HttpPost]
        public IActionResult EditBrand(BrandViewModel model)
        {
            if (ModelState.IsValid)
            {
                var brand = _context.Brands.Find(model.BrandId);
                if (brand == null)
                {
                    return NotFound();
                }

                string? fileName = brand.BrandLogo;

                if (model.ImageFile != null)
                {
                    string uploadDir = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images/brands");
                    if (!Directory.Exists(uploadDir))
                    {
                        Directory.CreateDirectory(uploadDir);
                    }

                    fileName = Path.GetFileName(model.ImageFile.FileName);
                    string filePath = Path.Combine(uploadDir, fileName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        model.ImageFile.CopyTo(fileStream);
                    }

                    // Xóa logo cũ nếu có
                    if (!string.IsNullOrEmpty(brand.BrandLogo))
                    {
                        string oldFilePath = Path.Combine(uploadDir, brand.BrandLogo);
                        if (System.IO.File.Exists(oldFilePath))
                        {
                            System.IO.File.Delete(oldFilePath);
                        }
                    }
                }

                // Cập nhật thông tin
                brand.BrandName = model.BrandName;
                brand.BrandDescription = model.BrandDescription;
                brand.BrandCountry = model.BrandCountry;
                brand.BrandLogo = fileName;

                _context.Brands.Update(brand);
                _context.SaveChanges();

                return RedirectToAction("ListBrand");
            }
            return View("BrandManager/EditBrand", model);
        }
    }

    //END MANAGER BRAND//

    //----------------------------------------------------------//


}
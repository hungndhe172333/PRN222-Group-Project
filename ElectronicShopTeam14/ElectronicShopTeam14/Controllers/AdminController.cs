using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
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

        public IActionResult Permission()
        {
            return View("UserManager/Permission");
        }
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
            // Kiểm tra ModelState
            if (!ModelState.IsValid)
            {
                // Log các lỗi validation
                var errors = ModelState.Values.SelectMany(v => v.Errors);
                foreach (var error in errors)
                {
                    Console.WriteLine(error.ErrorMessage); // Log lỗi
                }

                // Hiển thị lại form với thông báo lỗi
                return View("ProductManager/EditProduct", model);
            }

            // Nếu ModelState hợp lệ, tiếp tục xử lý
            var product = _context.Products.FirstOrDefault(p => p.ProductId == model.ProductId);
            if (product == null)
            {
                return NotFound();
            }

            // Cập nhật thông tin sản phẩm
            product.ProductName = model.ProductName;
            product.ProductPrice = model.ProductPrice;
            product.ProductDescribe = model.ProductDescribe;
            product.Quantity = model.Quantity;

            // Xử lý upload ảnh nếu có
            if (imageFile != null && imageFile.Length > 0)
            {
                string uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images");

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                // Sử dụng tên file gốc
                string fileName = imageFile.FileName; // laptop11.jpg
                string filePath = Path.Combine(uploadsFolder, fileName);

                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    imageFile.CopyTo(fileStream);
                }

                // Cập nhật đường dẫn ảnh
                product.Img = "images/" + fileName; // images/laptop11.jpg
            }

            // Lưu thay đổi vào database
            _context.Update(product);
            _context.SaveChanges();

            // Chuyển hướng sau khi cập nhật thành công
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

                    // Handle sizes
                    if (model.SelectedSizes != null && model.SelectedSizes.Any())
                    {
                        foreach (var size in model.SelectedSizes)
                        {
                            // Use raw SQL to insert directly
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
                // Remove related records in product_color and product_size tables
                _context.Database.ExecuteSqlRaw(
                    "DELETE FROM product_color WHERE product_id = {0}", id);
                _context.Database.ExecuteSqlRaw(
                    "DELETE FROM product_size WHERE product_id = {0}", id);

                // Remove record from ProductActive table
                var productActive = await _context.ProductActives.FirstOrDefaultAsync(pa => pa.ProductId == id);
                if (productActive != null)
                {
                    _context.ProductActives.Remove(productActive);
                }

                // Delete product image if it exists and isn't the default
                if (!string.IsNullOrEmpty(product.Img) && product.Img != "images/default.jpg")
                {
                    string imagePath = Path.Combine(_hostEnvironment.WebRootPath, product.Img);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
                }

                // Remove the product
                _context.Products.Remove(product);
                await _context.SaveChangesAsync();

                return RedirectToAction("ListProduct");
            }
            catch (Exception ex)
            {
                // Log the error
                Console.WriteLine($"Error deleting product: {ex.Message}");
                // You could add a TempData message here to show the error
                TempData["ErrorMessage"] = $"Could not delete product: {ex.Message}";
                return RedirectToAction("ListProduct");
            }
        }
        public IActionResult DetailProduct()
        {
            return View("ProductManager/DetailProduct");
        }

        //Manager Category
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
                    CreatedBy = "Admin",
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
        public IActionResult EditCategory(CategoryViewModel model)
        {
            if (!ModelState.IsValid)
            {
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
            return View("~/Views/CategoryManager/CreateCategory.cshtml");
        }


        //Manager Order (Bill)

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


    }
}
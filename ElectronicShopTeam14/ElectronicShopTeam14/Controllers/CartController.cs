using ElectronicShopTeam14.Extensions;
using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Security.Claims;

namespace ElectronicShopTeam14.Controllers
{
    public class CartController : Controller
    {
        private readonly ElectronicShopTeam14Context _context;

        public CartController(ElectronicShopTeam14Context context)
        {
            _context = context;
        }
        private long GetCurrentUserId()
        {
            if (!User.Identity.IsAuthenticated)
            {
                throw new Exception("User is not authenticated.");
            }

            var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (long.TryParse(userIdString, out long userId))
            {
                return userId;
            }

            throw new Exception("UserId claim not found or invalid.");
        }

        // GET: Cart
        public IActionResult Cart()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();
            ViewBag.TotalAmount = cart.Sum(item => item.Total);
            return View(cart);
        }


        [AcceptVerbs("GET", "POST")]
        public IActionResult Add(string id, int quantity = 1, string size = "Default", string color = "Default")
        {
            if (string.IsNullOrEmpty(id))
                return Json(new { success = false, message = "Invalid product ID" });

            var product = _context.Products.Find(id);
            if (product == null)
                return Json(new { success = false, message = "Product not found" });

            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();

            var existingItem = cart.FirstOrDefault(c => c.ProductId == id && c.Size == size && c.Color == color);
            if (existingItem != null)
            {
                existingItem.Quantity += quantity;
                existingItem.Total = existingItem.Quantity * existingItem.ProductPrice;
            }
            else
            {
                cart.Add(new CartItem
                {
                    ProductId = product.ProductId,
                    ProductName = product.ProductName,
                    ProductImg = product.Img?.Split(';')[0] ?? "",
                    ProductPrice = (double)product.ProductPrice,
                    Quantity = quantity,
                    Total = (double)product.ProductPrice * quantity,
                    Size = size,
                    Color = color
                });
            }

            HttpContext.Session.SetObjectAsJson("Cart", cart);
            Console.WriteLine($"Cart items after adding: {cart.Count}");

            return Json(new
            {
                success = true,
                message = "Thêm vào giỏ hàng thành công",
                cartCount = cart.Sum(c => c.Quantity),
                cartTotal = cart.Sum(c => c.Total)
            });
        }

        // POST: Cart/Update
        [HttpPost]
        public IActionResult Update(string id, int quantity)
        {
            if (string.IsNullOrEmpty(id))
                return Json(new { success = false, message = "Mã sản phẩm không hợp lệ" });

            if (quantity <= 0)
                return Json(new { success = false, message = "Số lượng phải lớn hơn 0" });

            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();
            var item = cart.FirstOrDefault(c => c.ProductId == id);

            if (item == null)
                return Json(new { success = false, message = "Sản phẩm không tìm thấy trong giỏ hàng" });

            item.Quantity = quantity;
            item.Total = item.Quantity * item.ProductPrice;

            HttpContext.Session.SetObjectAsJson("Cart", cart);

            return Json(new
            {
                success = true,
                message = "Giỏ hàng được cập nhật thành công",
                itemTotal = item.Total,
                cartCount = cart.Sum(c => c.Quantity),
                cartTotal = cart.Sum(c => c.Total)
            });
        }

        // POST: Cart/Remove
        [HttpPost]
        public IActionResult Remove(string id)
        {
            if (string.IsNullOrEmpty(id))
                return Json(new { success = false, message = "Invalid product ID" });

            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();
            var item = cart.FirstOrDefault(c => c.ProductId == id);

            if (item == null)
                return Json(new { success = false, message = "Product not found in cart" });

            cart.Remove(item);
            HttpContext.Session.SetObjectAsJson("Cart", cart);

            return Json(new
            {
                success = true,
                message = "Product removed from cart",
                cartCount = cart.Sum(c => c.Quantity),
                cartTotal = cart.Sum(c => c.Total)
            });
        }

        // POST: Cart/Clear
        [HttpPost]
        public IActionResult Clear()
        {
            HttpContext.Session.Remove("Cart");

            return Json(new
            {
                success = true,
                message = "Cart cleared successfully",
                cartCount = 0,
                cartTotal = 0
            });
        }

        /*// GET: Cart/CartSummary
        public IActionResult CartSummary()
        {
            return ViewComponent("CartSummary");
        }*/

        // GET: Cart/Count
        public IActionResult Count()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();
            return Json(new
            {
                count = cart.Sum(c => c.Quantity),
                total = cart.Sum(c => c.Total)

            });
        }

        public IActionResult Checkout()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();

            // Debug CartItems
            Console.WriteLine("CartItems in Checkout: " + JsonConvert.SerializeObject(cart));

            var checkoutViewModel = new CheckOutViewModel
            {
                CartItems = cart,
                SubTotal = cart.Sum(item => (decimal)item.Total),
                ShippingFee = 0,
                Total = cart.Sum(item => (decimal)item.Total),
                UserName = User.Identity.IsAuthenticated ? User.Identity.Name : "Khách"
            };

            return View(checkoutViewModel);
        }


        [HttpPost]
        [Authorize]
        public IActionResult ProcessCheckout(CheckoutFormModel formModel)
        {
            // Debug dữ liệu nhận được
            Console.WriteLine($"streetAddress: {formModel.StreetAddress}");
            Console.WriteLine($"district: {formModel.District}");
            Console.WriteLine($"city: {formModel.City}");
            Console.WriteLine($"phone: {formModel.Phone}");
            Console.WriteLine($"paymentMethod: {formModel.PaymentMethod}");
            Console.WriteLine($"defaultCheck10: {formModel.DefaultCheck10}");


            var model = new CheckOutViewModel();

            model.CartItems = HttpContext.Session.GetObjectFromJson<List<CartItem>>("Cart") ?? new List<CartItem>();
            Console.WriteLine("CartItems after deserialization in ProcessCheckout: " + JsonConvert.SerializeObject(model.CartItems));

            if (!model.CartItems.Any())
            {
                ModelState.AddModelError("", "Giỏ hàng trống.");
                return View("Checkout", model);
            }

            Console.WriteLine("Calculating SubTotal and Total...");
            model.SubTotal = model.CartItems.Sum(item => (decimal)item.Total);
            model.ShippingFee = 0;
            model.Total = model.SubTotal;
            Console.WriteLine($"SubTotal: {model.SubTotal}, Total: {model.Total}");

            model.UserName = User.Identity.IsAuthenticated ? User.Identity.Name : "Khách";

            // Debug ModelState
            if (!ModelState.IsValid)
            {
                Console.WriteLine("ModelState.IsValid is false. Full ModelState: " + JsonConvert.SerializeObject(ModelState));
                foreach (var key in ModelState.Keys)
                {
                    var entry = ModelState[key];
                    Console.WriteLine($"Key: {key}, ValidationState: {entry.ValidationState}, RawValue: {entry.RawValue}, AttemptedValue: {entry.AttemptedValue}");
                    if (entry.Errors.Any())
                    {
                        Console.WriteLine($"Errors for {key}:");
                        foreach (var error in entry.Errors)
                        {
                            Console.WriteLine($" - {error.ErrorMessage}");
                        }
                    }
                }
                return View("Checkout", model);
            }

            string fullAddress = $"{formModel.StreetAddress}, {formModel.District}, {formModel.City}";
            if (!long.TryParse(formModel.Phone, out long phoneNumber))
            {
                ModelState.AddModelError("formModel.Phone", "Số điện thoại không hợp lệ.");
                return View("Checkout", model);
            }

            // Debug User.Claims
            Console.WriteLine($"User.Identity.IsAuthenticated: {User.Identity.IsAuthenticated}");
            Console.WriteLine("User.Claims:");
            foreach (var claim in User.Claims)
            {
                Console.WriteLine($" - Type: {claim.Type}, Value: {claim.Value}");
            }

            long userId;
            try
            {
                userId = GetCurrentUserId();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error getting UserId: {ex.Message}");
                ModelState.AddModelError("", "Vui lòng đăng nhập để tiếp tục thanh toán.");
                return View("Checkout", model);
            }

            var bill = new Bill
            {
                UserId = userId,
                Total = model.Total,
                Payment = formModel.PaymentMethod,
                Address = fullAddress,
                Date = DateOnly.FromDateTime(DateTime.Now),
                Phone = phoneNumber
            };

            try
            {
                _context.Bills.Add(bill);
                _context.SaveChanges();

                foreach (var item in model.CartItems)
                {
                    var billDetail = new BillDetail
                    {
                        BillId = bill.BillId,
                        ProductId = item.ProductId,
                        Quantity = item.Quantity,
                        Size = item.Size ?? "Default",
                        Color = item.Color ?? "Default",
                        Price = (decimal)item.Total / item.Quantity
                    };
                    _context.BillDetails.Add(billDetail);
                }
                _context.SaveChanges();

                HttpContext.Session.Remove("Cart");
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving to database: {ex.Message}");
                ModelState.AddModelError("", "Đã xảy ra lỗi khi lưu đơn hàng. Vui lòng thử lại.");
                return View("Checkout", model);
            }
        }
    }
}


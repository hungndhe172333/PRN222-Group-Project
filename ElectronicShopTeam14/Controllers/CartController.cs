using ElectronicShopTeam14.Extensions;
using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Mvc;

namespace ElectronicShopTeam14.Controllers
{
    public class CartController : Controller
    {
        private readonly ElectronicShopTeam14Context _context;

        public CartController(ElectronicShopTeam14Context context)
        {
            _context = context;
        }

        // GET: Cart
        public IActionResult Cart()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();
            ViewBag.TotalAmount = cart.Sum(item => item.Total);
            return View(cart);
        }

        // Add to cart - handles both GET and POST
        [AcceptVerbs("GET", "POST")]
        public IActionResult Add(string id, int quantity = 1)
        {
            if (string.IsNullOrEmpty(id))
                return Json(new { success = false, message = "Invalid product ID" });

            var product = _context.Products.Find(id);
            if (product == null)
                return Json(new { success = false, message = "Product not found" });

            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();

            var existingItem = cart.FirstOrDefault(c => c.ProductId == id);
            if (existingItem != null)
            {
                existingItem.Quantity += quantity;
                existingItem.Total = existingItem.Quantity * existingItem.ProductPrice;
            }
            else
            {
                cart.Add(new Cart
                {
                    ProductId = product.ProductId,
                    ProductName = product.ProductName,
                    ProductImg = product.Img?.Split(';')[0] ?? "",
                    ProductPrice = (double)product.ProductPrice,
                    Quantity = quantity,
                    Total = (double)product.ProductPrice * quantity
                });
            }

            HttpContext.Session.SetObjectAsJson("Cart", cart);

            return Json(new
            {
                success = true,
                message = "Product added to cart successfully",
                cartCount = cart.Sum(c => c.Quantity),
                cartTotal = cart.Sum(c => c.Total)
            });
        }

        // POST: Cart/Update
        [HttpPost]
        public IActionResult Update(string id, int quantity)
        {
            if (string.IsNullOrEmpty(id))
                return Json(new { success = false, message = "Invalid product ID" });

            if (quantity <= 0)
                return Json(new { success = false, message = "Quantity must be greater than 0" });

            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();
            var item = cart.FirstOrDefault(c => c.ProductId == id);

            if (item == null)
                return Json(new { success = false, message = "Product not found in cart" });

            item.Quantity = quantity;
            item.Total = item.Quantity * item.ProductPrice;

            HttpContext.Session.SetObjectAsJson("Cart", cart);

            return Json(new
            {
                success = true,
                message = "Cart updated successfully",
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

            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();
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

        // GET: Cart/CartSummary
        public IActionResult CartSummary()
        {
            return ViewComponent("CartSummary");
        }

        // GET: Cart/Count
        public IActionResult Count()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();
            return Json(new
            {
                count = cart.Sum(c => c.Quantity),
                total = cart.Sum(c => c.Total)
            });
        }

        public IActionResult Checkout()
        {
            var cart = HttpContext.Session.GetObjectFromJson<List<Cart>>("Cart") ?? new List<Cart>();

            if (!cart.Any())
            {
                return RedirectToAction("Index", "Home");
            }

            var checkoutViewModel = new CheckOutViewModel
            {
                CartItems = cart,
                SubTotal = (decimal)cart.Sum(item => item.Total),
                ShippingFee = 0,
                Total = (decimal)cart.Sum(item => item.Total) 
            };

            return View(checkoutViewModel);
        }
    }
}


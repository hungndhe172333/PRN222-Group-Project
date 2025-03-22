using ElectronicShopTeam14.Models;
using ElectronicShopTeam14.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ElectronicShopTeam14.Controllers
{
    public class OrderController : Controller
    {

        private readonly ElectronicShopTeam14Context _context;
        private readonly IUserRepository _userRepository;
        public OrderController(IUserRepository userRepository, ElectronicShopTeam14Context context)
        {
            _userRepository = userRepository;
            _context = context;
        }

        [HttpGet]
        [Authorize]
        public IActionResult History()
        {

            var userIdClaim = User.Claims.FirstOrDefault(c => c.Type == "UserId");
            if (userIdClaim == null)
            {
                return RedirectToAction("Login");
            }
            var userId = long.Parse(userIdClaim.Value);
            var user = _userRepository.GetUserById(userId);

            if (user == null)
            {
                return NotFound();
            }

            var bills = _context.Bills.Where(t => t.UserId == userId).ToList();

            var viewModel = new BillDetailViewModel
            {

                Bills = bills
            };
            return View("History", viewModel);
        }

        [HttpGet]
        [Authorize]
        public IActionResult Detail(int billId)
        {

            var bill = _context.Bills.FirstOrDefault(b => b.BillId == billId);
            if (bill == null)
            {
                return NotFound();
            }


            var userIdClaim = User.Claims.FirstOrDefault(c => c.Type == "UserId");
            if (userIdClaim == null || bill.UserId != long.Parse(userIdClaim.Value))
            {
                return Unauthorized();
            }


            var billDetails = _context.BillDetails.Where(bd => bd.BillId == billId).ToList();
            var productIds = billDetails.Select(bd => bd.ProductId).ToList();
            var products = _context.Products.Where(p => productIds.Contains(p.ProductId)).ToList();


            var viewModel = new BillDetailViewModel
            {
                Bill = bill,
                BillDetails = billDetails,
                Products = products,
                Bills = new List<Bill> { bill }
            };

            return View("OrderDetail", viewModel);
        }
    }
}
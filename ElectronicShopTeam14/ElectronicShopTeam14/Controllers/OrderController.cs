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
        [Authorize] // Thêm attribute này để yêu cầu đăng nhập
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
        [Authorize] // Thêm attribute này để yêu cầu đăng nhập
        public IActionResult Detail(int billId)
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

            //var bill = _context.Bills.Where(b => b.BillId == billId).FirstOrDefault();
            //var billDetail = _context.BillDetails.Where(bd => bd.BillId == billId).ToList();

            //// Lấy ProductId từ BillDetails
            //var productIds = _context.BillDetails
            //    .Where(d => d.BillId == billId)
            //    .Select(d => d.ProductId)
            //    .ToList();

            //// Lấy danh sách Product từ các ProductId đã lấy
            //var products = _context.Products
            //    .Where(p => productIds.Contains(p.ProductId))
            //    .ToList();

            //var viewModel = new BillDetailViewModel
            //{
            //    Bill = bill,
            //    BillDetails = billDetail,
            //    Products = products
            //};

            var bill = _context.Bills
                .Where(b => b.BillId == billId)
                .Include(b => b.BillDetails)
                .ThenInclude(d => d.Product)
                .FirstOrDefault();

            var viewModel = new BillDetailViewModel
            {
                Bill = bill,
                BillDetails = bill.BillDetails.ToList(),
                Products = bill.BillDetails.Select(d => d.Product).ToList()
            };
            return View("OrderDetail", viewModel);
        }
    }
}

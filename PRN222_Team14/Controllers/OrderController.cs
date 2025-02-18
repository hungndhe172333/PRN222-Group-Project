using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace ElectronicShopTeam14.Controllers
{

   
        [Authorize]
        public class OrderController : Controller
        {
            private readonly ElectronicShopTeam14Context _context;

            public OrderController(ElectronicShopTeam14Context context)
            {
                _context = context;
            }

        public IActionResult History()
        {
            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            var bills = _context.Bills
                .Where(b => b.UserId.ToString() == userId)
                .OrderByDescending(b => b.Date)
                .ToList();

            return View(bills);
        }
    }
    

}


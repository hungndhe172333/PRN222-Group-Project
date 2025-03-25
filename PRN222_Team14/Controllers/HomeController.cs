using ElectronicShopTeam14.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace ElectronicShopTeam14.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private ElectronicShopTeam14Context _context;

        public HomeController(ILogger<HomeController> logger, ElectronicShopTeam14Context context)
        {
            _logger = logger;
            context = _context;
        }

        public IActionResult Index()
        {
          //  var products = _context.Products.ToList();

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

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

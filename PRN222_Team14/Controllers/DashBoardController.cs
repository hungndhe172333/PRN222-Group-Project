using Microsoft.AspNetCore.Mvc;

namespace ElectronicShopTeam14.Controllers
{
    public class DashboardController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}


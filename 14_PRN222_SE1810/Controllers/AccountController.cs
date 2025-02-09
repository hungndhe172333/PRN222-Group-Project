using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using System;

namespace _14_PRN222_SE1810.Controllers
{
    public class AccountController : Controller
    {
        private readonly _14_PRN222_SE1810.Models.Prn222Context _context;
        public AccountController(_14_PRN222_SE1810.Models.Prn222Context context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string email, string password, bool rememberMe)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserEmail == email && u.UserPass == password);

            if (user == null)
            {
                ViewBag.Error = "Sai email hoặc mật khẩu!";
                return View();
            }

            // Tạo claims (thông tin đăng nhập)
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.UserEmail),
                new Claim("FullName", user.UserName),
                new Claim(ClaimTypes.Role, user.IsAdmin)
            };

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var authProperties = new AuthenticationProperties
            {
                IsPersistent = rememberMe, // Nếu chọn "Remember Me", cookie sẽ lưu lâu hơn

                //true = 7 ngày; false = 1 giờ
                ExpiresUtc = rememberMe ? DateTime.UtcNow.AddDays(7) : DateTime.UtcNow.AddMinutes(120)
            };

            HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);

            return RedirectToAction("Index", "Home");
        }

        public IActionResult Logout()
        {
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Account");
        }
    }
}

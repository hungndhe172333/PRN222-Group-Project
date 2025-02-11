using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using System;
using _14_PRN222_SE1810.Models;
using System.Net.Mail;
using System.Net;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authentication.Facebook;

namespace _14_PRN222_SE1810.Controllers
{
    public class AccountController : Controller
    {
        private readonly _14_PRN222_SE1810.Models.Prn222Context _context;
        public AccountController(_14_PRN222_SE1810.Models.Prn222Context context)
        {
            _context = context;
        }

        //Đăng ký
        // Lưu tạm thông tin user để xác thực OTP
        //ádf
        private static Dictionary<string, (User User, string OTP, DateTime Expiry)> otpStorage = new();
        private static Dictionary<string, (string OTP, DateTime Expiry)> otpForgotPassStorage = new();

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(string email, string password, string confirmPassword, DateTime dob, string address, string phoneNumber)
        {
            if (password != confirmPassword)
            {
                ViewBag.Error = "Mật khẩu xác nhận không khớp!";
                return View();
            }

            // Kiểm tra email đã đăng ký chưa
            if (_context.Users.Any(u => u.UserEmail == email))
            {
                ViewBag.Error = "Email đã tồn tại!";
                return View();
            }

            var newUser = new User
            {
                UserEmail = email,
                UserPass = password,
                DateOfBirth = dob.Date.ToString(),
                Address = address,
                PhoneNumber = phoneNumber,
                IsAdmin = "False",  // Mặc định là user thường
                Banned = false,     // Mặc định
                IsStoreStaff = "False"
            };

            // Tạo OTP
            string otp = new Random().Next(100000, 999999).ToString();
            otpStorage[email] = (newUser, otp, DateTime.UtcNow.AddMinutes(5));
            SendOtpEmail(email, otp);

            // Lưu email để chuyển qua trang nhập OTP
            TempData["Email"] = email;
            return RedirectToAction("VerifyOtp");
        }

        //Xác thực OTP
        [HttpGet]
        public IActionResult VerifyOtp()
        {
            ViewBag.Email = TempData["Email"]?.ToString();
            return View();
        }

        [HttpPost]
        public IActionResult VerifyOtp(string email, string otp)
        {

            if (otpStorage.ContainsKey(email))
            {
                var (user, storedOtp, timeOtp) = otpStorage[email];

                if (timeOtp < DateTime.UtcNow)
                {
                    ViewBag.Error = "Mã OTP đã hết hạn!";
                    return View();
                }

                if (otp == storedOtp)
                {
                    _context.Users.Add(user);
                    _context.SaveChanges();
                    otpStorage.Remove(email); // Xóa OTP khỏi bộ nhớ
                    return RedirectToAction("Login");           //Khi thành công cần có thông báo
                }
                else
                {
                    ViewBag.Error = "Mã OTP không đúng!";
                }
            }

            //này là phần quên mật khẩu
            else if (otpForgotPassStorage.ContainsKey(email))
            {
                var (storedOtp, timeOtp) = otpForgotPassStorage[email];
                if (timeOtp < DateTime.UtcNow)
                {
                    ViewBag.Error = "Mã OTP đã hết hạn!";
                    return View();
                }

                if (otp == storedOtp)
                {
                    otpStorage.Remove(email); // Xóa OTP khỏi bộ nhớ
                    return RedirectToAction("ResetPassword");
                }
                else
                {
                    ViewBag.Error = "Mã OTP không đúng!";
                }
            }
            else
            {
                ViewBag.Error = "Không tìm thấy yêu cầu xác thực!";
            }

            return View();
        }

        //Resend OTP
        [HttpPost]
        public IActionResult ResendOtp(string email)
        {
            if (otpStorage.ContainsKey(email))
            {
                var (user, _, _) = otpStorage[email]; // Lấy thông tin user từ bộ nhớ tạm

                string newOtp = new Random().Next(100000, 999999).ToString();
                otpStorage[email] = (user, newOtp, DateTime.UtcNow.AddMinutes(5));
                SendOtpEmail(email, newOtp);

                ViewBag.Success = "OTP mới đã được gửi!";
            } 

            else if (otpForgotPassStorage.ContainsKey(email))
            {
                var (user, _) = otpForgotPassStorage[email];

                string newOtp = new Random().Next(100000, 999999).ToString();
                otpForgotPassStorage[email] = (newOtp, DateTime.UtcNow.AddMinutes(5));
                SendOtpEmail(email, newOtp);

                ViewBag.Success = "OTP mới đã được gửi!";
            }
            else
            {
                ViewBag.Error = "Không tìm thấy yêu cầu xác thực!";
            }

            ViewBag.Email = email;
            return View("VerifyOtp");
        }

        private void SendOtpEmail(string email, string otp)
        {
            var smtpClient = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("fctuoiconde@gmail.com", "zadc gtaz olcv ibxx"),
                EnableSsl = true,
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress("fctuoiconde@gmail.com"),
                Subject = "Xác thực OTP",
                Body = $"Mã OTP của bạn là: {otp}",
                IsBodyHtml = false,
            };

            mailMessage.To.Add(email);

            smtpClient.Send(mailMessage);
        }

        //Đăng nhập
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

        //Login Google
        [HttpGet]
        public IActionResult GoogleLogin()
        {
            var properties = new AuthenticationProperties { RedirectUri = Url.Action("GoogleResponse") };
            return Challenge(properties, GoogleDefaults.AuthenticationScheme);
        }

        // Google redirect
        [HttpGet]
        public async Task<IActionResult> GoogleResponse()
        {
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            if (!result.Succeeded)
                return RedirectToAction("Login");

            var claims = result.Principal.Identities.FirstOrDefault()?.Claims.Select(c => new
            {
                c.Type,
                c.Value
            });

            string email = claims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            string fullName = claims?.FirstOrDefault(c => c.Type == ClaimTypes.Name)?.Value;

            if (email == null)
            {
                ViewBag.Error = "Không thể xác thực tài khoản Google!";
                return View("Login");
            }

            // Kiểm tra email có trong DB không?
            var user = _context.Users.FirstOrDefault(u => u.UserEmail == email);
            if (user == null)
            {
                user = new User
                {
                    UserEmail = email,
                    UserName = fullName ?? "Google User",
                    UserPass = null, // Vì đăng nhập bằng Google
                    IsAdmin = "False",
                    Banned = false,
                    IsStoreStaff = "False"
                };

                _context.Users.Add(user);
                _context.SaveChanges();
            }

            // Đăng nhập user vào hệ thống
            var userClaims = new List<Claim>
        {
            new Claim(ClaimTypes.Email, user.UserEmail),
            new Claim("FullName", user.UserName),
        };

            var claimsIdentity = new ClaimsIdentity(userClaims, CookieAuthenticationDefaults.AuthenticationScheme);
            var authProperties = new AuthenticationProperties { IsPersistent = true };

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);

            return RedirectToAction("Index", "Home");
        }

        //Login Facebook
        [HttpGet]
        public IActionResult FacebookLogin()
        {
            var properties = new AuthenticationProperties { RedirectUri = Url.Action("FacebookResponse") };
            return Challenge(properties, FacebookDefaults.AuthenticationScheme);
        }

        [HttpGet]
        public async Task<IActionResult> FacebookResponse()
        {
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            if (!result.Succeeded)
                return RedirectToAction("Login");

            var claims = result.Principal.Identities.FirstOrDefault()?.Claims.Select(c => new
            {
                c.Type,
                c.Value
            });

            string email = claims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            string fullName = claims?.FirstOrDefault(c => c.Type == ClaimTypes.Name)?.Value;

            // Kiểm tra email có trong DB không?
            var user = _context.Users.FirstOrDefault(u => u.UserEmail == email);
            if (user == null)
            {
                user = new User { UserEmail = email, UserName = fullName };
                _context.Users.Add(user);
                _context.SaveChanges();
            }

            // Đăng nhập user vào hệ thống
            var userClaims = new List<Claim>
        {
            new Claim(ClaimTypes.Email, user.UserEmail),
            new Claim("FullName", user.UserName),
        };

            var claimsIdentity = new ClaimsIdentity(userClaims, CookieAuthenticationDefaults.AuthenticationScheme);
            var authProperties = new AuthenticationProperties { IsPersistent = true };

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);

            return RedirectToAction("Index", "Home");
        }

        //Quên mật khẩu
        [HttpPost]
        public IActionResult ForgotPassword(string email)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserEmail == email);
            if (user == null)
            {
                ViewBag.Error = "Email không tồn tại!";
                return View();
            }

            string otp = new Random().Next(100000, 999999).ToString();
            otpForgotPassStorage[email] = (otp, DateTime.UtcNow.AddMinutes(5));
            SendOtpEmail(email, otp);

            ViewBag.Email = email;
            ViewBag.Success = "OTP đã được gửi đến email!";
            return View("VerifyOtp");
        }

        //Reset Pass
        [HttpPost]
        public IActionResult ResetPassword(string email, string newPassword, string confirmPassword)
        {
            if (newPassword != confirmPassword)
            {
                ViewBag.Error = "Mật khẩu xác nhận không khớp!";
                return View("ResetPassword");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserEmail == email);
            if (user != null)
            {
                user.UserPass = newPassword;
                _context.SaveChanges();
            }

            otpStorage.Remove(email);
            return RedirectToAction("Login");       //Thông báo
        }

        //Đăng xuất
        public IActionResult Logout()
        {
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Account");
        }
    }
}

using ElectronicShopTeam14.Models;
using ElectronicShopTeam14.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Facebook;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.ComponentModel.DataAnnotations;
using System.Net.Mail;
using System.Net;
using System.Security.Claims;

namespace ElectronicShopTeam14.Controllers
{
    public class AccountController : Controller
    {
        private readonly IUserRepository _userRepository;
        private readonly IEmailService _emailService;


        public AccountController(IUserRepository userRepository, IEmailService emailService)
           
        {
            _userRepository = userRepository;
            _emailService = emailService;

        }
        //***** FORGOT PASSWORD *****
        [HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = _userRepository.GetUserByEmail(model.Email);

                if (user != null)
                {
                    // Generate password reset token
                    string token = _userRepository.GeneratePasswordResetToken(model.Email);

                    // Create reset password link
                    var resetLink = Url.Action("ResetPassword", "Account",
                        new { email = model.Email, token = token },
                        protocol: HttpContext.Request.Scheme);

                    // Send email
                    string emailBody = $@"
                <h2>Đặt lại mật khẩu</h2>
                <p>Để đặt lại mật khẩu, vui lòng click vào link bên dưới:</p>
                <p><a href='{resetLink}'>Đặt lại mật khẩu</a></p>
                <p>Link này sẽ hết hạn sau 24 giờ.</p>
                <p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>";

                    await _emailService.SendEmailAsync(model.Email, "Đặt lại mật khẩu", emailBody);

                    TempData["Success"] = "Link đặt lại mật khẩu đã được gửi đến email của bạn.";
                    return View();
                }

                // Don't reveal that the user does not exist
                TempData["Success"] = "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được link đặt lại mật khẩu.";
                return View();
            }

            return View(model);
        }

        //***** RESET PASSWORD *****
        public class ResetPasswordViewModel
        {
            [Required(ErrorMessage = "Email là bắt buộc")]
            [EmailAddress(ErrorMessage = "Email không hợp lệ")]
            public string Email { get; set; }

            [Required(ErrorMessage = "Token là bắt buộc")]
            public string Token { get; set; }

            [Required(ErrorMessage = "Mật khẩu mới là bắt buộc")]
            [StringLength(100, ErrorMessage = "Mật khẩu phải có ít nhất {2} ký tự.", MinimumLength = 6)]
            [DataType(DataType.Password)]
            public string NewPassword { get; set; }

            [DataType(DataType.Password)]
            [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp.")]
            public string ConfirmPassword { get; set; }
        }

        [HttpGet]
        public IActionResult ResetPassword(string email, string token)
        {
            var model = new ResetPasswordViewModel { Email = email, Token = token };
            return View(model);
        }

        [HttpPost]
        public IActionResult ResetPassword(ResetPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (_userRepository.ValidatePasswordResetToken(model.Email, model.Token))
                {
                    string hashedPassword = _userRepository.HashPassword(model.NewPassword);
                    _userRepository.UpdatePassword(model.Email, hashedPassword);

                    TempData["Success"] = "Mật khẩu đã được đặt lại thành công. Vui lòng đăng nhập.";
                    return RedirectToAction("Login");
                }

                ModelState.AddModelError("", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            }

            return View(model);
        }

        //***** LOGIN *****
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = _userRepository.GetUserByEmail(model.Email);

                if (user != null && _userRepository.ValidatePassword(model.Password, user.UserPass))
                {
                    if (user.Banned == true)
                    {
                        ModelState.AddModelError("", $"Tài khoản của bạn đã bị khóa. Lý do: {user.AdminReason}");
                        return View(model);
                    }

                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, user.UserName ?? user.UserEmail),
                        new Claim(ClaimTypes.Email, user.UserEmail),
                        new Claim("UserId", user.UserId.ToString())
                    };

                    if (user.IsAdmin == "True")
                        claims.Add(new Claim(ClaimTypes.Role, "Admin"));
                    if (user.IsStoreStaff == "True")
                        claims.Add(new Claim(ClaimTypes.Role, "StoreStaff"));

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var authProperties = new AuthenticationProperties
                    {
                        IsPersistent = model.RememberMe
                    };

                    await HttpContext.SignInAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        new ClaimsPrincipal(claimsIdentity),
                        authProperties);

                    return RedirectToAction("Index", "Home");
                }

                ModelState.AddModelError("", "Tài khoản hoặc mật khẩu sai");
            }

            return View(model);
        }

        //***** LOGIN GOOGLE *****
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
            var user = _userRepository.GetUserByEmail(email);
            if (user == null)
            {
                user = new User
                {
                    UserEmail = email,
                    UserName = fullName ?? "Google User",
                    UserPass = "abc@123",
                    IsAdmin = "False",
                    Banned = false,
                    IsStoreStaff = "False"
                };

                _userRepository.AddUser(user);
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

        //***** LOGIN FACEBOOK *****
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
            var user = _userRepository.GetUserByEmail(email);
            if (user == null)
            {
                user = new User
                {
                    UserEmail = email,
                    UserPass = "abc@123",
                    UserName = fullName,
                    IsAdmin = "False",
                    Banned = false,
                    IsStoreStaff = "False"
                };
                _userRepository.AddUser(user);
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

        //***** REGISTER *****
        // Lưu tạm thông tin user để xác thực OTP
        private static Dictionary<string, (User User, string OTP, DateTime Expiry)> otpStorage = new();
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Check if email already exists
                var existingUser = _userRepository.GetUserByEmail(model.Email);
                if (existingUser != null)
                {
                    ModelState.AddModelError("", "Email đã được sử dụng");
                    return View(model);
                }

                // Create new user
                var user = new User
                {
                    UserEmail = model.Email,
                    UserPass = _userRepository.HashPassword(model.Password), // Assume you have a password hashing method
                    UserName = model.UserName,
                    PhoneNumber = model.PhoneNumber,
                    Address = model.Address,
                    DateOfBirth = model.DateOfBirth,
                    IsAdmin = "False",
                    IsStoreStaff = "False",
                    Banned = false
                };

                // Tạo OTP
                string otp = new Random().Next(100000, 999999).ToString();
                otpStorage[model.Email] = (user, otp, DateTime.UtcNow.AddMinutes(5));
                SendOtpEmail(model.Email, otp);

                // Lưu email để chuyển qua trang nhập OTP
                TempData["Email"] = model.Email;
                return RedirectToAction("VerifyOtp");

                //try
                //{
                //    _userRepository.AddUser(user);

                //    // Automatically log in the user after registration
                //    var claims = new List<Claim>
                //        {
                //            new Claim(ClaimTypes.Name, user.UserName ?? user.UserEmail),
                //            new Claim(ClaimTypes.Email, user.UserEmail),
                //            new Claim("UserId", user.UserId.ToString())
                //        };

                //    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                //    var authProperties = new AuthenticationProperties();

                //    await HttpContext.SignInAsync(
                //        CookieAuthenticationDefaults.AuthenticationScheme,
                //        new ClaimsPrincipal(claimsIdentity),
                //        authProperties);

                //    return RedirectToAction("Index", "Home");
                //}
                //catch (Exception)
                //{
                //    ModelState.AddModelError("", "Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại sau.");
                //}
            }

            return View(model);
        }

        //***** VERIFY OTP *****
        [HttpGet]
        public IActionResult VerifyOtp()
        {
            ViewBag.Email = TempData["Email"]?.ToString();
            return View();
        }

        [HttpPost]
        public IActionResult VerifyOtp(string email, string otp)
        {
            if (string.IsNullOrEmpty(email))
            {
                ViewBag.Error = "Email không hợp lệ!";
                return View();
            }

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
                    _userRepository.AddUser(user);
                    otpStorage.Remove(email); // Xóa OTP khỏi bộ nhớ
                    return RedirectToAction("Login");           //Khi thành công cần có thông báo
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

        //***** RESEND OTP *****
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
            else
            {
                ViewBag.Error = "Không tìm thấy yêu cầu xác thực!";
            }

            ViewBag.Email = email;
            return View("VerifyOtp");
        }

        //***** SEND OTP BY EMAIL *****
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

        //***** LOGOUT *****
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home"); // Chuyển hướng về trang chủ
        }

        [HttpGet]
        [Authorize] // Thêm attribute này để yêu cầu đăng nhập
        public IActionResult Profile()
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

            var viewModel = new UserProfileViewModel
            {
                UserId = user.UserId,
                UserName = user.UserName,
                UserEmail = user.UserEmail,
                DateOfBirth = user.DateOfBirth,
                Address = user.Address,
                PhoneNumber = user.PhoneNumber
            };

            return View(viewModel);
        }

        [HttpPost]
        [Authorize]
        public IActionResult UpdateProfile(UserProfileViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View("Profile", model);
            }

            var user = _userRepository.GetUserById(model.UserId);
            if (user == null)
            {
                return NotFound();
            }

            // Kiểm tra xem email mới có bị trùng không (nếu email thay đổi)
            if (user.UserEmail != model.UserEmail)
            {
                var existingUser = _userRepository.GetUserByEmail(model.UserEmail);
                if (existingUser != null)
                {
                    ModelState.AddModelError("UserEmail", "Email này đã được sử dụng");
                    return View("Profile", model);
                }
            }

            user.UserName = model.UserName;
            user.UserEmail = model.UserEmail;
            user.DateOfBirth = model.DateOfBirth;
            user.Address = model.Address;
            user.PhoneNumber = model.PhoneNumber;

            try
            {
                _userRepository.UpdateUser(user);
                TempData["SuccessMessage"] = "Cập nhật thông tin thành công!";
            }
            catch (Exception)
            {
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi cập nhật thông tin!";
            }

            return RedirectToAction(nameof(Profile));
        }

        //***** CHANGE PASSWORD *****
        [HttpGet]
        public IActionResult ChangePassword()
        {
            var model = new UserProfileViewModel();
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ChangePassword(UserProfileViewModel model)
        {
            if (string.IsNullOrEmpty(model.CurrentPassword))
            {
                ModelState.AddModelError("CurrentPassword", "Vui lòng nhập mật khẩu hiện tại");
                return View(model);
            }

            if (string.IsNullOrEmpty(model.NewPassword))
            {
                ModelState.AddModelError("NewPassword", "Vui lòng nhập mật khẩu mới");
                return View(model);
            }

            if (string.IsNullOrEmpty(model.ConfirmPassword))
            {
                ModelState.AddModelError("ConfirmPassword", "Vui lòng xác nhận mật khẩu mới");
                return View(model);
            }

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

            // Verify old password
            if (!_userRepository.ValidatePassword(model.CurrentPassword, user.UserPass))
            {
                ModelState.AddModelError("CurrentPassword", "Mật khẩu hiện tại không đúng");
                return View(model);
            }

            try
            {
                // Update password
                user.UserPass = _userRepository.HashPassword(model.NewPassword);
                _userRepository.UpdateUser(user);

                TempData["SuccessMessage"] = "Đổi mật khẩu thành công!";
                return RedirectToAction(nameof(Profile));
            }
            catch (Exception)
            {
                ModelState.AddModelError("", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại sau.");
                return View(model);
            }
        }

    }
}
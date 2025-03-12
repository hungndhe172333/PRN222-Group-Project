using ElectronicShopTeam14.Models;
using ElectronicShopTeam14.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.ComponentModel.DataAnnotations;
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
        /*[HttpGet]
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
        }*/
        /* public class ResetPasswordViewModel
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
         }*/


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

                try
                {
                    _userRepository.AddUser(user);

                    // Automatically log in the user after registration
                    var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.UserName ?? user.UserEmail),
                new Claim(ClaimTypes.Email, user.UserEmail),
                new Claim("UserId", user.UserId.ToString())
            };

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var authProperties = new AuthenticationProperties();

                    await HttpContext.SignInAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        new ClaimsPrincipal(claimsIdentity),
                        authProperties);

                    return RedirectToAction("Index", "Home");
                }
                catch (Exception)
                {
                    ModelState.AddModelError("", "Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại sau.");
                }
            }

            return View(model);
        }



        [HttpPost]
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
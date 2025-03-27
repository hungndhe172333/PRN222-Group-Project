using ElectronicShopTeam14.Models;
using ElectronicShopTeam14.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Facebook;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
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

                    if (string.IsNullOrWhiteSpace(user.UserName))
                    {
                        ModelState.AddModelError("", "Tài khoản không có tên người dùng hợp lệ.");
                        return View(model);
                    }

                    Console.WriteLine($"User found - UserName: {user.UserName}, UserEmail: {user.UserEmail}");

                    var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.Email, user.UserEmail),
                new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString())
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

                    // Debug sau khi SignInAsync
                    Console.WriteLine($"After SignInAsync - IsAuthenticated: {User.Identity.IsAuthenticated}");
                    Console.WriteLine("Claims after SignInAsync:");
                    foreach (var claim in claims)
                    {
                        Console.WriteLine($" - Type: {claim.Type}, Value: {claim.Value}");
                    }

                    return RedirectToAction("Index", "Home");
                }

                TempData["ErrorMessage"] = "Tài khoản hoặc mật khẩu sai";
                return RedirectToAction("Index", "Home");
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

                    TempData["ErrorMessage"] = "Email đã tồn tại trong hệ thống";
                    return RedirectToAction("Index", "Home");
                }

                // Create new user
                var user = new User
                {
                    UserEmail = model.Email,
                    UserPass = _userRepository.HashPassword(model.Password),
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
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        [Authorize]
        public IActionResult Profile()
        {
            var userIdClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
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

            // Không cho phép thay đổi email, giữ nguyên email cũ
            if (model.UserEmail != user.UserEmail)
            {
                ModelState.AddModelError("UserEmail", "Không được phép thay đổi email");
                return View("Profile", model);
            }

            // Kiểm tra số điện thoại phải là 10 số
            if (!string.IsNullOrEmpty(model.PhoneNumber) && (model.PhoneNumber.Length != 10 || !model.PhoneNumber.All(char.IsDigit)))
            {
                ModelState.AddModelError("PhoneNumber", "Số điện thoại phải gồm 10 chữ số");
                return View("Profile", model);
            }

            user.UserName = model.UserName;
            user.UserEmail = user.UserEmail; // Giữ nguyên email
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

            var userIdClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
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
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace _14_GroupProject_PRN222_SE1810.Views.Account
{
    public class LoginModel : PageModel
    {

        [BindProperty]
        public string Email { get; set; }
        [BindProperty]
        public string Password { get; set; }
        public string Message { get; set; }
        [BindProperty] public bool RememberMe { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {

            if (Email == "admin@example.com" && Password == "123456")
            {
                return RedirectToPage("/Index");
            }
            else
            {
                Message = "Email hoặc mật khẩu không đúng!";
                return Page();
            }

        }
    }
}

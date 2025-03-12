using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models
{
    public class UserProfileViewModel
    {
        public long UserId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập tên người dùng")]
        [Display(Name = "Tên người dùng")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "Tên người dùng phải từ {2} đến {1} ký tự")]
        [RegularExpression(@"^[a-zA-ZÀ-ỹ\s]*$", ErrorMessage = "Tên người dùng chỉ được chứa chữ cái và khoảng trắng")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập email")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ")]
        [Display(Name = "Email")]
        [StringLength(100, ErrorMessage = "Email không được vượt quá {1} ký tự")]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", ErrorMessage = "Email không đúng định dạng")]
        public string UserEmail { get; set; }

        [Display(Name = "Ngày sinh")]
        [Required(ErrorMessage = "Vui lòng nhập ngày sinh")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]

        public string DateOfBirth { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập địa chỉ")]
        [Display(Name = "Địa chỉ")]
        [StringLength(20, MinimumLength = 5, ErrorMessage = "Địa chỉ phải từ {2} đến {1} ký tự")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số điện thoại")]
        [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
        [Display(Name = "Số điện thoại")]
        [RegularExpression(@"^(0[1-9]|84[1-9])([0-9]{8})$", ErrorMessage = "Số điện thoại không đúng định dạng")]
        [StringLength(12, MinimumLength = 10, ErrorMessage = "Số điện thoại phải từ {2} đến {1} số")]
        public string PhoneNumber { get; set; }

        // Thêm các trường từ ChangePasswordViewModel
        [Display(Name = "Mật khẩu hiện tại")]
        public string? CurrentPassword { get; set; }

        [StringLength(100, ErrorMessage = "Mật khẩu phải có ít nhất {2} ký tự", MinimumLength = 6)]
        [Display(Name = "Mật khẩu mới")]
        public string? NewPassword { get; set; }

        [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp")]
        [Display(Name = "Xác nhận mật khẩu mới")]
        public string? ConfirmPassword { get; set; }

        // Thêm flag để kiểm tra có đang thay đổi mật khẩu hay không
        public bool IsChangingPassword { get; set; }

        // Custom validation cho mật khẩu
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (IsChangingPassword)
            {
                if (string.IsNullOrEmpty(CurrentPassword))
                {
                    yield return new ValidationResult(
                        "Vui lòng nhập mật khẩu hiện tại",
                        new[] { nameof(CurrentPassword) });
                }

                if (string.IsNullOrEmpty(NewPassword))
                {
                    yield return new ValidationResult(
                        "Vui lòng nhập mật khẩu mới",
                        new[] { nameof(NewPassword) });
                }

                if (string.IsNullOrEmpty(ConfirmPassword))
                {
                    yield return new ValidationResult(
                        "Vui lòng xác nhận mật khẩu mới",
                        new[] { nameof(ConfirmPassword) });
                }
            }
        }
    }
}


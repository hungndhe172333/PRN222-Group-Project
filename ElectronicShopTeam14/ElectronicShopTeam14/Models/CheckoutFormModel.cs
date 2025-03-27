using System.ComponentModel.DataAnnotations;

namespace ElectronicShopTeam14.Models
{
    public class CheckoutFormModel
    {
        [Required(ErrorMessage = "Street address is required.")]
        public string StreetAddress { get; set; }

        [Required(ErrorMessage = "District is required.")]
        public string District { get; set; }

        [Required(ErrorMessage = "City is required.")]
        public string City { get; set; }

        [Required(ErrorMessage = "Phone number is required.")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Payment method is required.")]
        public string PaymentMethod { get; set; }

        [Required(ErrorMessage = "You must agree to the terms and conditions.")]
        public bool DefaultCheck10 { get; set; }
    }
}

using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace ElectronicShopTeam14.Hubs
{
	public class ProductHub : Hub
	{
		// Gửi thông báo khi có sản phẩm thay đổi
		public async Task NotifyProductChanged(string action, object product)
		{
			await Clients.All.SendAsync("ReceiveProductUpdate", action, product);
		}
	}
}

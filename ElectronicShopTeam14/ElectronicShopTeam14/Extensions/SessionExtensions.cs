using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace ElectronicShopTeam14.Extensions;

public static class SessionExtensions
{
	public static void SetObjectAsJson(this ISession session, string key, object value)
	{
		var settings = new JsonSerializerSettings
		{
			ReferenceLoopHandling = ReferenceLoopHandling.Ignore
		};
		session.SetString(key, JsonConvert.SerializeObject(value, settings));
	}

	public static T GetObjectFromJson<T>(this ISession session, string key)
	{
		var value = session.GetString(key);
		if (value == null) return default(T);
		try
		{
			var settings = new JsonSerializerSettings
			{
				ReferenceLoopHandling = ReferenceLoopHandling.Ignore
			};
			return JsonConvert.DeserializeObject<T>(value, settings);
		}
		catch (Exception ex)
		{
			Console.WriteLine($"Error deserializing session data: {ex.Message}");
			return default(T);
		}
	}
}
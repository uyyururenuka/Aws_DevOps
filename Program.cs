using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Helloworldwebapp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // Create the host
            var host = CreateHostBuilder(args).Build();

            // Run the host
            host.Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.ConfigureServices((context, services) =>
                    {
                        // Configure services
                        services.AddControllersWithViews();
                    })
                    .Configure((context, app) =>
                    {
                        // Configure request processing pipeline
                        app.UseHttpsRedirection();
                        app.UseStaticFiles();
                        app.UseRouting();
                        app.UseAuthorization();
                        app.UseEndpoints(endpoints =>
                        {
                            endpoints.MapControllerRoute(
                                name: "default",
                                pattern: "{controller=Home}/{action=Index}/{id?}");
                        });
                    });
                })
                
                .ConfigureLogging(logging =>
                {
                    logging.ClearProviders(); // Clear any previously configured providers
                    logging.AddConsole(); // Add console logging
                });

    }
}

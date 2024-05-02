using Helloworldwebapp.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Helloworldwebapp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            var CurrentTime = DateTime.Now.ToString("HH:mm:ss");
            ViewBag.Message = $"The Current server time is: {CurrentTime}";

            // Log the request
            //_logger.LogInformation($"Request received: {DateTime.Now}, Path: {HttpContext.Request.Path}");

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

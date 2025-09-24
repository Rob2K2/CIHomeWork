using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;


var builder = WebApplication.CreateBuilder(args);
builder.WebHost.UseUrls("http://*:5000"); // Escuchar en el puerto 5000

var app = builder.Build();
app.MapGet("/", () => "Hola Mundo");
app.Run();


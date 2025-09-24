# Imagen base para ejecutar la app
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5000
ENV PORT=5000

# Imagen para compilar la app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiar el archivo del proyecto
COPY ["MiAppWeb/MiAppWeb.csproj", "MiAppWeb/"]
RUN dotnet restore "MiAppWeb/MiAppWeb.csproj"

# Copiar el resto del código
COPY . .
WORKDIR "/src/MiAppWeb"
RUN dotnet build "MiAppWeb.csproj" -c Release -o /app/build
RUN dotnet publish "MiAppWeb.csproj" -c Release -o /app/publish

# Imagen final
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
CMD ["dotnet", "MiAppWeb.dll"]

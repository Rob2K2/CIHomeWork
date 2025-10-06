# Etapa base (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5000

# Etapa build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiar proyecto y restaurar
COPY ["MiAppWeb/MiAppWeb.csproj", "MiAppWeb/"]
RUN dotnet restore "MiAppWeb/MiAppWeb.csproj"

# Copiar el resto del código
COPY . .
WORKDIR "/src/MiAppWeb"

# Publicar directamente
RUN dotnet publish "MiAppWeb.csproj" -c Release -o /app/publish

# Imagen final
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Indicar ambiente Production
ENV ASPNETCORE_ENVIRONMENT=Production

CMD ["dotnet", "MiAppWeb.dll"]

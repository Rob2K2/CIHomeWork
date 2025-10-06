# Base stage (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5000

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy project and restore dependencies
COPY ["MiAppWeb/MiAppWeb.csproj", "MiAppWeb/"]
RUN dotnet restore "MiAppWeb/MiAppWeb.csproj"

# Copy the rest of the source code
COPY . .
WORKDIR "/src/MiAppWeb"

# Publish directly
RUN dotnet publish "MiAppWeb.csproj" -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Set environment to Production
ENV ASPNETCORE_ENVIRONMENT=Production

CMD ["dotnet", "MiAppWeb.dll"]

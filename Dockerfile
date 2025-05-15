FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# Copy the solution and project files
COPY *.sln .
COPY ./**/*.csproj ./
RUN mkdir src && move *.csproj src

# Restore NuGet packages
RUN nuget restore

# Copy the rest of the source code
COPY . .

# Build the application
RUN msbuild /p:Configuration=Release /p:OutputPath=/app/out

# Runtime image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/out .

# Expose port 80
EXPOSE 80
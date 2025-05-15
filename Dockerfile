FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY CustomFontSample/*.csproj ./CustomFontSample/
COPY CustomFontSample/*.config ./CustomFontSample/
RUN nuget restore

# copy everything else and build app
COPY CustomFontSample/. ./CustomFontSample/
WORKDIR /app/CustomFontSample
RUN msbuild /p:Configuration=Release -r:False


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/CustomFontSample/. ./
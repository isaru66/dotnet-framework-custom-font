FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

# Copy pre-built files from your local bin directory
COPY ./bin/Release/ .

# Expose port 80
EXPOSE 80

# Set the entry point
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
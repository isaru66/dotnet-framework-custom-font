FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

# Copy the entire web application
COPY CustomFontSample/ .

# Copy and install font
COPY ["CustomFontSample/FrederickatheGreat-Regular.ttf", "C:/Windows/Fonts/FrederickatheGreat-Regular.ttf"]
ADD ["CustomFontSample/FrederickatheGreat-Regular.ttf", "C:/Windows/Fonts/FrederickatheGreat-Regular.ttf"]

# Add registry entry for the font
RUN powershell.exe -Command \
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" \
    -Name "Fredericka the Great" \
    -Value "FrederickatheGreat-Regular.ttf" \
    -PropertyType String

# Expose port 80
EXPOSE 80

# Set the entry point
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
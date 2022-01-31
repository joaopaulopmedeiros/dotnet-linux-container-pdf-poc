#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:3.1 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["PdfGenerator.csproj", "."]
RUN dotnet restore "./PdfGenerator.csproj"
COPY . .
WORKDIR "/src/."
RUN apt-get update \ && apt-get install -y libgdiplus
RUN dotnet build "PdfGenerator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PdfGenerator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PdfGenerator.dll"]
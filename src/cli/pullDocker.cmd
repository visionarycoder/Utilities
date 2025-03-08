@echo off
echo Program: ~nx0
echo Purpose: Pull common images from docker 
echo.
docker pull mysql
docker pull alpine
docker pull nginx
docker pull postgres
docker pull hashicorp/vault
docker pull docker
echo.
echo __END__
echo.

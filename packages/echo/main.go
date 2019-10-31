package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func hello(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, World!")
}

func healthCheck(c echo.Context) error {
	return c.String(http.StatusOK, "healthy!")
}

func say(c echo.Context) error {
	msg := c.FormValue("message")
	return c.JSON(http.StatusOK, map[string]interface{}{"message": msg})
}

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/hello", hello)
	e.GET("/healthz", healthCheck)
	e.POST("/say", say)

	e.Logger.Fatal(e.Start(":1323"))
}

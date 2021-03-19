package main

import (
	"net/http"
	"os"

	gin "github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")
	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.tmpl", gin.H{
			"resgate_url": os.Getenv("RESGATE_URL"),
		})
	})
	r.Run(":" + os.Getenv("PORT"))
}

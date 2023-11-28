package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	qrcode "github.com/skip2/go-qrcode"
)

func main() {
	router := gin.Default()

	router.GET("/qrcode", func(c *gin.Context) {
		text := c.Query("text")
		var png []byte
		png, err := qrcode.Encode(text, qrcode.Medium, 256)
		if err != nil {
			c.String(http.StatusInternalServerError, "Could not generate QR code: %s", err.Error())
			return
		}
		c.Data(http.StatusOK, "image/png", png)
	})

	router.Run(":8888")
}

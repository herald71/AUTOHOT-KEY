ClickImage(100, 100, 400, 400, "Image.png")
ClickImage(600, 200, 900, 500, "Image.png")
ClickImage(500, 500, 800, 800, "ImageDiff.png")

ClickImage(startX, startY, endX, endY, imageFile)
{
	if (ImageSearch(&vx, &vy, startX, startY, endX, endY, imageFile))
		MouseClick("L", vx, vy)
}
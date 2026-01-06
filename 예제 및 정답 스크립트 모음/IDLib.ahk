GetID(param := "")
{
	return DriveGetSerial("C:")
}

CheckID(_id)
{
	return DriveGetSerial("C:") == _id
}
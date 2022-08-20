# Package

version       = "0.1.0"
author        = "Basal: Alex King"
description   = "a pgp encryption app"
license       = "MIT"
srcDir        = "src"
bin           = @["kurasu"]


# Dependencies

requires "nim >= 1.6.6", "jester", "niml", "logging"

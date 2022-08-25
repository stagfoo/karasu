# Package

version       = "0.1.0"
author        = "Stagfoo: Alex King"
description   = "a simple app to encrypt and descrypt message for transfering over unsecure messaging apps"
license       = "MIT"
srcDir        = "src"
bin           = @["karasu"]


# Dependencies

requires "nim >= 1.6.6", "jester", "niml", "logging"

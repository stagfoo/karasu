import nimpy

# doesnt work
let pgpy = pyImport("PGPy")
let py = pyBuiltinsModule()
var key = pgpy.PGPKey.new(pgpy.PubKeyAlgorithm.RSAEncryptOrSign, 4096)

echo key
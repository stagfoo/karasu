import nimAES
import murmurhash
import strutils

# hashed password
func generateKey*(passphrase: string): string =
    let hashArray = MurmurHash3_x64_128(passphrase)
    return $hashArray[0] & $hashArray[1]

type
  NewKeyringKey* = object
    id: string
    name: string
    email: string
    passphrase: string
    private: string
    public: string

# whats the dif?
# array[0..3, tuple[name: string, id: string, email: string, public: string, private: string]]
type
  KeyringKey* = object
    name: string 
    id: string
    email: string
    public: string
    private: string

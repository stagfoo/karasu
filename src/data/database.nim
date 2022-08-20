import ../types

# Figure out how to have a array with non speific length (；-_-)
# replace with database
let keyringKeys*: array[0..8, KeyringKey] = [
  (name: "alex", id: "x1", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "maki", id: "x2", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "adam", id: "x3", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke1", id: "x4", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke2", id: "x5", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke3", id: "x6", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke4", id: "x7", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke5", id: "x8", email: "yo@stagfoo.com", public: "", private: ""),
  (name: "luke6", id: "x9", email: "yo@stagfoo.com", public: "", private: ""),
]

const fakeTextMessage*:string = """
-----BEGIN PGP MESSAGE-----
Version: BCPG v1.63

hQEOA7AXaMxqYSTbEAQAxn2YTISyg7JlP5OYLEAACLd8YWSYyoZNX1z86nzRG5Fu
pEXu2gpq7Y+gsjuh/SfYMNgQ+uHJWanwa/ILnEN5pL4kmTGLBxr5PtTh7FgJHlsq
ITs+g6j7fdF5AOTF7MY1GWjrf4UKWFZoNpYk2y4j7HrpQ7G6BgBhrQwnMhCnr7QE
AM+KHsTd1YBS8oAPggxR3ngG9elQ122iexh3b2dog819im3tjsBw3CDdl/WFiZCx
E4Hd/h94e/wYdE72bhIT4NqiMTieoFNu/WbzfIXGn1hW9aWX3jHbxVDKzBnb/4T8
HwDIr+cS/1eXLymDHcB078NtcWRc0d3XQ6idxlWUqnaL0kABxSpETvZTrJrZCLlC
q+iSYLSsX+9+pfZlxLWG+ejeeEg7ld03xdlBBALWQnCKF6XbAgs0zhzbpBO71/zZ
wzVb
=Uipu
-----END PGP MESSAGE-----
"""

let selectedKeyId* = "alex"
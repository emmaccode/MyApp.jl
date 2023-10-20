using Pkg; Pkg.activate(".")
using Toolips
using MyApp

IP = "127.0.0.1"
PORT = 8000
MyAppServer = MyApp.start(IP, PORT)

using Pkg; Pkg.activate(".")
using Toolips
using Revise
using MyApp

IP = "127.0.0.1"
PORT = 8003
MyAppServer = MyApp.start(IP, PORT)

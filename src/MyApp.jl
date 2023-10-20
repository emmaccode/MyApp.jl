module MyApp
using Toolips
using ToolipsSession
# welcome to your new toolips project!
main = route("/") do c::Connection
    bod = body("mainbody")
    maindiv = div("maindiv")
    name_heading = h("nameheading", 2, text = "hello ! what is your name?")
    push!(maindiv, name_heading)
    style!(maindiv, "border-radius" => 5px, "border-color" => "darkgray", "border-style" => "solid", "padding" => 20px, 
    "transition" => 1seconds)
    style!(name_heading, "color" => "purple", "font-weight" => "bold", "font-size" => 13pt)
    button_txtbox = div("buttntxt")
    style!(button_txtbox, "display" => "flex", "border-radius" => 2px)
    push!(maindiv, button_txtbox)
    namebox = div("namebox", contenteditable = true)
    style!(namebox, "border" => "2px solid", "border-color" => "purple","border-top-right-radius" => 0px, 
    "border-bottom-right-radius" => 0px, "width" => 70percent)
    confirmbutton = button("confirmbutton", text = "enter")
    style!(confirmbutton, "background-color" => "purple", "color" => "white","border-top-right-radius" => 7px,
    "border-bottom-right-radius" => 7px, "border-top-left-radius" => 0px, "border-bottom-left-radius" => 0px)
    push!(button_txtbox, namebox, confirmbutton)
    on(c, confirmbutton, "click") do cm::ComponentModifier
        persons_name = cm[namebox]["text"]
        new_heading = h("newheading", 2, text = "hello, $persons_name !")
        style!(new_heading, "opacity" => 0percent, "transition" => 1seconds)
        append!(cm, bod, new_heading)
        style!(cm, maindiv, "height" => 0percent, "opacity" => 0percent)
        next!(c, maindiv, cm) do cm2::ComponentModifier
            style!(cm2, new_heading, "transform" => "translateX(50%)", "opacity" => 100percent, "color" => "blue")
        end
    end
    push!(bod, maindiv)
    write!(c, bod)
end

fourofour = route("404") do c
    write!(c, p("404message", text = "404, not found!"))
end

routes = [main, fourofour]
extensions = Vector{ServerExtension}([Logger(), Files(), Session(), ])
"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
The start function starts the WebServer.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws
end
end # - module
        
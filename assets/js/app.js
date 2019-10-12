import css from "../css/app.css"
import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket, debug, View } from "phoenix_live_view"

let Hooks = {}

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks })
liveSocket.connect()
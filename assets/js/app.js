import "phoenix_html"
import { generix_form, schema} from "./lib/forms"


const { h, app } = hyperapp



const state = {
  items : {
    data: [{inventory: "12", id: 1, description: null, code: "h21"}]
  },
  form_1 : {}
}

const actions = {
  echo: value => state => (console.log(state),{ }),
}

const view = (state, actions) =>
  h("div", { class : "bg-white shadow-md rounded text-black", style: "width: 980px; height: 900px"}, [
    top_nav(state, actions),
    main(state, actions)
  ])

const top_nav = (state, actions) =>
  h("div", {class: "bg-grey-lighter py-2 px-4"},[ 
    h("h3", {},["Generix Inv"])
  ])

const main = (state, actions) =>
  h("div", {class: "flex bg-white h-full"}, [
     main_side(state, actions),
     main_content(state, actions),
  ])

const main_side = (state, actions) =>
  h("div", {class: "h-full w-48 bg-grey-lightest px-2 py-4"}, [
     "Side" 
  ])

const main_content = (state, actions) =>
  h("div", {class: "bg-white p-4"}, [
     h("div", { class : "flex text-purple font-bold mb-4"}, [ "Inventario" ]),
     h("p", { class : "" }, [
       generix_form(schema, { action: "/api/items", method: "post" }, state, actions)
     ])
  ])

app(state, actions, view, document.body)
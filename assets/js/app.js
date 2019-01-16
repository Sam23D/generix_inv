import "phoenix_html"
import { generix_form} from "./lib/forms"


const { h, app } = hyperapp

const nueva_pieza_form_schema = {
  description : { type: "string", 
    //validation : ( desc )=>( { valid : desc.length > 5, value: desc } )
  },
  codigo : { type: "string" },
  inventory : { type: "number", 
    //validation : ( value )=>( { valid : parseInt(value) > 5, value: value } )
  },
}

const state = {
  items : {
    data: [{inventory: "12", id: 1, description: null, code: "h21"}]
  },
  form_1 : { }
}

const actions = {
  echo: value => state => (console.log(state),{ }),
  nueva_pieza_form : {
    generix_input_value_change : ({value, value_key, form_key})=> state => ({ [value_key] : value} ),
    generix_form_submition: ({form_key}) => state => {
      fetch("/api/items")
      .then((resp)=>(resp.json()))
      .then((data)=>{ console.log(data) })
      .catch(( err )=>{
        console.error(err)
      })
    }
  }
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
    h("button", { onclick: ()=>console.log(state), class : "" }, ["content"])
  ])

const main_content = (state, actions) =>
  h("div", {class: "bg-white p-4"}, [
     h("div", { class : "flex text-purple font-bold mb-4"}, [ "Inventario" ]),
     h("p", { class : "" }, [
       generix_form(nueva_pieza_form_schema, {form_key: "nueva_pieza_form"}, state, actions)
     ])
  ])

app(state, actions, view, document.body)
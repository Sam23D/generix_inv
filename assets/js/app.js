import "phoenix_html"
import { generix_form} from "./lib/forms"


const { h, app } = hyperapp

const state = {
  items : {
    data: [{inventory: "12", id: 1, description: null, code: "h21"}]
  },
  nueva_pieza_form : { }
}

const actions = {
  echo: value => state => (console.log(state),{ }),
  nueva_pieza_form : {
    generix_input_value_change : ({value, value_key, form_key})=> state => ({ [value_key] : value} ),
    generix_form_submition: ({form_key}) => state => {
      fetch("/api/items")
      .then((resp)=>(resp.json()))
      .then((data)=>{ 
        console.log(data) 
      })
      .catch(( err )=>{
        console.error(err)
      })
    }
  },
  items : {
    fetch_inventory: _ => (state, actions) => {
      fetch("/api/items")
      .then((resp)=>(resp.json()))
      .then((data)=>{ 
        console.log("data", data)
        actions.set_inventory(data)
        return data 
      })
      .catch(( err )=>{
        console.error(err)
      })
    },
    set_inventory: data => state => data
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
  h("div", {class: "flex flex-col h-full w-48 bg-grey-lightest px-2 py-4"}, [
    h("button", { onclick: actions.items.fetch_inventory , class : "" }, ["Reload"]),
    h("button", { onclick: ()=>{ console.log(state) } , class : "" }, ["log state"])
  ])

const main_content = (state, actions) =>
  h("div", {class: "bg-white p-4"}, [
     h("div", { class : "flex text-purple font-bold mb-4"}, [ "Inventario" ]),
     h("div", { class : "" }, [
       
       item_list,
     ])
  ])

const item_list = (state, actions)=>
  h("div", { class : "", style: "width: 640px" }, [
    h("div", { class : "flex flex-row-reverse w-full " }, [
      h("button", { class : "text-blue hover:text-blue-dark p-1" }, ["Create New"])
    ]),
    h("input", { class : "px-4 py-1 border-t w-full", placeholder: "Filter..." }, ["content"]),
    h("table", {
      class : `
        bg-grey-lightest
        border rounded
        text-black
        w-full
      `
    }, 
    [
      new_item_row({ code: "h20", desc: "pieza", inventory: 100 }),
      ...state.items.data.map(item_row)]
    ),
    pagination(state, actions)  
  ])
  

const item_row = ( item_object )=>{
  let data_cols = Object.keys( item_object ).map((key)=> item_col(item_object[key]) )
  let cols = [...data_cols, h("td", { class : "" }, [  ])]
  return h("tr", { class : "border-b hover:bg-grey-lighter" }, cols)
}

const item_col = (label)=>
  h("td", { class : "px-3 py-2"}, [ label ])

const new_item_row = (item_object)=>{
  let data_cols = Object.keys( item_object ).map((key)=> new_item_col(key, item_object[key]) )
  let cols = [...data_cols, h("td", { class : "" }, [
    h("button", { class : "text-blue hover:text-blue-dark text-sm" }, ["Guardar"])
  ])]
  return h("tr", { class : "border-b bg-grey-lighter" }, cols)
}

const new_item_col = (label, value)=>
  h("td", { class : "px-3 py-2"}, [ 
    h("input", { class : "bg-grey-lighter", placeholder: label, value: value })
  ])

const pagination = (state, actions)=> 
  h("div", { class : "flex justify-end text-blue" }, [1,2,3].map(pagination_bullet))

const pagination_bullet = (label) =>
  h("button", { class : "text-blue hover:bg-grey-lighter p-1 px-2" }, [label])

app(state, actions, view, document.body)
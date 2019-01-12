
const { h, app } = hyperapp

export const schema = {
  description : "string",
  inventory : "number",
  code : "string"
}

// FORM_ID
export const generix_form = ( schema, { action, method }, state, actions ) =>{
  let inputs = Object.keys(schema).map(( key )=>{
    return hyperapp.h("input", { class : "w-full mb-2 border border-grey p-2", type: schema[key], placeholder: key }, [])
  })
  return h("form", { 
    action: action, 
    method: method,
    class : "flex flex-col w-64 bg-grey-lightest p-2 border border-blue-lightest" 
  }, [
    ...inputs,
    h("button", { 
      onclick : ()=>{ actions.echo(10) },
      class : "bg-blue-lighter hover:bg-blue-light border border-blue py-1 font-bold", 
      type: "button" }, ["Submit"])
  ])
}



const { h, app } = hyperapp

export const schema = {
  description : "string",
  edad: "number",
  apellidos : "string",
  inventory : { 
    type: "number"
  },
  code : "string",

}

// FORM_ID
export const generix_form = ( schema, { action, method, form_key }, state, actions ) =>{
  let inputs = Object.keys(schema).map(( value_key )=>{
    return hyperapp.h("input", { 
      class : "w-full mb-2 border border-grey p-2", 
      oninput: ( {target: {value}} )=> ( actions[ form_key ].generix_input_value_change({value, value_key, form_key}) ),
      type: schema[value_key].type || schema[value_key], 
      placeholder: value_key }, [])
  })
  return h("form", { 
    action: action,
    method: method,
    class : "flex flex-col w-64 bg-grey-lightest p-2 border border-blue-lightest" 
  }, [
    ...inputs,
    h("button", { 
      onclick : ()=>{ actions[ form_key ].generix_form_submition({value: 10, form_key: form_key}) },
      class : "bg-blue-lighter hover:bg-blue-light border border-blue py-1 font-bold", 
      type: "button" }, ["Submit"])
  ])
}
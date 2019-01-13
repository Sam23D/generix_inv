
const { h, app } = hyperapp

export const schema = {
  description : "string",
  codigo : {
    type: "string",
    validation: value  => (/[A-z][0-9]{1,}/.test(value)? { status: "SUCCESS", value: value } : { status: "ERROR", value: value })
  },
  inventory : { 
    type: "number",
    
  },

}
/* 
    generix_form : 
      { value_key : { 
        type: type,
        validation: ( value ) => { status: ( "SUCCESS" | "ERROR" | "NO_VALIDATION"), value: value }
       }} =>
      { action, method, form_key } =>
      { state } =>
      { actions } =>

*/
// FORM_ID
export const generix_form = ( schema, { action, method, form_key }, state, actions ) =>{
  let inputs = Object.keys(schema).map(( value_key )=>{
    let validation_function = schema[value_key].validation || function( val ){ return{ status: "NO_VALIDATION" } };
    let this_input_value = state[form_key][value_key] || "";
    let validated_input = validate_with(this_input_value, validation_function) 
    console.log( validated_input );
    return hyperapp.h("input", { 
      class : ` w-full mb-2 p-2
                border 
                ${ input_border( validated_input ) }
                `, 
      value : this_input_value ,
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
      onclick : ()=>{ 
        console.log(state)
        actions[ form_key ].generix_form_submition({value: 10, form_key: form_key}) 
      },
      class : "bg-blue-lighter hover:bg-blue-light border border-blue py-1 font-bold", 
      type: "button" }, ["Submit"])
  ])
}

let validate_with = (value, func) => {
  if( value.length === 0  ){
    return { status: "NO_VALIDATION" }
  }else{
    return func(value)
  }
}

let input_border = ({ status, value })=>{
  switch (status) {
    case "SUCCESS":
      return "border-green-dark"
    case "ERROR":
      return "border-red"
    default:
      return "border-grey"
  }
}

const { h, app } = hyperapp

/* 
    OPTIONAL **

    generix_form : 
      { value_key : { 
        type: type,
        validation: ( value ) => { valid: boolean, value: value }
       }} =>
      { form_key } =>
      { state } =>
      { actions } =>

*/
export const generix_form = ( schema, { form_key }, state, actions ) =>{
  let is_form_valid = true
  let inputs = Object.keys(schema).map(( value_key )=>{
    let this_input_value = state[form_key][value_key] || "";
    let validated_input = validate_with(this_input_value, schema[value_key]) 
    is_form_valid =  ( !is_form_valid | !validated_input.valid ) ? false : true
    return hyperapp.h("input", { 
      class : ` w-full mb-2 px-2 py-1
                border 
                ${ input_border( validated_input ) }
                `, 
      value : this_input_value ,
      oninput: ( {target: {value}} )=> ( actions[ form_key ].generix_input_value_change({value, value_key, form_key}) ),
      type: schema[value_key].type || schema[value_key], 
      placeholder: value_key }, [])
  })
  return h("form", {
    class : "flex flex-col w-64 bg-grey-lightest p-2 border border-blue-lightest" 
  }, [
    ...inputs,
    submit_button(state, actions, form_key, is_form_valid)
  ])
}

let submit_button = (state, actions, form_key, is_form_valid)=>{
  let color = !is_form_valid ? "grey" : "blue"
  return h("button", { 
      onclick : ()=>{
        actions[ form_key ].generix_form_submition({value: 10, form_key: form_key}) 
      },
      disabled: !is_form_valid,
      class : `
          bg-${color}-lighter hover:bg-${color}-light
          text-${color}
          border border-${color} py-1 font-bold
          `, 
      type: "button" },[
    "Submit"
  ])
}

let validate_with = (value, { validation }) => {
  return validation === undefined 
    ?  {value,  valid: true }
    :  validation( value )
}

let input_border = ({ valid })=>{
  return valid ? "border-green-dark" : "border-red"
}
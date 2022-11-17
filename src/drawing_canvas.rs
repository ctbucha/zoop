use web_sys::HtmlCanvasElement;
use yew::{function_component, html, use_node_ref, use_effect};
use wasm_bindgen::JsCast;

#[function_component(DrawingCanvas)]
pub fn drawing_canvas() -> Html {
    let canvas_ref = use_node_ref();

    {
        let canvas_ref = canvas_ref.clone();
        use_effect(move || {
            let canvas = canvas_ref.cast::<HtmlCanvasElement>();
            let context = canvas
                .unwrap()
                .get_context("2d")
                .unwrap()
                .unwrap()
                .dyn_into::<web_sys::CanvasRenderingContext2d>()
                .unwrap();

            context.begin_path();

            context
                .arc(75.0, 75.0, 50.0, 0.0, std::f64::consts::PI * 2.0)
                .unwrap();

            context.stroke();
            || ()
        })
    }

    html! {
        <canvas ref={canvas_ref}/>
    }
}

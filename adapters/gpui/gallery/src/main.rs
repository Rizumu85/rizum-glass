use std::rc::Rc;

use gpui::{
    App, Application, Bounds, Context, Render, Window, WindowBounds, WindowOptions, div,
    prelude::*, px, rgb, size,
};
use gpui_component::{
    ActiveTheme as _, Root, StyledExt as _, Theme, ThemeSet,
    button::{Button, ButtonVariants as _},
    h_flex, v_flex,
};

#[allow(dead_code)]
mod tokens {
    include!("../../generated/rizum_glass_tokens.rs");
}

struct Gallery {
    confirmed: bool,
}

impl Gallery {
    fn panel(&self, cx: &App) -> gpui::Div {
        v_flex()
            .gap_3()
            .p(px(tokens::SPACE_MD_PX))
            .bg(cx.theme().popover)
            .border_1()
            .border_color(cx.theme().border)
            .rounded_xl()
            .shadow_lg()
    }

    fn point(color: u32) -> gpui::Div {
        div().size(px(7.)).rounded_full().bg(rgb(color))
    }
}

impl Render for Gallery {
    fn render(&mut self, _window: &mut Window, cx: &mut Context<Self>) -> impl IntoElement {
        let status = if self.confirmed {
            "Saved with the same neutral shell and a pointillist accent."
        } else {
            "The action shell stays neutral until interaction gives it meaning."
        };

        v_flex()
            .size_full()
            .overflow_hidden()
            .bg(cx.theme().background)
            .text_color(cx.theme().foreground)
            .p(px(tokens::SPACE_XL_PX))
            .gap_5()
            .child(
                h_flex()
                    .justify_between()
                    .items_end()
                    .child(
                        v_flex()
                            .gap_1()
                            .child(
                                div()
                                    .text_size(px(tokens::DISPLAY_FONT_SIZE_PX))
                                    .font_family(tokens::DISPLAY_FONT_FAMILY)
                                    .font_semibold()
                                    .child("Rizum Glass for GPUI"),
                            )
                            .child(
                                div()
                                    .text_size(px(tokens::BODY_FONT_SIZE_PX))
                                    .text_color(cx.theme().muted_foreground)
                                    .child("Optional native translation of an approved web reference"),
                            ),
                    )
                    .child(
                        h_flex()
                            .gap_2()
                            .child(Self::point(tokens::COLOR_ACCENT_TEAL))
                            .child(Self::point(tokens::COLOR_ACCENT_VIOLET))
                            .child(Self::point(tokens::COLOR_ACCENT_YELLOW))
                            .child(Self::point(tokens::COLOR_ACCENT_ROSE))
                            .child(Self::point(tokens::COLOR_ACCENT_MINT)),
                    ),
            )
            .child(
                h_flex()
                    .items_start()
                    .gap_4()
                    .child(
                        self.panel(cx)
                            .w(px(420.))
                            .child(
                                div()
                                    .text_size(px(tokens::TITLE_FONT_SIZE_PX))
                                    .font_family(tokens::TITLE_FONT_FAMILY)
                                    .font_semibold()
                                    .child("Compact glass panel"),
                            )
                            .child(
                                div()
                                    .text_size(px(tokens::BODY_FONT_SIZE_PX))
                                    .text_color(cx.theme().muted_foreground)
                                    .child("Width follows the content contract, not a universal dashboard grid."),
                            )
                            .child(
                                h_flex()
                                    .gap_2()
                                    .child(
                                        Button::new("confirm")
                                            .label(if self.confirmed { "Saved" } else { "Save" })
                                            .primary()
                                            .on_click(cx.listener(|view, _, _, cx| {
                                                view.confirmed = !view.confirmed;
                                                cx.notify();
                                            })),
                                    )
                                    .child(Button::new("later").label("Later"))
                                    .child(Button::new("dismiss").label("Dismiss").ghost()),
                            )
                            .child(
                                div()
                                    .pt_2()
                                    .text_size(px(tokens::BODY_FONT_SIZE_PX))
                                    .text_color(cx.theme().muted_foreground)
                                    .child(status),
                            ),
                    )
                    .child(
                        self.panel(cx)
                            .w(px(300.))
                            .child(
                                div()
                                    .text_size(px(tokens::TITLE_FONT_SIZE_PX))
                                    .font_family(tokens::TITLE_FONT_FAMILY)
                                    .font_semibold()
                                    .child("Token bridge"),
                            )
                            .child(
                                v_flex()
                                    .gap_2()
                                    .text_size(px(tokens::BODY_FONT_SIZE_PX))
                                    .child(h_flex().justify_between().child("Panel radius").child("20 px"))
                                    .child(h_flex().justify_between().child("Control radius").child("8 px"))
                                    .child(h_flex().justify_between().child("Body size").child("13 px"))
                                    .child(h_flex().justify_between().child("Accent use").child("semantic only")),
                            ),
                    ),
            )
            .child(
                self.panel(cx)
                    .w(px(736.))
                    .child(
                        div()
                            .text_size(px(tokens::TITLE_FONT_SIZE_PX))
                            .font_family(tokens::TITLE_FONT_FAMILY)
                            .font_semibold()
                            .child("Translation contract"),
                    )
                    .child(
                        div()
                            .text_size(px(tokens::MONO_FONT_SIZE_PX))
                            .font_family(cx.theme().mono_font_family.clone())
                            .text_color(cx.theme().muted_foreground)
                            .child(tokens::WEB_REFERENCE_STACK),
                    ),
            )
    }
}

fn main() {
    Application::new().run(|cx: &mut App| {
        gpui_component::init(cx);

        let theme_set: ThemeSet =
            serde_json::from_str(include_str!("../../themes/rizum-glass.json"))
                .expect("generated Rizum Glass theme must be valid");
        let theme = Rc::new(
            theme_set
                .themes
                .into_iter()
                .find(|theme| !theme.mode.is_dark())
                .expect("generated theme must include a light variant"),
        );
        Theme::global_mut(cx).apply_config(&theme);

        let bounds = Bounds::centered(None, size(px(860.), px(610.)), cx);
        cx.open_window(
            WindowOptions {
                window_bounds: Some(WindowBounds::Windowed(bounds)),
                ..Default::default()
            },
            |window, cx| {
                let gallery = cx.new(|_| Gallery { confirmed: false });
                cx.new(|cx| Root::new(gallery, window, cx))
            },
        )
        .expect("GPUI gallery window should open");
        cx.activate(true);
    });
}

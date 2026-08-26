# GPUI Component Gallery

This small native application verifies that the generated Rizum Glass theme loads in the current `gpui-component` release and demonstrates the translation boundary for panels, typography, actions, compact controls, and pointillist accents.

It is an adapter smoke test, not a second design source. Change `DESIGN.md` and the approved web reference first, then regenerate and port.

```bash
cargo run
```

The gallery enables GPUI's `runtime_shaders` feature on macOS so contributors can compile it without separately downloading Xcode's Metal Toolchain component. Production applications may choose their own shader strategy.

# homebrew-litchi

Homebrew formulae of [Litchi](https://github.com/BugenZhao/Litchi) cross-compile toolchains.

- `i386-litchi-elf-gcc`: gcc, g++ with newlib libstdc++
- `litchi-qemu`: ported from JOS, patched to dump registers when fault occurs

Bottles for macOS Catalina are provided. For other platform like old macOS or Linux, toolchains are built from sources.

## Installation

```bash
$ brew tap bugenzhao/litchi
$ brew install i386-litchi-elf-binutils i386-litchi-elf-gcc i386-litchi-elf-gdb litchi-qemu
```

## Notes on Maintaining Bottles

- Create a Bintray repo named "bottles-litchi"
- Create several packages under it, named the same as the formulae, e.g. "i386-litchi-elf-gcc"
- Build bottles.
  ```bash
  brew test-bot --root-url="https://dl.bintray.com/bugenzhao/bottles-litchi" --bintray-org=bugenzhao --tap=bugenzhao/litchi i386-litchi-elf-gcc i386-litchi-elf-gdb i386-litchi-elf-binutils
  ```
- Upload to Bintray.
  ```bash
  HOMEBREW_BINTRAY_USER=bugenzhao HOMEBREW_BINTRAY_KEY=SECRET brew pr-upload --root-url="https://dl.bintray.com/bugenzhao/bottles-litchi" --bintray-org=bugenzhao --debug
  ```
- Push the formulae to GitHub
  ```bash
  cd /usr/local/Homebrew/Library/Taps/bugenzhao/homebrew-litchi/
  git push
  ```


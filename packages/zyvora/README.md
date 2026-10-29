# ZYVORA Termux package

This directory contains the Termux package build definition for `zyvora`.

The package installs a `zyvora` launcher and the reusable Zyvora Zsh theme. It is platform-independent and intended to be built with the Termux package build system.

## Package flow

```text
ZYVORA repository
      ↓
Termux package build
      ↓
zyvora_1.0.0-1_all.deb
      ↓
Custom APT repository
      ↓
pkg install zyvora
```

A custom APT repository is required before `pkg install zyvora` can work for end users. A GitHub repository alone does not automatically become a Termux package repository.

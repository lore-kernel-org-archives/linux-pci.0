Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA864;
	Mon, 16 Feb 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247760; cv=none; b=RNQGjdSk7tjRqAfQ4c/NpzSzTm+wPSafNNvJdqWW3VKKWQAyJ+j5xyl4j0ZCAzn8Qvkqppt3s88UZK2axHbWNhz/efdFJuCWOogPik0UTKNj7DA7Mn/nmekGwiJil/iDJyYm8pmZ1JH+Woemy0cPc42/zlR6rqzZ85cFfWE9yuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247760; c=relaxed/simple;
	bh=JCuQM6fPgEFTbVeEejnR+/gwTbsc1IffniZ7P5huIms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQLmDnl2CsSSchfh4aU9rnH4zYmD16CTzh6uxYGPHKQg2i6AxSDHj/DEOir2+SDK2bHlOGpiGmItegup+t2V9g3GvhtWuu6zHg3T74HuTaqJcr4wmEECQ8mgPCmisabv8SourT6omCU9SthR4iTy3ZfQ+dP818GHhDSC4pZpInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ6DLHRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ6DLHRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19D4C116C6;
	Mon, 16 Feb 2026 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771247759;
	bh=JCuQM6fPgEFTbVeEejnR+/gwTbsc1IffniZ7P5huIms=;
	h=From:To:Cc:Subject:Date:From;
	b=QQ6DLHRNv2AYK0kwa2QiKk9vwnV3OMAj3sdSOav3Enu7+A3y+lrR28PpZQ4JoSR5n
	 GXFUI3o4i0hUUPobdZI9fUauaq7iJS2aammrLNBsetyzCkvJk1KKYYTsM2IXvrakTt
	 6+daUYb7hMXPCxZBLdUCN7AgeTkgCp081Nq1TAGKw0xVjprtGdPqtLfkXkwXmUG1Wi
	 +ahvcS6OSLR3GTnIMZOI/IJd8uBkp2RRuBueMoa57Ct+ooUk3OhtDBZ8Z+0GvzOAVl
	 MpklDDW+nnY2uhuEtkIllR0INAhncYOGndK0yauinYRKuFsHZF4gb+kKx45jgm3IFi
	 rLHCod1si9l4w==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com,
	daniel.almeida@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	zhiw@nvidia.com,
	acourbot@nvidia.com
Cc: driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH] rust: io: macro_export io_define_read!() and io_define_write!()
Date: Mon, 16 Feb 2026 14:14:33 +0100
Message-ID: <20260216131534.65008-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the define_read!() and define_write!() I/O macros are crate
public. The only user outside of the I/O module is PCI (for the
configurations space I/O backend). Consequently, when CONFIG_PCI=n this
causes a compile time warning [1].

In order to fix this, rename the macros to io_define_read!() and
io_define_write!() and use #[macro_export] to export them.

This is better than making the crate public visibility conditional, as
eventually subsystems will have their own crate.

Also, I/O backends are valid to be implemented by drivers as well. For
instance, there are devices (such as GPUs) that run firmware which
allows to program other devices only accessible through the primary
device through indirect I/O.

Since the macros are now public, also add the corresponding
documentation.

Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO implementation")
Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Closes: https://lore.kernel.org/driver-core/CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com/ [1]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/io.rs     | 129 ++++++++++++++++++++++++++++--------------
 rust/kernel/pci/io.rs |  24 ++++----
 2 files changed, 99 insertions(+), 54 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c1cca7b438c3..58f464cf5efd 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -139,9 +139,9 @@ pub fn maxsize(&self) -> usize {
 
 /// Internal helper macros used to invoke C MMIO read functions.
 ///
-/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
-/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
+/// This macro is intended to be used by higher-level MMIO access macros (io_define_read) and
+/// provides a unified expansion for infallible vs. fallible read semantics. It emits a direct call
+/// into the corresponding C helper and performs the required cast to the Rust return type.
 ///
 /// # Parameters
 ///
@@ -166,9 +166,9 @@ macro_rules! call_mmio_read {
 
 /// Internal helper macros used to invoke C MMIO write functions.
 ///
-/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
-/// a unified expansion for infallible vs. fallible write semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
+/// This macro is intended to be used by higher-level MMIO access macros (io_define_write) and
+/// provides a unified expansion for infallible vs. fallible write semantics. It emits a direct call
+/// into the corresponding C helper and performs the required cast to the Rust return type.
 ///
 /// # Parameters
 ///
@@ -193,7 +193,30 @@ macro_rules! call_mmio_write {
     }};
 }
 
-macro_rules! define_read {
+/// Generates an accessor method for reading from an I/O backend.
+///
+/// This macro reduces boilerplate by automatically generating either compile-time bounds-checked
+/// (infallible) or runtime bounds-checked (fallible) read methods. It abstracts the address
+/// calculation and bounds checking, and delegates the actual I/O read operation to a specified
+/// helper macro, making it generic over different I/O backends.
+///
+/// # Parameters
+///
+/// * `infallible` / `fallible` - Determines the bounds-checking strategy. `infallible` relies on
+///   `IoKnownSize` for compile-time checks and returns the value directly. `fallible` performs
+///   runtime checks against `maxsize()` and returns a `Result<T>`.
+/// * `$(#[$attr:meta])*` - Optional attributes to apply to the generated method (e.g.,
+///   `#[cfg(CONFIG_64BIT)]` or inline directives).
+/// * `$vis:vis` - The visibility of the generated method (e.g., `pub`).
+/// * `$name:ident` / `$try_name:ident` - The name of the generated method (e.g., `read32`,
+///   `try_read8`).
+/// * `$call_macro:ident` - The backend-specific helper macro used to emit the actual I/O call
+///   (e.g., `call_mmio_read`).
+/// * `$c_fn:ident` - The backend-specific C function or identifier to be passed into the
+///   `$call_macro`.
+/// * `$type_name:ty` - The Rust type of the value being read (e.g., `u8`, `u32`).
+#[macro_export]
+macro_rules! io_define_read {
     (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
      $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
@@ -226,9 +249,32 @@ macro_rules! define_read {
         }
     };
 }
-pub(crate) use define_read;
 
-macro_rules! define_write {
+/// Generates an accessor method for writing to an I/O backend.
+///
+/// This macro reduces boilerplate by automatically generating either compile-time bounds-checked
+/// (infallible) or runtime bounds-checked (fallible) write methods. It abstracts the address
+/// calculation and bounds checking, and delegates the actual I/O write operation to a specified
+/// helper macro, making it generic over different I/O backends.
+///
+/// # Parameters
+///
+/// * `infallible` / `fallible` - Determines the bounds-checking strategy. `infallible` relies on
+///   `IoKnownSize` for compile-time checks and returns `()`. `fallible` performs runtime checks
+///   against `maxsize()` and returns a `Result`.
+/// * `$(#[$attr:meta])*` - Optional attributes to apply to the generated method (e.g.,
+///   `#[cfg(CONFIG_64BIT)]` or inline directives).
+/// * `$vis:vis` - The visibility of the generated method (e.g., `pub`).
+/// * `$name:ident` / `$try_name:ident` - The name of the generated method (e.g., `write32`,
+///   `try_write8`).
+/// * `$call_macro:ident` - The backend-specific helper macro used to emit the actual I/O call
+///   (e.g., `call_mmio_write`).
+/// * `$c_fn:ident` - The backend-specific C function or identifier to be passed into the
+///   `$call_macro`.
+/// * `$type_name:ty` - The Rust type of the value being written (e.g., `u8`, `u32`). Note the use
+///   of `<-` before the type to denote a write operation.
+#[macro_export]
+macro_rules! io_define_write {
     (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
      $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
@@ -259,7 +305,6 @@ macro_rules! define_write {
         }
     };
 }
-pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -509,40 +554,40 @@ fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
 
-    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
-    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
-    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
-    define_read!(
+    io_define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
+    io_define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
+    io_define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
+    io_define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_read64,
         call_mmio_read(readq) -> u64
     );
 
-    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
-    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
-    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
-    define_write!(
+    io_define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
+    io_define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
+    io_define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
+    io_define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_write64,
         call_mmio_write(writeq) <- u64
     );
 
-    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
-    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
-    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
-    define_read!(
+    io_define_read!(infallible, read8, call_mmio_read(readb) -> u8);
+    io_define_read!(infallible, read16, call_mmio_read(readw) -> u16);
+    io_define_read!(infallible, read32, call_mmio_read(readl) -> u32);
+    io_define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         read64,
         call_mmio_read(readq) -> u64
     );
 
-    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
-    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
-    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
-    define_write!(
+    io_define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
+    io_define_write!(infallible, write16, call_mmio_write(writew) <- u16);
+    io_define_write!(infallible, write32, call_mmio_write(writel) <- u32);
+    io_define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         write64,
@@ -566,40 +611,40 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
+    io_define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    io_define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    io_define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
+    io_define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
         call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
+    io_define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    io_define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    io_define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
+    io_define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
         call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
+    io_define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    io_define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    io_define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
+    io_define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
         call_mmio_write(writeq_relaxed) <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
+    io_define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    io_define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    io_define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
+    io_define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 6ca4cf75594c..2c8d7d00e54d 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,14 +8,14 @@
     device,
     devres::Devres,
     io::{
-        define_read,
-        define_write,
         Io,
         IoCapable,
         IoKnownSize,
         Mmio,
         MmioRaw, //
     },
+    io_define_read,
+    io_define_write,
     prelude::*,
     sync::aref::ARef, //
 };
@@ -88,7 +88,7 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 /// Internal helper macros used to invoke C PCI configuration space read functions.
 ///
 /// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// (io_define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
 /// emits a direct call into the corresponding C helper and performs the required cast to the Rust
 /// return type.
 ///
@@ -117,9 +117,9 @@ macro_rules! call_config_read {
 /// Internal helper macros used to invoke C PCI configuration space write functions.
 ///
 /// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
-/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
-/// return type.
+/// (io_define_write) and provides a unified expansion for infallible vs. fallible read semantics.
+/// It emits a direct call into the corresponding C helper and performs the required cast to the
+/// Rust return type.
 ///
 /// # Parameters
 ///
@@ -163,13 +163,13 @@ fn maxsize(&self) -> usize {
     // PCI configuration space does not support fallible operations.
     // The default implementations from the Io trait are not used.
 
-    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
-    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
-    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
+    io_define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
+    io_define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
+    io_define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
 
-    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
-    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
-    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+    io_define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
+    io_define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
+    io_define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
 }
 
 impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {

base-commit: 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac
-- 
2.53.0


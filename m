Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2753B7B84;
	Mon, 23 Mar 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280317; cv=none; b=VK4I4x2ed1IwymtueP5iH4VyR4SoiqJeFmCREpXpgWue5YZLn6Am0uYKAhZX4ii6if327CylAQyF255w6umYsL4Yy2KeocOwV8g7IdHQOh8E/EQUxkS+QnvW1QMQsTqktvrS1iQuQrTEemUAgcRf1EjaDu7t8FiUuNFHUtQ1BTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280317; c=relaxed/simple;
	bh=8mB/PkDwYkyaqWVzjpPU3pghjSGOAflHKAPu4/cl0dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2xGcT5FIrWyEeBYbwk5WILrE7DQlSV1VXMGgk77fa0IQwyjESBHJTtbo4o5svQA0bNVpecKk7D4u2M5U4qSG/ErQ+MYB07IKZye+sFnuk+07+t9GQRCEpq7GyJfUNlR3evam2LsEnJWrqVBQfhTCNwPi2YQiMtKfsuC+nZyIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxlSg2I0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxlSg2I0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E56C4CEF7;
	Mon, 23 Mar 2026 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280317;
	bh=8mB/PkDwYkyaqWVzjpPU3pghjSGOAflHKAPu4/cl0dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=AxlSg2I0b1vGHIYDLP02pbEpNJh4OnuF+guHMqtf1xdoenQ4OxgSF4xHZqg8wiEUK
	 AGnG+YXNkURf5hswTlXdzXQE7ln/9GkZYttl+iCYgZTHy2Vithi0aBrrm9DozEHDt0
	 jIpBU4aqhUvHYMkm0olfAQLhURjpBorQhEwvxk4Agz/Jkbb3KFdE7HGFnAmXvyUqhQ
	 iFQb7i4rTEzwlWCkgGSxZbp4hZNPWuEAc6U5t1stRmrO6CpgZM5Yn1eSDmq/3jm7S0
	 TdH2cG30pXHqRaEPQHzIWjqm5atDpTHykrt6+VDA+amJ9ufG47PyYYYCIntDNhGDhY
	 irBdu8Vminpdw==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
Date: Mon, 23 Mar 2026 15:37:54 +0000
Message-ID: <20260323153807.1360705-3-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260323153807.1360705-1-gary@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

Currently, `io::Mmio` always represent an untyped region of a compile-time
known minimum size, which is roughly equivalent to `void __iomem*` (but
with bound checks). However, it is useful to also be to represent I/O
memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.

Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or a
DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
change brings the MMIO closer to the DMA coherent allocation types that we
have, which is already typed.

To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
`KnownSize` trait to represent compile-time known minimum size of a
specific type.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs      |  2 +-
 rust/kernel/io.rs          | 63 ++++++++++++++++++++++----------------
 rust/kernel/io/mem.rs      |  4 +--
 rust/kernel/io/poll.rs     |  6 ++--
 rust/kernel/io/register.rs | 19 +++++++-----
 rust/kernel/pci/io.rs      |  2 +-
 rust/kernel/ptr.rs         |  7 +++++
 7 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 65a4082122af..3e22c63efb98 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -106,7 +106,7 @@ struct Inner<T> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = Mmio<Region<SIZE>>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d7f2145fa9b9..5a26b1e7e533 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize = 0> {
 }
 
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         (p as *const [u8]).len()
@@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = Mmio<Region<SIZE>>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
@@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
+pub struct Mmio<T: ?Sized>(MmioRaw<T>);
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -462,9 +464,10 @@ fn write64(&self, value: u64, offset: usize)
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &Mmio) -> Result {
+    /// fn do_reads(io: &Mmio<Region<0>>) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -496,9 +499,10 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &Mmio) -> Result {
+    /// fn do_writes(io: &Mmio<Region<0>>) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -534,6 +538,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     ///     register,
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -549,7 +554,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio) -> Result {
+    /// fn do_write_reg(io: &Mmio<Region<0>>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -579,9 +584,10 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) -> Result {
+    /// fn do_update(io: &Mmio<Region<0x1000>>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -616,9 +622,10 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &Mmio<0x1000>) {
+    /// fn do_reads(io: &Mmio<Region<0x1000>>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -648,9 +655,10 @@ fn read<T, L>(&self, location: L) -> T
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &Mmio<0x1000>) {
+    /// fn do_writes(io: &Mmio<Region<0x1000>>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -682,6 +690,7 @@ fn write<T, L>(&self, location: L, value: T)
     ///     register,
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -697,7 +706,7 @@ fn write<T, L>(&self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio<0x1000>) {
+    /// fn do_write_reg(io: &Mmio<Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -726,9 +735,10 @@ fn write_reg<T, L, V>(&self, value: V)
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) {
+    /// fn do_update(io: &Mmio<Region<0x1000>>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -778,7 +788,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
+        impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
@@ -805,7 +815,7 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<T: ?Sized + KnownSize> Io for Mmio<T> {
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -819,18 +829,18 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
+impl<T: ?Sized + KnownSize> IoKnownSize for Mmio<T> {
+    const MIN_SIZE: usize = T::MIN_SIZE;
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<T: ?Sized + KnownSize> Mmio<T> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
+    /// `addr.size()`.
+    pub unsafe fn from_raw(raw: &MmioRaw<T>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
@@ -843,9 +853,9 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
 ///
 /// See [`Mmio::relaxed`] for a usage example.
 #[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+pub struct RelaxedMmio<T: ?Sized>(Mmio<T>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<T: ?Sized + KnownSize> Io for RelaxedMmio<T> {
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -857,11 +867,11 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
+impl<T: ?Sized + KnownSize> IoKnownSize for RelaxedMmio<T> {
+    const MIN_SIZE: usize = T::MIN_SIZE;
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<T: ?Sized> Mmio<T> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -873,18 +883,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &Mmio<0x100>) {
+    /// fn do_io(io: &Mmio<Region<0x100>>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
-    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
-        // `RelaxedMmio<SIZE>` have identical layout.
+    pub fn relaxed(&self) -> &RelaxedMmio<T> {
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<T>` and
+        // `RelaxedMmio<T>` have identical layout.
         unsafe { core::mem::transmute(self) }
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 9117d417f99c..a6292f4ebfa4 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -214,7 +214,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<super::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -289,7 +289,7 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<super::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 75d1b3e8596c..2dce2b24b5ff 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -48,13 +48,14 @@
 /// use kernel::io::{
 ///     Io,
 ///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<Region<SIZE>>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -135,13 +136,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// use kernel::io::{
 ///     Io,
 ///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<Region<SIZE>>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index abc49926abfe..1a407fc35edc 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -55,6 +55,7 @@
 //!         register,
 //!         Io,
 //!         IoLoc,
+//!         Region,
 //!     },
 //!     num::Bounded,
 //! };
@@ -66,7 +67,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &Mmio<0x1000>) {
+//! # fn test(io: &Mmio<Region<0x1000>>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -441,6 +442,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     io::{
 ///         register,
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -452,7 +454,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) {
+/// # fn test(io: &Mmio<Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -554,6 +556,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -581,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: Mmio<0x1000>) {
+/// # fn test(io: Mmio<Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -598,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: Mmio<0x1000>) {
+/// # fn test2(io: Mmio<Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -633,6 +636,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         register,
 ///         register::Array,
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -648,7 +652,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>)
+/// # fn test(io: &Mmio<Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -719,6 +723,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -749,7 +754,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test(io: &Mmio<Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -791,7 +796,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: &Mmio<Region<0x1000>>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0335b5068f69..e048370fb8c1 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -238,7 +238,7 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<crate::io::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index bdc2d79ff669..72d51ba7b67e 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -236,11 +236,16 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = core::mem::size_of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -248,6 +253,8 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()
-- 
2.51.2


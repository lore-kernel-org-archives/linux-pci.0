Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52C3BA24F;
	Mon, 23 Mar 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280322; cv=none; b=MnwwJhxbstHo6PYNQCvhYcvuQ36Mg3Y7/q4HFWH4pUfj9NT/B4OKbTDBgUwfkQAir/JzRDtybPVoadj3MpaMk7L+Rv9AWjjGOwXmt2abUh87QDvu8yqFCkr7T3v5g3Dm6gCzFQ9EETQytT6efu0CTKkwiUBKtG4SHfQAnfwumao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280322; c=relaxed/simple;
	bh=XjZYGT3mwhQnfIQS5JPPg8DonuJKTzN2NsDCfhyYH4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIfKb3VI6+1pFFfOBOlSWtlH1kDahpbFthxdIjDNq02F+99jyGeWTUJXarGkzvqdHCRXeRpaGXiQdf5yEWAegW9BjbRgW4mF+Rf9PogBfFDcEZ3YKOzPL1awk+nqypE/yeV3kJ4XduCimgSTFxMZpgXj5QrxrhsF6CXS6br1wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/P3siaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/P3siaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D76C2BC9E;
	Mon, 23 Mar 2026 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280322;
	bh=XjZYGT3mwhQnfIQS5JPPg8DonuJKTzN2NsDCfhyYH4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=S/P3siaG7aCKIVSo1bqUArpBG+XHn3RI0kIhCciyjlhS0RvFvoDoMMPXvOutls7L+
	 nvUKj6it85ygupV+CrwmwP6YgGmmUYbNbdMOPsg4YVlReJL62SVGUBYcW7bNbPC/gA
	 qCm9G5Zs6ZhCt4rzOGgZhkYdlNqLfGanWW+wTQS/Oh/FThUimk4mDyAE+Zv5QFHzKF
	 jzAfd5D3UBcIYaYSIsft2YC6rs+GYT2BO1NqXiJ8Y+tKUufsjvpuMRZNagz6JZu5ok
	 geSotcQec0GKw3zGtM/yIfdKvyjYTbIfHp9RzFRQoW4vjMPXzHb51UKucSZhb2n93X
	 DO8EQ1aEfKJqg==
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
Subject: [PATCH 3/8] rust: io: use pointer types instead of address
Date: Mon, 23 Mar 2026 15:37:55 +0000
Message-ID: <20260323153807.1360705-4-gary@kernel.org>
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

This carries the size information with the pointer type and metadata, makes
it possible to use I/O projections and paves the way for IO view types.

With this change, minimum size information becomes available through types;
so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
necessary. The trait is kept for compatibility and can be removed when
users stop using it for bounds.

PCI config space uses only offsets and not pointers like MMIO; for this
null pointers (with proper size metadata) is used. This is okay as I/O
trait impl and I/O projections can operate on invalid pointers, and for PCI
config space we will only use address info and ignore the provenance.

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment, although this is guaranteed by checks in `Io`. Add it so
it can be relied on by implementor of `IoCapable`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   2 +-
 rust/kernel/io.rs     | 129 ++++++++++++++++++------------------------
 rust/kernel/io/mem.rs |   2 +-
 rust/kernel/pci/io.rs |  82 +++++++++++++++++----------
 4 files changed, 111 insertions(+), 104 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3e22c63efb98..ea86e9c62cdf 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -101,7 +101,7 @@ struct Inner<T> {
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5a26b1e7e533..72902a4a343d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -105,8 +105,8 @@ pub fn new_region(addr: usize, size: usize) -> Result<Self> {
 impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
-    pub fn addr(&self) -> usize {
-        self.addr.addr()
+    pub fn as_ptr(&self) -> *mut T {
+        self.addr
     }
 
     /// Returns the size of the MMIO region.
@@ -166,7 +166,7 @@ pub fn size(&self) -> usize {
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
 ///     }
 /// }
 ///
@@ -216,15 +216,17 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    unsafe fn io_read(&self, address: usize) -> T;
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
+    unsafe fn io_read(&self, address: *mut T) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    unsafe fn io_write(&self, value: T, address: usize);
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
+    unsafe fn io_write(&self, value: T, address: *mut T);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -291,23 +293,35 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
-    /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    /// Type of this I/O region. For untyped I/O regions, [`Region`] type can be used.
+    type Type: ?Sized + KnownSize;
+
+    /// Returns the base pointer of this mapping.
+    ///
+    /// This is a pointer to capture metadata. The specific meaning of the pointer depends on
+    /// I/O backend and is not necessarily valid.
+    fn as_ptr(&self) -> *mut Self::Type;
+
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> *mut U {
+        build_assert!(offset_valid::<U>(offset, Self::Type::MIN_SIZE));
 
-    /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+        self.as_ptr().wrapping_byte_add(offset).cast()
+    }
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+    fn io_addr<U>(&self, offset: usize) -> Result<*mut U> {
+        let ptr = self.as_ptr();
+        if !offset_valid::<U>(offset, Self::Type::size(ptr)) {
             return Err(EINVAL);
         }
 
-        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
-        // this can't overflow.
-        self.addr().checked_add(offset).ok_or(EINVAL)
+        Ok(ptr.wrapping_byte_add(offset).cast())
     }
 
     /// Fallible 8-bit read with runtime bounds check.
@@ -386,7 +400,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -395,7 +409,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -404,7 +418,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -413,7 +427,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -422,7 +436,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -431,7 +445,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -440,7 +454,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -449,7 +463,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -637,7 +651,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -670,7 +684,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -715,7 +729,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -748,7 +762,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -762,41 +776,25 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
+// For compatibility only.
+#[doc(hidden)]
+pub trait IoKnownSize: Io {}
 
-        self.addr() + offset
-    }
-}
+impl<T: Io + ?Sized> IoKnownSize for T {}
 
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
         impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+                unsafe { bindings::$write_fn(value, address.cast()) }
             }
         }
     };
@@ -816,23 +814,15 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<T: ?Sized + KnownSize> Io for Mmio<T> {
-    /// Returns the base address of this mapping.
-    #[inline]
-    fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    type Type = T;
 
-    /// Returns the maximum size of this mapping.
+    /// Returns the base address of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.0.size()
+    fn as_ptr(&self) -> *mut T {
+        self.0.as_ptr()
     }
 }
 
-impl<T: ?Sized + KnownSize> IoKnownSize for Mmio<T> {
-    const MIN_SIZE: usize = T::MIN_SIZE;
-}
-
 impl<T: ?Sized + KnownSize> Mmio<T> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -856,21 +846,14 @@ pub unsafe fn from_raw(raw: &MmioRaw<T>) -> &Self {
 pub struct RelaxedMmio<T: ?Sized>(Mmio<T>);
 
 impl<T: ?Sized + KnownSize> Io for RelaxedMmio<T> {
-    #[inline]
-    fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    type Type = T;
 
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.0.maxsize()
+    fn as_ptr(&self) -> *mut T {
+        self.0.as_ptr()
     }
 }
 
-impl<T: ?Sized + KnownSize> IoKnownSize for RelaxedMmio<T> {
-    const MIN_SIZE: usize = T::MIN_SIZE;
-}
-
 impl<T: ?Sized> Mmio<T> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index a6292f4ebfa4..f87a29f90e79 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -284,7 +284,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 impl<const SIZE: usize> Drop for IoMem<SIZE> {
     fn drop(&mut self) {
         // SAFETY: Safe as by the invariant of `Io`.
-        unsafe { bindings::iounmap(self.io.addr() as *mut c_void) }
+        unsafe { bindings::iounmap(self.io.as_ptr().cast()) }
     }
 }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e048370fb8c1..2c8f6388db70 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,11 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
         MmioRaw, //
     },
     prelude::*,
+    ptr::KnownSize,
     sync::aref::ARef, //
 };
 use core::{
@@ -60,14 +60,45 @@ pub const fn into_raw(self) -> usize {
 pub trait ConfigSpaceKind {
     /// The size of this configuration space in bytes.
     const SIZE: usize;
+
+    /// Region type for this kind of config space. This should be [`crate::io::Region<SIZE>`].
+    type Region: ?Sized + KnownSize;
+
+    /// Obtain pointer with actual size information.
+    fn null_ptr_from_size(size: ConfigSpaceSize) -> *mut Self::Region;
 }
 
 impl ConfigSpaceKind for Normal {
     const SIZE: usize = 256;
+
+    type Region = crate::io::Region<256>;
+
+    #[inline]
+    #[allow(
+        clippy::invalid_null_ptr_usage,
+        reason = "false positive, fixed in Clippy 1.83"
+    )]
+    fn null_ptr_from_size(size: ConfigSpaceSize) -> *mut Self::Region {
+        core::ptr::slice_from_raw_parts_mut(core::ptr::null_mut::<u8>(), size.into_raw())
+            as *mut Self::Region
+    }
 }
 
 impl ConfigSpaceKind for Extended {
     const SIZE: usize = 4096;
+
+    type Region = crate::io::Region<4096>;
+
+    #[inline]
+    #[allow(
+        clippy::invalid_null_ptr_usage,
+        reason = "false positive, fixed in Clippy 1.83"
+    )]
+    fn null_ptr_from_size(_: ConfigSpaceSize) -> *mut Self::Region {
+        // Small optimization. For a extended config space, we already know that the size
+        // is 4096.
+        core::ptr::slice_from_raw_parts_mut(core::ptr::null_mut::<u8>(), 4096) as *mut Self::Region
+    }
 }
 
 /// The PCI configuration space of a device.
@@ -87,28 +118,28 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
         impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = address.addr() as i32;
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
-
+                // SAFETY: By the type invariant `self.pdev` is a valid address.
+                let _ = unsafe { bindings::$read_fn(self.pdev.as_raw(), addr, &mut val) };
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = address.addr() as i32;
+
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+                // SAFETY: By the type invariant `self.pdev` is a valid address.
+                let _ = unsafe { bindings::$write_fn(self.pdev.as_raw(), addr, value) };
             }
         }
     };
@@ -120,23 +151,15 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
 impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
-    #[inline]
-    fn addr(&self) -> usize {
-        0
-    }
+    type Type = S::Region;
 
-    /// Returns the maximum size of the configuration space.
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.pdev.cfg_size().into_raw()
+    fn as_ptr(&self) -> *mut Self::Type {
+        S::null_ptr_from_size(self.pdev.cfg_size())
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
@@ -219,7 +242,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
 
     fn release(&self) {
         // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+        unsafe { Self::do_release(&self.pdev, self.io.as_ptr().addr(), self.num) };
     }
 }
 
@@ -267,6 +290,7 @@ pub fn iomap_region<'a>(
     }
 
     /// Returns the size of configuration space.
+    #[inline]
     pub fn cfg_size(&self) -> ConfigSpaceSize {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         let size = unsafe { (*self.as_raw()).cfg_size };
-- 
2.51.2


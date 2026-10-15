Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449555221F0;
	Thu, 15 Oct 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068000; cv=pass; b=iLowbJdwxIoJ710fvmzWE/m7XbuH7rgVYZtW/LYEw3T8BSOkY6xopH4It0zhF6m4Hmgk8opbRS+NVCyiRMW78+pC/X5bsR4qnwztW5fMmVE6OLwZo8uemRkY9EzqNdLjsofc8y7pxSxFb5BA88NoMOvnG9rO/pjyoOQtlh38moY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068000; c=relaxed/simple;
	bh=BQNPOvIEumpI3ZQKw6LY4qA4QfqlHK/9RJtkHQIHdFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaOR5FDRmxBqIK63SesTvJ+SEv25mCcYZGnMIW8GeNX3DtvN8tVk4qz6ombIQOe7CI3jB5IWGOCou8NAQRwlPuLVykXb5xh++8t1x7PykloyVhgCYrr9+DOe3BHFyDsGKlBLTdUFte+Uuta1a79jMhJySETo0DNxbMvCs6eJ3ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ArFmEJE9; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ArFmEJE9"
ARC-Seal: i=1; a=rsa-sha256; t=1792067968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HXlYleMGYoR4L6lEUytje1PlZGP7V2yEObe0tnu83z/06mV8iU8cOmn6rAzKG3SuLlTveQxnPu0RQYIiHXfD7D7ej1rGFXcKiwUrS64wm9RHcKkJKrRVEC9xpUFeCYjpL4vFkkX9VfBSujF1ugIrQZn6RW2q0FDaEwD0sTKgrrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067968; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3E1bdrq4gqFYtbBaaweOh7zV8x4SqRbEvntWxZX2Fbg=; 
	b=bNYvQmWb+FS8RpOmYw8AdoMdTzxK8+y4Pq2LmC7TAHc1FpmYm0++TE11oUql0lfyzyxgcs5pwxQv4OkaoXwNA79blJjFZlZNobPh7ExWnYIqJTtutN7acQtv6Sf6LOgoQytIqeMRxQBljBUE2K1oKQjeiZwTTkmdJUFGIfI82pU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067967;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=3E1bdrq4gqFYtbBaaweOh7zV8x4SqRbEvntWxZX2Fbg=;
	b=ArFmEJE9eFZD4SNTUMDpxsswzqIvZC77SC8WU4lXGVoXosYu8yuyTSEFjIPUEuMy
	W78d4MTPPngtio6K1vm5ThEBwGuBMm+AzRvCvLIJjIrz09eVaaLbedsus0utzL485rg
	O4noIZU5iCVq6e9qbNqzVxtKuXnmmI4bYS39HTo0=
Received: by smtp.zohomail.com with SMTPS id 1792067964754958.2798476402018;
	Thu, 15 Oct 2026 05:39:24 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:05 -0300
Subject: [PATCH 1/7] rust: io: split IoCapable into IoReadable and
 IoWritable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

`IoCapable<T>` provides both `io_read` and `io_write`, so a backend that
supports accesses of type `T` supports them in both directions, and every
(non-copy) `Io` method that reads or writes a value requires both. There
is no way to express a backend, or a view, that can only be read or only
be written.

Thus, replace `IoCapable<T>` with an `IoReadable<T>` trait holding
`io_read` and an `IoWritable<T>` trait holding `io_write`, and implement
both for all existing backends. The non-copy `Io` methods that read a
value now require `IoReadable` and those that write one require
`IoWritable`. `update` and `try_update` read and then write, so they
require both.

The copy methods use `IoCopyable` and are not changed here.

No functional change intended. This prepares for read-only and write-only
views, added in a following patch.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/dma.rs    |  12 ++++--
 rust/kernel/io.rs     | 101 +++++++++++++++++++++++++++++---------------------
 rust/kernel/pci/io.rs |  10 +++--
 3 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 4ce914b7d1da..7216a78d38c9 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -17,8 +17,9 @@
     io::{
         IoBackend,
         IoBase,
-        IoCapable,
         IoCopyable,
+        IoReadable,
+        IoWritable,
         SysMem,
         SysMemBackend, //
     },
@@ -1180,15 +1181,20 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<T> IoCapable<T> for CoherentIoBackend
+impl<T> IoReadable<T> for CoherentIoBackend
 where
-    SysMemBackend: IoCapable<T>,
+    SysMemBackend: IoReadable<T>,
 {
     #[inline]
     fn io_read<'a>(view: Self::View<'a, T>) -> T {
         SysMemBackend::io_read(view.cpu_addr)
     }
+}
 
+impl<T> IoWritable<T> for CoherentIoBackend
+where
+    SysMemBackend: IoWritable<T>,
+{
     #[inline]
     fn io_write<'a>(view: Self::View<'a, T>, value: T) {
         SysMemBackend::io_write(view.cpu_addr, value)
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index de8ef8e2aec4..fd5dd5f6bda4 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -247,9 +247,9 @@ fn io_view_as_repr<'a, IO: Io<'a, Target = T>, T: AsRepr>(
 /// backends (e.g. MMIO, PCI config space, etc.).
 ///
 /// The base trait only defines the projection operations; which I/O methods are available depends
-/// on which [`IoCapable<T>`] traits are implemented for the type. For example, for MMIO regions,
-/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically supported. For PCI
-/// configuration space, u8, u16, and u32 are supported but u64 is not.
+/// on which [`IoReadable<T>`] and [`IoWritable<T>`] traits are implemented for the type. For
+/// example, for MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
+/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 ///
 /// This trait is separate from the `Io` trait as multiple different I/O types may share the same
 /// operation.
@@ -276,18 +276,24 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     ) -> Self::View<'a, U>;
 }
 
-/// Trait indicating that an I/O backend supports operations of a certain type and providing an
-/// implementation for these operations.
+/// Trait indicating that an I/O backend supports reads of a certain type and providing an
+/// implementation for these reads.
 ///
 /// Different I/O backends can implement this trait to expose only the operations they support.
 ///
-/// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
-/// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
+/// For example, a PCI configuration space may implement `IoReadable<u8>`, `IoReadable<u16>`,
+/// and `IoReadable<u32>`, but not `IoReadable<u64>`, while an MMIO region on a 64-bit
 /// system might implement all four.
-pub trait IoCapable<T>: IoBackend {
+pub trait IoReadable<T>: IoBackend {
     /// Performs an I/O read of type `T` at `view` and returns the result.
     fn io_read<'a>(view: Self::View<'a, T>) -> T;
+}
 
+/// Trait indicating that an I/O backend supports writes of a certain type and providing an
+/// implementation for these writes.
+///
+/// Like [`IoReadable`], it is implemented for each type the backend supports.
+pub trait IoWritable<T>: IoBackend {
     /// Performs an I/O write of `value` at `view`.
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
@@ -548,7 +554,7 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
     fn read_val(self) -> Self::Target
     where
         Self::Target: AsReprMut,
-        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
+        Self::Backend: IoReadable<<Self::Target as AsRepr>::Repr>,
     {
         Self::Target::from_repr(Self::Backend::io_read(io_view_as_repr(self)))
     }
@@ -570,7 +576,7 @@ fn read_val(self) -> Self::Target
     fn write_val(self, value: Self::Target)
     where
         Self::Target: AsRepr,
-        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
+        Self::Backend: IoWritable<<Self::Target as AsRepr>::Repr>,
     {
         Self::Backend::io_write(io_view_as_repr(self), Self::Target::into_repr(value))
     }
@@ -695,7 +701,7 @@ fn copy_to_slice(self, data: &mut [u8])
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: IoReadable<u8>,
     {
         self.try_read(offset)
     }
@@ -705,7 +711,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: IoReadable<u16>,
     {
         self.try_read(offset)
     }
@@ -715,7 +721,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: IoReadable<u32>,
     {
         self.try_read(offset)
     }
@@ -725,7 +731,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: IoReadable<u64>,
     {
         self.try_read(offset)
     }
@@ -735,7 +741,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: IoWritable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -745,7 +751,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: IoWritable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -755,7 +761,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: IoWritable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -765,7 +771,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: IoWritable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -777,7 +783,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: IoReadable<u8>,
     {
         self.read(offset)
     }
@@ -789,7 +795,7 @@ fn read8(self, offset: usize) -> u8
     fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: IoReadable<u16>,
     {
         self.read(offset)
     }
@@ -801,7 +807,7 @@ fn read16(self, offset: usize) -> u16
     fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: IoReadable<u32>,
     {
         self.read(offset)
     }
@@ -813,7 +819,7 @@ fn read32(self, offset: usize) -> u32
     fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: IoReadable<u64>,
     {
         self.read(offset)
     }
@@ -825,7 +831,7 @@ fn read64(self, offset: usize) -> u64
     fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: IoWritable<u8>,
     {
         self.write(offset, value)
     }
@@ -837,7 +843,7 @@ fn write8(self, value: u8, offset: usize)
     fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: IoWritable<u16>,
     {
         self.write(offset, value)
     }
@@ -849,7 +855,7 @@ fn write16(self, value: u16, offset: usize)
     fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: IoWritable<u32>,
     {
         self.write(offset, value)
     }
@@ -861,7 +867,7 @@ fn write32(self, value: u32, offset: usize)
     fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: IoWritable<u64>,
     {
         self.write(offset, value)
     }
@@ -894,7 +900,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoReadable<<T as AsRepr>::Repr>,
     {
         Ok(io_read!(self, try: location))
     }
@@ -927,7 +933,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
     {
         io_write!(self, try: location, value);
         Ok(())
@@ -973,7 +979,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1007,7 +1013,7 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
         let view = io_project!(self, try: location);
@@ -1041,7 +1047,7 @@ fn read<T, L>(self, location: L) -> T
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoReadable<<T as AsRepr>::Repr>,
     {
         io_read!(self, build: location)
     }
@@ -1072,7 +1078,7 @@ fn write<T, L>(self, location: L, value: T)
     where
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
     {
         io_write!(self, build: location, value);
     }
@@ -1116,7 +1122,7 @@ fn write_reg<T, L, V>(self, value: V)
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1150,7 +1156,7 @@ fn update<T, L, F>(self, location: L, f: F)
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
+        Self::Backend: IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
         let view = io_project!(self, build: location);
@@ -1237,17 +1243,20 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-/// Implements [`IoCapable`] on `$backend` for `$ty` using `$read_fn` and `$write_fn`.
+/// Implements [`IoReadable`] and [`IoWritable`] on `$backend` for `$ty` using `$read_fn` and
+/// `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($backend: ident, $ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl IoCapable<$ty> for $backend {
+        impl IoReadable<$ty> for $backend {
             #[inline]
             fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) -> $ty {
                 // SAFETY: `$backend::as_ptr(view)` is a valid pointer for MMIO operations for both
                 // `MmioBackend` and `RelaxedMmioBackend`.
                 unsafe { bindings::$read_fn($backend::as_ptr(view).cast_const().cast()) }
             }
+        }
 
+        impl IoWritable<$ty> for $backend {
             #[inline]
             fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
                 // SAFETY: `$backend::as_ptr(view)` is a valid pointer for MMIO operations for both
@@ -1396,11 +1405,11 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_volatile` and
-/// `write_volatile`.
+/// Implements [`IoReadable`] and [`IoWritable`] on `SysMemBackend` for `$ty` using
+/// `read_volatile` and `write_volatile`.
 macro_rules! impl_sysmem_io_capable {
     ($ty:ty) => {
-        impl IoCapable<$ty> for SysMemBackend {
+        impl IoReadable<$ty> for SysMemBackend {
             #[inline]
             fn io_read(view: SysMem<'_, $ty>) -> $ty {
                 // SAFETY:
@@ -1411,7 +1420,9 @@ fn io_read(view: SysMem<'_, $ty>) -> $ty {
                 // - The macro is only used on primitives so all bit patterns are valid.
                 unsafe { view.ptr.read_volatile() }
             }
+        }
 
+        impl IoWritable<$ty> for SysMemBackend {
             #[inline]
             fn io_write(view: SysMem<'_, $ty>, value: $ty) {
                 // SAFETY:
@@ -1601,10 +1612,10 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<T> IoCapable<T> for IoSysMapBackend
+impl<T> IoReadable<T> for IoSysMapBackend
 where
-    MmioBackend: IoCapable<T>,
-    SysMemBackend: IoCapable<T>,
+    MmioBackend: IoReadable<T>,
+    SysMemBackend: IoReadable<T>,
 {
     #[inline]
     fn io_read(view: Self::View<'_, T>) -> T {
@@ -1613,7 +1624,13 @@ fn io_read(view: Self::View<'_, T>) -> T {
             IoSysMap::Sys(r) => SysMemBackend::io_read(r),
         }
     }
+}
 
+impl<T> IoWritable<T> for IoSysMapBackend
+where
+    MmioBackend: IoWritable<T>,
+    SysMemBackend: IoWritable<T>,
+{
     #[inline]
     fn io_write<'a>(view: Self::View<'a, T>, value: T) {
         match view {
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 953e16735c6e..426e914e15c2 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,7 +10,8 @@
     io::{
         IoBackend,
         IoBase,
-        IoCapable,
+        IoReadable,
+        IoWritable,
         Mmio,
         MmioBackend,
         MmioRaw,
@@ -111,10 +112,11 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-/// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
+/// Implements [`IoReadable`] and [`IoWritable`] on [`ConfigSpace`] for `$ty` using `$read_fn`
+/// and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl IoCapable<$ty> for ConfigSpaceBackend {
+        impl IoReadable<$ty> for ConfigSpaceBackend {
             fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
                 // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
                 // signed offset parameter. PCI configuration space size is at most 4096 bytes,
@@ -128,7 +130,9 @@ fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
                 let _ = unsafe { bindings::$read_fn(view.pdev.as_raw(), addr, &mut val) };
                 val
             }
+        }
 
+        impl IoWritable<$ty> for ConfigSpaceBackend {
             fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
                 // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
                 // signed offset parameter. PCI configuration space size is at most 4096 bytes,

-- 
2.56.0


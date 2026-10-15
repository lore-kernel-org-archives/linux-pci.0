Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1884522EEA;
	Thu, 15 Oct 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068005; cv=pass; b=bEhcbuWcOx+i7t/FRQZIQeryfQi1MqTvj4fW6/PCfBNMSMTA2aEXrryF4iM3UU0m1iODKiLTW68TwJbEF8mWc2XJ6f6QnsrCffbkhziAoRNqYMSFMUNisUBItNhW2nkJ/6koqH2NgKBN+h70gKvXv6RG26kmGLKdktTW6sBoDl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068005; c=relaxed/simple;
	bh=cq42WNx79AbF/slEtzUjmpZNXTnsmW/vDF8MfI5obus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+QHuTsEVuribMosU9QRaQng2YvcgemMB8gRL0TzmzzL6mRQGDnh1wt74iGGxiy2gNw54Ory9dXhmocKGy4ShoO48xpLh82lsoUBF+7sYw/mh2F26aslcrjkIgaY3UhcURTepd3NKw/9fS9y2F600RkbFtnVgpFI1/szKhLrUDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AMBLqnL/; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AMBLqnL/"
ARC-Seal: i=1; a=rsa-sha256; t=1792067971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WF5okEyZHdiWwA2qTru/kgBV4fphcNtggbXs6vD8jAjmpp8WLhrzgpgGd8oqDNuwIDNkCQwOhGNC0u084NvOPMrVhI//fb01ZFA5ZG5EPVFo7lT1zcXN9K6lna7D933Q0Rxo48c+ljAjKdzLuR1gMO8wDpT/CGexNJ38txoO1gE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067971; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4canWF0BmOD+pTDrdjB/WAdCS+NSwCbnQYOFbdxT5zM=; 
	b=QubaMshhQRAeXDDjyWHYCCuErYXVbQhyuz5aKEydiLIKyCE8/D6cAkXnswjVxFRXbU1GS93bMdbPiJXbZJl9G1QtjsgYeKmFH/lS/RH5XB1cOwG2+MA6pvKQ2goYicFrn/73LYcBQGcdrYcZamBCvvQNXzHNwzJIrz4+7jHJtYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067971;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=4canWF0BmOD+pTDrdjB/WAdCS+NSwCbnQYOFbdxT5zM=;
	b=AMBLqnL/oft4JYUic6R+zVhHKuFjLLAsQcLIVbuEiNG5LcNfU0rEM2frSWLOBJtX
	3zyfJ2o8SpmTCSUqj8eWuPD1AuMygZ7vsXDl2XnAyuTlqN5yQ/R/H5dnTDtGAfAfwY1
	eB9SN1WAgTdvaxXsQTFs6Pv6HuHNDJVIhYt9D7kk=
Received: by smtp.zohomail.com with SMTPS id 1792067969994426.1811832118665;
	Thu, 15 Oct 2026 05:39:29 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:06 -0300
Subject: [PATCH 2/7] rust: io: split IoCopyable into IoCopyReadable and
 IoCopyWritable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-2-93611b84b5e3@collabora.com>
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

`IoCopyable` provides both `copy_from_io` and `copy_to_io`, so a backend
that supports copies supports them in both directions, and all four copy
methods of `Io` require both.

Thus, as done for `IoCapable` in the previous patch, replace `IoCopyable`
with an `IoCopyReadable` trait holding `copy_from_io` and `copy_read`, and
an `IoCopyWritable` trait holding `copy_to_io` and `copy_write`, and
implement both for every backend that implemented `IoCopyable`.
`copy_read` and `copy_to_slice`, which read from I/O memory, now require
`IoCopyReadable`, and `copy_write` and `copy_from_slice`, which write to
it, require `IoCopyWritable`.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/dma.rs | 17 +++++++-----
 rust/kernel/io.rs  | 77 ++++++++++++++++++++++++++++++------------------------
 2 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 7216a78d38c9..c57026368ab8 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -17,7 +17,8 @@
     io::{
         IoBackend,
         IoBase,
-        IoCopyable,
+        IoCopyReadable,
+        IoCopyWritable,
         IoReadable,
         IoWritable,
         SysMem,
@@ -1201,7 +1202,7 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
-impl IoCopyable for CoherentIoBackend {
+impl IoCopyReadable for CoherentIoBackend {
     #[inline]
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
         // SAFETY: Per safety requirement.
@@ -1209,14 +1210,16 @@ unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
     }
 
     #[inline]
-    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
-        // SAFETY: Per safety requirement.
-        unsafe { SysMemBackend::copy_to_io(view.cpu_addr, buffer) }
+    fn copy_read<T: zerocopy::FromBytes>(view: Self::View<'_, T>) -> T {
+        SysMemBackend::copy_read(view.cpu_addr)
     }
+}
 
+impl IoCopyWritable for CoherentIoBackend {
     #[inline]
-    fn copy_read<T: zerocopy::FromBytes>(view: Self::View<'_, T>) -> T {
-        SysMemBackend::copy_read(view.cpu_addr)
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { SysMemBackend::copy_to_io(view.cpu_addr, buffer) }
     }
 
     #[inline]
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fd5dd5f6bda4..ae60099fd4c3 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -298,8 +298,8 @@ pub trait IoWritable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
-/// Trait indicating that an I/O backend supports memory copy operations.
-pub trait IoCopyable: IoBackend {
+/// Trait indicating that an I/O backend supports memory copy operations from I/O.
+pub trait IoCopyReadable: IoBackend {
     /// Copy contents of `view` to `buffer`.
     ///
     /// # Safety
@@ -308,14 +308,6 @@ pub trait IoCopyable: IoBackend {
     /// - `buffer` should not overlap with `view`.
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8);
 
-    /// Copy contents from `buffer` to `view`.
-    ///
-    /// # Safety
-    ///
-    /// - `buffer` is valid for volatile read for `view.size()` bytes.
-    /// - `buffer` should not overlap with `view`.
-    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8);
-
     /// Copy from `view` and return the value.
     #[inline]
     fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
@@ -337,6 +329,17 @@ fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
         // SAFETY: `T: FromBytes` guarantee that all bit patterns are valid.
         unsafe { buf.assume_init() }
     }
+}
+
+/// Trait indicating that an I/O backend supports memory copy operations to I/O.
+pub trait IoCopyWritable: IoBackend {
+    /// Copy contents from `buffer` to `view`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile read for `view.size()` bytes.
+    /// - `buffer` should not overlap with `view`.
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8);
 
     /// Copy `value` to `view`.
     ///
@@ -602,7 +605,7 @@ fn write_val(self, value: Self::Target)
     #[inline]
     fn copy_read(self) -> Self::Target
     where
-        Self::Backend: IoCopyable,
+        Self::Backend: IoCopyReadable,
         Self::Target: Sized + FromBytes,
     {
         Self::Backend::copy_read(self.as_view())
@@ -629,7 +632,7 @@ fn copy_read(self) -> Self::Target
     #[inline]
     fn copy_write(self, value: Self::Target)
     where
-        Self::Backend: IoCopyable,
+        Self::Backend: IoCopyWritable,
         Self::Target: Sized + IntoBytes,
     {
         Self::Backend::copy_write(self.as_view(), value);
@@ -654,7 +657,7 @@ fn copy_write(self, value: Self::Target)
     #[inline]
     fn copy_from_slice(self, data: &[u8])
     where
-        Self::Backend: IoCopyable,
+        Self::Backend: IoCopyWritable,
         Self: Io<'a, Target = [u8]>,
     {
         assert_eq!(self.len(), data.len());
@@ -685,7 +688,7 @@ fn copy_from_slice(self, data: &[u8])
     #[inline]
     fn copy_to_slice(self, data: &mut [u8])
     where
-        Self::Backend: IoCopyable,
+        Self::Backend: IoCopyReadable,
         Self: Io<'a, Target = [u8]>,
     {
         assert_eq!(self.len(), data.len());
@@ -1275,7 +1278,7 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl IoCopyable for MmioBackend {
+impl IoCopyReadable for MmioBackend {
     #[inline]
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
         // SAFETY:
@@ -1285,7 +1288,9 @@ unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
             bindings::memcpy_fromio(buffer.cast(), view.ptr.cast(), view.size());
         }
     }
+}
 
+impl IoCopyWritable for MmioBackend {
     #[inline]
     unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
         // SAFETY:
@@ -1442,7 +1447,7 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_sysmem_io_capable!(u64);
 
-impl IoCopyable for SysMemBackend {
+impl IoCopyReadable for SysMemBackend {
     #[inline]
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
         // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
@@ -1452,15 +1457,6 @@ unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
         unsafe { bindings::memcpy(buffer.cast(), view.ptr.cast(), view.ptr.len()) };
     }
 
-    #[inline]
-    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
-        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
-        // SAFETY:
-        // - `view.ptr` is in CPU address space and valid for write.
-        // - `buffer` is valid for read for `view.size()` bytes which is equal to `view.ptr.len()`.
-        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.ptr.len()) };
-    }
-
     #[inline]
     fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
         // SAFETY:
@@ -1471,6 +1467,17 @@ fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
         // - `T: FromBytes` so all bit patterns are valid.
         unsafe { view.ptr.read_volatile() }
     }
+}
+
+impl IoCopyWritable for SysMemBackend {
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
+        // SAFETY:
+        // - `view.ptr` is in CPU address space and valid for write.
+        // - `buffer` is valid for read for `view.size()` bytes which is equal to `view.ptr.len()`.
+        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.ptr.len()) };
+    }
 
     #[inline]
     fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
@@ -1640,7 +1647,7 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
-impl IoCopyable for IoSysMapBackend {
+impl IoCopyReadable for IoSysMapBackend {
     #[inline]
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
         match view {
@@ -1652,20 +1659,22 @@ unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
     }
 
     #[inline]
-    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
         match view {
-            // SAFETY: Per safety requirement.
-            IoSysMap::Io(l) => unsafe { MmioBackend::copy_to_io(l, buffer) },
-            // SAFETY: Per safety requirement.
-            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_to_io(r, buffer) },
+            IoSysMap::Io(l) => MmioBackend::copy_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::copy_read(r),
         }
     }
+}
 
+impl IoCopyWritable for IoSysMapBackend {
     #[inline]
-    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
         match view {
-            IoSysMap::Io(l) => MmioBackend::copy_read(l),
-            IoSysMap::Sys(r) => SysMemBackend::copy_read(r),
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_to_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_to_io(r, buffer) },
         }
     }
 

-- 
2.56.0


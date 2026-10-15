Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B251DDF3;
	Thu, 15 Oct 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068026; cv=pass; b=Gh3MKeLOo7yNenefUmqgH6yijGYm2IBKnDA2ztth8cEbuyiDx/j+cNuEeFowQyTKwx5rA3NuklG/6BcU87aOfK5NlI0Im/xGgMhqjyJz2Qm/9o9uc+2uLRkBNiUsbahucr7XIayDpUs4mGFhzOOXrQYPvMn1vKBIeV43LAP7/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068026; c=relaxed/simple;
	bh=UhOW24s2yUc8kCp4Km06imoSYBRncV1dnDwDdFdwwUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxigYJtbpg7x+SSPrrySxLjqz9U4CEnHo18JGAshGU44q6Antyx5AaAr+1OKk+MIMB7fzU3YvG/CMKIDYEgD3r0Y1uCzfAouLjladh7aLT2MXTDHjJ0TaYSaSRIcY9lSM6hqFoyoxYi1jAdc9jhf+tim1OcGdf2THo7Zk2WN5XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OU6U70VQ; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OU6U70VQ"
ARC-Seal: i=1; a=rsa-sha256; t=1792067988; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FZ3HWdsydTpzqso0xg3TZ3uHmmznThlVa1zh5NoGHc0tcmIeNDlBgvokcny4BvdD8A3k2KNVDAOB+PQZEUhNwtUnRnxXubZ/eYhab9BJEKEoQtMzmripCh+LKqjIj9+wtawYUtzUSs3mGzsnENie7qQ9kNp2YB2Nxv4dpC16K3c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067988; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SbvGLtSNiT/nCJriHxBz6XcPbdrSHUtNrM6kaTGv7tM=; 
	b=ll5EctNRWAGch20FX4/tXDGUOz9fHnujwJRNPgavoLZ4bst6DULkO4jVpywjbcy8cM8MVBgFn1FUjuiGzrm+2q4epX7TYGR38+tkyU5ums66s4MTeFd6yS8wy8mLkFW22xgKeVEz0hhgyYnCHG5mm6ia2VbDa1v7k0PK7esCGRM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067988;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=SbvGLtSNiT/nCJriHxBz6XcPbdrSHUtNrM6kaTGv7tM=;
	b=OU6U70VQDn7KWtzdeALGltwGSVR/5TDudX/mhupbKtbl3l2nAZ2eI3b3UXt/wXFQ
	6OPC7RF2L7bIhyaD7LfTuFM/1ZYQ/qSmxT7hX/dy0a6EuuvpWNoj3MD5RlsAaPD05H6
	iEcN66eDgP69Mw1YY7tgzRrc9UbfsmBTWtjdnDEo=
Received: by smtp.zohomail.com with SMTPS id 1792067985538849.0373958060442;
	Thu, 15 Oct 2026 05:39:45 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:09 -0300
Subject: [PATCH 5/7] rust: io: let I/O locations carry an access mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
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

`Io::read`, `Io::write`, `Io::update` and their fallible variants
project the view to the given `IoLoc` and access it there. A location
has no say in which accesses are allowed, so a register cannot be
declared read-only or write-only.

Add the `io::access` module with the `Mode` trait and the `ReadWrite`,
`ReadOnly` and `WriteOnly` modes, and add an `Access` associated type to
`IoLoc`. Projecting through a location applies its mode: `ReadWrite`
leaves the view as it is, while `ReadOnly` and `WriteOnly` wrap it in the
`ReadOnly` and `WriteOnly` views. The bounds of the generic accessors now
apply to the backend of the restricted view, so a write to a read-only
location, or a read from a write-only one, does not compile.

Raw offsets are `ReadWrite`. `OffsetLoc` takes the mode as a type
parameter that defaults to `ReadWrite`, and `RegisterArray` gets an
`Access` type, which `register!` sets to `ReadWrite` for now.

No existing location changes its mode, so there is no functional change.
A following patch lets `register!` declare read-only and write-only
registers.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/io.rs          | 42 +++++++++++++++++--------
 rust/kernel/io/access.rs   | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/io/register.rs | 18 +++++++++--
 rust/macros/io/register.rs |  1 +
 4 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 4be8c761c556..71bcd0d77ce9 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -22,6 +22,7 @@
     }, //
 };
 
+pub mod access;
 #[cfg(CONFIG_HAS_IOMEM)]
 pub mod mem;
 pub mod poll;
@@ -377,12 +378,16 @@ fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
 ///
 /// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
-/// - The type `T` in which the data is returned or provided.
+/// - The type `T` in which the data is returned or provided,
+/// - The access mode ([`IoLoc::Access`]) applied to the views projected through it.
 ///
 /// `T` is not necessarily the type for underlying I/O operation. Methods that take `IoLoc` have `T:
 /// AsRepr` bound and the `<T as AsRepr>::Repr` type would be used to perform I/O and converted to
 /// `T` instead.
 pub trait IoLoc<Base: ?Sized, T> {
+    /// Access mode applied to the views projected through this location.
+    type Access: access::Mode;
+
     /// Consumes `self` and returns the offset of this location.
     fn offset(self) -> usize;
 }
@@ -393,6 +398,8 @@ macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
             impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
+                type Access = access::ReadWrite;
+
                 #[inline(always)]
                 fn offset(self) -> usize {
                     self
@@ -961,7 +968,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoReadable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoReadable<<T as AsRepr>::Repr>,
     {
         Ok(io_read!(self, try: location))
     }
@@ -994,7 +1001,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoWritable<<T as AsRepr>::Repr>,
     {
         io_write!(self, try: location, value);
         Ok(())
@@ -1040,7 +1047,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoWritable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1074,7 +1081,8 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>:
+            IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
         let view = io_project!(self, try: location);
@@ -1108,7 +1116,7 @@ fn read<T, L>(self, location: L) -> T
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoReadable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoReadable<<T as AsRepr>::Repr>,
     {
         io_read!(self, build: location)
     }
@@ -1139,7 +1147,7 @@ fn write<T, L>(self, location: L, value: T)
     where
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoWritable<<T as AsRepr>::Repr>,
     {
         io_write!(self, build: location, value);
     }
@@ -1183,7 +1191,7 @@ fn write_reg<T, L, V>(self, value: V)
         T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>: IoWritable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1217,7 +1225,8 @@ fn update<T, L, F>(self, location: L, f: F)
     where
         T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
+        <L::Access as access::Mode>::Backend<Self::Backend>:
+            IoReadable<<T as AsRepr>::Repr> + IoWritable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
         let view = io_project!(self, build: location);
@@ -1909,19 +1918,26 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
     pub fn try_project_loc<U, L>(
         self,
         location: L,
-    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
+    ) -> Result<access::RestrictedView<'a, L::Access, T::Backend, U>>
     where
         L: IoLoc<T::Target, U>,
     {
-        io_view::<_, U>(self.0, location.offset())
+        let view = io_view::<_, U>(self.0, location.offset())?;
+
+        Ok(<L::Access as access::Mode>::restrict::<T::Backend, U>(view))
     }
 
     #[inline(always)]
-    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'a, U>
+    pub fn project_loc<U, L>(
+        self,
+        location: L,
+    ) -> access::RestrictedView<'a, L::Access, T::Backend, U>
     where
         L: IoLoc<T::Target, U>,
     {
-        io_view_assert::<_, U>(self.0, location.offset())
+        let view = io_view_assert::<_, U>(self.0, location.offset());
+
+        <L::Access as access::Mode>::restrict::<T::Backend, U>(view)
     }
 }
 
diff --git a/rust/kernel/io/access.rs b/rust/kernel/io/access.rs
new file mode 100644
index 000000000000..caec21dd943b
--- /dev/null
+++ b/rust/kernel/io/access.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Access modes of I/O locations.
+//!
+//! An I/O location ([`IoLoc`](super::IoLoc)) has an access mode, which applies to the views
+//! projected through it: a [`ReadWrite`] location gives the view as it is, a [`ReadOnly`] location
+//! gives a [`ReadOnly`](super::ReadOnly) view, and a [`WriteOnly`] location gives a
+//! [`WriteOnly`](super::WriteOnly) view.
+
+use crate::ptr::KnownSize;
+
+use super::{
+    IoBackend,
+    ReadOnlyBackend,
+    WriteOnlyBackend, //
+};
+
+/// An access mode of an I/O location.
+pub trait Mode {
+    /// Backend of the views this mode gives for views of backend `B`.
+    type Backend<B: IoBackend>: IoBackend;
+
+    /// Applies this mode to `view`.
+    fn restrict<'a, B: IoBackend, T: ?Sized + KnownSize>(
+        view: B::View<'a, T>,
+    ) -> <Self::Backend<B> as IoBackend>::View<'a, T>;
+}
+
+/// View of `T` that access mode `M` gives for views of backend `B`.
+pub type RestrictedView<'a, M, B, T> = <<M as Mode>::Backend<B> as IoBackend>::View<'a, T>;
+
+/// Read-write access mode.
+///
+/// Views are given as they are.
+pub struct ReadWrite;
+
+impl Mode for ReadWrite {
+    type Backend<B: IoBackend> = B;
+
+    #[inline(always)]
+    fn restrict<'a, B: IoBackend, T: ?Sized + KnownSize>(view: B::View<'a, T>) -> B::View<'a, T> {
+        view
+    }
+}
+
+/// Read-only access mode.
+///
+/// Views are wrapped in [`ReadOnly`](super::ReadOnly).
+pub struct ReadOnly;
+
+impl Mode for ReadOnly {
+    type Backend<B: IoBackend> = ReadOnlyBackend<B>;
+
+    #[inline(always)]
+    fn restrict<'a, B: IoBackend, T: ?Sized + KnownSize>(
+        view: B::View<'a, T>,
+    ) -> super::ReadOnly<B::View<'a, T>> {
+        super::ReadOnly(view)
+    }
+}
+
+/// Write-only access mode.
+///
+/// Views are wrapped in [`WriteOnly`](super::WriteOnly).
+pub struct WriteOnly;
+
+impl Mode for WriteOnly {
+    type Backend<B: IoBackend> = WriteOnlyBackend<B>;
+
+    #[inline(always)]
+    fn restrict<'a, B: IoBackend, T: ?Sized + KnownSize>(
+        view: B::View<'a, T>,
+    ) -> super::WriteOnly<B::View<'a, T>> {
+        super::WriteOnly(view)
+    }
+}
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index b6513fa0f412..9218dc66017b 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -118,7 +118,10 @@
 
 use crate::{
     build_assert::build_assert,
-    io::IoLoc, //
+    io::{
+        access,
+        IoLoc, //
+    },
 };
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
@@ -127,6 +130,8 @@ impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
     T: FixedIoLoc<Base>,
 {
+    type Access = <T::Location as IoLoc<Base, T>>::Access;
+
     #[inline(always)]
     fn offset(self) -> usize {
         T::LOCATION.offset()
@@ -135,7 +140,7 @@ fn offset(self) -> usize {
 
 // Provides a `IoLoc` impl that for a fixed offset.
 #[doc(hidden)]
-pub struct OffsetLoc<Base: ?Sized, T>(usize, PhantomData<(T, Base)>);
+pub struct OffsetLoc<Base: ?Sized, T, A = access::ReadWrite>(usize, PhantomData<(T, A, Base)>);
 
 impl<Base: ?Sized, T> OffsetLoc<Base, T> {
     #[inline]
@@ -149,7 +154,9 @@ pub const fn const_offset(self) -> usize {
     }
 }
 
-impl<Base: ?Sized, T> IoLoc<Base, T> for OffsetLoc<Base, T> {
+impl<Base: ?Sized, T, A: access::Mode> IoLoc<Base, T> for OffsetLoc<Base, T, A> {
+    type Access = A;
+
     #[inline(always)]
     fn offset(self) -> usize {
         self.0
@@ -161,6 +168,9 @@ pub trait RegisterArray: Sized {
     /// Base type for this register.
     type Base: ?Sized;
 
+    /// Access mode of the registers in this array.
+    type Access: access::Mode;
+
     /// Start offset of the register.
     ///
     /// The interpretation of this offset depends on the type of the register.
@@ -198,6 +208,8 @@ impl<Base: ?Sized, T> IoLoc<Base, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray<Base = Base>,
 {
+    type Access = T::Access;
+
     #[inline(always)]
     fn offset(self) -> usize {
         T::OFFSET + self.0 * T::STRIDE
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 420c3ad052b8..2d92c7f41447 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -283,6 +283,7 @@ impl ::kernel::io::register::Array for #name {}
 
                     impl ::kernel::io::register::RegisterArray for #name {
                         type Base = #base;
+                        type Access = ::kernel::io::access::ReadWrite;
                         const OFFSET: usize = #offset;
                         const SIZE: usize = #size;
                         const STRIDE: usize = #stride;

-- 
2.56.0


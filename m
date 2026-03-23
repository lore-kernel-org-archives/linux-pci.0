Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2523B62C;
	Mon, 23 Mar 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280312; cv=none; b=VbCiUNnV7+xUarR4d1ArnZ2mTfuoAmnjBx0QdGIBfWkq5pyetPbBiQzWPVb0M6PeXLshhHQcmKLG8Sj5xihOqbPyfjYPG1cnGW4Mp4c8+1787fqrtDNtvSUzUZY3kULG60Nm5oWMKxZCNiMUhODs9+S+gMym3TP8Ge4y8rfZozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280312; c=relaxed/simple;
	bh=BOeZuOkHwvtyFUw0CJw2gCjht9rffOScyV77YvWQ4oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csOy9P4w5RF+RvfIIkeyy7IE7FNeFPJuVb4BaJhtUOlCQIG9W9QCee2xFvQz+N7cIKRIpsZAWAgOdXJnfs3Syo9yNnp4lXOfxHAWE0LiFqF1MLhqFEsXRlOC2tSaPUNcTgDkc+9y9I7S6q76GsphohMrDFdipa6wqrDQ9mLPS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRoVpSZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRoVpSZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36003C2BC9E;
	Mon, 23 Mar 2026 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280312;
	bh=BOeZuOkHwvtyFUw0CJw2gCjht9rffOScyV77YvWQ4oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=LRoVpSZS12sLEuffa4ygbK+Pnj2hIE2qXqKM2aLLbv+W3dFJlBYQILukcMJfk4fRI
	 qSuozygmO2Kt6C6s7joIa7EIP5/Q0H51X0Usx9H3jUGibiqHNqlNqPBDCoRIWmtwn6
	 8sIVmslKMsC5BHqp/R6M6ccQnzmvpWnIhVCm986jnqqTsDwK+HY4pr3gZUxK5A3QRG
	 G0ukLXC7EjhtJNc4yIcWhiuvB3djDDTKGALTK3MtMlp5ftg1uQRq8/w6mLpVxZlta1
	 13Kaq5YV6xz5rEv0WfZIbhjfgI7lwhn84T61Qdth8/lowdAG3QhN0O6T0yUpZ3T2ak
	 YIRDIgYAHOimA==
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
Subject: [PATCH 1/8] rust: io: generalize `MmioRaw` to pointer to arbitrary type
Date: Mon, 23 Mar 2026 15:37:53 +0000
Message-ID: <20260323153807.1360705-2-gary@kernel.org>
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

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. The existing use case where it represents a region of compile-time
known minimum size and run-time known actual size is moved to a custom
dynamic-sized type `Region<SIZE>` instead. The `maxsize` method is also
renamed to `size` to reflect that it is the actual size (not a bound) of
the region.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 ++--
 rust/kernel/io.rs     | 84 +++++++++++++++++++++++++++++++++----------
 rust/kernel/io/mem.rs |  4 +--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..65a4082122af 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -71,14 +71,15 @@ struct Inner<T> {
 ///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -93,7 +94,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..d7f2145fa9b9 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,8 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 
 pub mod mem;
@@ -31,39 +32,85 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// The `SIZE` generic parameter indicate the minimum size of the region.
+#[repr(transparent)]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    addr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            addr: core::ptr::without_provenance_mut(addr),
+        }
+    }
+}
+
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        if size < SIZE {
             return Err(EINVAL);
         }
 
-        Ok(Self { addr, maxsize })
+        let addr = core::ptr::slice_from_raw_parts_mut::<u8>(
+            core::ptr::without_provenance_mut(addr),
+            size,
+        ) as *mut Region<SIZE>;
+        Ok(Self { addr })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.addr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.addr)
     }
 }
 
@@ -89,12 +136,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -109,7 +157,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -139,7 +187,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -767,7 +815,7 @@ fn addr(&self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(&self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -782,7 +830,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..9117d417f99c 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -231,7 +231,7 @@ fn deref(&self) -> &Self::Target {
 /// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
 pub struct IoMem<const SIZE: usize = 0> {
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<const SIZE: usize> IoMem<SIZE> {
@@ -266,7 +266,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new_region(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..0335b5068f69 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -148,7 +148,7 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -184,7 +184,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
-- 
2.51.2


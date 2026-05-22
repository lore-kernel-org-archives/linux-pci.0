Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5E347BC6;
	Fri, 22 May 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470359; cv=none; b=BozEFvMqsHYVuuWLSWrYaeCEFi4vtQEcd5Z+L4jwxRTFDjpbY5wqc/wa8E8KZtp8TQMZ4yZgzVnSmRhuXrMQjrdeLOoD1Y2jIGtBKN1zLJrhej3/evusVnE88gxb/kNtEoBPOO1a8aIEsXbgZnyvPa+d91NZJWhsGmU582v+q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470359; c=relaxed/simple;
	bh=MhkkUhprzZatSAr710zyAOf01NkFUJqP819XHk9vcBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zx6ziI1xW4u8EqCbdv+YOjQvPt52wxOROAJua8c2Z0svhjQD+eGbcVMhfIT8w3NsQeLKsH6mYf/YWgtCYBUJwT7dmEDck5Lahbpl8/wBXpvBYjhZbTT7PqXkuXBcCxEZpA+DW3lZnqhWRWnwc4ZucmK3nxZQDrUEU2rtMcGERuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0c51H0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0c51H0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164561F000E9;
	Fri, 22 May 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470357;
	bh=aQGTSxAfsqnSuAq7mFUGt6QOb1HC+teLuXiWb8rx+VY=;
	h=From:Date:Subject:To:Cc;
	b=d0c51H0Y1PHu86953MYZrETiUYMXuQvavQxO2rjnGdVFbR3FzBNoxcNfppEx6MuSy
	 TVMdZdCLBmqIiO1rjyagnXZ8OxVPxAUf4laSERBm+H7TT11TSnNHjWuExcbQz9Au4J
	 vt9TjoWML0xdRt/HHJ/EeCDxY/LVZCIKzxszZyQ7ZeAoiB5leAcJ7QwJHJH2JrCAUd
	 UnbWVKw/JVu1EihzatMFMdH0zeRhw4seXx9MHHZhLfGg8GnFRkZR6GyMwmw+tSGaWI
	 L+SgfpGWugCnFAfejXWm+wvPza+oopl30lVRMv+SqdDg5TggwBeUVVyyWCoMAJCwsN
	 pCJ1dQzoOuGBQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 22 May 2026 19:19:09 +0200
Subject: [PATCH] rust: kernel: use strict provenance APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-strict-provenance-redux-v1-1-0880b65fc17c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm3CjEGJVzEuaqdqXQykHQgJ4
 e4MunyL/1dwMRWHW7OCyayuQ64Ipwb4Q/ktqKkaYhsvbRcDejHlgqMNs2TKLGiSpgVT14drz0S
 JzlDr0eSly+98f/zt0/MrXI4dbNsOG+V8gXsAAAA=
X-Change-ID: 20260521-strict-provenance-redux-d58178caada3
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10633; i=tamird@kernel.org;
 h=from:subject:message-id; bh=MhkkUhprzZatSAr710zyAOf01NkFUJqP819XHk9vcBU=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkCEwRmrGFe4yAu+6/7kS33KcHQaqdPv/UcF0ZeyfLc+
 SHQP/5Ix0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKkWMmf4n7P/qLqJ9cxTetOOexwutX1bk7z6XnnumrdLVF1mt4RkSjH84V3J0rA
 +5u232C+HXPT/JSZdnRv0k8tmypxvHfft9GUyeAE=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Replace existing pointer-to-integer and integer-to-pointer conversions
with calls to the strict provenance APIs.

The strict provenance APIs were stabilized in Rust 1.84.0 [1]. Since
commit f32fb9c58a5b ("rust: bump Rust minimum supported version to
1.85.0 (Debian Trixie)"), the minimum supported Rust version is 1.85.0,
so no polyfills are needed.

Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-provenance-apis [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 rust/kernel/alloc.rs           |  2 +-
 rust/kernel/alloc/allocator.rs |  2 +-
 rust/kernel/devres.rs          |  4 ++--
 rust/kernel/error.rs           |  2 +-
 rust/kernel/io.rs              | 10 ++++++----
 rust/kernel/io/mem.rs          |  4 ++--
 rust/kernel/of.rs              |  2 +-
 rust/kernel/pci/io.rs          |  4 ++--
 rust/kernel/str.rs             | 16 ++++++----------
 rust/kernel/uaccess.rs         |  2 +-
 10 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index e38720349dcf..332e7fff15c4 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -262,7 +262,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
 
 /// Returns a properly aligned dangling pointer from the given `layout`.
 pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
-    let ptr = layout.align() as *mut u8;
+    let ptr = core::ptr::without_provenance_mut(layout.align());
 
     // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
     unsafe { NonNull::new_unchecked(ptr) }
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 63bfb91b3671..9a56d2407d8f 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -280,7 +280,7 @@ fn new() -> Result<Self> {
             fn is_aligned_to(&self, align: usize) -> bool {
                 assert!(align.is_power_of_two());
 
-                let addr = self.0.as_ptr() as usize;
+                let addr = self.0.as_ptr().addr();
                 addr & (align - 1) == 0
             }
         }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..ecba524e41df 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -93,14 +93,14 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr.expose_provenance(), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(core::ptr::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05cf869ac090..37eb14c71fb0 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -483,7 +483,7 @@ pub fn to_result(err: crate::ffi::c_int) -> Result {
 /// #         core::ptr::null_mut()
 /// #     }
 /// #     pub(super) unsafe fn non_null_ptr() -> *mut kernel::ffi::c_void {
-/// #         0x1234 as *mut kernel::ffi::c_void
+/// #         core::ptr::without_provenance_mut(0x1234)
 /// #     }
 /// # }
 /// // SAFETY: ...
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..a416221fb4a5 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -109,14 +109,14 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr.expose_provenance(), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(core::ptr::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
@@ -733,12 +733,14 @@ macro_rules! impl_mmio_io_capable {
         impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$read_fn(address as *const c_void) }
+                unsafe { bindings::$read_fn(core::ptr::with_exposed_provenance(address)) }
             }
 
             unsafe fn io_write(&self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+                unsafe {
+                    bindings::$write_fn(value, core::ptr::with_exposed_provenance_mut(address))
+                }
             }
         }
     };
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..e7e909c6bb2d 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -266,7 +266,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr.expose_provenance(), size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -284,7 +284,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 impl<const SIZE: usize> Drop for IoMem<SIZE> {
     fn drop(&mut self) {
         // SAFETY: Safe as by the invariant of `Io`.
-        unsafe { bindings::iounmap(self.io.addr() as *mut c_void) }
+        unsafe { bindings::iounmap(core::ptr::with_exposed_provenance_mut(self.io.addr())) }
     }
 }
 
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 58b20c367f99..95ef14b9a615 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -27,7 +27,7 @@ unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        self.0.data as usize
+        self.0.data.addr()
     }
 }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..b5e3a68a7a11 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -175,7 +175,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         // `pdev` is valid by the invariants of `Device`.
         // `num` is checked for validity by a previous call to `Device::resource_len`.
         // `name` is always valid.
-        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
+        let ioptr = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) }.expose_provenance();
         if ioptr == 0 {
             // SAFETY:
             // `pdev` is valid by the invariants of `Device`.
@@ -212,7 +212,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut c_void);
+            bindings::pci_iounmap(pdev.as_raw(), core::ptr::with_exposed_provenance_mut(ioptr));
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 8311d91549e1..67aba11c9702 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -564,9 +564,9 @@ fn new() -> Self {
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
         // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
-            beg: pos as usize,
-            pos: pos as usize,
-            end: end as usize,
+            beg: pos.expose_provenance(),
+            pos: pos.expose_provenance(),
+            end: end.expose_provenance(),
         }
     }
 
@@ -577,7 +577,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
     /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
     /// for the lifetime of the returned [`RawFormatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
-        let pos = buf as usize;
+        let pos = buf.expose_provenance();
         // INVARIANT: We ensure that `end` is never less than `buf`, and the safety requirements
         // guarantees that the memory region is valid for writes.
         Self {
@@ -591,7 +591,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     ///
     /// N.B. It may point to invalid memory.
     pub(crate) fn pos(&self) -> *mut u8 {
-        self.pos as *mut u8
+        core::ptr::with_exposed_provenance_mut(self.pos)
     }
 
     /// Returns the number of bytes written to the formatter.
@@ -613,11 +613,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
             // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
             // yet, so it is valid for write per the type invariants.
             unsafe {
-                core::ptr::copy_nonoverlapping(
-                    s.as_bytes().as_ptr(),
-                    self.pos as *mut u8,
-                    len_to_copy,
-                )
+                core::ptr::copy_nonoverlapping(s.as_bytes().as_ptr(), self.pos(), len_to_copy)
             };
         }
 
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 5f6c4d7a1a51..f06b4c1637ca 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -28,7 +28,7 @@ impl UserPtr {
     /// Create a `UserPtr` from an integer representing the userspace address.
     #[inline]
     pub fn from_addr(addr: usize) -> Self {
-        Self(addr as *mut c_void)
+        Self(core::ptr::without_provenance_mut(addr))
     }
 
     /// Create a `UserPtr` from a pointer representing the userspace address.

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260521-strict-provenance-redux-d58178caada3

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D743B6F3;
	Tue, 11 Aug 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491612; cv=none; b=dpccP/mY9kBZcEBIFM6+S0Pd2gjWm+Ug6pytTri2oNvOCuL0oCvuA6P7xwgU58Bbhp7h83eCkAuUcgght5hCArTWSQPLBjy8Bi8lE1HVAiN/lM+YH23T/E7TAxplqiXqoJ6tDChpVlkhpupbuOZ+REKyOT4DFYfNx7I0ea419hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491612; c=relaxed/simple;
	bh=LuIZpXt3LYtHQWbNbsIpJMzmdp5Su9S36JY4bvbi1QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyuVbFk3UqbSWye6vAPCuoeGwxsyWIv+JItCh4q02YqDpX9hVpjQU9ELAEj1RIy7ahZ1IePjOEv/8BGkkdnUGwseFbKqtL6woepc0+i1qgVtD/K/N//5IzkggXlE+IhvXEupjIgxxwW0a64DlswR54fwTtdqGeftiK5PEtaaJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRttyq1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRttyq1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15771F000E9;
	Tue, 11 Aug 2026 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491610;
	bh=xLWO9FzBt+MuDdgpLZKkGWMPfByZxM3sqppm2elb0es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRttyq1I08OtbtvaJg1f33Riq5t2uHo7oLqV1NeqZm8GsYOCcZr5d95d6VVW+u0u1
	 qk4MLDnznp8/e1/flxa6E1eXMeB6CBBfMALWN4/FWt63cKdEzrOJEtwhWeLp31oIJP
	 18/4y2x9TLmoAMVRh3cv1pGnBaGGLUGn5BFAgh+nTHwVo1ypBqKrv9Tf1oirJZNCYF
	 KKFpuiBbadFvH4aod+yN1VlQk1iejEreimYoFinegtpfchuh6bwjuWJpZ6BJwTH/LK
	 s9Apz5EhXlJ+LPA36ZYf5lmKvAhuotZEAG7wTlBXPia3i5fe+Is0LdXGKjE5YUBFcP
	 RX+3+lXiIKf/Q==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	dakr@kernel.org,
	kwilczynski@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com,
	ttabi@nvidia.com,
	apopple@nvidia.com,
	ecourtney@nvidia.com,
	shashanks@nvidia.com,
	zhiw@nvidia.com
Cc: driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed IrqRequest in IrqVector
Date: Wed, 12 Aug 2026 01:39:33 +0200
Message-ID: <20260811233952.3000968-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811233952.3000968-1-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pci_irq_vector() call from the TryInto<IrqRequest> impl into
IrqVectorRegistration::vector(), so the IRQ number is resolved eagerly.

IrqVector now embeds the resolved IrqRequest and the vector index. The
conversion to IrqRequest is infallible (From instead of TryInto), which
removes the need for pin_init_scope in request_irq/request_threaded_irq.

Inspired-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/irq.rs | 77 ++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 8e0651587829..305701440114 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -68,31 +68,39 @@ const fn as_raw(self) -> u32 {
     }
 }
 
-/// Represents an allocated IRQ vector for a specific PCI device.
+/// A resolved IRQ vector from a PCI interrupt vector allocation.
 ///
-/// This type ties an IRQ vector to the device it was allocated for,
-/// ensuring the vector is only used with the correct device.
-#[derive(Clone, Copy)]
+/// Created by [`IrqVectorRegistration::vector`] and consumed by [`Device::request_irq`] or
+/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistration`] it was derived from,
+/// so the allocation stays live until the handler is freed.
 pub struct IrqVector<'a> {
-    dev: &'a Device<Bound>,
+    request: IrqRequest<'a>,
     reg: &'a IrqVectorRegistration<'a>,
-    index: u32,
+    index: usize,
 }
 
 impl<'a> IrqVector<'a> {
-    /// Creates a new [`IrqVector`] for the given device and index.
+    /// Creates a new [`IrqVector`] with an already resolved [`IrqRequest`].
     ///
     /// # Safety
     ///
-    /// - `index` must be a valid IRQ vector index for `reg`.
-    /// - `dev` must be the device `reg` was allocated from.
+    /// `request` must have been resolved from `reg`.
     #[inline]
-    unsafe fn new(dev: &'a Device<Bound>, reg: &'a IrqVectorRegistration<'a>, index: u32) -> Self {
-        Self { dev, reg, index }
+    unsafe fn new(
+        request: IrqRequest<'a>,
+        reg: &'a IrqVectorRegistration<'a>,
+        index: usize,
+    ) -> Self {
+        Self {
+            request,
+            reg,
+            index,
+        }
     }
 
-    /// Returns the raw vector index.
-    fn index(&self) -> u32 {
+    /// Returns the vector index within the allocation.
+    #[inline]
+    pub fn index(&self) -> usize {
         self.index
     }
 
@@ -102,17 +110,10 @@ pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
     }
 }
 
-impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
-    type Error = Error;
-
-    fn try_into(self) -> Result<IrqRequest<'a>> {
-        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `struct pci_dev`.
-        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
-        if irq < 0 {
-            return Err(crate::error::Error::from_errno(irq));
-        }
-        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `self.dev`.
-        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
+impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {
+    #[inline]
+    fn from(vector: IrqVector<'a>) -> Self {
+        vector.request
     }
 }
 
@@ -142,15 +143,19 @@ pub fn vector_count(&self) -> usize {
     ///
     /// The returned [`IrqVector`] borrows from this registration, ensuring the vector allocation
     /// remains live while any handler is registered on it.
-    #[inline]
     pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
         if index >= self.count.get() {
             return Err(EINVAL);
         }
 
-        // SAFETY: `index` is within bounds of this registration's allocation, and `self.dev` is
-        // the device it was allocated from.
-        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
+        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), index as u32) };
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
+        }
+
+        // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this registration.
+        Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u32), self, index) })
     }
 }
 
@@ -177,12 +182,8 @@ pub unsafe fn request_irq<'a, T: crate::irq::Handler + 'a>(
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
     ) -> impl PinInit<irq::Registration<'a, T>, Error> + 'a {
-        pin_init::pin_init_scope(move || {
-            let request = vector.try_into()?;
-
-            // SAFETY: Caller guarantees the Registration will not be leaked.
-            Ok(unsafe { irq::Registration::<T>::new(request, flags, name, handler) })
-        })
+        // SAFETY: Caller guarantees the Registration will not be leaked.
+        unsafe { irq::Registration::<T>::new(vector.into(), flags, name, handler) }
     }
 
     /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
@@ -198,12 +199,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
     ) -> impl PinInit<irq::ThreadedRegistration<'a, T>, Error> + 'a {
-        pin_init::pin_init_scope(move || {
-            let request = vector.try_into()?;
-
-            // SAFETY: Caller guarantees the Registration will not be leaked.
-            Ok(unsafe { irq::ThreadedRegistration::<T>::new(request, flags, name, handler) })
-        })
+        // SAFETY: Caller guarantees the Registration will not be leaked.
+        unsafe { irq::ThreadedRegistration::<T>::new(vector.into(), flags, name, handler) }
     }
 
     /// Allocate IRQ vectors for this PCI device.
-- 
2.55.0


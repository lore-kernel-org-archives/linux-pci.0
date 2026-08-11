Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B942C51D;
	Tue, 11 Aug 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491607; cv=none; b=MrMuO5tKCwOPnGVhU0tWaADDyUcjUxKPCJm1XTNx/2HNBM/qV2Tmfb6dw7s8OULTvr7KKTlmHvN1d4wsdIABulJeoN5H63ZTTTgrvdpNG0xQPSjHdhu0asdhSG4Bw5JPlY3hTe/V9CPwSpVScWfOG/r+xu3m9I4tSiZewZbrvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491607; c=relaxed/simple;
	bh=3wLxYcxDRIIarwWq35LeGf/oxOrii9Ju1xrb9oIUx1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEB5Th9J6cHbguIVAPIyHDuO4pzCoNBaQoB5YbZ7z/1LEpTfEnoKqrJ1m8ZLCjfdNvUtiLaoWtYvCPzYmW/7y3MT8WQGuSp/w/pjL5Q5qCptps260DxAhO2cNTfJHaxr8tuumNCoo/eKVTn9G/BtjXijD9FCoz5EVdzH/hIFVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQqkS4b9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQqkS4b9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4EF1F00A3A;
	Tue, 11 Aug 2026 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491605;
	bh=8IGmQrLEypuzyWOq4KvdNpRNse0H9fRot9r9BRdJXbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQqkS4b9lPTAJAUHUGeX38qcNhbO0B6wFZYzvQu1DER8F8WM/eqPAVOUCDdCNF3hw
	 dSGERX/etz8Bus8D6M9gTqlUimwG2Ny2hk9q0C4cluIUzWEiQieYa+v7O3vSLnep2m
	 pj4pChAPnO4pUbJWuMF3J/mPzpQR3DYdf7l91HleCNh7cEVesUy2mHKxxwrEzy0tEr
	 3JABqtPvJ49bCNXgbDZVjVYFUYKY+eSd6ra9mPhnu2f2qSxTGQ5ZF7kJUmWp2aFmNY
	 3my/Ze7YqXWOc3kp2/D/btB8dGIilmNdF+btkmsFIFtXN4fqMIxiaJ73Z3cmXfqBP0
	 bVRZFHSKk0jdw==
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
Subject: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a lifetime-managed owning type
Date: Wed, 12 Aug 2026 01:39:32 +0200
Message-ID: <20260811233952.3000968-2-dakr@kernel.org>
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

Convert IrqVectorRegistration from a devres-managed internal type to a
lifetime-annotated type that owns the PCI interrupt vector allocation.
Dropping it frees the vectors.

IrqVector gains a reference to the IrqVectorRegistration it was derived
from. Since vector() borrows the registration, the compiler prevents the
allocation from being dropped while any IrqVector (and hence any
irq::Registration built from it) is still live.

alloc_irq_vectors() returns IrqVectorRegistration<'_> directly, giving
drivers explicit control over the allocation lifetime, which is needed
by net and block drivers that re-allocate vectors at runtime, e.g.
during queue reconfiguration or device recovery.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs     |   3 +-
 rust/kernel/pci/irq.rs | 127 ++++++++++++++++++++++-------------------
 2 files changed, 69 insertions(+), 61 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c6417af2bb17..2757a0cc0f11 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -51,7 +51,8 @@
 pub use self::irq::{
     IrqType,
     IrqTypes,
-    IrqVector, //
+    IrqVector,
+    IrqVectorRegistration, //
 };
 
 /// An adapter for the registration of PCI drivers.
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index fea484dcf9cf..8e0651587829 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -7,17 +7,14 @@
     bindings,
     device,
     device::Bound,
-    devres,
     error::to_result,
     irq::{
         self,
         IrqRequest, //
     },
-    prelude::*,
-    str::CStr,
-    sync::aref::ARef, //
+    prelude::*, //
 };
-use core::ops::RangeInclusive;
+use core::num::NonZero;
 
 /// IRQ type flags for PCI interrupt allocation.
 #[derive(Debug, Clone, Copy)]
@@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
 #[derive(Clone, Copy)]
 pub struct IrqVector<'a> {
     dev: &'a Device<Bound>,
+    reg: &'a IrqVectorRegistration<'a>,
     index: u32,
 }
 
@@ -86,87 +84,81 @@ impl<'a> IrqVector<'a> {
     ///
     /// # Safety
     ///
-    /// - `index` must be a valid IRQ vector index for `dev`.
-    /// - `dev` must point to a [`Device`] that has successfully allocated IRQ vectors.
-    unsafe fn new(dev: &'a Device<Bound>, index: u32) -> Self {
-        Self { dev, index }
+    /// - `index` must be a valid IRQ vector index for `reg`.
+    /// - `dev` must be the device `reg` was allocated from.
+    #[inline]
+    unsafe fn new(dev: &'a Device<Bound>, reg: &'a IrqVectorRegistration<'a>, index: u32) -> Self {
+        Self { dev, reg, index }
     }
 
     /// Returns the raw vector index.
     fn index(&self) -> u32 {
         self.index
     }
+
+    /// Returns the [`IrqVectorRegistration`] this vector was derived from.
+    pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
+        self.reg
+    }
 }
 
 impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
     type Error = Error;
 
     fn try_into(self) -> Result<IrqRequest<'a>> {
-        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `struct pci_dev`.
         let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
         if irq < 0 {
             return Err(crate::error::Error::from_errno(irq));
         }
-        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `self.dev`.
         Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
     }
 }
 
-/// Represents an IRQ vector allocation for a PCI device.
+/// An allocation of PCI interrupt vectors for a device.
 ///
-/// This type ensures that IRQ vectors are properly allocated and freed by
-/// tying the allocation to the lifetime of this registration object.
+/// This type owns the vector allocation; dropping it frees the vectors. IRQ handlers borrow from
+/// this registration and must be dropped before it is.
 ///
 /// # Invariants
 ///
-/// The [`Device`] has successfully allocated IRQ vectors.
-struct IrqVectorRegistration {
-    dev: ARef<Device>,
+/// `dev` has an allocation of `count` interrupt vectors.
+pub struct IrqVectorRegistration<'a> {
+    dev: &'a Device<Bound>,
+    count: NonZero<usize>,
 }
 
-impl IrqVectorRegistration {
-    /// Allocate and register IRQ vectors for the given PCI device.
+impl<'a> IrqVectorRegistration<'a> {
+    /// Returns the number of allocated vectors.
     ///
-    /// Allocates IRQ vectors and registers them with devres for automatic cleanup.
-    /// Returns a range of valid IRQ vectors.
-    fn register<'a>(
-        dev: &'a Device<Bound>,
-        min_vecs: u32,
-        max_vecs: u32,
-        irq_types: IrqTypes,
-    ) -> Result<RangeInclusive<IrqVector<'a>>> {
-        // SAFETY:
-        // - `dev.as_raw()` is guaranteed to be a valid pointer to a `struct pci_dev`
-        //   by the type invariant of `Device`.
-        // - `pci_alloc_irq_vectors` internally validates all other parameters
-        //   and returns error codes.
-        let ret = unsafe {
-            bindings::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
-        };
-
-        to_result(ret)?;
-        let count = ret as u32;
-
-        // SAFETY:
-        // - `pci_alloc_irq_vectors` returns the number of allocated vectors on success.
-        // - Vectors are 0-based, so valid indices are [0, count-1].
-        // - `pci_alloc_irq_vectors` guarantees `count >= min_vecs > 0`, so both `0` and
-        //   `count - 1` are valid IRQ vector indices for `dev`.
-        let range = unsafe { IrqVector::new(dev, 0)..=IrqVector::new(dev, count - 1) };
+    /// This is at least the `min_vecs` that [`Device::alloc_irq_vectors`] was asked for.
+    #[inline]
+    pub fn vector_count(&self) -> usize {
+        self.count.get()
+    }
 
-        // INVARIANT: The IRQ vector allocation for `dev` above was successful.
-        let irq_vecs = Self { dev: dev.into() };
-        devres::register(dev.as_ref(), irq_vecs, GFP_KERNEL)?;
+    /// Returns the [`IrqVector`] at `index`.
+    ///
+    /// The returned [`IrqVector`] borrows from this registration, ensuring the vector allocation
+    /// remains live while any handler is registered on it.
+    #[inline]
+    pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
+        if index >= self.count.get() {
+            return Err(EINVAL);
+        }
 
-        Ok(range)
+        // SAFETY: `index` is within bounds of this registration's allocation, and `self.dev` is
+        // the device it was allocated from.
+        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
     }
 }
 
-impl Drop for IrqVectorRegistration {
+impl Drop for IrqVectorRegistration<'_> {
+    #[inline]
     fn drop(&mut self) {
-        // SAFETY:
-        // - By the type invariant, `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
-        // - `self.dev` has successfully allocated IRQ vectors.
+        // SAFETY: By the type invariant, `self.dev.as_raw()` is a valid pointer to a
+        // `struct pci_dev` that has successfully allocated IRQ vectors.
         unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
     }
 }
@@ -214,15 +206,16 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
         })
     }
 
-    /// Allocate IRQ vectors for this PCI device with automatic cleanup.
+    /// Allocate IRQ vectors for this PCI device.
     ///
     /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
     /// The allocation will use MSI-X, MSI, or INTx interrupts based on the `irq_types`
     /// parameter and hardware capabilities. When multiple types are specified, the kernel
     /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
-    /// The allocated vectors are automatically freed when the device is unbound, using the
-    /// devres (device resource management) system.
+    /// The allocated vectors are freed when the returned [`IrqVectorRegistration`] is dropped.
+    /// IRQ handlers registered via [`Self::request_irq`] or [`Self::request_threaded_irq`]
+    /// borrow from the registration, so the compiler ensures they are freed first.
     ///
     /// # Arguments
     ///
@@ -232,8 +225,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
     ///
     /// # Returns
     ///
-    /// Returns a range of IRQ vectors that were successfully allocated, or an error if the
-    /// allocation fails or cannot meet the minimum requirement.
+    /// Returns the IRQ vector registration, or an error if `min_vecs` vectors cannot be
+    /// allocated.
     ///
     /// # Examples
     ///
@@ -256,7 +249,21 @@ pub fn alloc_irq_vectors(
         min_vecs: u32,
         max_vecs: u32,
         irq_types: IrqTypes,
-    ) -> Result<RangeInclusive<IrqVector<'_>>> {
-        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_types)
+    ) -> Result<IrqVectorRegistration<'_>> {
+        // SAFETY:
+        // - `self.as_raw()` is guaranteed to be a valid pointer to a `struct pci_dev`
+        //   by the type invariant of `Device`.
+        // - `pci_alloc_irq_vectors` internally validates all other parameters
+        //   and returns error codes.
+        let ret = unsafe {
+            bindings::pci_alloc_irq_vectors(self.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
+        };
+
+        to_result(ret)?;
+
+        let count = NonZero::new(ret as usize).ok_or(EINVAL)?;
+
+        // INVARIANT: `pci_alloc_irq_vectors()` allocated `count` vectors for `self`.
+        Ok(IrqVectorRegistration { dev: self, count })
     }
 }
-- 
2.55.0


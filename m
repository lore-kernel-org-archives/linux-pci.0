Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324939AD3B;
	Mon, 10 Aug 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402214; cv=none; b=gCj1h4jc8/S7t5D+iuDx0yUTT4r6h92K+PiTH7001aS2xp/PI8C2lCWXh//qSerHibLyRaZYl0iwgJ3qVbuIhMxn2V/HTgw71+LPtjqA0oGuiaCBvWld497qCtPCO7heV0JRHyAeHe23FabiNzG3eGQaHF1ONEr+xX3KqfBSQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402214; c=relaxed/simple;
	bh=fVhkaAYsHwHl2ZNPSTLjEiNP4c8pdj212fQ2gFanOrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sayN762SxEwlUUun0VrrSjl+J8/NLWnugaUl7QWUJC4onYECKKkBMkEHT3pxRZMFaY/6YWgoo072BnALvQ/FxucQWnsiVvNI7YVmIrxA3qHY/gpUXE6Acm9Oo/Ktc/rZDSYtYF82oVQQMgNxLhONphpsrYusdkAUjlhH5C1J6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otj9Z5At; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otj9Z5At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9121E1F000E9;
	Mon, 10 Aug 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402212;
	bh=w2oNiNgPZWWxJG/BlshTlKa5yCRKRo3XyNXanMUjbsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otj9Z5AtirQQb1ZuJlRqiGIJ7hCqdiVS48Ti913qz1cP+yceqUe5Ho2SSCB+jodG8
	 y0d9cFiQodSvpneg6zrOXhS/VDftD+Mv+D/btv7wVqcDXZW+K2HJuAUroFIpGTG+6e
	 0EEpvjZVqDql0CrcL23N4SaIKmYuGr8HHS7mhoe61NVaqD9Ll3kGJrJ45VdDcWC5Ek
	 8yWXSFVkw9aTTgovgDomxHvBQtXbggy5DQ1b+7M1lWk3BJHCGrFx78cLZrT9pvcLWC
	 sNwCpbjAn36FAxseHUykiWRfTUhzvdiKS2/UQQnU3uu6EgUwMfMKQVnheLgXCyLOoq
	 0uF7YQLeW4XOg==
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
Subject: [PATCH 3/5] rust: pci: remove IrqVector and resolve IrqRequest directly
Date: Tue, 11 Aug 2026 00:47:42 +0200
Message-ID: <20260810224800.2314458-4-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810224800.2314458-1-dakr@kernel.org>
References: <20260810224800.2314458-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the IrqVector intermediate type; IrqVectorRegistration::request()
now resolves a vector index to an IrqRequest directly, combining the
bounds check and pci_irq_vector() call in one step.

Also remove Device::request_irq() and Device::request_threaded_irq(),
which only exist to convert IrqVector to IrqRequest. Drivers pass the
IrqRequest from IrqVectorRegistration::request() to
irq::Registration::new() directly.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs     |   1 -
 rust/kernel/pci/irq.rs | 109 +++++------------------------------------
 2 files changed, 13 insertions(+), 97 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 2757a0cc0f11..f7f6b21f64bf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -51,7 +51,6 @@
 pub use self::irq::{
     IrqType,
     IrqTypes,
-    IrqVector,
     IrqVectorRegistration, //
 };
 
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 38a7d72dcda7..d69ab6435a80 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -9,7 +9,6 @@
     device::Bound,
     error::to_result,
     irq::{
-        self,
         IrqRequest,
         IrqRequestAnchor, //
     },
@@ -69,35 +68,6 @@ const fn as_raw(self) -> u32 {
     }
 }
 
-/// Represents an allocated IRQ vector for a specific PCI device.
-///
-/// This type ties an IRQ vector to the device it was allocated for,
-/// ensuring the vector is only used with the correct device.
-#[derive(Clone, Copy)]
-pub struct IrqVector<'a> {
-    dev: &'a Device<Bound>,
-    reg: &'a IrqVectorRegistration<'a>,
-    index: u32,
-}
-
-impl<'a> IrqVector<'a> {
-    /// Creates a new [`IrqVector`] for the given device and index.
-    ///
-    /// # Safety
-    ///
-    /// - `index` must be a valid IRQ vector index for `reg`.
-    /// - `dev` must be the device `reg` was allocated from.
-    #[inline]
-    unsafe fn new(dev: &'a Device<Bound>, reg: &'a IrqVectorRegistration<'a>, index: u32) -> Self {
-        Self { dev, reg, index }
-    }
-
-    /// Returns the raw vector index.
-    fn index(&self) -> u32 {
-        self.index
-    }
-}
-
 impl IrqRequestAnchor for &IrqVectorRegistration<'_> {}
 
 impl<'a> IrqRequest<'a, &'a IrqVectorRegistration<'a>> {
@@ -107,20 +77,6 @@ pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
     }
 }
 
-impl<'a> TryInto<IrqRequest<'a, &'a IrqVectorRegistration<'a>>> for IrqVector<'a> {
-    type Error = Error;
-
-    fn try_into(self) -> Result<IrqRequest<'a, &'a IrqVectorRegistration<'a>>> {
-        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `struct pci_dev`.
-        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
-        if irq < 0 {
-            return Err(crate::error::Error::from_errno(irq));
-        }
-        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `self.dev`.
-        Ok(unsafe { IrqRequest::new_anchored(self.dev.as_ref(), irq as u32, self.reg) })
-    }
-}
-
 /// An allocation of PCI interrupt vectors for a device.
 ///
 /// This type owns the vector allocation; dropping it frees the vectors. IRQ handlers borrow from
@@ -143,19 +99,23 @@ pub fn vector_count(&self) -> usize {
         self.count.get()
     }
 
-    /// Returns the [`IrqVector`] at `index`.
+    /// Resolves the vector at `index` to an [`IrqRequest`].
     ///
-    /// The returned [`IrqVector`] borrows from this registration, ensuring the vector allocation
+    /// The returned [`IrqRequest`] borrows from this registration, ensuring the vector allocation
     /// remains live while any handler is registered on it.
-    #[inline]
-    pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
+    pub fn request(&self, index: usize) -> Result<IrqRequest<'_, &'_ Self>> {
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
+        // SAFETY: `irq` is a valid IRQ number for `self.dev`.
+        Ok(unsafe { IrqRequest::new_anchored(self.dev.as_ref(), irq as u32, self) })
     }
 }
 
@@ -169,49 +129,6 @@ fn drop(&mut self) {
 }
 
 impl Device<device::Bound> {
-    /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
-    ///
-    /// # Safety
-    ///
-    /// Callers must not `mem::forget()` the resulting [`irq::Registration`] or otherwise prevent
-    /// its [`Drop`] implementation from running.
-    pub unsafe fn request_irq<'a, T: crate::irq::Handler + 'a>(
-        &'a self,
-        vector: IrqVector<'a>,
-        flags: irq::Flags,
-        name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::Registration<'a, T, &'a IrqVectorRegistration<'a>>, Error> + 'a {
-        pin_init::pin_init_scope(move || {
-            let request = vector.try_into()?;
-
-            // SAFETY: Caller guarantees the Registration will not be leaked.
-            Ok(unsafe { irq::Registration::new(request, flags, name, handler) })
-        })
-    }
-
-    /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
-    ///
-    /// # Safety
-    ///
-    /// Callers must not `mem::forget()` the resulting [`irq::ThreadedRegistration`] or otherwise
-    /// prevent its [`Drop`] implementation from running.
-    pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
-        &'a self,
-        vector: IrqVector<'a>,
-        flags: irq::Flags,
-        name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::ThreadedRegistration<'a, T, &'a IrqVectorRegistration<'a>>, Error> + 'a
-    {
-        pin_init::pin_init_scope(move || {
-            let request = vector.try_into()?;
-
-            // SAFETY: Caller guarantees the Registration will not be leaked.
-            Ok(unsafe { irq::ThreadedRegistration::new(request, flags, name, handler) })
-        })
-    }
-
     /// Allocate IRQ vectors for this PCI device.
     ///
     /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
@@ -220,8 +137,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
     /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
     /// The allocated vectors are freed when the returned [`IrqVectorRegistration`] is dropped.
-    /// IRQ handlers registered via [`Self::request_irq`] or [`Self::request_threaded_irq`]
-    /// borrow from the registration, so the compiler ensures they are freed first.
+    /// Use [`IrqVectorRegistration::request`] to obtain an [`IrqRequest`] for a given vector
+    /// index.
     ///
     /// # Arguments
     ///
-- 
2.55.0


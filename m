Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497853446AD;
	Thu, 13 Aug 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639974; cv=none; b=B1ypDTUOZKYTrQTaAr1NP+xBsFRxBw0bdEbyJB6vLud3LMgqhRhoDV4KKMStR4oCLDzgTEVQ2bqKbJzDsS9AyMPqqm/GnM4PQY3mqW7huwTP5R3b9qpDA2S2B5dBmVdzhZ2shgK/jSxKfKwSqrOW61m6yhzRCWFRvvlvKLtwDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639974; c=relaxed/simple;
	bh=qjF9ZjN491oEVBbRaLmSQxFY64UKoX2ow/J8yxMsDlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY4D5UMe68HBR/jlnUH1ek3DiREuA8vWm8stftkZav5C6C7hAbdKFzBdrqI+chudimAhjzi3aAMN3tvkhiyhvHqkG1DPGtaCfqxMwPnUMFC+t3zc4YPT70mHsoT4DtNVAn8NM0BmGQQL0owfuMpY2XR8Mz/oD81PM4Pe3PhB/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjwkztUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjwkztUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5FB1F00A3A;
	Thu, 13 Aug 2026 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639971;
	bh=Hsq3DSjGOVtc1v3UzQLGWtlptJsL4JsK+kfeVAeGja0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjwkztUcfSbfubDqulvgGCCCvNGJCy7LZV9xqhp6MZrEaGNEckBDsBr5L8VIngBqj
	 MaRMQX4SVJXFX0MCEsjt5xh0ojFHuvf1U9a/+z/d5eQaGvCUKq661YjzydUddGJYw7
	 PUum4VpcJEvunoacvrMavFH3T6Z77EuYpEsBaEXmeIz1cEATViHdqbxDVLUcXrOHLT
	 b77n8vZFhu6dYOugHciOlRzDk5Py0jDiENmVCiSyxu8wzp6sgDqtd+1m2BvqqszIN1
	 Gja7wIsgEmLi8G11Ngd/LDfyW33evnXUqYtyX8NQBlhrvjuyfiLdkMxZ2ByKPA94mI
	 YZEq4AGF1+Dig==
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
Subject: [PATCH v3 2/5] rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector
Date: Thu, 13 Aug 2026 18:52:02 +0200
Message-ID: <20260813165234.620555-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813165234.620555-1-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pci_irq_vector() call from the TryInto<IrqRequest> impl into
IrqVectorRegistration::index(), so the IRQ number is resolved eagerly.

IrqVector now embeds the resolved IrqRequest and a reference to the
IrqVectorRegistration. The conversion to IrqRequest is infallible, which
removes the need for pin_init_scope() in request_irq() /
request_threaded_irq().

Tested-by: John Hubbard <jhubbard@nvidia.com>
Inspired-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/irq.rs | 67 +++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index daba86505cd2..81b74c4c17d9 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -68,32 +68,25 @@ const fn as_raw(self) -> u32 {
     }
 }
 
-/// Represents an allocated IRQ vector for a specific PCI device.
+/// A resolved IRQ vector from a PCI interrupt vector allocation.
 ///
-/// This type ties an IRQ vector to the device it was allocated for,
-/// ensuring the vector is only used with the correct device.
-#[derive(Clone, Copy)]
+/// Created by [`IrqVectorRegistration::index`] and consumed by [`Device::request_irq`] or
+/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistration`] it was derived from,
+/// so the allocation stays live until the handler is freed.
 pub struct IrqVector<'a> {
-    dev: &'a Device<Bound>,
+    request: IrqRequest<'a>,
     reg: &'a IrqVectorRegistration<'a>,
-    index: u32,
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
-    }
-
-    /// Returns the raw vector index.
-    fn index(&self) -> u32 {
-        self.index
+    unsafe fn new(request: IrqRequest<'a>, reg: &'a IrqVectorRegistration<'a>) -> Self {
+        Self { request, reg }
     }
 
     /// Returns the [`IrqVectorRegistration`] this vector was derived from.
@@ -103,17 +96,10 @@ pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
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
 
@@ -146,13 +132,14 @@ pub fn len(&self) -> usize {
     /// [`Self::len()`].
     #[inline]
     pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
-        if index >= self.len.get() {
-            return Err(EINVAL);
+        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), index as u32) };
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
         }
 
-        // SAFETY: `index` is within bounds of this registration's allocation, and `self.dev` is
-        // the device it was allocated from.
-        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
+        // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this registration.
+        Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u32), self) })
     }
 }
 
@@ -179,12 +166,8 @@ pub unsafe fn request_irq<'a, T: crate::irq::Handler + 'a>(
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
@@ -200,12 +183,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
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


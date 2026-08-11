Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944E438499;
	Tue, 11 Aug 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491617; cv=none; b=cCkyLEIyrZ6M9yABV/0GhoVnmG9eIZIdy8RGJ/BRoGASYc4jb320HJ9hIp1cX50SKnKEbW9S3f5a3nPuKID9X9Lsm6O1PMAWGMuoE+qB8qWJ8WdI/8qfChIA/QFkcsTf5HQLHSsIo7maL1HAs4IG3rA7VisYi69nv6qDNyZ7P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491617; c=relaxed/simple;
	bh=4/hxo/KFhuiiLAHDJGcEHJ8QKsRDXYCtObffmXj2gBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHvYyYGvWccgzjJ0rHDq2XrEMric7uQZyd4YlJiBvah7HKaGqBm7f02NOSs6Y/+LwzbdiryCe+HHdx0fw0WaS7NjZNUbR5NydyaRGGIGvM4lzAjz+hyiTIOaw9wgWIhmlyN0/qSQwhVso/p65uE0VZunqQm8fDtuQ3jd8EudIZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4C5op87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4C5op87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DFB1F00A3A;
	Tue, 11 Aug 2026 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491615;
	bh=Et6jvRde03qX5l8BhSg3TWpD9qWGcYu/EHrQQaM36Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4C5op87uxYqeKnYwobAmbMOGGPHnCNN0qH7haoRHUm+U6Fvs+lPW7ozeivc8it8Y
	 8wETeI2x+QNvmC1cz3B/5qsZKIOseop85Rrz8NGIPjOP4pBw81pGaMt9XwAiKNNtxW
	 UaWmQyqa4IWdXwBEeqBo6VuxQ7vq7BeEFhlNlHsX+yJI2j+bzszscJyFr+sZ1emB+H
	 LS2sR7q6MmIsVUytxipvfMZFDeLR4qBGjTnjPDjimzI/jurRsFpXaBIU+gruBso6QU
	 MPO7iBRTiP9m5ilo5K4q7e1pawmQysHMEZ/MNbp9CS0xMJimqD4MS2A9FWCGwMwRy3
	 UmlKftAy9NDfg==
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
Subject: [PATCH v2 3/5] rust: pci: remove request_irq() and request_threaded_irq() from Device
Date: Wed, 12 Aug 2026 01:39:34 +0200
Message-ID: <20260811233952.3000968-4-dakr@kernel.org>
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

Remove the thin wrappers on Device<Bound> that only forwarded to
irq::Registration::new() and irq::ThreadedRegistration::new(). With
IrqVector embedding a resolved IrqRequest, the conversion is infallible
and drivers call irq::Registration::new(vector.into(), ...) directly.

Unlike the platform equivalents, which combine a fallible IRQ lookup
with handler registration, the PCI wrappers add no value beyond
namespacing. They also introduce a redundant device reference.
IrqVector already carries a device borrow through its embedded
IrqRequest, yet the wrappers required a second, potentially unrelated,
&self receiver.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/irq.rs | 50 ++++++------------------------------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 305701440114..b3dce5b49d57 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -8,10 +8,7 @@
     device,
     device::Bound,
     error::to_result,
-    irq::{
-        self,
-        IrqRequest, //
-    },
+    irq::IrqRequest,
     prelude::*, //
 };
 use core::num::NonZero;
@@ -70,9 +67,10 @@ const fn as_raw(self) -> u32 {
 
 /// A resolved IRQ vector from a PCI interrupt vector allocation.
 ///
-/// Created by [`IrqVectorRegistration::vector`] and consumed by [`Device::request_irq`] or
-/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistration`] it was derived from,
-/// so the allocation stays live until the handler is freed.
+/// Created by [`IrqVectorRegistration::vector`]. Convert to [`IrqRequest`] via [`From`] to register
+/// a handler with [`irq::Registration::new`](crate::irq::Registration::new). Borrows the
+/// [`IrqVectorRegistration`] it was derived from, so the allocation stays live until the handler is
+/// freed.
 pub struct IrqVector<'a> {
     request: IrqRequest<'a>,
     reg: &'a IrqVectorRegistration<'a>,
@@ -169,40 +167,6 @@ fn drop(&mut self) {
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
-    ) -> impl PinInit<irq::Registration<'a, T>, Error> + 'a {
-        // SAFETY: Caller guarantees the Registration will not be leaked.
-        unsafe { irq::Registration::<T>::new(vector.into(), flags, name, handler) }
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
-    ) -> impl PinInit<irq::ThreadedRegistration<'a, T>, Error> + 'a {
-        // SAFETY: Caller guarantees the Registration will not be leaked.
-        unsafe { irq::ThreadedRegistration::<T>::new(vector.into(), flags, name, handler) }
-    }
-
     /// Allocate IRQ vectors for this PCI device.
     ///
     /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
@@ -211,8 +175,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
     /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
     /// The allocated vectors are freed when the returned [`IrqVectorRegistration`] is dropped.
-    /// IRQ handlers registered via [`Self::request_irq`] or [`Self::request_threaded_irq`]
-    /// borrow from the registration, so the compiler ensures they are freed first.
+    /// Use [`IrqVectorRegistration::vector`] to obtain an [`IrqVector`] for a given vector
+    /// index.
     ///
     /// # Arguments
     ///
-- 
2.55.0


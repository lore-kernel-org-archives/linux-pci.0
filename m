Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBD35AC07;
	Thu, 13 Aug 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639980; cv=none; b=neR7leT5/tol/UsZtlICce4W5Ob66w5dJbVtcxUJmgm/IgnxPK6BzbIT9Y/Lj3TXj91LkgMOWGgMSn62KQ2hTlLZCcZ2Agw8SLnYH/VIc3nUhldszQiX7TC3VTmjLnrXuACb/anWZtEsT7kqyrDhcyEO+hBMGiZLajRqEUHuMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639980; c=relaxed/simple;
	bh=mFZvfEvqd7VkKmmxVZ6CztW9cydN1cX5HDn0SOiZEYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO+6HnDJXrYBr7uVPaJ2BFiVG9GUMMDIuOZYjNcjQJenHag8ovBM/3qaU47nj8BOttLc34Ns04KgUCCF+M6NlB4Dn8IodDCoOS9/Rh6A3K0oRxirNLGKHbmVCbaJCwQ+d8aY3yqqZkZg23if8Ya3eLLWuIKgvAWwDMePLdfBtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+ipMQd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+ipMQd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F411F000E9;
	Thu, 13 Aug 2026 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639976;
	bh=NyhqZ9JNtLYH1Zizz10hH1uJrjQDQO/Ha/me0m2ZwaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+ipMQd7qRZiE6aNd5mLmuTBPSdN9o92BAwuYm5jstcVSzqog5aP2yJZnuVnNL9DN
	 Nj7yGTAKh4gIcGulGBl2IMcfQSl4PNJRaAdU+GZMrXJ9YacJuzFzqqQJb0O+oGLw1d
	 Ww1KZDjZ239A69E6Zo0lo6RT9S2XQcbIDQw6xBPjWTV16U0SzqqklDQKLV4yOeLKBr
	 Sl7u1AP/L/jY7k60mmnq8FL2TqB5fZQqYa0hJ7eTEXfwFTS0XidZ1B5hUjFzyuDQYO
	 SUtICenWw7ksjKJBqwYGm9NDFOKEebPlndf5jXfj0MHtrGmONgf2puX5kAmKKWuSGG
	 Ch370+8fsXTBA==
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
Subject: [PATCH v3 3/5] rust: pci: remove request_irq() and request_threaded_irq() from Device
Date: Thu, 13 Aug 2026 18:52:03 +0200
Message-ID: <20260813165234.620555-4-dakr@kernel.org>
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

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/irq.rs | 48 +++++-------------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 81b74c4c17d9..b6d1699ee3eb 100644
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
@@ -70,9 +67,8 @@ const fn as_raw(self) -> u32 {
 
 /// A resolved IRQ vector from a PCI interrupt vector allocation.
 ///
-/// Created by [`IrqVectorRegistration::index`] and consumed by [`Device::request_irq`] or
-/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistration`] it was derived from,
-/// so the allocation stays live until the handler is freed.
+/// Created by [`IrqVectorRegistration::index`]. Convert to [`IrqRequest`] via [`From`] to register
+/// a handler with [`irq::Registration::new`](crate::irq::Registration::new).
 pub struct IrqVector<'a> {
     request: IrqRequest<'a>,
     reg: &'a IrqVectorRegistration<'a>,
@@ -153,40 +149,6 @@ fn drop(&mut self) {
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
@@ -195,8 +157,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
     /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
     /// The allocated vectors are freed when the returned [`IrqVectorRegistration`] is dropped.
-    /// IRQ handlers registered via [`Self::request_irq`] or [`Self::request_threaded_irq`]
-    /// borrow from the registration, so the compiler ensures they are freed first.
+    /// Use [`IrqVectorRegistration::index`] to obtain an [`IrqVector`] for a given vector
+    /// index.
     ///
     /// # Arguments
     ///
-- 
2.55.0


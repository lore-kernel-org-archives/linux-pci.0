Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC9432E6F;
	Tue, 11 Aug 2026 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491626; cv=none; b=cQK5v+XSLorFRoV0Tcz/QcqyVh29J9ai5INW/e76NKl7yEwtg8MvrgTNhOrOLxYxzncHkG/EUINba4FZ2Co58v5lTq/a/xeFraFF7kW+Gc5/ZoG0HToUVuDR6wLd/xzPxc4r/Di3dGLfD+G0oLA3GExFHxw6Rt+7ZPAd0gC6+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491626; c=relaxed/simple;
	bh=F3xDwx9RXkfN9aqmpjv4XwQeNvoYEzjQQAwVjG6j/to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSXbIybSNOUrbEyfI3515dY8bvdQcKRgv07bk7JAeB5vLW69wbuk7igJQu2TmO96WDoq4vLMRANBt1twtlT/AD8EwGWB9bqIdoSiVhG20mFmKHQjhJubFYngSZy8uZy+lvGJK79qqAMAsQOzaySEKQUAJGP7or1eQ2qbygpD09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td7a9W5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td7a9W5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED801F00A3A;
	Tue, 11 Aug 2026 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491625;
	bh=IlVtep7DDzI4H03ENDQUeTtt1UMkSbhkQnvi+Gh7hMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Td7a9W5quWBbBRzMvye4EQIKclUWNiEzNpRtRhLPx+TR0fUuQuyf4qcipuQI4Q/lL
	 sODohtV9Foz0MCU8JFRMlpIMjBx1lZKnPTjn/625L6iIILo49ePUfKLBmmSn74Jbc8
	 TBvnY5oGI380CmPQKWQsSFtgjy8u8v87yYm/Nt2bYRvHbY5EsaVNiV2UYYyck1AWXu
	 PQAw3QRw1SLX7G1fnD9mfVusPp0wetgj4ajAjyt5l7lo2EsWo0Rb061xdDdo3Yl/Yk
	 s5mw+p+HdnsVTb6IweCUGGBbx7W7geX472CY7USgZdJrZb/y+jB6kbU5Xj0scnS20e
	 Mc9XAZAd/EDug==
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
Subject: [PATCH v2 5/5] rust: pci: expose the allocated interrupt type
Date: Wed, 12 Aug 2026 01:39:36 +0200
Message-ID: <20260811233952.3000968-6-dakr@kernel.org>
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

Add irq_type() on IrqVectorRegistration and IrqVector, wrapping the new
pci_irq_type() C function. A driver whose interrupt acknowledgment
depends on the type (MSI-X vs MSI vs INTx) queries it here rather than
assuming which type the PCI core selected.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/pci.c     |  5 +++++
 rust/kernel/pci/irq.rs | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index e44905317d75..23b06becb448 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct device *dev)
 	return dev_is_pci(dev);
 }
 
+__rust_helper unsigned int rust_helper_pci_irq_type(struct pci_dev *pdev)
+{
+	return pci_irq_type(pdev);
+}
+
 #ifndef CONFIG_PCI_MSI
 __rust_helper int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
 						    unsigned int min_vecs,
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index b3dce5b49d57..41059b922492 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -33,6 +33,16 @@ const fn as_raw(self) -> u32 {
             IrqType::MsiX => bindings::PCI_IRQ_MSIX,
         }
     }
+
+    /// Construct from raw value.
+    #[inline]
+    const fn from_raw(raw: u32) -> Self {
+        match raw {
+            bindings::PCI_IRQ_MSIX => IrqType::MsiX,
+            bindings::PCI_IRQ_MSI => IrqType::Msi,
+            _ => IrqType::Intx,
+        }
+    }
 }
 
 /// Set of IRQ types that can be used for PCI interrupt allocation.
@@ -106,6 +116,11 @@ pub fn index(&self) -> usize {
     pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
         self.reg
     }
+
+    /// Returns the interrupt type the PCI core selected for this vector's allocation.
+    pub fn irq_type(&self) -> IrqType {
+        self.reg.irq_type()
+    }
 }
 
 impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {
@@ -137,6 +152,13 @@ pub fn vector_count(&self) -> usize {
         self.count.get()
     }
 
+    /// Returns the interrupt type the PCI core selected for this allocation.
+    #[inline]
+    pub fn irq_type(&self) -> IrqType {
+        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
+        IrqType::from_raw(unsafe { bindings::pci_irq_type(self.dev.as_raw()) })
+    }
+
     /// Returns the [`IrqVector`] at `index`.
     ///
     /// The returned [`IrqVector`] borrows from this registration, ensuring the vector allocation
-- 
2.55.0


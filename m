Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D64968EB;
	Thu, 13 Aug 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639992; cv=none; b=CfCFtValTvYM9wIeB1I4TQBHKXu6B9miktTwd2lLYPDh+x6/dVtxygwy6fGz+sMLyk1MZS+PVCmakrRQt7nP/6AGvbijbeV9qvkrfk4454kazZpRUP5lHXjfLoz15hZboUcPAqh+WVG/lc3GliAAKBL5dxL9BOd5xz/m/46qMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639992; c=relaxed/simple;
	bh=+4TDnZ8BZBRfq5vXg7FAaHlmhE5Hc45YdBF8W1hFrow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+EtLKolBfe5E0BUFi9K17aI9+6lEoHQOm7ybnsFK60cpcVS5wWHDwrPcr+uoU9GXm4/O9UT7CyxzNrHOt7El8h/tOOQWQT0Sk1N2snh4h6llcsyE9wdBmxcgISQooh/+QtDsXzufVlFl8cdH+3JXMr7t18cVB+CCUHvb2GYXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O42pm27i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O42pm27i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F851F000E9;
	Thu, 13 Aug 2026 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639986;
	bh=Kl/jmZVIL4SB1peSqKcfd75nHoFx4C0sgfY8gHPdx7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O42pm27im3EQtpmhg+aAY/4eN1AV4on42GtqBsJtisHsQZgdvSdKkQlzZHO+eaELn
	 a17weWr4ITEX/Z3rWlbS2RgjWf0nE9ONDIxwn+cnRfWPu/u+rYc9l6haJkpT35dydZ
	 C1mOpxrtZedrbhzrEk+ETn4sf0e9+AoaR3fTs+b2kLCVdTaQFjrvO8nkqN0gUY0yIF
	 UiaIZoauRtZPHLRt0Ph5Qc79CpfvoV6IY9535GjeDXL6dUl5i3R1WMlQW2Gdl2pKe9
	 K9a3V3a5pWxx93uPVcchzyRZDx3qvdkWK7sBW6OQBJZzDBazq2c1Umd74SwpoX0kUc
	 qm5lCgKREx4aA==
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
Subject: [PATCH v3 5/5] rust: pci: expose the allocated interrupt type
Date: Thu, 13 Aug 2026 18:52:05 +0200
Message-ID: <20260813165234.620555-6-dakr@kernel.org>
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

Add irq_type() on IrqVectorRegistration and IrqVector, wrapping the new
pci_irq_type() C function. A driver whose interrupt acknowledgment
depends on the type (MSI-X vs MSI vs INTx) queries it here rather than
assuming which type the PCI core selected.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/pci.c     |  5 +++++
 rust/kernel/pci/irq.rs | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index b6d1699ee3eb..6741046ec1c0 100644
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
@@ -90,6 +100,12 @@ unsafe fn new(request: IrqRequest<'a>, reg: &'a IrqVectorRegistration<'a>) -> Se
     pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
         self.reg
     }
+
+    /// Returns the interrupt type the PCI core selected for this vector's allocation.
+    #[inline]
+    pub fn irq_type(&self) -> IrqType {
+        self.reg.irq_type()
+    }
 }
 
 impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {
@@ -122,6 +138,13 @@ pub fn len(&self) -> usize {
         self.len.get()
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
     /// Returns [`EINVAL`] if the `index` is out of bounds for the length reported by
-- 
2.55.0


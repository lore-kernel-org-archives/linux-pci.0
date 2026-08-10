Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964453B6BF5;
	Mon, 10 Aug 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402224; cv=none; b=hpYVefXqBXzFczqcd+1hEav1SexiILhk6THvwTvsgtz18DHvK303f7EIYtit/9fpPR67wqQMBmqhIPd8bN8H2YGQr9CzYKgWnPL3HUOfW7z80f4uH1Evkad/N7sFV+lzY0l3Fhx/CRMVd/zKWoxKT+n/ynJtfpLC9dNpcu3Jhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402224; c=relaxed/simple;
	bh=XqQVkPra4BwUQnNOr+Dt76+oCEZeQ2AKrFE4hCCngkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck/pxtugV2gzEF+XaQ5og1A4LkIPNtW8tYDQMhGG0PdzB2cDrlwCtMxdEUXFE7eneqQtM1E0PbVu7ecmrA+l5mIA1D4O+U73XKGaJKxh2Of5gej6XbY3yF4Wo+jzpZLn1QaDZmUBLyfesQzvUw56p7Adh00Ze6eQgBEW82425Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3F9aYJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3F9aYJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D361F000E9;
	Mon, 10 Aug 2026 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402223;
	bh=2RRlOwVysOpjD6022bpwR8qZ3gP+k7XooabvZKC9zOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3F9aYJHb0zWBxS7H5baZ7K3WRZR1XLay4HIAJAdWJ76ANvVHu3kpL57oWyi3i5UF
	 SD79QYk3uPItB+9e9aGlDQrvSQ3EpAyLT4dsSPf4Xw0co24mADX0LAP6KVe9cPSzhq
	 TYfD3RtmAKLu1LYKgCjaBqM+167VmXVYVcFYmE5m9Pftqe7gkCNQX7wFu9jn8WL5YU
	 jebI3iYf6QTVtNnw8+F0c53/PEyuCLU+vy499NySQO6ErAU4Fo6ffwNcu/pAjJhcD1
	 t4fzgDovce866zWWllO6I5VRtJL+FCmOQWFhHu4V/6FFrB5nzoY1cl76k5Z8/hfCAl
	 p7j0hpF5D4OZA==
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
Subject: [PATCH 5/5] rust: pci: expose the allocated interrupt type
Date: Tue, 11 Aug 2026 00:47:44 +0200
Message-ID: <20260810224800.2314458-6-dakr@kernel.org>
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

Add irq_type() on IrqVectorRegistration, wrapping the new pci_irq_type()
C function. A driver whose interrupt acknowledgment depends on the type
(MSI-X vs MSI vs INTx) queries it here rather than assuming which type
the PCI core selected.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/pci.c     |  5 +++++
 rust/kernel/pci/irq.rs | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

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
index d69ab6435a80..618310e4535c 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -36,6 +36,16 @@ const fn as_raw(self) -> u32 {
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
@@ -99,6 +109,13 @@ pub fn vector_count(&self) -> usize {
         self.count.get()
     }
 
+    /// Returns the interrupt type the PCI core selected for this allocation.
+    #[inline]
+    pub fn irq_type(&self) -> IrqType {
+        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
+        IrqType::from_raw(unsafe { bindings::pci_irq_type(self.dev.as_raw()) })
+    }
+
     /// Resolves the vector at `index` to an [`IrqRequest`].
     ///
     /// The returned [`IrqRequest`] borrows from this registration, ensuring the vector allocation
-- 
2.55.0


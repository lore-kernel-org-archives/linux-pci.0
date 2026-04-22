Received: from mail-m19731107.qiye.163.com (mail-m19731107.qiye.163.com [220.197.31.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6331E0B9C
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821472; cv=none; b=OGgDnS6ePWsi+uitDVONcrmNy5MfH474uBplQBuwSSsyZERag10If1gIkkilxWLh/9Xp+e3b/ID1fhv80bsxXon1TKPYxyUwjH6TuxlLL8Ac8RoLJQvFLdRAsVX6q8MwJjGOoCJWnqmWmZvuHhutvs2YQ4Gnv6vzBquTiSd/6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821472; c=relaxed/simple;
	bh=mgOROuN7KOw/IJn45SaXnkxOyF2I9YikrzO2sZIeVhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=umtWqEbxHI4AQoIwRXy+fPOub+YPRGrmPFuMJdX6A+i5k2tUeELF3I9ZwV9BUokbaAY47RwPGHzQF0enq3Rf9A3W4sIXGkpygrkcGmticj3G4XSJZoJo8H7cGi4+7ISQJ8AYfplWVgZsQ1KIlOsV+7NtP42xAqM+kuonqeYnsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QKxEZYXx; arc=none smtp.client-ip=220.197.31.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QKxEZYXx"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba07bb34;
	Wed, 22 Apr 2026 09:25:48 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/3] PCI/MSI: Add Devres managed IRQ vectors allocation
Date: Wed, 22 Apr 2026 09:25:25 +0800
Message-Id: <1776821127-234830-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9db2cb1a0309cckunm4d4f8bca15def1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk1PVksZTB1ISExJGEwYHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QKxEZYXxt4Fp30R+T3roc63r1fbAbRfy1tF/S/dJ0Iyp6KszXaXKvWUsNXRfMVEYuRXxWJmTKOU3qfgq8XcJLlesuVr1ohcH1ypQXzSdQSaY8vy0pXStXPDz9UmJwGYADuM9K92vo2PkOhOCpS2GpyRQrRiHFpymrrRbBO7dWWM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HxWUyPlDcbq4Pzt6slUkVSSbA8U7i/j7+dvZ/xOYPJg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCI/MSI subsystem suffers from a long-standing design issue where
the implicit, automatic management of IRQ vectors by the devres
framework conflicts with explicit driver cleanup, leading to ambiguous
ownership and potential resource management bugs.

Historically, pcim_enable_device() not only manages standard PCI
resources (BARs) via devres but also implicitly sets the is_msi_managed
flag if calling pci_alloc_irq_vectors*(). This registers pcim_msi_release()
as a cleanup action, creating a hybrid ownership model.

This ambiguity causes problems when drivers follow a common but
hazardous pattern:
1. Using pcim_enable_device() (which implicitly marks IRQs as managed)
2. Explicitly calling pci_alloc_irq_vectors() for IRQ allocation
3. Also calling pci_free_irq_vectors() in error paths or remove routines

In this scenario, the devres framework may attempt to free the IRQ
vectors a second time upon device release, leading to double-free
issues. Analysis of the tree shows this hazardous pattern exists
in multiple drivers, while 35 other drivers correctly rely solely
on the implicit cleanup.

To resolve this ambiguity, introduce explicit managed APIs for IRQ
vector allocation:
- pcim_alloc_irq_vectors()
- pcim_alloc_irq_vectors_affinity()

These functions are the devres-managed counterparts to
pci_alloc_irq_vectors[_affinity](). Drivers that wish to have
devres-managed IRQ vectors should use these new APIs instead.

The long-term goal is to convert all drivers which use pcim_enable_device()
as well as pci_alloc_irq_vectors[_affinity]() to use these managed
functions, and eventually remove the problematic hybrid management
pattern from pcim_enable_device() and pcim_setup_msi_release() entirely.
This patch lays the foundation by introducing the APIs.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- Rework the commit message and function doc (Philipp)
- Remove setting is_msi_managed flag from new APIs (Philipp)

Changes in v2:
- Rebase
- Introduce patches only for PCI subsystem to convert the API

 drivers/pci/msi/api.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   | 22 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b..53b3966 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -297,6 +297,57 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
+ * pcim_alloc_irq_vectors - devres managed pci_alloc_irq_vectors()
+ * @dev: the PCI device to operate on
+ * @min_vecs: minimum number of vectors required (must be >= 1)
+ * @max_vecs: maximum (desired) number of vectors
+ * @flags: flags for this allocation, see pci_alloc_irq_vectors()
+ *
+ * This is a device resource managed version of pci_alloc_irq_vectors().
+ * Interrupt vectors are automatically freed on driver detach by the
+ * devres. Drivers do not need to explicitly call pci_free_irq_vectors().
+ *
+ * Returns number of vectors allocated (which might be smaller than
+ * @max_vecs) on success, or a negative error code on failure.
+ */
+int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			   unsigned int max_vecs, unsigned int flags)
+{
+	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					       flags, NULL);
+}
+EXPORT_SYMBOL(pcim_alloc_irq_vectors);
+
+/**
+ * pcim_alloc_irq_vectors_affinity - devres managed pci_alloc_irq_vectors_affinity()
+ * @dev: the PCI device to operate on
+ * @min_vecs: minimum number of vectors required (must be >= 1)
+ * @max_vecs: maximum (desired) number of vectors
+ * @flags: flags for this allocation, see pci_alloc_irq_vectors()
+ * @affd: optional description of the affinity requirements
+ *
+ * This is a device resource managed version of pci_alloc_irq_vectors_affinity().
+ * Interrupt vectors are automatically freed on driver detach by the devres
+ * machinery. Drivers do not need to explicitly call pci_free_irq_vectors().
+ *
+ * The function sets dev->is_msi_managed to true before allocating
+ * vectors. If allocation fails and is_msi_managed was not already set
+ * before calling this function, the flag is restored to false. This
+ * ensures proper state cleanup on failure.
+ *
+ * Returns number of vectors allocated (which might be smaller than
+ * @max_vecs) on success, or a negative error code on failure.
+ */
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, affd);
+}
+EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
+
+/**
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c44545..3716c67 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
 
+int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags);
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd);
+
 bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
 struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
 				     const struct irq_affinity_desc *affdesc);
@@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline int
+pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+			       unsigned int max_vecs, unsigned int flags,
+			       struct irq_affinity *aff_desc)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, aff_desc);
+}
+static inline int
+pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
+
 static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
 { return false; }
 static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
-- 
2.7.4


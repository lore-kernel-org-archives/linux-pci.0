Received: from mail-m3280.qiye.163.com (mail-m3280.qiye.163.com [220.197.32.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAE255E43
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397353; cv=none; b=e9bd+4nKLLIZ1LKjo75smPmgabVeAn0p8y8ltv23Fc+xioy+9jI+0gGQmCU4kdvLRZrtofjMUdzVEHX7DBBNtv5D7/7k+u/BWzCJBkkAjPMEvF//TlWup4JjMlxO99/fCpJ6hY7i+FDflKLYZd3+02WPjbXLK071EDiPnexCQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397353; c=relaxed/simple;
	bh=9ITrv80iyejeDZV2huUwR48BTZzvMywKxp5Rm/kU+pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IzZu4LBMqII67BfszBb7tsAdsAsDghp59iWFxT2Wi8qVvtlht8C391TfoAi+URh1WI91rwD+MjQhjQYlWwx5cNz0LmA8vVmGKC83DzjifL+BtER8oRw3auATHCtt8eA+xdFLdR3BUcg3kDnCm7oOaaxlixuYN7Cfdww+N/4yO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OXkUKeNI; arc=none smtp.client-ip=220.197.32.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OXkUKeNI"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b1199b31;
	Fri, 17 Apr 2026 10:26:42 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors allocation
Date: Fri, 17 Apr 2026 10:26:05 +0800
Message-Id: <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d99430ef609cckunm63489ccb2f7434
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhoYSVYeTx1MQ0lNQk0dGUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OXkUKeNIk35zFiF4hTY8FMM5N6WoHAfEG/vkz7gECfe/YnfRcCDmsZKVAU9pySPFjBMdrIKxLYh5ofyrfwfImUAmgo/Oq3AvgJjn73FJy40Yc+0BPWyMF+dIlADchPBXK5EpKisAY1QiX7r6U67IaWKiBHJWcSflQX/ZrfP4tbk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=eyfqmoHR3fotEgixzCzTpdRmQvA3RmfAmT0sWYcvMIs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
pci device drivers which rely on the devres machinery to help cleanup the IRQ
vectors.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2: None

 drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
 include/linux/pci.h   | 22 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b..2362fca 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -297,6 +297,32 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
+ * pcim_alloc_irq_vectors() - devres managed pci_alloc_irq_vectors()
+ * Interrupt vectors are automatically freed by the devres machinery
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
+ * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vectors_affinity()
+ * Interrupt vectors are automatically freed by the devres machinery
+ */
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	dev->is_msi_managed = true;
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


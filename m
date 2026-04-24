Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226536C9F4
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017577; cv=none; b=jItA+l8uFGbHktvbb7bWo5Kc42CjICe32hw6aPM4+8hoCj1yP9vev9TuGE3RN1U107zhqxQ3wm/6g8vznmGXG5E/hLkxnKYmRWeBh0svwjj4yYICAcSdFlEaARn20Sw1jO3bAHIvSKEAixEmyCEfq0ZFXalBpP+SgWRdboNCueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017577; c=relaxed/simple;
	bh=vK2gtdOOrsNZTYX+kl0HnKmgj3th1i3V+R9vgOBBAwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OajTKuQlt4mE8GfwZHTsNxkkrytl65dSQgxUJgXNQBx4j9fMfQplp6pCuKXciai2s7+pOzD6giYQ6uE7cLjfw0EVnaYzpysoCADhoOZFeqkSl6bG3a8cDRyf4usQnJOkIdSW2PMN6gx0w8QHF0ORZo7xAdvG2JUd3n6P1oYx9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bY8IXweD; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bY8IXweD"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c02053a3;
	Fri, 24 Apr 2026 15:59:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 5/7] PCI/MSI: Add Devres managed IRQ vectors allocation
Date: Fri, 24 Apr 2026 15:57:38 +0800
Message-Id: <1777017460-243543-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe80040f09cckunm66d640875ec20
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU8YVk1CTU5PGR9CGksdS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bY8IXweDRW8Oxe2OSVX+VEBUeffGJcYcHtpvGJdZ81lYo8wym/JYU9sFsdwLqlqpFfMXbaRW6BQabhxdJa+plfpNb0/3CDXM8zQPwlzA35vi2pIbFfaLMp9iCFDwHR0zx8g4VLksQZz3TepCuXKB2nRDdlsIfw6TfgAkANxPPz0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=U7phM1w+8/dSJ0SfACj/OhUZrbuShDU5P7KWiVgxgiA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

There is a long-standing design ambiguity in the PCI/MSI subsystem
regarding the management of IRQ vectors. Currently, the management
operates in a "hybrid" mode. Sometimes it's handled by devres but
sometimes not, creating potential for resource management bugs.

Historically, pcim_enable_device() implicitly triggers automatic IRQ
vector management when calling pci_alloc_irq_vectors[_affinity], as
pcim_enable_device() sets the is_managed flag, thus pcim_msi_release()
will register a cleanup action. However, using pci_enable_device()
will not make pci_alloc_irq_vectors[_affinity] register a cleanup
action.

This ambiguity causes problems when drivers follow a common but
hazardous pattern:
1. Using pcim_enable_device() (which implicitly marks IRQs as managed)
2. Explicitly calling pci_alloc_irq_vectors() for IRQ allocation
3. Also calling pci_free_irq_vectors() in error paths or remove routines

In this scenario, the devres framework may attempt to free the IRQ
vectors a second time upon device release, leading to double-free
issues. Analysis of the tree shows this hazardous pattern exists
in multiple drivers, while 37 other drivers correctly rely solely
on the implicit cleanup.

To resolve this ambiguity, introduce explicit managed APIs for IRQ
vector allocation:
- pcim_alloc_irq_vectors()
- pcim_alloc_irq_vectors_affinity()

These functions are the devres-managed counterparts to
pci_alloc_irq_vectors[_affinity](). Drivers that wish to have
devres-managed IRQ vectors should use these new APIs instead.

The long-term goal is to convert all drivers which use pcim_enable_device()
in combination with pci_alloc_irq_vectors[_affinity]() to use these managed
functions, and eventually remove the problematic hybrid management
pattern from pcim_enable_device() and pcim_setup_msi_release() entirely.
This patch lays the foundation by introducing the APIs.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- Rework to create dedicated devres-managed function (Philipp)

Changes in v3:
- Rework the commit message and function doc (Philipp)
- Remove setting is_msi_managed flag from new APIs (Philipp)

Changes in v2:
- Rebase
- Introduce patches only for PCI subsystem to convert the API

 drivers/pci/msi/api.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   | 22 ++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b..405da7b 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -297,6 +297,90 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
+ * pcim_alloc_irq_vectors - devres managed pci_alloc_irq_vectors()
+ * @dev: the PCI device to operate on
+ * @min_vecs: minimum number of vectors required (must be >= 1)
+ * @max_vecs: maximum (desired) number of vectors
+ * @flags: flags for this allocation, see pci_alloc_irq_vectors()
+ *
+ * This is a device resource managed version of pci_alloc_irq_vectors().
+ * Interrupt vectors are automatically freed on driver detach by devres.
+ * Drivers MUST NOT call pci_free_irq_vectors().
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
+ * Interrupt vectors are automatically freed on driver detach by devres.
+ * Drivers MUST NOT call pci_free_irq_vectors().
+ *
+ * Returns number of vectors allocated (which might be smaller than
+ * @max_vecs) on success, or a negative error code on failure.
+ */
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				    unsigned int max_vecs, unsigned int flags,
+				    struct irq_affinity *affd)
+{
+	struct irq_affinity msi_default_affd = {0};
+	int nvecs = -ENOSPC;
+
+	if (flags & PCI_IRQ_AFFINITY) {
+		if (!affd)
+			affd = &msi_default_affd;
+	} else {
+		if (WARN_ON(affd))
+			affd = NULL;
+	}
+
+	if (flags & PCI_IRQ_MSIX) {
+		nvecs = __pcim_enable_msix_range(dev, NULL, min_vecs, max_vecs,
+						 affd, flags);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	if (flags & PCI_IRQ_MSI) {
+		nvecs = __pcim_enable_msi_range(dev, min_vecs, max_vecs, affd);
+		if (nvecs > 0)
+			return nvecs;
+	}
+
+	/* use INTx IRQ if allowed */
+	if (flags & PCI_IRQ_INTX) {
+		if (min_vecs == 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				kfree(irq_create_affinity_masks(1, affd));
+			pci_intx(dev, 1);
+			return 1;
+		}
+	}
+
+	return nvecs;
+}
+EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
+
+/**
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c44545..6eab553 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
 
+int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			   unsigned int max_vecs, unsigned int flags);
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				    unsigned int max_vecs, unsigned int flags,
+				    struct irq_affinity *affd);
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


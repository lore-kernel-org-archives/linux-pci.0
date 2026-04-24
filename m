Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058511F3BAC
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018571; cv=none; b=bHb3XIPOn0RxA4wECcZIgaPVw1f42ms+OEnTsWCtYrrdK60kMrOvFiT7OlVjFkwjqq4ioM59AYHVULWS5Xu6htobGBrcPo0dOP+jBxvs+YvsTeDnvteewTLkPde9yaukllSfRw3I++v1230gyYZa/uWgP4mYKyQd/d9Eg+18VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018571; c=relaxed/simple;
	bh=/WLmShfTe09UWkzARJLXYwpdw4V4ubJdJX8bzAimaTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AqiGov9TMud95nRq4U9unA+4/UtlRcdMFHDNaAROJJhne9ncEY8pElLIEMf7iFhIy/cQdQVLmTZt6u1nEURRr0Wwn3hFUZn8PhYQX4na0HahzpfIQ0fj0NAJV9BDVTqaFVBAZ1Ps16kunSaUuFRXDquDp0i2xhFfZ8rtxFWYjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kV+ImfAB; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kV+ImfAB"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c0205330;
	Fri, 24 Apr 2026 15:58:53 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 4/7] PCI/MSI: Introduce __pcim_enable_msix_range()
Date: Fri, 24 Apr 2026 15:57:37 +0800
Message-Id: <1777017460-243543-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe7fb4aa09cckunm66d640875eb88
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUgZVkpMSkgdTRpLSkNNSlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=kV+ImfABC4r83H00yEIwQYw9ay6IYjhyT4tdOY1E74JcBwMONHI8S6gqUOMRNEFaXfjVYeedD9OWdTLVDBhym6jj1dV3j2GQDampBipoWhgckyi9DG3YNpMMpnWKp5ABmM5S6WQIZnzIPpU1dCbFeKLFIPZ/j19xeF8ZambYmbI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tUGBWeaNM4DC0fKMSuIkB31wERPflv0/PrY+shHbQpg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Introduce __pcim_enable_msix_range(), a devres-managed variant of
__pci_enable_msix_range(). Similar to the previously added MSI variant,
this function provides automatic cleanup of MSI-X interrupts via devres,
reducing the risk of resource leaks and simplifying driver error handling.

This function is particularly useful for drivers that already use
pcim_enable_device() and want consistent devres management for all
PCI resources, including MSI-X interrupts.

Drivers can replace calls to __pci_enable_msix_range() with
__pcim_enable_msix_range() to benefit from automatic cleanup without
changing their core logic. The flags parameter (e.g., PCI_IRQ_VIRTUAL)
is fully supported and passed through to the underlying functions.

This completes the set of devres-managed MSI/MSI-X allocation functions,
providing a consistent API for driver authors who prefer automatic
resource management.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/msi/msi.c | 22 ++++++++++++++++++++++
 drivers/pci/msi/msi.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 0aaff57..8fdf40d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -930,6 +930,28 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, affd);
 }
 
+int __pcim_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			     int minvec, int maxvec, struct irq_affinity *affd,
+			     int flags)
+{
+	int hwsize, nvec, rc;
+
+	hwsize = pci_msix_range_alloc(dev, entries, minvec,
+				      maxvec, flags, &nvec);
+	if (hwsize < 0)
+		return hwsize;
+
+	rc = msi_setup_device_data(&dev->dev);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (rc)
+		return rc;
+
+	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, affd);
+}
+
 void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 81c6b099..e6364a8 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -97,6 +97,8 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct i
 int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
 			    int maxvec,  struct irq_affinity *affd, int flags);
+int __pcim_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
+			     int maxvec,  struct irq_affinity *affd, int flags);
 void __pci_restore_msi_state(struct pci_dev *dev);
 void __pci_restore_msix_state(struct pci_dev *dev);
 
-- 
2.7.4


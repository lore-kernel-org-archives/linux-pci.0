Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F01314D34
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018508; cv=none; b=a9pvZWvrXofBIztWrpIhuB0OqU8j4lALTPd2msKfVuN/IN3dA365VkN12ZAzRA3oih09q5VTVf9SlT97TU3DBp/XyCfAY09aElwnJQ35neSXgy6vQrpwewgwVzFdfdYvh5oUGelawOsMLs6yNxW6nagpy1BpVzX1cAN1eSTXApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018508; c=relaxed/simple;
	bh=W+kK7r7LveBgNBQC72NOeqgz4hV3qFGCsuqQzejqHXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iTIK32VG4WlId1mF02tNby1vyWhdam3hpJvgK/NeNWDSKLhWF09MEmfNWggprx74sEd9jr6drGv+wNTCxpkvyIAKJm8H5rDFVdIxgNPCbptxfbTWiLLjD28PRghU36xy1BGUJg4nFkMX5woS9HiyyYEmJ59Qo46WnP1i6N2JhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QxiWhGir; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QxiWhGir"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c02052a1;
	Fri, 24 Apr 2026 15:58:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 3/7] PCI/MSI: Introduce __pcim_enable_msi_range()
Date: Fri, 24 Apr 2026 15:57:36 +0800
Message-Id: <1777017460-243543-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe7f5b7009cckunm66d640875eac0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk5OVkgYS0MZGh1CTkpOSlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=QxiWhGir9DGlbp2RTIJMDv/yPic3147goPsX4DLiBwxs1MIG5oBX5R1B4d4szHHOlg0kT7VGEeb/sKEWJK0fokPQZriBfvybLkFv1AdmX+qfFMpvcrFhckfG9lwethhK/Ys7hp1ldaAXFtlhFaQ8IBF6BZS7uaf4GawAjUzPkiQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Gxg7934kII0Uyamt7yOZlWU8O9tnaRuI4ujeJUpRmZE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Introduce __pcim_enable_msi_range(), a devres-managed variant of
__pci_enable_msi_range(). The new function provides automatic cleanup
of MSI interrupts via devres, reducing the risk of resource leaks and
simplifying driver error handling.

This function is particularly useful for drivers that already use
pcim_enable_device() and want consistent devres management for all
PCI resources, including MSI interrupts.

Drivers can replace calls to __pci_enable_msi_range() with
__pcim_enable_msi_range() to benefit from automatic cleanup without
changing their core logic.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/msi/msi.c | 20 ++++++++++++++++++++
 drivers/pci/msi/msi.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 5c196c2..0aaff57 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -499,6 +499,26 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
 }
 
+int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			    struct irq_affinity *affd)
+{
+	int nvec, rc;
+
+	nvec = pci_msi_range_alloc(dev, minvec, maxvec);
+	if (nvec < 0)
+		return nvec;
+
+	rc = msi_setup_device_data(&dev->dev);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (rc)
+		return rc;
+
+	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
+}
+
 /**
  * pci_msi_vec_count - Return the number of MSI vectors a device can send
  * @dev: device to report about
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b3..81c6b099 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -94,6 +94,7 @@ void pci_msi_shutdown(struct pci_dev *dev);
 void pci_msix_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
+int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
 			    int maxvec,  struct irq_affinity *affd, int flags);
 void __pci_restore_msi_state(struct pci_dev *dev);
-- 
2.7.4


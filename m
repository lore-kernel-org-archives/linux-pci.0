Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33950 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932205AbbDJWza (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:55:30 -0400
Received: by iedfl3 with SMTP id fl3so32537463ied.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:55:29 -0700 (PDT)
Subject: [PATCH v6 10/10] PCI/MSI: Remove unused pci_msi_off()
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:55:27 -0500
Message-ID: <20150410225527.20848.88717.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_msi_off() is unused, so remove it.

Removes the exported symbol pci_msi_off().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |   33 ---------------------------------
 include/linux/pci.h |    1 -
 2 files changed, 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8dcc04..3d938a7d3b04 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3096,39 +3096,6 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
-/**
- * pci_msi_off - disables any MSI or MSI-X capabilities
- * @dev: the PCI device to operate on
- *
- * If you want to use MSI, see pci_enable_msi() and friends.
- * This is a lower-level primitive that allows us to disable
- * MSI operation at the device level.
- */
-void pci_msi_off(struct pci_dev *dev)
-{
-	int pos;
-	u16 control;
-
-	/*
-	 * This looks like it could go in msi.c, but we need it even when
-	 * CONFIG_PCI_MSI=n.  For the same reason, we can't use
-	 * dev->msi_cap or dev->msix_cap here.
-	 */
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
-		control &= ~PCI_MSI_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
-	}
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
-		control &= ~PCI_MSIX_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
-	}
-}
-EXPORT_SYMBOL_GPL(pci_msi_off);
-
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
 {
 	return dma_set_max_seg_size(&dev->dev, size);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a34df456faf2..ef15f91207b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -970,7 +970,6 @@ void pci_intx(struct pci_dev *dev, int enable);
 bool pci_intx_mask_supported(struct pci_dev *dev);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
-void pci_msi_off(struct pci_dev *dev);
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size);
 int pci_set_dma_seg_boundary(struct pci_dev *dev, unsigned long mask);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);


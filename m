Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49165 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB13 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:29 -0500
Received: by mail-pd0-f179.google.com with SMTP id y13so2751972pdi.10
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:29 -0800 (PST)
Subject: [PATCH v2 06/12] PCI: Remove unused pci_vpd_truncate()
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:27:26 -0700
Message-ID: <20140111012726.14505.74201.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts db5679437a2b ("PCI: add interface to set visible size of
VPD"), removing this interface:

    pci_vpd_truncate()

[bhelgaas: split to separate patch, also remove prototype from pci.h]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   24 ------------------------
 include/linux/pci.h  |    1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 0857ca981fae..7f8b78c08879 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -381,30 +381,6 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 }
 
 /**
- * pci_vpd_truncate - Set available Vital Product Data size
- * @dev:	pci device struct
- * @size:	available memory in bytes
- *
- * Adjust size of available VPD area.
- */
-int pci_vpd_truncate(struct pci_dev *dev, size_t size)
-{
-	if (!dev->vpd)
-		return -EINVAL;
-
-	/* limited by the access method */
-	if (size > dev->vpd->len)
-		return -EINVAL;
-
-	dev->vpd->len = size;
-	if (dev->vpd->attr)
-		dev->vpd->attr->size = size;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_vpd_truncate);
-
-/**
  * pci_cfg_access_lock - Lock PCI config reads/writes
  * @dev:	pci device struct
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index efd0b8b67705..bf1f385bf14d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1009,7 +1009,6 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-int pci_vpd_truncate(struct pci_dev *dev, size_t size);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);


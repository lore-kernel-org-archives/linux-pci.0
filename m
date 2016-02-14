Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:44178
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751476AbcBNWIo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2016 17:08:44 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jayachandran C <jchandra@broadcom.com>
Subject: [RFC PATCH 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
Date: Mon, 15 Feb 2016 03:35:00 +0530
Message-Id: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a new flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS to indicate bridges
that should not be considered during DMA alias search. This is
to support hardware (in this case Broadcom Vulcan PCIe subsystem)
that has internal bridges which have either missing or wrong PCIe
capabilities.

Update the function pci_for_each_dma_alias() to skip bridges with
this flag set.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---

This patch is an RFC, if there is a better way to do this, please
let me know.

Thanks,
JC.

 drivers/pci/search.c | 2 ++
 include/linux/pci.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a20ce7d..e5296aa 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -55,6 +55,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 			continue;
 
 		tmp = bus->self;
+		if (tmp->dev_flags & PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS)
+			continue;
 
 		/*
 		 * PCIe-to-PCI/X bridges alias transactions from downstream
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..b4d8215 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -182,6 +182,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
 	/* Get VPD from function 0 VPD */
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	/* Bridge should be ignored for alias search  */
+	PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS = (__force pci_dev_flags_t) (1 << 9),
 };
 
 enum pci_irq_reroute_variant {
-- 
1.9.1


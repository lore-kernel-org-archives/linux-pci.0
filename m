Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58966 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965093AbcAZKcV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 05:32:21 -0500
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	dwmw2@infradead.org, jroedel@suse.de, jacek.lawrynowicz@intel.com
Subject: [PATCH v2 2/2] pci: Add DMA alias quirk for mic_x200_dma
Date: Tue, 26 Jan 2016 11:31:50 +0100
Message-Id: <1453804310-12946-2-git-send-email-jacek.lawrynowicz@intel.com>
In-Reply-To: <1453804310-12946-1-git-send-email-jacek.lawrynowicz@intel.com>
References: <1453804310-12946-1-git-send-email-jacek.lawrynowicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
be added as aliases to the DMA device in order to allow buffer access
when IOMMU is enabled.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b094061..bc23bc8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3703,6 +3703,21 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled.
+ */
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
+{
+	if (iommu_present(pdev->dev.bus)) {
+		pci_enable_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
+		pci_enable_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
+		pci_enable_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
-- 
2.1.4


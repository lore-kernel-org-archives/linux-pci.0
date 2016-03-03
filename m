Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41637 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbcCCOx0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 09:53:26 -0500
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
To: helgaas@kernel.org
Cc: jroedel@suse.de, dwmw2@infradead.org, alex.williamson@redhat.com,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Subject: [PATCH v5 5/6] PCI: Add DMA alias quirk for mic_x200_dma
Date: Thu,  3 Mar 2016 15:53:20 +0100
Message-Id: <1457016800-11903-1-git-send-email-jacek.lawrynowicz@intel.com>
In-Reply-To: <20160224194423.7585.46582.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224194423.7585.46582.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
be added as aliases to the DMA device in order to allow buffer access
when IOMMU is enabled.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Acked-by: David Woodhouse <David.Woodhouse@intel.com>
---
 Updated quirk comment with requirement that aliases have to be matching
 values programmed in the EEPROM. The LUT table on x200 is static so there
 is no need to program it from the driver.

 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 51927a5..e66f09d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3696,6 +3696,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled. Following devfns have to match RIT-LUT table
+ * programmed in the EEPROM.
+ */
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
+{
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
-- 
1.8.3.1


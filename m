Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcBXTo1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:44:27 -0500
Subject: [PATCH v4 5/6] pci: Add DMA alias quirk for mic_x200_dma
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 24 Feb 2016 13:44:23 -0600
Message-ID: <20160224194423.7585.46582.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>

MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
be added as aliases to the DMA device in order to allow buffer access
when IOMMU is enabled.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Acked-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/pci/quirks.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index cf023ea..ac23a30 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3696,6 +3696,19 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled.
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


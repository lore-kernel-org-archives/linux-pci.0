Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:39976
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678AbcBOJah (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2016 04:30:37 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jayachandran C <jchandra@broadcom.com>
Subject: [RFC PATCH 2/2] PCI: Handle Broadcom Vulcan quirks
Date: Mon, 15 Feb 2016 14:56:38 +0530
Message-Id: <1455528398-29311-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1455487501-28630-2-git-send-email-jchandra@broadcom.com>
References: <1455487501-28630-2-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Handle two quirks of the PCI controller on Broadcom's Vulcan processor.
 - Mark internal bridges so that they are skipped during DMA alias
   search.
 - Skip BAR0 resource assignment for internal bridges. The BARs
   of internal bridges should not be assigned from the mem resource
   range.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---

Resending, last patch was missing the Signed-off-by, also fixed the
comment a bit.

JC.

 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..afc186a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3705,6 +3705,27 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * Two levels of bridges in Broadcom Vulcan are not real PCI or PCIe bridges.
+ * These are internal bridges and should not be used for dma alias
+ * calculations. Additionally, the BAR0 of thes bridges should not be
+ * assigned with a mem resource from linux
+ */
+static void quirk_bridge_brcm_vulcan_internal(struct pci_dev *pdev)
+{
+	struct resource *r = &pdev->resource[0];
+
+	/* skip from alias search */
+	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS;
+
+	/* clear BAR0, should not be used from Linux */
+	memset(r, 0, sizeof(*r));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
+				quirk_bridge_brcm_vulcan_internal);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9039,
+				quirk_bridge_brcm_vulcan_internal);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
-- 
1.9.1


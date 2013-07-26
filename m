Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:29097
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757461Ab3GZHdZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 03:33:25 -0400
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] PCI: Add quirk for setting valid class for FSL PCI host bridge
Date: Fri, 26 Jul 2013 15:23:38 +0800
Message-ID: <1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Freescale platform has class code = 0x0b2000, when it boots. This makes
kernel PCI bus code to setup these devices resulting into the following
notice information when trying to enable them:

pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)

This patch adds a ID specific(PCI_VENDOR_ID_FREESCALE & PCI_ANY_ID based)
'early' fixup quirk to replace class code with PCI_CLASS_BRIDGE_PCI as
class. Then the above information disappears.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e85d230..906a04a3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2772,6 +2772,16 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x342e, vtd_mask_spec_errors);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
 #endif
 
+#ifdef CONFIG_FSL_PCI
+static void quirk_freescale_class(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "Setting PCI class for FSL PCI host bridge\n");
+	dev->class = (PCI_CLASS_BRIDGE_PCI << 8) | (dev->class & 0xff);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
+			quirk_freescale_class);
+#endif
+
 static void fixup_ti816x_class(struct pci_dev *dev)
 {
 	/* TI 816x devices do not have class code set when in PCIe boot mode */
-- 
1.7.6.5



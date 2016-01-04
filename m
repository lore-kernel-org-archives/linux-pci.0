Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:60188
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbcADQxW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 11:53:22 -0500
From: Tim Sander <tim@krieglstein.org>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add quirk for Lite-On IT Corp. / Plextor M6e PCI Express
Date: Mon, 04 Jan 2016 17:47:14 +0100
Message-ID: <11003431.x6xHs1WP1I@dabox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

Please consider this patch for the next release. It won't recognize my Plextor
M6e PCIE disk without it. Please cc as i am not on the list.

Signed-off-by: Tim Sander <tim@krieglstein.org>

PCI: Add quirk for Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)
---
 drivers/pci/quirks.c    | 4 ++++
 include/linux/pci_ids.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e32730..93ec5a02 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3620,6 +3620,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
                         PCI_DEVICE_ID_JMICRON_JMB388_ESD,
                         quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
+                        PCI_DEVICE_ID_PLEXTOR_M6E,
+                        quirk_dma_func1_alias);
 
 /*
  * Some devices DMA with the wrong devfn, not just the wrong function.
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..01d8041 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2501,6 +2501,9 @@
 
 #define PCI_VENDOR_ID_ASMEDIA          0x1b21
 
+#define PCI_VENDOR_ID_LITE_ON          0x1c28
+#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
+
 #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
 
-- 
1.9.1



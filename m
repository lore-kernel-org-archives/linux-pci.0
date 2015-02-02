Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:53479
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370AbbBBLfu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 06:35:50 -0500
From: Tim Sander <tim@krieglstein.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
Date: Mon, 02 Feb 2015 12:29:37 +0100
Message-ID: <1561014.NTLJeH8lPH@dabox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


The long name for this device is
Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)

Background: the error description on bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=42679
inspired me to check if my brand new m4 pci ssd could work with a quirk.
Its device representation is not visible before this patch.
After this patch it appears as a normal device. Formatting
and mounting worked so far.

Signed-off-by: Tim Sander <tim@krieglstein.org>
---
 drivers/pci/quirks.c    | 4 ++++
 include/linux/pci_ids.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e52356a..fad7383 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3540,6 +3540,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
                         PCI_DEVICE_ID_JMICRON_JMB388_ESD,
                         quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
+                        PCI_DEVICE_ID_PLEXTOR_M6E,
+                        quirk_dma_func1_alias);
 
 /*
  * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting in
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e63c02a..1607b20 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2487,6 +2487,9 @@
 
 #define PCI_VENDOR_ID_ASMEDIA          0x1b21
 
+#define PCI_VENDOR_ID_LITE_ON          0x1c28
+#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
+
 #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
 
-- 
1.9.1



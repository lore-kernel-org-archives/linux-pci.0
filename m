Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:52236 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933788Ab2J3R0N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Oct 2012 13:26:13 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/2 v2] PCI: add workaround for PLX PCI 9050 bug
Date: Tue, 30 Oct 2012 17:25:53 +0000
Message-Id: <1351617953-4201-1-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
References: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PLX PCI 9050 PCI Target bridge controller has a bug that prevents
its local configuration registers being read through BAR0 (memory) or
BAR1 (i/o) if the base address lies on an odd 128-byte boundary, i.e. if
bit 7 of the base address is non-zero.  This bug is described in the PCI
9050 errata list, version 1.4, May 2005.  It was fixed in the
pin-compatible PCI 9052, which can be distinguished from the PCI 9050 by
checking the revision in the PCI header, which is hard-coded for these
chips.

Workaround the problem by re-allocating the affected regions to a
256-byte boundary.  Note that BAR0 and/or BAR1 may have been disabled
(size 0) during initialization of the PCI chip when its configuration is
read from a serial EEPROM.

Currently, the fix-up has only been used for devices with the default
vendor and device ID of the PLX PCI 9050.  The PCI 9052 shares the same
default device ID as the PCI 9050 but they have different PCI revision
codes.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Use dev_info() to report when quirk applied.
---
 drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7a451ff..2d0d1c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1790,6 +1790,34 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
 			 PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE,
 			 quirk_tc86c001_ide);
 
+/*
+ * PLX PCI 9050 PCI Target bridge controller has an errata that prevents the
+ * local configuration registers accessible via BAR0 (memory) or BAR1 (i/o)
+ * being read correctly if bit 7 of the base address is set.
+ * The BAR0 or BAR1 region may be disabled (size 0) or enabled (size 128).
+ * Re-allocate the regions to a 256-byte boundary if necessary.
+ */
+static void __devinit quirk_plx_pci9050(struct pci_dev *dev)
+{
+	unsigned int bar;
+
+	/* Fixed in revision 2 (PCI 9052). */
+	if (dev->revision >= 2)
+		return;
+	for (bar = 0; bar <= 1; bar++)
+		if (pci_resource_len(dev, bar) == 0x80 &&
+		    (pci_resource_start(dev, bar) & 0x80)) {
+			struct resource *r = &dev->resource[bar];
+			dev_info(&dev->dev,
+				 "Re-allocating PLX PCI 9050 BAR %u to length 256 to avoid bit 7 bug\n",
+				 bar);
+			r->start = 0;
+			r->end = 0xff;
+		}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			 quirk_plx_pci9050);
+
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
-- 
1.7.12.4


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:49723 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759270Ab2J2Okc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Oct 2012 10:40:32 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/2] PCI: add PLX PCI 9050 workaround for some Meilhaus DAQ cards
Date: Mon, 29 Oct 2012 14:40:18 +0000
Message-Id: <1351521618-6818-2-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
References: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Meilhaus ME-2000i and ME-2600i data acquisition cards supported by
the Comedi "me_daq" driver use the PLX PCI 9050 PCI Target bridge chip
affected by the bug that prevents the chip's local configuration
registers being read from BAR0 or BAR1 base addresses that are an odd
multiple of 128 bytes.  Use the PLX PCI 9050 quirk handler for these
devices to re-allocate affected regions to a 256-byte boundary.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e6be56..f9a1b33 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1814,6 +1814,17 @@ static void __devinit quirk_plx_pci9050(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 			 quirk_plx_pci9050);
+/*
+ * The following Meilhaus (vendor ID 0x1402) device IDs (amongst others)
+ * may be using the PLX PCI 9050: 0x0630, 0x0940, 0x0950, 0x0960, 0x100b,
+ * 0x1400, 0x140a, 0x140b, 0x14e0, 0x14ea, 0x14eb, 0x1604, 0x1608, 0x160c,
+ * 0x168f, 0x2000, 0x2600, 0x3000, 0x810a, 0x810b.
+ *
+ * Currently, device IDs 0x2000 and 0x2600 are used by the Comedi "me_daq"
+ * driver.
+ */
+DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2000, quirk_plx_pci9050);
+DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2600, quirk_plx_pci9050);
 
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
-- 
1.7.12.4


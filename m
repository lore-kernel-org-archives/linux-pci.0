Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbcCXTDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Mar 2016 15:03:51 -0400
Subject: [PATCH] PCI: Quirk broken INTx masking on Intel i40e NICs
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, john.ronciak@intel.com,
	linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com
Date: Thu, 24 Mar 2016 13:03:49 -0600
Message-ID: <20160324190328.3880.44785.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All of the i40e (XL710/X710) 10/20/40GbE NICs lack support for
indicating INTx is asserted via the interrupt bit in the PCI status
register.  The DisINTx bit in the command register is functional,
causing these devices to be incorrectly detected as supporting INTx
masking.  Quirk them to properly indicate no INTx masking support.

Device IDs copied from i40e_devids.h.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: John Ronciak <john.ronciak@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/pci/quirks.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..583f040 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3121,6 +3121,39 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
 			 quirk_broken_intx_masking);
 
+/*
+ * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
+ * DisINTx can be set but the interrupt status bit is non-functional.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1572,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1574,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1580,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1581,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1583,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1584,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1585,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1586,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1587,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1588,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1589,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d0,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d1,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d2,
+			 quirk_broken_intx_masking);
+
 static void quirk_no_bus_reset(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56970 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965917AbcKOIAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 03:00:33 -0500
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com, noaos@mellanox.com
Subject: [PATCH v1 1/3] PCI: Use FINAL fixup to mark broken INTx masking
Date: Tue, 15 Nov 2016 09:59:58 +0200
Message-Id: <1479196800-32191-2-git-send-email-noaos@mellanox.com>
In-Reply-To: <1479196800-32191-1-git-send-email-noaos@mellanox.com>
References: <1479196800-32191-1-git-send-email-noaos@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Convert all quirk_broken_intx_masking quirks from HEADER to FINAL.
None of those calls need to be in HEADER but some might need to be
called as FINAL. Moving them all to FINAL will save time during
pci_do_fixups.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c | 72 ++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729f5b1b..85048fdf2474 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3146,53 +3146,53 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
 {
 	dev->broken_intx_masking = 1;
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
-			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0030,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
+			quirk_broken_intx_masking);
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
  *
  * RTL8110SC - Fails under PCI device assignment using DisINTx masking.
  */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
-			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+			quirk_broken_intx_masking);
 
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
  * DisINTx can be set but the interrupt status bit is non-functional.
  */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1572,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1574,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1580,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1581,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1583,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1584,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1585,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1586,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1587,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1588,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1589,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d0,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d1,
-			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d2,
-			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1572,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1574,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1580,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1581,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1583,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1584,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1585,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1586,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1587,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1588,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2,
+			quirk_broken_intx_masking);
 
 static void quirk_no_bus_reset(struct pci_dev *dev)
 {
-- 
1.8.3.1


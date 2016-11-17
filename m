Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbcKQXaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 18:30:21 -0500
Subject: [PATCH v3 3/5] PCI: Convert broken INTx masking quirks from HEADER
 to FINAL
From: Bjorn Helgaas <bhelgaas@google.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com
Date: Thu, 17 Nov 2016 17:30:17 -0600
Message-ID: <20161117233017.2003.43124.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Noa Osherovich <noaos@mellanox.com>

Convert all quirk_broken_intx_masking() quirks from HEADER to FINAL.

The quirk sets dev->broken_intx_masking, which is only used by
pci_intx_mask_supported(), which is not needed until after FINAL
quirks have been run.

[bhelgaas: changelog]
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c |   72 +++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729..85048fd 100644
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


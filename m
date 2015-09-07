Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbbIGELs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Sep 2015 00:11:48 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Pratyush Anand <panand@redhat.com>,
	stable@vger.kernel.org.#.v3.17+,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list),
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH] PCIe: SPEAr13xx: fix dw_pcie_cfg_read/write() usage
Date: Mon,  7 Sep 2015 09:40:30 +0530
Message-Id: <f80c925090a4c0116a9a028c10836685148e1bbd.1441598691.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dw_pcie_cfg_read/write() expects 1st argument 'addr' as a 32 bit word
aligned address, 2nd argument 'where' as the offset within that word(0, 1,
2 or 3) and 3rd argument 'size' is the number of bytes need to be read at
the offset(could be 1, 2 ,4).

SPEAr13xx is using dw_pcie_cfg_read() and dw_pcie_cfg_write() incorrectly.
Without this fix, SPEAr13xx host will never work with  few buggy gen1 card
which connects with only gen1 host and also with any endpoint which would
generate a read request of more than 128 bytes.

Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Pratyush Anand <panand@redhat.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index c49fbdc0f6e4..40862681f010 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -163,34 +163,36 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
+				0, 2, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
+				0, 2, val);
 
-	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 0, 2, 0x104A);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 2, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
-				 &val);
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+					0, 4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCAP, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+						PCI_EXP_LNKCAP, 0, 4, val);
 		}
 
-		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
-				 &val);
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+					0, 2, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
-					  PCI_EXP_LNKCTL2, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+						PCI_EXP_LNKCTL2, 0, 2, val);
 		}
 	}
 
-- 
2.5.0


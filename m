Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
Date: Fri, 14 Jul 2017 14:07:35 +0200
Message-ID: <20170714120735.11993-3-niklas.cassel@axis.com>
In-Reply-To: <20170714120735.11993-1-niklas.cassel@axis.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index 80897291e0fb..7ebfbf6086fe 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -92,34 +92,32 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
+	val = dw_pcie_readw_dbi(pci, exp_cap_off + PCI_EXP_DEVCTL);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_write(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
+	dw_pcie_writew_dbi(pci, exp_cap_off + PCI_EXP_DEVCTL, val);
 
-	dw_pcie_write(pci->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_write(pci->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, 0x104A);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-			     4, &val);
+		val = dw_pcie_readl_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCAP, 4, val);
+			dw_pcie_writel_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP,
+					   val);
 		}
 
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-			     2, &val);
+		val = dw_pcie_readw_dbi(pci, exp_cap_off + PCI_EXP_LNKCTL2);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCTL2, 2, val);
+			dw_pcie_writew_dbi(pci, exp_cap_off + PCI_EXP_LNKCTL2,
+					   val);
 		}
 	}
 
-- 
2.11.0

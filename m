Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:39495 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754003AbdGNMHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jul 2017 08:07:51 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
Date: Fri, 14 Jul 2017 14:07:34 +0200
Message-ID: <20170714120735.11993-2-niklas.cassel@axis.com>
In-Reply-To: <20170714120735.11993-1-niklas.cassel@axis.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f47064e..e30c837c4437 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -145,22 +145,20 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 	}
 
 	if (dra7xx->link_gen == 1) {
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-			     4, &reg);
+		reg = dw_pcie_readl_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCAP, 4, reg);
+			dw_pcie_writel_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP,
+					   reg);
 		}
 
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-			     2, &reg);
+		reg = dw_pcie_readw_dbi(pci, exp_cap_off + PCI_EXP_LNKCTL2);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCTL2, 2, reg);
+			dw_pcie_writew_dbi(pci, exp_cap_off + PCI_EXP_LNKCTL2,
+					   reg);
 		}
 	}
 
-- 
2.11.0

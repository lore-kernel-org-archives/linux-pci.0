Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:60583 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbeCHNdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 08:33:42 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs properly
Date: Thu,  8 Mar 2018 14:33:27 +0100
Message-Id: <20180308133331.19464-3-niklas.cassel@axis.com>
In-Reply-To: <20180308133331.19464-1-niklas.cassel@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since a 64-bit BAR consists of a BAR pair, we need to write to both
BARs in the BAR pair to setup the BAR properly.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 9236b998327f..946bbdf53c4d 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -136,8 +136,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 		return ret;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writel_dbi2(pci, reg, size - 1);
-	dw_pcie_writel_dbi(pci, reg, flags);
+	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
+		dw_pcie_writel_dbi(pci, reg, flags);
+		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
+		dw_pcie_writel_dbi(pci, reg + 4, 0);
+	} else {
+		dw_pcie_writel_dbi2(pci, reg, size - 1);
+		dw_pcie_writel_dbi(pci, reg, flags);
+	}
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
-- 
2.14.2

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:54035 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeC1LvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:51:25 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/12] PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs properly
Date: Wed, 28 Mar 2018 13:50:16 +0200
Message-Id: <20180328115018.31921-12-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since a 64-bit BAR consists of a BAR pair, we need to write to both
BARs in the BAR pair to clear the BAR properly.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index cc4d8381c1dc..4d304e3ccf24 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -28,6 +28,10 @@ static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
+	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
+		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
+	}
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-- 
2.14.2

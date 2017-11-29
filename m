Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdK2Axg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Nov 2017 19:53:36 -0500
From: Stephen Boyd <sboyd@codeaurora.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: Use {upper,lower}_32_bits() macros for clarity
Date: Tue, 28 Nov 2017 16:53:34 -0800
Message-Id: <20171129005334.16425-1-sboyd@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have macros for getting the upper or lower 32 bits of a
number. Use them here to shave a couple lines off the code.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pci/dwc/pcie-designware-host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 157621175147..ae5abfddf8de 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -89,10 +89,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	msi_target = virt_to_phys((void *)pp->msi_data);
 
 	/* program the msi_data */
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			    (u32)(msi_target & 0xffffffff));
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
-			    (u32)(msi_target >> 32 & 0xffffffff));
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4, lower_32_bits(msi_target));
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, upper_32_bits(msi_target));
 }
 
 static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

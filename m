Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbeCVQdX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 12:33:23 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] PCI: pcie-xilinx-nwl: Fix mask value to disable MSIs
Date: Thu, 22 Mar 2018 16:33:17 +0000
Message-Id: <20180322163317.12093-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Compiling the xilinx-nwl driver with sparse checks result in the
following warning:

drivers/pci/host/pcie-xilinx-nwl.c:633:38: sparse: cast truncates bits
from constant value (ffffffff00000000 becomes 0)

Fix it by explicitly writing 0 to mask interrupts instead of relying
on a bogus cast applied to the mask bitwise complement.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 7702d68abbdc..9505bb9649d0 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -632,7 +632,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	 * For high range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
+	nwl_bridge_writel(pcie, 0, MSGF_MSI_MASK_HI);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,  MSGF_MSI_STATUS_HI) &
 			  MSGF_MSI_SR_HI_MASK, MSGF_MSI_STATUS_HI);
@@ -643,7 +643,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	 * For low range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
+	nwl_bridge_writel(pcie, 0, MSGF_MSI_MASK_LO);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO) &
 			  MSGF_MSI_SR_LO_MASK, MSGF_MSI_STATUS_LO);
-- 
2.15.0

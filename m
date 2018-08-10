Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 4/4] PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
Date: Fri, 10 Aug 2018 21:09:40 +0530
Message-ID: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
register platform provided IRQ number to kernel AER service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840..285647b 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -22,6 +22,7 @@
 #include <linux/irqchip/chained_irq.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
@@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	return 0;
 }
 
+int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
+			   int plat_mask)
+{
+	struct nwl_pcie *pcie;
+
+	pcie = pci_host_bridge_priv(bridge);
+	if (plat_mask & PCIE_PORT_SERVICE_AER) {
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
+		plat_mask &= ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
+	}
+
+	return plat_mask;
+}
+
 static const struct of_device_id nwl_pcie_of_match[] = {
 	{ .compatible = "xlnx,nwl-pcie-2.11", },
 	{}
@@ -880,6 +895,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &nwl_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
1.7.1

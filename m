Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36777 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751302AbdH1OXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 10:23:12 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 1/3] PCI: designware: only register MSI controller when MSI irq line is valid
Date: Mon, 28 Aug 2017 16:23:05 +0200
Message-Id: <20170828142307.30061-2-l.stach@pengutronix.de>
In-Reply-To: <20170828142307.30061-1-l.stach@pengutronix.de>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The MSI part of the controller isn't essential, so the host controller can
be registered without the MSI controller being present. This allows the
host to work in PCIe legancy interrupt only mode, if the IRQ line for the
MSI controller is missing.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/dwc/pcie-designware-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index d29c020da082..8494089f088d 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -381,7 +381,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
 		if (!pp->ops->msi_host_init) {
 			pp->irq_domain = irq_domain_add_linear(dev->of_node,
 						MAX_MSI_IRQS, &msi_domain_ops,
@@ -412,7 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
 		bridge->msi = &dw_pcie_msi_chip;
 		dw_pcie_msi_chip.dev = dev;
 	}
-- 
2.11.0

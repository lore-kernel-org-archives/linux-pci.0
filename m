Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 16/22] PCI: designware: update PCI config space remap function
Date: Mon, 27 Mar 2017 10:49:44 +0100
Message-Id: <20170327094954.7162-17-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 5ba3349..d2dd228 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -338,8 +338,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (!pci->dbi_base) {
-		pci->dbi_base = devm_ioremap(dev, pp->cfg->start,
-					resource_size(pp->cfg));
+		pci->dbi_base = devm_ioremap_nopost(dev, pp->cfg->start,
+						    resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
@@ -350,8 +350,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pp->mem_base = pp->mem->start;
 
 	if (!pp->va_cfg0_base) {
-		pp->va_cfg0_base = devm_ioremap(dev, pp->cfg0_base,
-						pp->cfg0_size);
+		pp->va_cfg0_base = devm_ioremap_nopost(dev, pp->cfg0_base,
+						       pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "error with ioremap in function\n");
 			ret = -ENOMEM;
@@ -360,8 +360,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (!pp->va_cfg1_base) {
-		pp->va_cfg1_base = devm_ioremap(dev, pp->cfg1_base,
-						pp->cfg1_size);
+		pp->va_cfg1_base = devm_ioremap_nopost(dev, pp->cfg1_base,
+						       pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
-- 
2.10.0

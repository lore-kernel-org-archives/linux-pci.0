Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:59222 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeDPOiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 10:38:10 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v4 10/10] PCI: dwc: Replace magic number by defines
Date: Mon, 16 Apr 2018 15:37:58 +0100
Message-Id: <f92eb1e94c9233cafb0d14462263e1c02f3d23c2.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace magic numbers by a well known define in order to make the code
human readable and also facilitate the code reusability.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Changes v3->v4:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-host.c | 34 ++++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware.h      |  1 +
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index fc55fde..a7657ab 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -83,18 +83,23 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				    &val);
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
+					(i * MSI_REG_CTRL_BLOCK_SIZE),
+				    4, &val);
 		if (!val)
 			continue;
 
 		ret = IRQ_HANDLED;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val, 32,
-					    pos)) != 32) {
-			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
+		while ((pos = find_next_bit((unsigned long *) &val,
+					    MAX_MSI_IRQS_PER_CTRL,
+					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+			irq = irq_find_mapping(pp->irq_domain,
+					       (i * MAX_MSI_IRQS_PER_CTRL) +
+					       pos);
 			generic_handle_irq(irq);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
+						(i * MSI_REG_CTRL_BLOCK_SIZE),
 					    4, 1 << pos);
 			pos++;
 		}
@@ -157,9 +162,9 @@ static void dw_pci_bottom_mask(struct irq_data *data)
 	if (pp->ops->msi_clear_irq) {
 		pp->ops->msi_clear_irq(pp, data->hwirq);
 	} else {
-		ctrl = data->hwirq / 32;
-		res = ctrl * 12;
-		bit = data->hwirq % 32;
+		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
@@ -180,9 +185,9 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
 	if (pp->ops->msi_set_irq) {
 		pp->ops->msi_set_irq(pp, data->hwirq);
 	} else {
-		ctrl = data->hwirq / 32;
-		res = ctrl * 12;
-		bit = data->hwirq % 32;
+		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] |= 1 << bit;
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
@@ -652,8 +657,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* Initialize IRQ Status array */
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
-				    &pp->irq_status[ctrl]);
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    4, &pp->irq_status[ctrl]);
 
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index fe811db..bee4e25 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -110,6 +110,7 @@
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
+#define MSI_REG_CTRL_BLOCK_SIZE		12
 #define MSI_DEF_NUM_VECTORS		32
 
 /* Maximum number of inbound/outbound iATUs */
-- 
2.7.4

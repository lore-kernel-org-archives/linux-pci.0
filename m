Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50152 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeBWPKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 10:10:40 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com, gustavo.pimentel@synopsys.com
Subject: [PATCH v7 9/9] PCI: dwc: Expand maximum number of IRQs from 32 to 256
Date: Fri, 23 Feb 2018 15:10:32 +0000
Message-Id: <9790c7af149503e03c48ccacfe2d29a456c2c699.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys PCIe Root Complex supports up to 256 IRQs distributed by 8
controller registers.

Having this in mind, the number of the maximum number of IRQs was changed
to 256 and now the number of controllers is calculated based on the number
of vectors used by the specific SoC driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- New patch file.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Change v3->v4:
- Patch renamed from v3-0009 to v4-0010.
- Changed summary line to match the drivers/PCI convention and changelog to
maintain the consistency (thanks Bjorn).
Change v4->v5:
- Nothing changed, just to follow the patch set version.
Change v5->v6:
- Nothing changed, just to follow the patch set version.
Change v6->v7:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-host.c | 12 ++++++++----
 drivers/pci/dwc/pcie-designware.h      | 10 +++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 2dc4941..bcadf82 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -79,11 +79,13 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
-	u32 val;
 	int i, pos, irq;
+	u32 val, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
 
-	for (i = 0; i < MAX_MSI_CTRLS; i++) {
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	for (i = 0; i < num_ctrls; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
 				    &val);
 		if (!val)
@@ -644,13 +646,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
-	u32 val, ctrl;
+	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	dw_pcie_setup(pci);
 
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
 	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
 				    &pp->irq_status[ctrl]);
 	/* setup RC BARs */
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index c77c2e0..074bd14 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -110,13 +110,9 @@
 #define MSI_MESSAGE_DATA_32		0x58
 #define MSI_MESSAGE_DATA_64		0x5C
 
-/*
- * Maximum number of MSI IRQs can be 256 per controller. But keep
- * it 32 as of now. Probably we will never need more than 32. If needed,
- * then increment it in multiple of 32.
- */
-#define MAX_MSI_IRQS			32
-#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
+#define MAX_MSI_IRQS			256
+#define MAX_MSI_IRQS_PER_CTRL		32
+#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
 #define MSI_DEF_NUM_VECTORS		32
 
 /* Maximum number of inbound/outbound iATUs */
-- 
2.7.4

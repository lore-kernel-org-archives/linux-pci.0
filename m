Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60935 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932112AbeCFRyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 12:54:38 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, shawn.guo@linaro.org,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com,
        gustavo.pimentel@synopsys.com
Subject: [PATCH v11 3/4] PCI: dwc: Expand maximum number of MSI IRQs from 32 to 256
Date: Tue,  6 Mar 2018 17:54:29 +0000
Message-Id: <1f319cb0538a10339d1ca73ee124331d611b43bf.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys PCIe Root Complex supports up to MSI 256 IRQs distributed
over 8 controller registers, therefore the maximum number of MSI IRQs
can be changed to 256. The number of controllers can be calculated based
on the number of vectors used by the specific SoC driver.

Update the dwc host bridge driver maximum number of supported MSI
IRQs.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
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
Change v7->v8:
- Rebased against v4.16-rc1.
Change v8->v9:
- Changed patch indexation, due patch series squash.
Change v9->v10:
- Log commit rewrite to be accurate by Lorenzo (thanks Lorenzo).
Change v10->v11:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-host.c | 12 ++++++++----
 drivers/pci/dwc/pcie-designware.h      | 10 +++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 193a0fa..550fdbb 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -76,11 +76,13 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
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
@@ -639,13 +641,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 
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
index 923f956..fe811db 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -107,13 +107,9 @@
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

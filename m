Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:54295 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdFEQUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2017 12:20:48 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 9/9] pci: remove limitation of the number of the available IRQs
Date: Mon,  5 Jun 2017 17:19:56 +0100
Message-Id: <3839dbf866a10034298b758f63fe019873b829bc.1496677911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496677911.git.jpinto@synopsys.com>
References: <cover.1496677911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496677911.git.jpinto@synopsys.com>
References: <cover.1496677911.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys PCIe Controller supports up to 256 IRQs distributed
by 8 controller registers.

Having this in mind, the number of the maximum number of
IRQs was changed to 256 and now the number of controllers is
calculated based on the number of vectors used by the specific
SoC driver.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Change v1->v2:
- New patch

 drivers/pci/dwc/pcie-designware-host.c | 12 ++++++++----
 drivers/pci/dwc/pcie-designware.h      | 10 +++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 6c771cc..31c7ccd 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -73,11 +73,13 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
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
@@ -625,13 +627,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 
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
 
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index f95c086..4a72f16 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -102,13 +102,9 @@
 #define MSI_MESSAGE_ADDR_L32		0x54
 #define MSI_MESSAGE_ADDR_U32		0x58
 
-/*
- * Maximum number of MSI IRQs can be 256 per controller. But keep
- * it 32 as of now. Probably we will never need more than 32. If needed,
- * then increment it in multiple of 32.
- */
-#define MAX_MSI_IRQS			32
-#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
+#define MAX_MSI_IRQS			256
+#define MAX_MSI_IRQS_PER_CTRL		32
+#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / (MAX_MSI_IRQS_PER_CTRL))
 #define MSI_DEF_NUM_VECTORS		32
 
 struct pcie_port;
-- 
2.9.3

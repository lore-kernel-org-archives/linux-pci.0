Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:2656
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752485AbaJTFzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 01:55:47 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>, Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v8 1/9] PCI: designware: Refine setup_rc and add msi data restore
Date: Mon, 20 Oct 2014 13:25:16 +0800
Message-ID: <1413782724-30795-2-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

- move "program correct class for RC" from dw_pcie_host_init()
to dw_pcie_setup_rc(). since this is RC setup, it's
better to contained in dw_pcie_setup_rc function.
Then, RC can be re-setup really by dw_pcie_setup_rc().

- add one store/re-store msi cfg functions. Because that
pcie controller maybe powered off during system suspend,
and the msi data configuration would be lost.
these functions can be used to store/restore the msi data
and msi_enable during the suspend/resume callback.
  * all the four msi enable register are stored/re-stored.
  * use pp->ops->get_msi_data if there is get_msi_data
  callback.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 41 +++++++++++++++++++++++++++++++++++---
 drivers/pci/host/pcie-designware.h |  6 ++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 538bbf3..8d1c809 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -44,6 +44,15 @@
 #define PCIE_MSI_INTR0_ENABLE		0x828
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
+#define PCIE_MSI_INTR1_ENABLE		0x834
+#define PCIE_MSI_INTR1_MASK		0x838
+#define PCIE_MSI_INTR1_STATUS		0x83C
+#define PCIE_MSI_INTR2_ENABLE		0x840
+#define PCIE_MSI_INTR2_MASK		0x844
+#define PCIE_MSI_INTR2_STATUS		0x848
+#define PCIE_MSI_INTR3_ENABLE		0x84C
+#define PCIE_MSI_INTR3_MASK		0x850
+#define PCIE_MSI_INTR3_STATUS		0x854
 
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
@@ -194,6 +203,32 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
 }
 
+void dw_pcie_msi_cfg_store(struct pcie_port *pp)
+{
+	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE, 4, &pp->msi_int0_enable);
+	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR1_ENABLE, 4, &pp->msi_int1_enable);
+	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR2_ENABLE, 4, &pp->msi_int2_enable);
+	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR3_ENABLE, 4, &pp->msi_int3_enable);
+}
+
+void dw_pcie_msi_cfg_restore(struct pcie_port *pp)
+{
+	u32 address_lo;
+
+	if (pp->ops->get_msi_data)
+		address_lo = pp->ops->get_msi_data(pp);
+	else
+		address_lo = virt_to_phys((void *)pp->msi_data);
+
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4, address_lo);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
+
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE, 4, pp->msi_int0_enable);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR1_ENABLE, 4, pp->msi_int1_enable);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR2_ENABLE, 4, pp->msi_int2_enable);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR3_ENABLE, 4, pp->msi_int3_enable);
+}
+
 static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
 {
 	int flag = 1;
@@ -570,9 +605,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
-	/* program correct class for RC */
-	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-
 	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
@@ -917,6 +949,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val = memlimit | membase;
 	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
 
+	/* program correct class for RC */
+	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+
 	/* setup command register */
 	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
 	val &= 0xffff0000;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index a476e60..1a59600 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -56,6 +56,10 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	unsigned int		msi_int0_enable;
+	unsigned int		msi_int1_enable;
+	unsigned int		msi_int2_enable;
+	unsigned int		msi_int3_enable;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
@@ -83,6 +87,8 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+void dw_pcie_msi_cfg_store(struct pcie_port *pp);
+void dw_pcie_msi_cfg_restore(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
-- 
1.9.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v11 2/4] PCI: designware: Add generic dw_pcie_wait_for_link()
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: mark.rutland@arm.com, Alexey.Brodkin@synopsys.com, arnd@arndb.de,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com,
	robh+dt@kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
	galak@codeaurora.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-snps-arc@lists.infradead.org
Date: Fri, 26 Feb 2016 10:30:04 -0600
Message-ID: <20160226163004.11964.55387.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Several DesignWare-based drivers (dra7xx, exynos, imx6, keystone, qcom, and
spear13xx) had similar loops waiting for the link to come up.

Add a generic dw_pcie_wait_for_link() for use by all these drivers so the
waiting is done consistently, e.g., always using usleep_range() rather than
mdelay() and using similar timeouts and retry counts.

Note that this changes the Keystone link training/wait for link strategy,
so we initiate link training, then wait longer for the link to come up
before re-initiating link training.

[bhelgaas: changelog, split into its own patch, update pci-keystone.c, pcie-qcom.c]
Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c      |   11 +----------
 drivers/pci/host/pci-exynos.c      |   13 +++----------
 drivers/pci/host/pci-imx6.c        |   13 ++++---------
 drivers/pci/host/pci-keystone.c    |   10 ++++------
 drivers/pci/host/pcie-designware.c |   19 +++++++++++++++++++
 drivers/pci/host/pcie-designware.h |    6 ++++++
 drivers/pci/host/pcie-qcom.c       |   10 +---------
 drivers/pci/host/pcie-spear13xx.c  |   14 +-------------
 8 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 923607b..2ca3a1f 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -108,7 +107,6 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 	u32 reg;
-	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "link is already up\n");
@@ -119,14 +117,7 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	for (retries = 0; retries < 1000; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(10, 20);
-	}
-
-	dev_err(pp->dev, "link is not up\n");
-	return -EINVAL;
+	return dw_pcie_wait_for_link(pp);
 }
 
 static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index d997d22..2199761 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -318,7 +318,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 	u32 val;
-	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "Link already up\n");
@@ -357,13 +356,8 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "Link up\n");
-			return 0;
-		}
-		mdelay(100);
-	}
+	if (!dw_pcie_wait_for_link(pp))
+		return 0;
 
 	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
@@ -372,8 +366,7 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	/* power off phy */
 	exynos_pcie_power_off_phy(pp);
 
-	dev_err(pp->dev, "PCIe Link Fail\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fe60096..6c35d86 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -330,19 +330,14 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 {
-	unsigned int retries;
-
-	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(100, 1000);
-	}
+	/* check if the link is up or not */
+	if (!dw_pcie_wait_for_link(pp))
+		return 0;
 
-	dev_err(pp->dev, "phy link never came up\n");
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd..9a91487 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -97,17 +97,15 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 		return 0;
 	}
 
-	ks_dw_pcie_initiate_link_train(ks_pcie);
 	/* check if the link is up or not */
-	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(100, 1000);
+	for (retries = 0; retries < 5; retries++) {
 		ks_dw_pcie_initiate_link_train(ks_pcie);
+		if (!dw_pcie_wait_for_link(pp))
+			return 0;
 	}
 
 	dev_err(pp->dev, "phy link never came up\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2171682..1fd3ad3 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -22,6 +22,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 
 #include "pcie-designware.h"
 
@@ -380,6 +381,24 @@ static struct msi_controller dw_pcie_msi_chip = {
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
+int dw_pcie_wait_for_link(struct pcie_port *pp)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(pp->dev, "phy link never came up\n");
+
+	return -ETIMEDOUT;
+}
+
 int dw_pcie_link_up(struct pcie_port *pp)
 {
 	if (pp->ops->link_up)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..f437f9b 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,6 +22,11 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_USLEEP_MIN		90000
+#define LINK_WAIT_USLEEP_MAX		100000
+
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
@@ -76,6 +81,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+int dw_pcie_wait_for_link(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index e845fba..ec4ef54 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -128,15 +128,7 @@ static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
 	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
 
-	do {
-		if (dw_pcie_link_up(&pcie->pp))
-			return 0;
-		usleep_range(250, 1000);
-	} while (retries < 200);
-
-	dev_warn(dev, "phy link never came up\n");
-
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pp);
 }
 
 static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index a6cd823..a4060b8 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -149,7 +148,6 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
-	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "link already up\n");
@@ -200,17 +198,7 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 			| ((u32)1 << REG_TRANSLATION_ENABLE),
 			&app_reg->app_ctrl_0);
 
-	/* check if the link is up or not */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
-			return 0;
-		}
-		mdelay(100);
-	}
-
-	dev_err(pp->dev, "link Fail\n");
-	return -EINVAL;
+	return dw_pcie_wait_for_link(pp);
 }
 
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)

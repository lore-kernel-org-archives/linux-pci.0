Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52398 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbcBHMoE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 07:44:04 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] link up validation moved to pcie-designware
Date: Mon,  8 Feb 2016 12:43:58 +0000
Message-Id: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch goal is to centralize in pcie-designware the link up
validation. A new function was added to pci-designware that is
responsible for doing such a task. This was implemented in a form that
permits flexibility for all SoCs.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/host/pci-dra7xx.c      | 11 +++--------
 drivers/pci/host/pci-exynos.c      | 11 ++---------
 drivers/pci/host/pci-imx6.c        | 11 +++--------
 drivers/pci/host/pcie-designware.c | 20 ++++++++++++++++++++
 drivers/pci/host/pcie-designware.h |  2 ++
 drivers/pci/host/pcie-spear13xx.c  | 12 ++----------
 6 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 8c36880..e425944 100644
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
@@ -119,13 +117,10 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	for (retries = 0; retries < 1000; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(10, 20);
-	}
+	/* check if the link is up or not */
+	if (!dw_pcie_check_link_is_up(pp, 1000, 10, 20))
+		return 0;
 
-	dev_err(pp->dev, "link is not up\n");
 	return -EINVAL;
 }
 
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 01095e1..770c45a 100644
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
+	if (!dw_pcie_check_link_is_up(pp, 10, 100000, 110000))
+		return 0;
 
 	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
@@ -372,7 +366,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	/* power off phy */
 	exynos_pcie_power_off_phy(pp);
 
-	dev_err(pp->dev, "PCIe Link Fail\n");
 	return -EINVAL;
 }
 
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224..9e323be 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -330,15 +330,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 
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
+	if (!dw_pcie_check_link_is_up(pp, 200, 100, 1000))
+		return 0;
 
-	dev_err(pp->dev, "phy link never came up\n");
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077..6725231 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -22,6 +22,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 
 #include "pcie-designware.h"
 
@@ -380,6 +381,25 @@ static struct msi_controller dw_pcie_msi_chip = {
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
+int dw_pcie_check_link_is_up(struct pcie_port *pp, int max_ret, int sleep_min,
+								int sleep_max)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < max_ret; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "link up\n");
+			return 0;
+		}
+		usleep_range(sleep_min, sleep_max);
+	}
+
+	dev_err(pp->dev, "phy link never came up\n");
+
+	return 1;
+}
+
 int dw_pcie_link_up(struct pcie_port *pp)
 {
 	if (pp->ops->link_up)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..b077fe0 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -76,6 +76,8 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+int dw_pcie_check_link_is_up(struct pcie_port *pp, int max_ret, int sleep_min,
+								int sleep_max);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index b95b756..5c24595 100644
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
@@ -201,15 +199,9 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 			&app_reg->app_ctrl_0);
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
-			return 0;
-		}
-		mdelay(100);
-	}
+	if (!dw_pcie_check_link_is_up(pp, 10, 100000, 110000))
+		return 0;
 
-	dev_err(pp->dev, "link Fail\n");
 	return -EINVAL;
 }
 
-- 
1.8.1.5


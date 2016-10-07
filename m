Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965004AbcJGQm5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:42:57 -0400
Subject: [PATCH 1/5] PCI: qcom: Name private struct pointer "qcom"
 consistently
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:42:51 -0500
Message-ID: <20161007164251.26464.42894.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "qcom", for struct qcom_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-qcom.c |  142 +++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 5ec2d44..e72e038 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -80,9 +80,9 @@ union qcom_pcie_resources {
 struct qcom_pcie;
 
 struct qcom_pcie_ops {
-	int (*get_resources)(struct qcom_pcie *pcie);
-	int (*init)(struct qcom_pcie *pcie);
-	void (*deinit)(struct qcom_pcie *pcie);
+	int (*get_resources)(struct qcom_pcie *qcom);
+	int (*init)(struct qcom_pcie *qcom);
+	void (*deinit)(struct qcom_pcie *qcom);
 };
 
 struct qcom_pcie {
@@ -99,15 +99,15 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		container_of(x, struct qcom_pcie, pp)
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_assert(struct qcom_pcie *qcom)
 {
-	gpiod_set_value(pcie->reset, 1);
+	gpiod_set_value(qcom->reset, 1);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_deassert(struct qcom_pcie *qcom)
 {
-	gpiod_set_value(pcie->reset, 0);
+	gpiod_set_value(qcom->reset, 0);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
@@ -118,25 +118,25 @@ static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
+static int qcom_pcie_establish_link(struct qcom_pcie *qcom)
 {
 	u32 val;
 
-	if (dw_pcie_link_up(&pcie->pp))
+	if (dw_pcie_link_up(&qcom->pp))
 		return 0;
 
 	/* enable link training */
-	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	val = readl(qcom->elbi + PCIE20_ELBI_SYS_CTRL);
 	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	writel(val, qcom->elbi + PCIE20_ELBI_SYS_CTRL);
 
-	return dw_pcie_wait_for_link(&pcie->pp);
+	return dw_pcie_wait_for_link(&qcom->pp);
 }
 
-static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_v0(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
-	struct device *dev = pcie->dev;
+	struct qcom_pcie_resources_v0 *res = &qcom->res.v0;
+	struct device *dev = qcom->dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -185,10 +185,10 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_v1(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
-	struct device *dev = pcie->dev;
+	struct qcom_pcie_resources_v1 *res = &qcom->res.v1;
+	struct device *dev = qcom->dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -217,9 +217,9 @@ static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_v0(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
+	struct qcom_pcie_resources_v0 *res = &qcom->res.v0;
 
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
@@ -234,10 +234,10 @@ static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
 	regulator_disable(res->vdda_refclk);
 }
 
-static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
+static int qcom_pcie_init_v0(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
-	struct device *dev = pcie->dev;
+	struct qcom_pcie_resources_v0 *res = &qcom->res.v0;
+	struct device *dev = qcom->dev;
 	u32 val;
 	int ret;
 
@@ -290,14 +290,14 @@ static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
 	}
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(qcom->parf + PCIE20_PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, qcom->parf + PCIE20_PARF_PHY_CTRL);
 
 	/* enable external reference clock */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	val = readl(qcom->parf + PCIE20_PARF_PHY_REFCLK);
 	val |= BIT(16);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	writel(val, qcom->parf + PCIE20_PARF_PHY_REFCLK);
 
 	ret = reset_control_deassert(res->phy_reset);
 	if (ret) {
@@ -344,9 +344,9 @@ err_refclk:
 	return ret;
 }
 
-static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_v1(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
+	struct qcom_pcie_resources_v1 *res = &qcom->res.v1;
 
 	reset_control_assert(res->core);
 	clk_disable_unprepare(res->slave_bus);
@@ -356,10 +356,10 @@ static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
 	regulator_disable(res->vdda);
 }
 
-static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
+static int qcom_pcie_init_v1(struct qcom_pcie *qcom)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
-	struct device *dev = pcie->dev;
+	struct qcom_pcie_resources_v1 *res = &qcom->res.v1;
+	struct device *dev = qcom->dev;
 	int ret;
 
 	ret = reset_control_deassert(res->core);
@@ -399,13 +399,13 @@ static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
 	}
 
 	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, qcom->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		u32 val = readl(qcom->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
 
 		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		writel(val, qcom->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
 	return 0;
@@ -425,24 +425,24 @@ err_res:
 
 static int qcom_pcie_link_up(struct pcie_port *pp)
 {
-	struct qcom_pcie *pcie = to_qcom_pcie(pp);
-	u16 val = readw(pcie->dbi + PCIE20_CAP + PCI_EXP_LNKSTA);
+	struct qcom_pcie *qcom = to_qcom_pcie(pp);
+	u16 val = readw(qcom->dbi + PCIE20_CAP + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
 static void qcom_pcie_host_init(struct pcie_port *pp)
 {
-	struct qcom_pcie *pcie = to_qcom_pcie(pp);
+	struct qcom_pcie *qcom = to_qcom_pcie(pp);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(qcom);
 
-	ret = pcie->ops->init(pcie);
+	ret = qcom->ops->init(qcom);
 	if (ret)
 		goto err_deinit;
 
-	ret = phy_power_on(pcie->phy);
+	ret = phy_power_on(qcom->phy);
 	if (ret)
 		goto err_deinit;
 
@@ -451,18 +451,18 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 
-	qcom_ep_reset_deassert(pcie);
+	qcom_ep_reset_deassert(qcom);
 
-	ret = qcom_pcie_establish_link(pcie);
+	ret = qcom_pcie_establish_link(qcom);
 	if (ret)
 		goto err;
 
 	return;
 err:
-	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	qcom_ep_reset_assert(qcom);
+	phy_power_off(qcom->phy);
 err_deinit:
-	pcie->ops->deinit(pcie);
+	qcom->ops->deinit(qcom);
 }
 
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -501,47 +501,47 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct qcom_pcie *pcie;
+	struct qcom_pcie *qcom;
 	struct pcie_port *pp;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	qcom = devm_kzalloc(dev, sizeof(*qcom), GFP_KERNEL);
+	if (!qcom)
 		return -ENOMEM;
 
-	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
-	pcie->dev = dev;
+	qcom->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
+	qcom->dev = dev;
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
-	if (IS_ERR(pcie->reset))
-		return PTR_ERR(pcie->reset);
+	qcom->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
+	if (IS_ERR(qcom->reset))
+		return PTR_ERR(qcom->reset);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
-	pcie->parf = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->parf))
-		return PTR_ERR(pcie->parf);
+	qcom->parf = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qcom->parf))
+		return PTR_ERR(qcom->parf);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pcie->dbi = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->dbi))
-		return PTR_ERR(pcie->dbi);
+	qcom->dbi = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qcom->dbi))
+		return PTR_ERR(qcom->dbi);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
-	pcie->elbi = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->elbi))
-		return PTR_ERR(pcie->elbi);
+	qcom->elbi = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qcom->elbi))
+		return PTR_ERR(qcom->elbi);
 
-	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
+	qcom->phy = devm_phy_optional_get(dev, "pciephy");
+	if (IS_ERR(qcom->phy))
+		return PTR_ERR(qcom->phy);
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = qcom->ops->get_resources(qcom);
 	if (ret)
 		return ret;
 
-	pp = &pcie->pp;
+	pp = &qcom->pp;
 	pp->dev = dev;
-	pp->dbi_base = pcie->dbi;
+	pp->dbi_base = qcom->dbi;
 	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 
@@ -559,7 +559,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = phy_init(pcie->phy);
+	ret = phy_init(qcom->phy);
 	if (ret)
 		return ret;
 
@@ -569,7 +569,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, qcom);
 
 	return 0;
 }


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32994 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967684AbeEYTJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 15:09:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id e21-v6so2673745pgv.0
        for <linux-pci@vger.kernel.org>; Fri, 25 May 2018 12:09:37 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom: Fix error handling in pm_runtime support
Date: Fri, 25 May 2018 12:09:34 -0700
Message-Id: <20180525190934.1042-1-bjorn.andersson@linaro.org>
In-Reply-To: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver does not cope with the fact that probe can fail in a number
of cases after enabling pm_runtime on the device, this results in
warnings about "Unbalanced pm_runtime_enable". Further more if probe
fails after invoking host_init the power-domain will be left referenced.

As it's not possible for the error handling in qcom_pcie_host_init() to
handle errors happening after returning from that function the
pm_runtime_get_sync() is moved to probe() as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

I'm sorry for not spotting this last week when we discussed the previous patch.

 drivers/pci/dwc/pcie-qcom.c | 65 ++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 3f35098b71b1..f2453196278f 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -1088,8 +1088,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	pm_runtime_get_sync(pci->dev);
-
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -1126,7 +1124,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
-	pm_runtime_put_sync(pci->dev);
 
 	return ret;
 }
@@ -1207,7 +1204,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct qcom_pcie *pcie;
 	int ret;
 
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1217,6 +1213,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
@@ -1227,53 +1224,82 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pcie->ops = of_device_get_match_data(dev);
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
-	if (IS_ERR(pcie->reset))
-		return PTR_ERR(pcie->reset);
+	if (IS_ERR(pcie->reset)) {
+		ret = PTR_ERR(pcie->reset);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->parf))
-		return PTR_ERR(pcie->parf);
+	if (IS_ERR(pcie->parf)) {
+		ret = PTR_ERR(pcie->parf);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
+	if (IS_ERR(pci->dbi_base)) {
+		ret = PTR_ERR(pci->dbi_base);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
 	pcie->elbi = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->elbi))
-		return PTR_ERR(pcie->elbi);
+	if (IS_ERR(pcie->elbi)) {
+		ret = PTR_ERR(pcie->elbi);
+		goto err_pm_runtime_put;
+	}
 
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
+	if (IS_ERR(pcie->phy)) {
+		ret = PTR_ERR(pcie->phy);
+		goto err_pm_runtime_put;
+	}
 
 	ret = pcie->ops->get_resources(pcie);
 	if (ret)
-		return ret;
+		goto err_pm_runtime_put;
 
 	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq < 0)
-			return pp->msi_irq;
+		if (pp->msi_irq < 0) {
+			ret = pp->msi_irq;
+			goto err_pm_runtime_put;
+		}
 	}
 
 	ret = phy_init(pcie->phy);
 	if (ret)
-		return ret;
+		goto err_pm_runtime_put;
 
 	platform_set_drvdata(pdev, pcie);
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
+	return 0;
+
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int qcom_pcie_remove(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+	struct device *dev = pcie->pci->dev;
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
 	return 0;
 }
 
@@ -1289,6 +1315,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
+	.remove = qcom_pcie_remove,
 	.driver = {
 		.name = "qcom-pcie",
 		.suppress_bind_attrs = true,
-- 
2.17.0

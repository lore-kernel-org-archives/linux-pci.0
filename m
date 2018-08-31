Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39871 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIADDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 23:03:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so6074635plp.6
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2018 15:53:28 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Fix error handling in pm_runtime support
Date: Fri, 31 Aug 2018 15:55:10 -0700
Message-Id: <20180831225510.32230-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver does not cope with the fact that probe can fail in a number
of cases after enabling pm_runtime on the device, this results in
warnings about "Unbalanced pm_runtime_enable". Further more if probe
fails after invoking host_init the power-domain will be left referenced.

As it's not possible for the error handling in qcom_pcie_host_init() to
handle errors happening after returning from that function the
pm_runtime_get_sync() is moved to probe() as well.

Fixes: 854b69efbdd2 ("PCI: qcom: add runtime pm support to pcie_port")
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped remove function, as this can't be called
- Handle pm_runtime_get_sync() errors
- Add "Fixes" tag

 drivers/pci/controller/dwc/pcie-qcom.c | 56 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d2373e4d141c..3bfaad052736 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1117,7 +1117,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	pm_runtime_get_sync(pci->dev);
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -1154,7 +1153,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
-	pm_runtime_put(pci->dev);
 
 	return ret;
 }
@@ -1244,6 +1242,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1253,44 +1257,56 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	platform_set_drvdata(pdev, pcie);
@@ -1299,10 +1315,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
 		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
+
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
-- 
2.18.0

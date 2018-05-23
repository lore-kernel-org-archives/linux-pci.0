Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] PCI: qcom: add runtime pm support to pcie_port
Date: Wed, 23 May 2018 11:44:25 +0100
Message-Id: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is required when the pcie controller sits on a bus with
its own power domain and clocks which are controlled via a bus driver
like simple pm bus. As these bus driver have runtime pm enabled, it makes
sense to update the usage counter so that the runtime pm does not suspend
the clks or power domain associated with the bus driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/dwc/pcie-qcom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5897af7d3355..d6ed5aeeae9c 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -19,6 +19,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
@@ -1088,6 +1089,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
+	pm_runtime_get_sync(pci->dev);
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -1124,6 +1126,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+	pm_runtime_put(pci->dev);
 
 	return ret;
 }
@@ -1212,6 +1215,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pm_runtime_enable(dev);
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1257,14 +1261,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = phy_init(pcie->phy);
-	if (ret)
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
 		return ret;
+	}
 
 	platform_set_drvdata(pdev, pcie);
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
-- 
2.16.2

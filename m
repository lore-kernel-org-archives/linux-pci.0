Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35551 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeERHHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2018 03:07:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id 11-v6so1287273pge.2
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2018 00:07:40 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: qcom: add runtime pm support to pcie_port
Date: Fri, 18 May 2018 00:07:36 -0700
Message-Id: <20180518070736.3003-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch is required when the pcie controller sits on a bus with
its own power domain and clocks which are controlled via a bus driver
like simple pm bus. As these bus driver have runtime pm enabled, it makes
sense to update the usage counter so that the runtime pm does not suspend
the clks or power domain associated with the bus driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This patch was posted 18 months ago but was somehow lost. linux-next recently
enabled PCIe on MSM8996 and DB820c, but the system stalls as the agnoc gdsc
isn't enabled. This patch still fixes this problem for me.

 drivers/pci/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5897af7d3355..3f35098b71b1 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -1088,6 +1088,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
+	pm_runtime_get_sync(pci->dev);
+
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -1124,6 +1126,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+	pm_runtime_put_sync(pci->dev);
 
 	return ret;
 }
@@ -1204,6 +1207,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct qcom_pcie *pcie;
 	int ret;
 
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1212,6 +1216,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pm_runtime_enable(dev);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
-- 
2.17.0

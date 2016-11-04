Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36937 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934672AbcKDM74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2016 08:59:56 -0400
Received: by mail-wm0-f46.google.com with SMTP id t79so48425339wmt.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Nov 2016 05:59:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/3] PCI: qcom: add runtime pm support to pcie_port
Date: Fri,  4 Nov 2016 12:59:47 +0000
Message-Id: <1478264387-17914-4-git-send-email-srinivas.kandagatla@linaro.org>
In-Reply-To: <1478264387-17914-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1478264387-17914-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is required when the pcie controller sits on a bus with
its own power domain and clocks which are controlled via a bus driver
like simple pm bus. As these bus driver have runtime pm enabled, it makes
sense to update the usage counter so that the runtime pm does not suspend
the clks or power domain associated with the bus driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/pci/host/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index f37c690..3751635 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -587,6 +587,9 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
 	int ret;
 
+
+	pm_runtime_get_sync(pp->dev);
+
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -617,6 +620,7 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+	pm_runtime_put_sync(pp->dev);
 }
 
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -669,10 +673,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	int ret;
 
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
+	pm_runtime_enable(dev);
 	pp = &pcie->pp;
 	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
 
-- 
2.10.1


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34889 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932810AbcKNLQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 06:16:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so91504456wmd.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 03:16:14 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc: robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] PCI: qcom: add runtime pm support to pcie_port
Date: Mon, 14 Nov 2016 11:15:55 +0000
Message-Id: <1479122155-13393-4-git-send-email-srinivas.kandagatla@linaro.org>
In-Reply-To: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is required when the pcie controller sits on a bus with
its own power domain and clocks which are controlled via a bus driver
like simple pm bus. As these bus driver have runtime pm enabled, it makes
sense to update the usage counter so that the runtime pm does not suspend
the clks or power domain associated with the bus driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/pci/host/pcie-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 03ba6b1..c2ca848 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -587,6 +587,8 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
 	int ret;
 
+	pm_runtime_get_sync(pp->dev);
+
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -617,6 +619,7 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+	pm_runtime_put_sync(pp->dev);
 }
 
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -673,6 +676,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pm_runtime_enable(dev);
 	pp = &pcie->pp;
 	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
 
-- 
2.10.1


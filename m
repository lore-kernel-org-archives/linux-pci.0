Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37828 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbcJYNnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2016 09:43:16 -0400
Received: by mail-wm0-f51.google.com with SMTP id c78so25315307wme.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2016 06:43:15 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH] PCI: qcom: fix NULL pointer dereference in get_resources()
Date: Tue, 25 Oct 2016 14:42:51 +0100
Message-Id: <1477402971-22146-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

get_resources() will dereference dev as NULL pointer when called from probe(),
as pp.dev is only assigned after get_resources() is called.

Fix this by moving dev pointer assignment before get_resources() call.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: e6a087eeaf91 ("PCI: qcom: Remove redundant struct qcom_pcie.dev")
---
 drivers/pci/host/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index ef0a84c..3593640 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -533,11 +533,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
+	pp->dev = dev;
 	ret = pcie->ops->get_resources(pcie);
 	if (ret)
 		return ret;
 
-	pp->dev = dev;
 	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 
-- 
2.10.1


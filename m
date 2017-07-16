Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34889 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdGPGl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 02:41:57 -0400
Received: by mail-pg0-f47.google.com with SMTP id v190so6244513pgv.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2017 23:41:57 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: qcom: Don't unroll init if init fails
Date: Sat, 15 Jul 2017 23:41:53 -0700
Message-Id: <20170716064153.3346-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When the init op fails it will restore the state of the resources, so we
should not disable them one more time when this happens.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index d15657dc3990..7b703741a3fd 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -901,7 +901,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	ret = pcie->ops->init(pcie);
 	if (ret)
-		goto err_deinit;
+		return ret;
 
 	ret = phy_power_on(pcie->phy);
 	if (ret)
-- 
2.12.0

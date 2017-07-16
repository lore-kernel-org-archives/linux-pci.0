Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35114 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdGPGjy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 02:39:54 -0400
Received: by mail-pf0-f170.google.com with SMTP id e199so1807147pfh.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2017 23:39:54 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR QUALCOMM MSM),
        linux-arm-msm@vger.kernel.org (open list:PCIE DRIVER FOR QUALCOMM MSM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] PCI: qcom: Don't unroll init if init fails
Date: Sat, 15 Jul 2017 23:39:46 -0700
Message-Id: <20170716063947.3272-2-bjorn.andersson@linaro.org>
In-Reply-To: <20170716063947.3272-1-bjorn.andersson@linaro.org>
References: <20170716063947.3272-1-bjorn.andersson@linaro.org>
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

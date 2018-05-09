Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40433 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFmg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id f189so25061943pfa.7
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:35 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jianguo Sun <sunjianguo1@huawei.com>
Subject: [PATCH 7/9] PCI: histb: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:44 +0800
Message-Id: <1525844386-5433-7-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
---
 drivers/pci/dwc/pcie-histb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 3611d6ce9a92..7b32e619b959 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -420,7 +420,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		phy_init(hipcie->phy);
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &histb_pcie_host_ops;
 
 	platform_set_drvdata(pdev, hipcie);
-- 
1.9.1

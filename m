Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40944 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKAVI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:21:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so2237375plo.7
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:21:08 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 4/9] PCI: armada8k: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:14 +0800
Message-Id: <1525998019-28634-5-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index b587352f8b9f..2d8eb88fd4f8 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -171,7 +171,6 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	pp->root_bus_nr = -1;
 	pp->ops = &armada8k_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 0);
-- 
1.9.1

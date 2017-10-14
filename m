Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:51628 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdJNWHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:07:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id 17so8837343qkq.8
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:07:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5/5] PCI: xilinx-nwl: Fix platform_get_irq() error handling
Date: Sat, 14 Oct 2017 19:07:31 -0300
Message-Id: <1508018851-9272-5-git-send-email-festevam@gmail.com>
In-Reply-To: <1508018851-9272-1-git-send-email-festevam@gmail.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error value
instead of always returning -EINVAL.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 65dea98..b896167 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -591,7 +591,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
 	if (msi->irq_msi1 < 0) {
 		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
-		ret = -EINVAL;
+		ret = msi->irq_msi1;
 		goto err;
 	}
 
@@ -602,7 +602,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (msi->irq_msi0 < 0) {
 		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
-		ret = -EINVAL;
+		ret = msi->irq_msi0;
 		goto err;
 	}
 
@@ -735,7 +735,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	if (pcie->irq_misc < 0) {
 		dev_err(dev, "failed to get misc IRQ %d\n",
 			pcie->irq_misc);
-		return -EINVAL;
+		return pcie->irq_misc;
 	}
 
 	err = devm_request_irq(dev, pcie->irq_misc,
-- 
2.7.4

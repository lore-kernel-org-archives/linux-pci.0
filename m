Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:53560 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965500AbdGUB0k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 21:26:40 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] PCI: hisi: remove unused variable driver
Date: Fri, 21 Jul 2017 09:26:06 +0800
Message-Id: <1500600366-181656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It was never used and also introduce a warning

drivers/pci/dwc/pcie-hisi.c: In function 'hisi_pcie_probe':
drivers/pci/dwc/pcie-hisi.c:271:24: warning: variable 'driver' set but
not used [-Wunused-but-set-variable]

Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/dwc/pcie-hisi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index e51acee..6631654 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -268,7 +268,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct hisi_pcie *hisi_pcie;
 	struct resource *reg;
-	struct device_driver *driver;
 	int ret;
 
 	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
@@ -282,8 +281,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
-	driver = dev->driver;
-
 	hisi_pcie->pci = pci;
 
 	hisi_pcie->soc_ops = of_device_get_match_data(dev);
-- 
1.9.1

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57389 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbEXUhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 24 May 2015 16:37:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: rjui@broadcom.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, zajec5@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] PCI: iproc: free resource list after registration
Date: Sun, 24 May 2015 22:37:03 +0200
Message-Id: <1432499823-27369-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
References: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The resource list is only used in the setup process and was never
freed. pci_add_resource() allocates a memory area to store the list
item. This patch fixes the memory leak.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/pci/host/pcie-iproc-bcma.c     | 8 ++++----
 drivers/pci/host/pcie-iproc-platform.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index f96b39e..2e4f2d6 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -65,12 +65,12 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	pcie->map_irq = iproc_pcie_bcma_map_irq;
 
 	ret = iproc_pcie_setup(pcie, &res);
-	if (ret) {
+	if (ret)
 		dev_err(pcie->dev, "PCIe controller setup failed\n");
-		return ret;
-	}
 
-	return 0;
+	pci_free_resource_list(&res);
+
+	return ret;
 }
 
 static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index c5fe4c1..9aedc8e 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -72,12 +72,12 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	pcie->map_irq = of_irq_parse_and_map_pci;
 
 	ret = iproc_pcie_setup(pcie, &res);
-	if (ret) {
+	if (ret)
 		dev_err(pcie->dev, "PCIe controller setup failed\n");
-		return ret;
-	}
 
-	return 0;
+	pci_free_resource_list(&res);
+
+	return ret;
 }
 
 static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
-- 
2.1.4


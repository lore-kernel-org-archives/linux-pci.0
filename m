Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49111 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaEIFbb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 01:31:31 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5A009UMKODQG40@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 09 May 2014 14:31:25 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: exynos: Remove unnecessary OOM messages
Date: Fri, 09 May 2014 14:31:25 +0900
Message-id: <000301cf6b47$eb8de9f0$c2a9bdd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-exynos.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 3de6bfb..81aa700 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -568,10 +568,8 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 	exynos_pcie = devm_kzalloc(&pdev->dev, sizeof(*exynos_pcie),
 				GFP_KERNEL);
-	if (!exynos_pcie) {
-		dev_err(&pdev->dev, "no memory for exynos pcie\n");
+	if (!exynos_pcie)
 		return -ENOMEM;
-	}
 
 	pp = &exynos_pcie->pp;
 
-- 
1.7.10.4



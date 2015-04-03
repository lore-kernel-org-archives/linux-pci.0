Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:59351 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860AbbDCNUX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 09:20:23 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <robh@kernel.org>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] PCI: versatile: don't check resource with devm_ioremap_resource
Date: Fri, 3 Apr 2015 21:17:05 +0800
Message-ID: <1428067025-543-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_ioremap_resource does sanity checks on the given resource. No need
to duplicate this in the driver. And we should check whether
devm_ioremap_resource() succeeds or not.

This patch fixes all of these two trival issues.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pci-versatile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 464bf49..ba5eab1 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -138,19 +138,19 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	LIST_HEAD(pci_res);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
 	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_pci_base))
+		return PTR_ERR(versatile_pci_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
 	versatile_cfg_base[0] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_cfg_base[0]))
+		return PTR_ERR(versatile_cfg_base[0]);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (!res)
-		return -ENODEV;
 	versatile_cfg_base[1] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_cfg_base[1]))
+		return PTR_ERR(versatile_cfg_base[1]);
 
 	ret = versatile_pci_parse_request_of_pci_ranges(&pdev->dev, &pci_res);
 	if (ret)
-- 
2.1.4


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:39738 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeAUVRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Jan 2018 16:17:03 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992604AbeAUVRCgQRqG (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:17:02 +0100
Date: Sun, 21 Jan 2018 22:17:01 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/5] mtd: nand: davinci: Use devm_ioremap_shared_resource()
Message-ID: <20180121211701.GF15151@lenoch>
References: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211432.GA15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify error handling by using devm_ioremap_shared_resource().

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/mtd/nand/davinci_nand.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index ccc8c43abcff..9b6f06b177b9 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -612,10 +612,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
 	struct davinci_nand_info	*info;
-	struct resource			*res1;
-	struct resource			*res2;
+	struct resource			*res;
 	void __iomem			*vaddr;
-	void __iomem			*base;
 	int				ret;
 	uint32_t			val;
 	struct mtd_info			*mtd;
@@ -638,14 +636,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res1 || !res2) {
-		dev_err(&pdev->dev, "resource missing\n");
-		return -EINVAL;
-	}
-
-	vaddr = devm_ioremap_resource(&pdev->dev, res1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	vaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 
@@ -655,14 +647,12 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	 * by AEMIF, so we cannot request it twice, just ioremap.
 	 * The AEMIF and NAND drivers not use the same registers in this range.
 	 */
-	base = devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
-	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
-		return -EADDRNOTAVAIL;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	info->base = devm_ioremap_shared_resource(&pdev->dev, res);
+	if (IS_ERR(info->base))
+		return PTR_ERR(info->base);
 
 	info->dev		= &pdev->dev;
-	info->base		= base;
 	info->vaddr		= vaddr;
 
 	mtd			= nand_to_mtd(&info->chip);
-- 
2.15.1

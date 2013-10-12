Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:53186 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3JLGLD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Oct 2013 02:11:03 -0400
Received: by mail-bk0-f51.google.com with SMTP id mx10so1857297bkb.24
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2013 23:11:02 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 12 Oct 2013 14:11:02 +0800
Message-ID: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
Subject: [PATCH -next] PCI: imx6: remove redundant dev_err call in imx6_pcie_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, grant.likely@linaro.org,
	rob.herring@calxeda.com, xobs@kosagi.com, s.hauer@pengutronix.de,
	shawn.guo@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pci/host/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 5afa922..51338ac 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -439,7 +439,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
 	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
 	if (IS_ERR(pp->dbi_base)) {
-		dev_err(&pdev->dev, "unable to remap dbi_base\n");
 		ret = PTR_ERR(pp->dbi_base);
 		goto err;
 	}


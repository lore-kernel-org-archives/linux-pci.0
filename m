Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:52426 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3KSDka (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 22:40:30 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so632835bkb.18
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2013 19:40:29 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 19 Nov 2013 11:40:28 +0800
Message-ID: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
Subject: [PATCH] PCI: rcar: fix return value check in rcar_pci_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, valentine.barshak@cogentembedded.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pci/host/pci-rcar-gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index cbaa5c4..96d1182 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -276,8 +276,8 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
 
 	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
-	if (!reg)
-		return -ENODEV;
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!mem_res || !mem_res->start)


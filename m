Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45588 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab3FQJbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2013 05:31:01 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so2588856pbc.32
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2013 02:31:01 -0700 (PDT)
From: Tushar Behera <tushar.behera@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@gmail.com, patches@linaro.org,
	sachin.kamat@linaro.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH V2 6/6] pci: mvebu: Convert to use devm_ioremap_resource
Date: Mon, 17 Jun 2013 14:46:13 +0530
Message-Id: <1371460573-30004-1-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1370864113-17895-14-git-send-email-tushar.behera@linaro.org>
References: <1370864113-17895-14-git-send-email-tushar.behera@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
introduced devm_ioremap_resource() and deprecated the use of
devm_request_and_ioremap().

While at it, modify mvebu_pcie_map_registers() to propagate error code.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: linux-pci@vger.kernel.org
CC: Bjorn Helgaas <bhelgaas@google.com>
---
Changes for V2:
* Return proper error code in mvebu_pcie_map_registers.

 drivers/pci/host/pci-mvebu.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..8fc2a82 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -750,9 +750,9 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
 
 	ret = of_address_to_resource(np, 0, &regs);
 	if (ret)
-		return NULL;
+		return ERR_PTR(ret);
 
-	return devm_request_and_ioremap(&pdev->dev, &regs);
+	return devm_ioremap_resource(&pdev->dev, &regs);
 }
 
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
@@ -842,9 +842,10 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
-		if (!port->base) {
+		if (IS_ERR(port->base)) {
 			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
 				port->port, port->lane);
+			port->base = NULL;
 			continue;
 		}
 
-- 
1.7.9.5


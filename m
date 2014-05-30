Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32925 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbaE3GlO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 02:41:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so623040pdj.6
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2014 23:41:13 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: r65037@freescale.com, shawn.guo@linaro.org, bhelgaas@google.com,
	sachin.kamat@linaro.org, Sean Cross <xobs@kosagi.com>
Subject: [PATCH 1/1] PCI: imx6: Annotate imx6_add_pcie_port with __init
Date: Fri, 30 May 2014 12:08:48 +0530
Message-Id: <1401431928-15096-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

imx6_add_pcie_port is called from probe which is annotated with __init.
imx6_add_pcie_port calls dw_pcie_host_init which is also annotated with
__init. Thus it makes sense to annotate imx6_add_pcie_port with __init.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sean Cross <xobs@kosagi.com>
---
 drivers/pci/host/pci-imx6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ee082509b0ba..facbf8faa353 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -487,7 +487,7 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
 
-static int imx6_add_pcie_port(struct pcie_port *pp,
+static int __init imx6_add_pcie_port(struct pcie_port *pp,
 			struct platform_device *pdev)
 {
 	int ret;
-- 
1.7.9.5


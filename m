Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35394 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075AbcG1QQY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 12:16:24 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so3765003pad.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Jul 2016 09:16:23 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: keystone: Fix error return code in ks_add_pcie_port()
Date: Thu, 28 Jul 2016 16:16:18 +0000
Message-Id: <1469722578-14863-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix to return a negative error code from the request IRQ error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/pci/host/pci-keystone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 8ba2883..82b461b 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -334,8 +334,9 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	if (ks_pcie->error_irq <= 0)
 		dev_info(&pdev->dev, "no error IRQ defined\n");
 	else {
-		if (request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
-				IRQF_SHARED, "pcie-error-irq", ks_pcie) < 0) {
+		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
+				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
+		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
 				ks_pcie->error_irq);
 			return ret;


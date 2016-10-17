Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34599 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbcJQO4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:56:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so12957618pfz.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:56:33 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: altera: Remove redundant dev_err call in altera_pcie_parse_dt()
Date: Mon, 17 Oct 2016 14:56:13 +0000
Message-Id: <1476716173-31310-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-altera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b0ac4df..8be45a8 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -550,10 +550,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
 	pcie->cra_base = devm_ioremap_resource(dev, cra);
-	if (IS_ERR(pcie->cra_base)) {
-		dev_err(dev, "failed to map cra memory\n");
+	if (IS_ERR(pcie->cra_base))
 		return PTR_ERR(pcie->cra_base);
-	}
 
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);




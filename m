Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34850 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933663AbcJQOzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:55:50 -0400
Received: by mail-pa0-f68.google.com with SMTP id qn10so9309994pac.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:55:49 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: layerscape: Remove redundant dev_err call in ls_pcie_probe()
Date: Mon, 17 Oct 2016 14:55:40 +0000
Message-Id: <1476716140-30608-1-git-send-email-weiyj.lk@gmail.com>
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
 drivers/pci/host/pci-layerscape.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2cb7315..bbd3d23 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -251,10 +251,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pcie->pp.dbi_base)) {
-		dev_err(dev, "missing *regs* space\n");
+	if (IS_ERR(pcie->pp.dbi_base))
 		return PTR_ERR(pcie->pp.dbi_base);
-	}
 
 	pcie->drvdata = match->data;
 	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;




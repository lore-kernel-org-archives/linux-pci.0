Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36620 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbcJQO46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:56:58 -0400
Received: by mail-pa0-f68.google.com with SMTP id os4so5246019pac.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:56:58 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: hisi: Remove redundant dev_err call in hisi_pcie_probe()
Date: Mon, 17 Oct 2016 14:56:50 +0000
Message-Id: <1476716210-31532-1-git-send-email-weiyj.lk@gmail.com>
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
 drivers/pci/host/pcie-hisi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 56154c2..a77b9bda 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -185,10 +185,8 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
 	pp->dbi_base = devm_ioremap_resource(dev, reg);
-	if (IS_ERR(pp->dbi_base)) {
-		dev_err(dev, "cannot get rc_dbi base\n");
+	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
-	}
 
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
 	if (ret)




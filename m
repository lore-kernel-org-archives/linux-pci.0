Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:46204 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757168AbdLWLHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Dec 2017 06:07:33 -0500
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <ysxie@foxmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v3 08/27] PCI: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 18:58:44 +0800
Message-ID: <1514026724-32962-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index e77a4cee..3f3712a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -637,7 +637,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
-	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
+	base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!base)
 		return -ENOMEM;
 
-- 
1.8.3.1

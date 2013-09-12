Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38426 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab3ILJh1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 05:37:27 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT000M22API9DT0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Sep 2013 18:37:19 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
In-reply-to: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
Subject: [PATCH 3/3] PCI: mvebu: add missing __iomem annotation
Date: Thu, 12 Sep 2013 18:37:18 +0900
Message-id: <000501ceaf9b$acaec690$060c53b0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added missing __iomem annotation in order to fix the following
sparse warning:

drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different address spaces)
drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
drivers/pci/host/pci-mvebu.c:744:31:    got void *

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-mvebu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b54ceb1..2d8e478 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -741,7 +741,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 
 	ret = of_address_to_resource(np, 0, &regs);
 	if (ret)
-		return ERR_PTR(ret);
+		return (void __iomem *)ERR_PTR(ret);
 
 	return devm_ioremap_resource(&pdev->dev, &regs);
 }
-- 
1.7.10.4



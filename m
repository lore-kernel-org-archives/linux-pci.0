Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64043 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3IQF1d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 01:27:33 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT900ERJ8HP32O0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 17 Sep 2013 14:27:32 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
In-reply-to: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
Subject: [PATCH V2 3/3] PCI: mvebu: add missing __iomem annotation
Date: Tue, 17 Sep 2013 14:27:31 +0900
Message-id: <001c01ceb366$9bad8740$d30895c0$%han@samsung.com>
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
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b54ceb1..fb2474f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -741,7 +741,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 
 	ret = of_address_to_resource(np, 0, &regs);
 	if (ret)
-		return ERR_PTR(ret);
+		return NULL;
 
 	return devm_ioremap_resource(&pdev->dev, &regs);
 }
@@ -940,11 +940,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
-		if (IS_ERR(port->base)) {
+		if (!port->base) {
 			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
 				port->port, port->lane);
 			clk_disable_unprepare(port->clk);
-			port->base = NULL;
 			continue;
 		}
 
-- 
1.7.10.4



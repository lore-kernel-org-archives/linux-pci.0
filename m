Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23134 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaKLDYZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:24:25 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00JS4PGOMY70@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:24:24 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Lucas Stach' <l.stach@pengutronix.de>
Subject: [PATCH] PCI: imx6: Use tabs for indentation
Date: Wed, 12 Nov 2014 12:25:09 +0900
Message-id: <002801cffe28$43176f70$c9464e50$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes the following checkpatch error.

  ERROR: code indent should use tabs where possible

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-imx6.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233fe8a..8a7530b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -526,8 +526,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 		}
 
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
-		                       imx6_pcie_msi_handler,
-		                       IRQF_SHARED, "mx6-pcie-msi", pp);
+				       imx6_pcie_msi_handler,
+				       IRQF_SHARED, "mx6-pcie-msi", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
 			return -ENODEV;
-- 
1.7.9.5



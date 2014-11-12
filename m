Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22770 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbaKLDW0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:22:26 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00H7WPD6ISA0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:22:18 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Santosh Shilimkar' <ssantosh@kernel.org>
Subject: [PATCH] PCI: keystone: Remove unnecessary OOM message
Date: Wed, 12 Nov 2014 12:22:56 +0900
Message-id: <002601cffe27$f7bca9f0$e735fdd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. This patch
fixes the following checkpatch warning.

  WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-keystone.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 1b893bc..62b9454 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -353,10 +353,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
 				GFP_KERNEL);
-	if (!ks_pcie) {
-		dev_err(dev, "no memory for keystone pcie\n");
+	if (!ks_pcie)
 		return -ENOMEM;
-	}
+
 	pp = &ks_pcie->pp;
 
 	/* initialize SerDes Phy if present */
-- 
1.7.9.5



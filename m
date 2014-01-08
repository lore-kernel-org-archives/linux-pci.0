Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:8075
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbaAHFCJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 00:02:09 -0500
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Zang Roy-R61911 <r61911@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH 09/12][v4] pci: fsl: update PCI PM driver
Date: Wed, 8 Jan 2014 13:02:00 +0800
Message-ID: <1389157323-3088-9-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch updates PCI PM driver, uses fsl_pci instead of
pci_controller.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index d608550..e3696eb 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -702,19 +702,12 @@ static int fsl_pci_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int fsl_pci_resume(struct device *dev)
 {
-	struct pci_controller *hose;
-	struct resource pci_rsrc;
+	struct fsl_pci *pci = dev_get_drvdata(dev);
 
-	hose = pci_find_hose_for_OF_device(dev->of_node);
-	if (!hose)
+	if (!pci)
 		return -ENODEV;
 
-	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
-		dev_err(dev, "Get pci register base failed.");
-		return -ENODEV;
-	}
-
-	setup_pci_atmu(hose);
+	setup_pci_atmu(pci);
 
 	return 0;
 }
-- 
1.8.1.2



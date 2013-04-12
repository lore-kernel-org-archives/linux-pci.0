Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46636 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3DLWpE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 18:45:04 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 21/29] PCI, xen: Use for_each_pci_resource() with xen pci
Date: Fri, 12 Apr 2013 15:44:35 -0700
Message-Id: <1365806683-26717-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
References: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: virtualization@lists.linux-foundation.org
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/pci/xen-pcifront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 966abc6..c90835f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -395,9 +395,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
 	int i;
 	struct resource *r;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = &dev->resource[i];
-
+	for_each_pci_resource(dev, r, i, PCI_ALL_RES) {
 		if (!r->parent && r->start && r->flags) {
 			dev_info(&pdev->xdev->dev, "claiming resource %s/%d\n",
 				pci_name(dev), i);
-- 
1.8.1.4


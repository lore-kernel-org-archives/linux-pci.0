Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54080 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HUXjc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:32 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so2242018obb.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:31 -0700 (PDT)
Subject: [PATCH v7 3/5] PCI: Remove unnecessary check for pcie_get_mps()
 failure
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:29 -0600
Message-ID: <20130821233929.2300.74057.stgit@bhelgaas-glaptop>
In-Reply-To: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
References: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>

After 59875ae489 ("PCI/core: Use PCI Express Capability accessors"),
pcie_get_mps() never returns an error, so don't bother to check for it.

No functional change.

[bhelgaas: changelog, fix pcie_get_mps() doc]
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e37fea6..5bb97ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3525,8 +3525,6 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
 		int mps = pcie_get_mps(dev);
 
-		if (mps < 0)
-			return mps;
 		if (mps < rq)
 			rq = mps;
 	}
@@ -3543,7 +3541,6 @@ EXPORT_SYMBOL(pcie_set_readrq);
  * @dev: PCI device to query
  *
  * Returns maximum payload size in bytes
- *    or appropriate error value.
  */
 int pcie_get_mps(struct pci_dev *dev)
 {


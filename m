Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:7185 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261Ab3HBJd5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:33:57 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: remove unnecessary check for mps in pcie_get_mps()
Date: Fri, 2 Aug 2013 17:33:38 +0800
Message-ID: <1375436018-26732-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit 59875ae489, pcie_get_mps() will never
return Negative value. So remove the unnecessary check code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a8d5fd0..84a3c09 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3586,8 +3586,6 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
 		int mps = pcie_get_mps(dev);
 
-		if (mps < 0)
-			return mps;
 		if (mps < rq)
 			rq = mps;
 	}
-- 
1.7.1



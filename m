Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44264 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3HSDrU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Aug 2013 23:47:20 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2] PCI: clean up dead code in pcie_get_mps()
Date: Mon, 19 Aug 2013 11:47:00 +0800
Message-ID: <1376884020-37104-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1->v2: rename patch name and update patch log
        the v1 patch https://patchwork.kernel.org/patch/2837637/

After commit 59875ae489, pcie_get_mps() will never
return negative value. So we can remove two lines
of dead code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 10e3c4e..86beb31 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3919,8 +3919,6 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
 		int mps = pcie_get_mps(dev);
 
-		if (mps < 0)
-			return mps;
 		if (mps < rq)
 			rq = mps;
 	}
-- 
1.7.1



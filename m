Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:26031 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab3HVD1M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 23:27:12 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v8 3/6] PCI: Remove unnecessary check for pcie_get_mps() failure
Date: Thu, 22 Aug 2013 11:24:45 +0800
Message-ID: <1377141888-7000-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After 59875ae489 ("PCI/core: Use PCI Express Capability accessors"),
pcie_get_mps() never returns an error, so don't bother to check for it.

No functional change.

[bhelgaas: changelog, fix pcie_get_mps() doc]
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 10e3c4e..9cdba6a 100644
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
@@ -3937,7 +3935,6 @@ EXPORT_SYMBOL(pcie_set_readrq);
  * @dev: PCI device to query
  *
  * Returns maximum payload size in bytes
- *    or appropriate error value.
  */
 int pcie_get_mps(struct pci_dev *dev)
 {
-- 
1.7.1



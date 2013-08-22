Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:26032 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab3HVD0u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 23:26:50 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: [PATCH v8 1/6] PCI: Drop "PCI-E" prefix from Max Payload Size message
Date: Thu, 22 Aug 2013 11:24:43 +0800
Message-ID: <1377141888-7000-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The conventional spelling is "PCIe", but I think even that is superfluous,
so remove the whole thing.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf57fe7..1fa9e5e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1596,7 +1596,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	pcie_write_mps(dev, mps);
 	pcie_write_mrrs(dev);
 
-	dev_info(&dev->dev, "PCI-E Max Payload Size set to %4d/%4d (was %4d), "
+	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d), "
 		 "Max Read Rq %4d\n", pcie_get_mps(dev), 128 << dev->pcie_mpss,
 		 orig_mps, pcie_get_readrq(dev));
 
-- 
1.7.1



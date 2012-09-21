Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:17068 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab2IUIpA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 04:45:00 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v5 2/5] PCI/AER: use list_for_each_entry to avoid a small race condition window
Date: Fri, 21 Sep 2012 16:43:10 +0800
Message-ID: <1348216993-6948-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348216993-6948-1-git-send-email-wangyijing@huawei.com>
References: <1348216993-6948-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we rmmod aer_inject module, there is a small race condition window between pci_bus_ops_pop()
and pci_bus_set_ops() in aer_inject_exit, eg. pci_read_aer/pci_write_aer was called between
them. So keep pci_bus_ops_list until pci_bus_set_ops complete, use list_for_each_entry() instead of
pci_bus_ops_pop to get bus_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index fdab3bb..f499f01 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -543,10 +543,11 @@ static void __exit aer_inject_exit(void)
 
 	misc_deregister(&aer_inject_device);
 
-	while ((bus_ops = pci_bus_ops_pop())) {
+	list_for_each_entry(bus_ops, &pci_bus_ops_list, list)
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
+
+	while ((bus_ops = pci_bus_ops_pop()))
 		kfree(bus_ops);
-	}
 
 	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
-- 
1.7.1



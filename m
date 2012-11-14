Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:54648 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161213Ab2KNM2V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2012 07:28:21 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Huang Ying <ying.huang@intel.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v5 2/5][RESEND] PCI/AER: use list_for_each_entry to avoid a small race condition window
Date: Wed, 14 Nov 2012 20:27:19 +0800
Message-ID: <1352896042-11832-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1352896042-11832-1-git-send-email-wangyijing@huawei.com>
References: <1352896042-11832-1-git-send-email-wangyijing@huawei.com>
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



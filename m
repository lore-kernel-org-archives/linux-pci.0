Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:29551 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab2HPMNQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 08:13:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] PCI, acpiphp: Use res->flags to determine whether the resouce is valid
Date: Thu, 16 Aug 2012 20:12:22 +0800
Message-ID: <1345119142-5896-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
References: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we hot plug pci devices, system will allocate resources to these new add
devices, pci_bus_assign_resources() will be called.If the pci devices was assigned
resource fail, the resource struct will reset to zero.So I think use res->flags here
to determine whether the resource is valid is reliable.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 7bbd6bf..2161902 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1084,13 +1084,11 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
 	int i;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
 
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
 		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
 			struct resource *res = &dev->resource[i];
-			if ((res->flags & type_mask) && !res->start &&
-					res->end) {
+			if (!res->flags) {
 				/* Could not assign a required resources
 				 * for this device, remove it */
 				pci_stop_and_remove_bus_device(dev);
-- 
1.7.1



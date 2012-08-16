Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:10566 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab2HPMNK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 08:13:10 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/3] PCI, acpiphp: Use list_for_each_entry_safe instead of list_for_each_entry
Date: Thu, 16 Aug 2012 20:12:21 +0800
Message-ID: <1345119142-5896-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
References: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

list_for_each_entry is not safe, use list_for_each_entry_safe fix this.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index a372ade..7bbd6bf 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1082,11 +1082,11 @@ static void acpiphp_set_hpp_values(struct pci_bus *bus)
  */
 static void acpiphp_sanitize_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *tmp;
 	int i;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
 
-	list_for_each_entry(dev, &bus->devices, bus_list) {
+	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
 		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
 			struct resource *res = &dev->resource[i];
 			if ((res->flags & type_mask) && !res->start &&
-- 
1.7.1



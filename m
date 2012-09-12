Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60909 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab2ILMff (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2012 08:35:35 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/4] PCI/AER: Fix pci_ops return NULL when hotplug a pci bus doing aer error inject
Date: Wed, 12 Sep 2012 20:33:42 +0800
Message-ID: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we inject aer errors to the target pcie device by aer_inject module, the pci_ops of pci
bus which the target device is on will be assigned to pci_ops_aer.So if the target pci device
is a bridge, once we hot-remove and hot-add the bridge, the newly created child bus's pci_ops
will be assigned to pci_ops_aer too.Now every access to the child bus's devices will result to
system panic, because it get a NULL pci_ops in pci_read_aer/pci_write_aer.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Reviewed-by: Sven Dietrich <Sven.Dietrich@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 4e24cb8..0816483 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -109,6 +109,19 @@ static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
 	return __find_aer_error((u16)domain, dev->bus->number, dev->devfn);
 }
 
+static bool pci_is_upstream_bus(struct pci_bus *bus, struct pci_bus *up_bus)
+{
+	struct pci_bus *pbus = bus->parent;
+
+	while (pbus) {
+		if (pbus == up_bus)
+			return true;
+		pbus = pbus->parent;
+	}
+
+	return false;
+}
+
 /* inject_lock must be held before calling */
 static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 {
@@ -118,6 +131,13 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 		if (bus_ops->bus == bus)
 			return bus_ops->ops;
 	}
+
+	/* can't find bus_ops, fall back to get bus_ops of upstream bus */
+	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
+		if (pci_is_upstream_bus(bus, bus_ops->bus))
+			return bus_ops->ops;
+	}
+
 	return NULL;
 }
 
@@ -208,6 +228,7 @@ static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 out:
 	ops = __find_pci_bus_ops(bus);
+	BUG_ON(!ops);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return ops->read(bus, devfn, where, size, val);
 }
@@ -243,6 +264,7 @@ int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where, int size,
 	}
 out:
 	ops = __find_pci_bus_ops(bus);
+	BUG_ON(!ops);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return ops->write(bus, devfn, where, size, val);
 }
@@ -506,6 +528,7 @@ static struct miscdevice aer_inject_device = {
 	.fops = &aer_inject_fops,
 };
 
+
 static int __init aer_inject_init(void)
 {
 	return misc_register(&aer_inject_device);
-- 
1.7.1



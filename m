Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 61/61] PCI: Only try to assign io port only for root bus that support it
Date: Tue, 27 Oct 2015 13:55:53 -0700
Message-Id: <1445979353-1728-62-git-send-email-yinghai@kernel.org>
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI subsystem always assumes that I/O is supported on root bus and
tries to assign an I/O window to each child bus even if that is not the
case.

The use cases is on Intel 8 socket system that have 8 root buses,
last two root buses would not have io port resources from _CRS.

Check if root bus supports I/O, and later during sizing and
assigning, check that flags and skip those resources.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c     | 6 ++++++
 drivers/pci/setup-bus.c | 9 +++++++++
 include/linux/pci.h     | 1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f9589d9..d5fca94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -339,6 +339,9 @@ static void pci_read_bridge_io(struct pci_bus *child)
 	struct pci_bus_region region;
 	struct resource *res;
 
+	if (!pci_find_host_bridge(child)->has_ioport)
+		return;
+
 	io_mask = PCI_IO_RANGE_MASK;
 	io_granularity = 0x1000;
 	if (dev->io_window_1k) {
@@ -2126,6 +2129,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 			bus_addr[0] = '\0';
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
 
+		if (resource_type(res) == IORESOURCE_IO)
+			bridge->has_ioport = 1;
+
 		if (resource_type(res) == IORESOURCE_MEM) {
 			if ((res->end - offset) > 0xffffffff)
 				bridge->has_mem64 = 1;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 22ee1a1..f4918d7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -226,6 +226,10 @@ static void pdev_assign_resources_prepare(struct pci_dev *dev,
 		if (resource_disabled(r) || r->parent)
 			continue;
 
+		if ((r->flags & IORESOURCE_IO) &&
+		    !pci_find_host_bridge(dev->bus)->has_ioport)
+			continue;
+
 		r_align = __pci_resource_alignment(dev, r, realloc_head);
 		if (!r_align) {
 			dev_warn(&dev->dev, "BAR %d: %pR has bogus alignment\n",
@@ -1189,6 +1193,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		min_size = 0;
 	}
 
+	if (!pci_find_host_bridge(bus)->has_ioport) {
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
+		return;
+	}
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6bc56f1..9ffe03c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -414,6 +414,7 @@ struct pci_host_bridge {
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
 	unsigned int has_mem64:1;
+	unsigned int has_ioport:1;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
-- 
1.8.4.5


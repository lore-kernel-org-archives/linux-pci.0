Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH V4 19/23] drivers: pci: add generic code to claim bus resources
Date: Thu,  4 Feb 2016 18:28:57 +0100
Message-Id: <1454606941-9523-20-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

PCI core code contains a set of functions, eg:

pci_assign_unassigned_bus_resources()

that allow to assign the PCI resources for a given bus after
enumeration.

On systems where the PCI BARs are immutable (ie they must not and can
not be assigned), PCI resources must be claimed in order to be
validated and inserted in the PCI resources tree, but there is no generic
PCI kernel function for that purpose and the resource claiming is
implemented in an arch specific fashion which resulted in arches
implementations that contain duplicated code.

This patch, based on the ia64 resource claiming arch implementation,
implements a set of functions in core PCI code that provides a PCI core
interface for resources claiming for a given PCI bus hierarchy, paving
the way for further resource claiming consolidation across architectures.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..c959398 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1424,6 +1424,69 @@ void pci_bus_assign_resources(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
 
+static void pci_claim_device_resources(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || r->parent)
+			continue;
+
+		pci_claim_resource(dev, i);
+	}
+}
+
+static void pci_claim_bridge_resources(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || r->parent)
+			continue;
+
+		pci_claim_bridge_resource(dev, i);
+	}
+}
+
+static void pci_bus_allocate_dev_resources(struct pci_bus *b)
+{
+	struct pci_dev *dev;
+	struct pci_bus *child;
+
+	list_for_each_entry(dev, &b->devices, bus_list) {
+		pci_claim_device_resources(dev);
+
+		child = dev->subordinate;
+		if (child)
+			pci_bus_allocate_dev_resources(child);
+	}
+}
+
+static void pci_bus_allocate_resources(struct pci_bus *b)
+{
+	struct pci_bus *child;
+
+	/* Depth-First Search on bus tree */
+	if (b->self) {
+		pci_read_bridge_bases(b);
+		pci_claim_bridge_resources(b->self);
+	}
+
+	list_for_each_entry(child, &b->children, node)
+		pci_bus_allocate_resources(child);
+}
+
+void pci_bus_claim_resources(struct pci_bus *b)
+{
+	pci_bus_allocate_resources(b);
+	pci_bus_allocate_dev_resources(b);
+}
+EXPORT_SYMBOL(pci_bus_claim_resources);
+
 static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 					  struct list_head *add_head,
 					  struct list_head *fail_head)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dac677c..6faf994 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1119,6 +1119,7 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
 void pci_bus_assign_resources(const struct pci_bus *bus);
+void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
-- 
1.9.1


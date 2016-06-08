Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] PCI: add generic code to claim bus resources
Date: Wed,  8 Jun 2016 12:04:47 +0100
Message-Id: <1465383890-13538-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 David Daney <david.daney@cavium.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

PCI core code contains a set of functions, eg:

pci_assign_unassigned_bus_resources()

that allow to assign the PCI resources for a given bus after
enumeration.

On systems where the PCI BARs are immutable (ie they must not and can
not be assigned), PCI bus resources should still be inserted in the PCI
resources tree (even if they are not (re)-assigned), but there is
no generic PCI kernel function for that purpose. Currently the PCI bus
resources insertion in the resources tree is implemented in an arch
specific fashion through arch specific callbacks that rely on the PCI
resources claiming API (for bridges and devices) which resulted in arches
implementations that contain duplicated code to claim resources for a
given PCI bus hierarchy.

Based on the x86/ia64 resources claiming arch implementations, implement
a set of functions in core PCI code that provides a PCI core interface
for resources claiming for a given PCI bus hierarchy, paving the way for
further resource claiming consolidation across architectures.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..1d1a2c9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1423,6 +1423,74 @@ void pci_bus_assign_resources(const struct pci_bus *bus)
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
+	/*
+	 * Carry out a depth-first search on the PCI bus
+	 * tree to allocate bridge apertures. Read the
+	 * programmed bridge bases and recursively claim
+	 * the respective bridge resources.
+	 */
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
index b67e4df..cea1a66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1114,6 +1114,7 @@ int pci_set_vpd_size(struct pci_dev *dev, size_t len);
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
 void pci_bus_assign_resources(const struct pci_bus *bus);
+void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

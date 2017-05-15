Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: [RFC/RFT PATCH v2 3/3] PCI/ACPI: Add ACPI pci_bus_find_numa_node() implementation
Date: Mon, 15 May 2017 14:22:05 +0100
Message-Id: <20170515132205.19622-4-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
References: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_bus_find_numa_node(pci_bus) allows at PCI
host bridge registration to detect the NUMA node for a given
struct pci_bus.dev. Implement an ACPI method that, through
the struct pci_bus.bridge ACPI companion, retrieve and return
the NUMA node corresponding to a given struct pci_bus.dev.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c | 20 ++++++++++++++++++++
 drivers/pci/pci.c      |  2 +-
 include/linux/pci.h    |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0018603..915da79 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
+#include <linux/numa.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/pci_hotplug.h>
@@ -853,6 +854,25 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
 	return irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI);
 }
 
+int acpi_pci_bus_find_numa_node(struct pci_bus *bus)
+{
+	int node = NUMA_NO_NODE;
+	struct device *bridge = get_device(bus->bridge);
+
+	if (!bridge)
+		return node;
+
+	if (has_acpi_companion(bridge)) {
+		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
+
+		node = acpi_get_node(adev->handle);
+	}
+
+	put_device(bridge);
+
+	return node;
+}
+
 static int __init acpi_pci_init(void)
 {
 	int ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9803c1..451342d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5406,7 +5406,7 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 
 int pci_bus_find_numa_node(struct pci_bus *bus)
 {
-	return NUMA_NO_NODE;
+	return acpi_disabled ? NUMA_NO_NODE : acpi_pci_bus_find_numa_node(bus);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ccbeefd..ed89220 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1472,6 +1472,12 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
+#ifdef CONFIG_ACPI
+int acpi_pci_bus_find_numa_node(struct pci_bus *bus);
+#else
+static inline int acpi_pci_bus_find_numa_node(struct pci_bus *bus)
+{ return NUMA_NO_NODE; }
+#endif
 int pci_bus_find_numa_node(struct pci_bus *bus);
 
 /* some architectures require additional setup to direct VGA traffic */
-- 
2.10.0


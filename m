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
Subject: [RFC/RFT PATCH v2 1/3] PCI: Introduce pci_bus_find_numa_node()
Date: Mon, 15 May 2017 14:22:03 +0100
Message-Id: <20170515132205.19622-2-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
References: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Create an empty stub, to be populated by firmware methods, to
retrieve the NUMA node for a given pci_bus. No functional change
introduced.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 6 ++++++
 include/linux/pci.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5b..e9803c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/numa.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -5403,6 +5404,11 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 #endif
 #endif
 
+int pci_bus_find_numa_node(struct pci_bus *bus)
+{
+	return NUMA_NO_NODE;
+}
+
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b..ccbeefd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1472,6 +1472,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
+int pci_bus_find_numa_node(struct pci_bus *bus);
 
 /* some architectures require additional setup to direct VGA traffic */
 typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
-- 
2.10.0


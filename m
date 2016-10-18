Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030487AbcJRQEL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Oct 2016 12:04:11 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 07/16] drivers: acpi: implement acpi_dma_configure
Date: Tue, 18 Oct 2016 17:04:05 +0100
Message-Id: <20161018160414.1228-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On DT based systems, the of_dma_configure() API implements DMA
configuration for a given device. On ACPI systems an API equivalent to
of_dma_configure() is missing which implies that it is currently not
possible to set-up DMA operations for devices through the ACPI generic
kernel layer.

This patch fills the gap by introducing acpi_dma_configure/deconfigure()
calls that for now are just wrappers around arch_setup_dma_ops() and
arch_teardown_dma_ops() and also updates ACPI and PCI core code to use
the newly introduced acpi_dma_configure/acpi_dma_deconfigure functions.

Since acpi_dma_configure() is used to configure DMA operations, the
function initializes the dma/coherent_dma masks to sane default values
if the current masks are uninitialized (also to keep the default values
consistent with DT systems) to make sure the device has a complete
default DMA set-up.

The DMA range size passed to arch_setup_dma_ops() is sized according
to the device coherent_dma_mask (starting at address 0x0), mirroring the
DT probing path behaviour when a dma-ranges property is not provided
for the device being probed; this changes the current arch_setup_dma_ops()
call parameters in the ACPI probing case, but since arch_setup_dma_ops()
is a NOP on all architectures but ARM/ARM64 this patch does not change
the current kernel behaviour on them.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> [pci]
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/glue.c     |  4 ++--
 drivers/acpi/scan.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c     |  3 +--
 include/acpi/acpi_bus.h |  2 ++
 include/linux/acpi.h    |  5 +++++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 5ea5dc2..f8d6564 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -227,8 +227,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 
 	attr = acpi_get_dma_attr(acpi_dev);
 	if (attr != DEV_DMA_NOT_SUPPORTED)
-		arch_setup_dma_ops(dev, 0, 0, NULL,
-				   attr == DEV_DMA_COHERENT);
+		acpi_dma_configure(dev, attr);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
@@ -251,6 +250,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	return 0;
 
  err:
+	acpi_dma_deconfigure(dev);
 	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
 	put_device(&acpi_dev->dev);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 035ac64..694e0b6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1370,6 +1370,46 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 		return DEV_DMA_NON_COHERENT;
 }
 
+/**
+ * acpi_dma_configure - Set-up DMA configuration for the device.
+ * @dev: The pointer to the device
+ * @attr: device dma attributes
+ */
+void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
+{
+	/*
+	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
+	 * setup the correct supported mask.
+	 */
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	/*
+	 * Set it to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+
+	/*
+	 * Assume dma valid range starts at 0 and covers the whole
+	 * coherent_dma_mask.
+	 */
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
+			   attr == DEV_DMA_COHERENT);
+}
+EXPORT_SYMBOL_GPL(acpi_dma_configure);
+
+/**
+ * acpi_dma_deconfigure - Tear-down DMA configuration for the device.
+ * @dev: The pointer to the device
+ */
+void acpi_dma_deconfigure(struct device *dev)
+{
+	arch_teardown_dma_ops(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_dma_deconfigure);
+
 static void acpi_init_coherency(struct acpi_device *adev)
 {
 	unsigned long long cca = 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab00267..c29e07a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1738,8 +1738,7 @@ static void pci_dma_configure(struct pci_dev *dev)
 		if (attr == DEV_DMA_NOT_SUPPORTED)
 			dev_warn(&dev->dev, "DMA not supported.\n");
 		else
-			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
-					   attr == DEV_DMA_COHERENT);
+			acpi_dma_configure(&dev->dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c1a524d..4242c31 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -573,6 +573,8 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
+void acpi_dma_deconfigure(struct device *dev);
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a284273..3abbf2b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -763,6 +763,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
+static inline void acpi_dma_configure(struct device *dev,
+				      enum dev_dma_attr attr) { }
+
+static inline void acpi_dma_deconfigure(struct device *dev) { }
+
 #define ACPI_PTR(_ptr)	(NULL)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
-- 
2.10.0


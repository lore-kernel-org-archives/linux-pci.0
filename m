Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 12/15] drivers: acpi: implement acpi_dma_configure
Date: Tue,  7 Jun 2016 14:31:07 +0100
Message-Id: <1465306270-27076-13-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On DT based systems, the of_dma_configure() API implements DMA configuration
for a given device. On ACPI systems an API equivalent to of_dma_configure()
is missing which implies that it is currently not possible to set-up DMA
operations for devices through the ACPI generic kernel layer.

This patch fills the gap by introducing acpi_dma_configure/deconfigure()
calls that for now are just wrappers around arch_setup_dma_ops() and
arch_teardown_dma_ops() and also updates ACPI and PCI core code to use
the newly introduced acpi_dma_configure/acpi_dma_deconfigure functions.

The DMA range size passed to arch_setup_dma_ops() is sized according
to the device coherent_dma_mask (starting at address 0x0), mirroring the
DT probing path behaviour when a dma-ranges property is not provided
for the device being probed; this changes the current arch_setup_dma_ops()
call parameters in the ACPI probing case, but since arch_setup_dma_ops()
is a NOP on all architectures but ARM/ARM64 this patch does not change
the current kernel behaviour on them.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/glue.c     |  4 ++--
 drivers/acpi/scan.c     | 24 ++++++++++++++++++++++++
 drivers/pci/probe.c     |  3 +--
 include/acpi/acpi_bus.h |  2 ++
 include/linux/acpi.h    |  5 +++++
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index 5f28cf7..b4b9064 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1358,6 +1358,30 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
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
+	 * Assume dma valid range starts at 0 and covers the whole
+	 * coherent_dma_mask.
+	 */
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
+			   attr == DEV_DMA_COHERENT);
+}
+
+/**
+ * acpi_dma_deconfigure - Tear-down DMA configuration for the device.
+ * @dev: The pointer to the device
+ */
+void acpi_dma_deconfigure(struct device *dev)
+{
+	arch_teardown_dma_ops(dev);
+}
+
 static void acpi_init_coherency(struct acpi_device *adev)
 {
 	unsigned long long cca = 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e3ef72..01dd369 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1725,8 +1725,7 @@ static void pci_dma_configure(struct pci_dev *dev)
 		if (attr == DEV_DMA_NOT_SUPPORTED)
 			dev_warn(&dev->dev, "DMA not supported.\n");
 		else
-			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
-					   attr == DEV_DMA_COHERENT);
+			acpi_dma_configure(&dev->dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 788c6c35..8b5039a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -566,6 +566,8 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
+void acpi_dma_deconfigure(struct device *dev);
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..135a452 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -676,6 +676,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
+static inline void acpi_dma_configure(struct device *dev,
+				      enum dev_dma_attr attr) { }
+
+static inline void acpi_dma_deconfigure(struct device *dev) { }
+
 #define ACPI_PTR(_ptr)	(NULL)
 
 #endif	/* !CONFIG_ACPI */
-- 
2.6.4

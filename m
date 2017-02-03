Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V8 06/11] of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices
Date: Fri,  3 Feb 2017 21:18:48 +0530
Message-Id: <1486136933-20328-7-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Configuring DMA ops at probe time will allow deferring device probe when
the IOMMU isn't available yet. The dma_configure for the device is
now called from the generic device_attach callback just before the
bus/driver probe is called. This way, configuring the DMA ops for the
device would be called at the same place for all bus_types, hence the
deferred probing mechanism should work for all buses as well.

pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
       |                         |
pci_bus_add_device     (device_add/driver_register)
       |                         |
device_attach           device_initial_probe
       |                         |
__device_attach_driver    __device_attach_driver
       |
driver_probe_device
       |
really_probe
       |
dma_configure

Similarly on the device/driver_unregister path __device_release_driver is
called which inturn calls dma_deconfigure.

This patch changes the dma ops configuration to probe time for
both OF and ACPI based platform/amba/pci bus devices.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> (drivers/pci part)
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/acpi/glue.c         |  5 -----
 drivers/base/dd.c           |  9 +++++++++
 drivers/base/dma-mapping.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c       |  5 +----
 drivers/pci/probe.c         | 28 ----------------------------
 include/linux/dma-mapping.h |  3 +++
 6 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index fb19e1c..c05f241 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -176,7 +176,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval = -EINVAL;
-	enum dev_dma_attr attr;
 
 	if (has_acpi_companion(dev)) {
 		if (acpi_dev) {
@@ -233,10 +232,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	if (!has_acpi_companion(dev))
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
-	attr = acpi_get_dma_attr(acpi_dev);
-	if (attr != DEV_DMA_NOT_SUPPORTED)
-		acpi_dma_configure(dev, attr);
-
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				   physical_node_name);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a1fbf55..4882f06 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
@@ -356,6 +357,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
+	ret = dma_configure(dev);
+	if (ret)
+		goto dma_failed;
+
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
 			__func__, dev_name(dev));
@@ -417,6 +422,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
+	dma_deconfigure(dev);
+dma_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
@@ -826,6 +833,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			drv->remove(dev);
 
 		device_links_driver_cleanup(dev);
+		dma_deconfigure(dev);
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index efd71cf..449b948 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -7,9 +7,11 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -341,3 +343,41 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 	vunmap(cpu_addr);
 }
 #endif
+
+/*
+ * Common configuration to enable DMA API use for a device
+ */
+#include <linux/pci.h>
+
+int dma_configure(struct device *dev)
+{
+	struct device *bridge = NULL, *dma_dev = dev;
+	enum dev_dma_attr attr;
+
+	if (dev_is_pci(dev)) {
+		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+		dma_dev = bridge;
+		if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
+		    dma_dev->parent->of_node)
+			dma_dev = dma_dev->parent;
+	}
+
+	if (dma_dev->of_node) {
+		of_dma_configure(dev, dma_dev->of_node);
+	} else if (has_acpi_companion(dma_dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			acpi_dma_configure(dev, attr);
+	}
+
+	if (bridge)
+		pci_put_host_bridge_device(bridge);
+
+	return 0;
+}
+
+void dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+	acpi_dma_deconfigure(dev);
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 57418f7..cf35030 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -186,11 +187,9 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
-		of_dma_deconfigure(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -248,7 +247,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
@@ -542,7 +540,6 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
-	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 139466c..c11b3de 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1875,33 +1875,6 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 	dev_set_msi_domain(&dev->dev, d);
 }
 
-/**
- * pci_dma_configure - Setup DMA configuration
- * @dev: ptr to pci_dev struct of the PCI device
- *
- * Function to update PCI devices's DMA configuration using the same
- * info from the OF node or ACPI node of host bridge's parent (if any).
- */
-static void pci_dma_configure(struct pci_dev *dev)
-{
-	struct device *bridge = pci_get_host_bridge_device(dev);
-
-	if (IS_ENABLED(CONFIG_OF) &&
-		bridge->parent && bridge->parent->of_node) {
-			of_dma_configure(&dev->dev, bridge->parent->of_node);
-	} else if (has_acpi_companion(bridge)) {
-		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
-		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
-
-		if (attr == DEV_DMA_NOT_SUPPORTED)
-			dev_warn(&dev->dev, "DMA not supported.\n");
-		else
-			acpi_dma_configure(&dev->dev, attr);
-	}
-
-	pci_put_host_bridge_device(bridge);
-}
-
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -1915,7 +1888,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
-	pci_dma_configure(dev);
 
 	pci_set_dma_max_seg_size(dev, 65536);
 	pci_set_dma_seg_boundary(dev, 0xffffffff);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c24721a..5972087 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -715,6 +715,9 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
+int dma_configure(struct device *dev);
+void dma_deconfigure(struct device *dev);
+
 /*
  * Managed DMA API
  */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


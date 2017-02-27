Return-Path: <linux-arch-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        John Garry <john.garry@huawei.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Jon Mason <jonmason@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 07/20] PCI: implement Devres interface to map PCI config space
Date: Mon, 27 Feb 2017 15:14:18 +0000
Message-Id: <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of the pci_remap_cfgspace() interface allows
PCI host controller drivers to map PCI config space through a
dedicated kernel interface. Current PCI host controller drivers
use the devm_ioremap_* Devres interfaces to map PCI configuration
space regions so in order to update them to the new
pci_remap_cfgspace() mapping interface a new set of Devres interfaces
should be implemented so that PCI host controller drivers can make
use of them.

Introduce two new functions in the PCI kernel layer and Devres
documentation:

- devm_pci_remap_cfgspace()
- devm_pci_remap_cfg_resource()

so that PCI host controller drivers can make use of them to map
PCI configuration space regions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/driver-model/devres.txt |  6 ++-
 drivers/pci/pci.c                     | 82 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h                   |  5 +++
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index bf34d5b..e72587f 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -342,8 +342,10 @@ PER-CPU MEM
   devm_free_percpu()
 
 PCI
-  pcim_enable_device()	: after success, all PCI ops become managed
-  pcim_pin_device()	: keep PCI device enabled after release
+  devm_pci_remap_cfgspace()	: ioremap PCI configuration space
+  devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
+  pcim_enable_device()		: after success, all PCI ops become managed
+  pcim_pin_device()		: keep PCI device enabled after release
 
 PHY
   devm_usb_get_phy()
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfb3c6e..1e435c2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3401,6 +3401,88 @@ void pci_unmap_iospace(struct resource *res)
 #endif
 }
 
+/**
+ * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_pci_remap_cfgspace(struct device *dev,
+				      resource_size_t offset,
+				      resource_size_t size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = pci_remap_cfgspace(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfgspace);
+
+/**
+ * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
+ * @dev: generic device to handle the resource for
+ * @res: configuration space resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps with pci_remap_cfgspace() API that ensures the
+ * proper PCI configuration space memory attributes are guaranteed.
+ *
+ * All operations are managed and will be undone on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example:
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
+					  struct resource *res)
+{
+	resource_size_t size;
+	const char *name;
+	void __iomem *dest_ptr;
+
+	BUG_ON(!dev);
+
+	if (!res || resource_type(res) != IORESOURCE_MEM) {
+		dev_err(dev, "invalid resource\n");
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+	name = res->name ?: dev_name(dev);
+
+	if (!devm_request_mem_region(dev, res->start, size, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return IOMEM_ERR_PTR(-EBUSY);
+	}
+
+	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
+	if (!dest_ptr) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		devm_release_mem_region(dev, res->start, size);
+		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
+
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 282ed32..5a3588b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1199,6 +1199,11 @@ unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
 void pci_unmap_iospace(struct resource *res);
+void __iomem *devm_pci_remap_cfgspace(struct device *dev,
+				      resource_size_t offset,
+				      resource_size_t size);
+void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
+					  struct resource *res);
 
 static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
 {
-- 
2.10.0

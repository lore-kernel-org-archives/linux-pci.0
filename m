Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vw0-f74.google.com ([209.85.212.74]:48559 "EHLO
	mail-vw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030771Ab2CGWds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:33:48 -0500
Received: by mail-vw0-f74.google.com with SMTP id l22so865384vbn.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:33:47 -0800 (PST)
Subject: [PATCH v3 20/34] arm/PCI: get rid of device resource fixups
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>
Date: Wed, 07 Mar 2012 15:33:46 -0700
Message-ID: <20120307223346.25669.47622.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/common/it8152.c              |    4 +-
 arch/arm/include/asm/pci.h            |    8 ----
 arch/arm/kernel/bios32.c              |   69 ++-------------------------------
 arch/arm/mach-cns3xxx/pcie.c          |    4 +-
 arch/arm/mach-dove/pcie.c             |    4 +-
 arch/arm/mach-footbridge/dc21285.c    |    8 ++--
 arch/arm/mach-integrator/pci_v3.c     |    7 ++-
 arch/arm/mach-iop13xx/pci.c           |    4 +-
 arch/arm/mach-ixp2000/pci.c           |    6 ++-
 arch/arm/mach-ixp23xx/pci.c           |    6 ++-
 arch/arm/mach-ixp4xx/common-pci.c     |    4 +-
 arch/arm/mach-kirkwood/pcie.c         |    4 +-
 arch/arm/mach-ks8695/pci.c            |    4 +-
 arch/arm/mach-mv78xx0/pcie.c          |    4 +-
 arch/arm/mach-orion5x/pci.c           |   14 +++----
 arch/arm/mach-sa1100/pci-nanoengine.c |    8 ++--
 arch/arm/mach-tegra/pcie.c            |    6 +--
 arch/arm/mach-versatile/pci.c         |    6 +--
 arch/arm/plat-iop/pci.c               |    4 +-
 19 files changed, 57 insertions(+), 117 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index d1bcd7b..9384c2d 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -299,8 +299,8 @@ int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
 		goto err1;
 	}
 
-	pci_add_resource(&sys->resources, &it8152_io);
-	pci_add_resource(&sys->resources, &it8152_mem);
+	pci_add_resource_offset(&sys->resources, &it8152_io, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &it8152_mem, sys->mem_offset);
 
 	if (platform_notify || platform_notify_remove) {
 		printk(KERN_ERR "PCI: Can't use platform_notify\n");
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index da337ba..4748a75 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -57,13 +57,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
                                enum pci_mmap_state mmap_state, int write_combine);
 
-extern void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res);
-
-extern void
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 /*
  * Dummy implementation; always return 0.
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a28c78e..632df9a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -294,28 +294,6 @@ static inline int pdev_bad_for_parity(struct pci_dev *dev)
 }
 
 /*
- * Adjust the device resources from bus-centric to Linux-centric.
- */
-static void __devinit
-pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
-{
-	resource_size_t offset;
-	int i;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		if (dev->resource[i].start == 0)
-			continue;
-		if (dev->resource[i].flags & IORESOURCE_MEM)
-			offset = root->mem_offset;
-		else
-			offset = root->io_offset;
-
-		dev->resource[i].start += offset;
-		dev->resource[i].end   += offset;
-	}
-}
-
-/*
  * pcibios_fixup_bus - Called after each bus is probed,
  * but before its children are examined.
  */
@@ -332,8 +310,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 status;
 
-		pdev_fixup_device_resources(root, dev);
-
 		pci_read_config_word(dev, PCI_STATUS, &status);
 
 		/*
@@ -399,43 +375,6 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
 #endif
 
 /*
- * Convert from Linux-centric to bus-centric addresses for bridge devices.
- */
-void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res)
-{
-	struct pci_sys_data *root = dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = root->io_offset;
-	if (res->flags & IORESOURCE_MEM)
-		offset = root->mem_offset;
-
-	region->start = res->start - offset;
-	region->end   = res->end - offset;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void __devinit
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region)
-{
-	struct pci_sys_data *root = dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = root->io_offset;
-	if (res->flags & IORESOURCE_MEM)
-		offset = root->mem_offset;
-
-	res->start = region->start + offset;
-	res->end   = region->end + offset;
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
-/*
  * Swizzle the device pin each time we cross a bridge.
  * This might update pin and returns the slot number.
  */
@@ -496,10 +435,10 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 
 		if (ret > 0) {
 			if (list_empty(&sys->resources)) {
-				pci_add_resource(&sys->resources,
-						 &ioport_resource);
-				pci_add_resource(&sys->resources,
-						 &iomem_resource);
+				pci_add_resource_offset(&sys->resources,
+					 &ioport_resource, sys->io_offset);
+				pci_add_resource_offset(&sys->resources,
+					 &iomem_resource, sys->mem_offset);
 			}
 
 			sys->bus = hw->scan(nr, sys);
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index e159d69..79d001f 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -155,8 +155,8 @@ static int cns3xxx_pci_setup(int nr, struct pci_sys_data *sys)
 	BUG_ON(request_resource(&iomem_resource, res_io) ||
 	       request_resource(&iomem_resource, res_mem));
 
-	pci_add_resource(&sys->resources, res_io);
-	pci_add_resource(&sys->resources, res_mem);
+	pci_add_resource_offset(&sys->resources, res_io, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, res_mem, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 52e96d3..48a0320 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -69,7 +69,7 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[0].flags = IORESOURCE_IO;
 	if (request_resource(&ioport_resource, &pp->res[0]))
 		panic("Request PCIe IO resource failed\n");
-	pci_add_resource(&sys->resources, &pp->res[0]);
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
 
 	/*
 	 * IORESOURCE_MEM
@@ -88,7 +88,7 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[1].flags = IORESOURCE_MEM;
 	if (request_resource(&iomem_resource, &pp->res[1]))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource(&sys->resources, &pp->res[1]);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index f685650..3194d3f 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -275,11 +275,13 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 	allocate_resource(&iomem_resource, &res[0], 0x40000000,
 			  0x80000000, 0xffffffff, 0x40000000, NULL, NULL);
 
-	pci_add_resource(&sys->resources, &ioport_resource);
-	pci_add_resource(&sys->resources, &res[0]);
-	pci_add_resource(&sys->resources, &res[1]);
 	sys->mem_offset  = DC21285_PCI_MEM;
 
+	pci_add_resource_offset(&sys->resources,
+				&ioport_resource, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
+
 	return 1;
 }
 
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 3c82566..015be77 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -378,9 +378,10 @@ static int __init pci_v3_setup_resources(struct pci_sys_data *sys)
 	 * the mem resource for this bus
 	 * the prefetch mem resource for this bus
 	 */
-	pci_add_resource(&sys->resources, &ioport_resource);
-	pci_add_resource(&sys->resources, &non_mem);
-	pci_add_resource(&sys->resources, &pre_mem);
+	pci_add_resource_offset(&sys->resources,
+				&ioport_resource, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index b8f5a87..861cb12 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -1084,8 +1084,8 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 	request_resource(&ioport_resource, &res[0]);
 	request_resource(&iomem_resource, &res[1]);
 
-	pci_add_resource(&sys->resources, &res[0]);
-	pci_add_resource(&sys->resources, &res[1]);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
index 626fda4..49c36f3 100644
--- a/arch/arm/mach-ixp2000/pci.c
+++ b/arch/arm/mach-ixp2000/pci.c
@@ -243,8 +243,10 @@ int ixp2000_pci_setup(int nr, struct pci_sys_data *sys)
 	if (nr >= 1)
 		return 0;
 
-	pci_add_resource(&sys->resources, &ixp2000_pci_io_space);
-	pci_add_resource(&sys->resources, &ixp2000_pci_mem_space);
+	pci_add_resource_offset(&sys->resources,
+				&ixp2000_pci_io_space, sys->io_offset);
+	pci_add_resource_offset(&sys->resources,
+				&ixp2000_pci_mem_space, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-ixp23xx/pci.c b/arch/arm/mach-ixp23xx/pci.c
index 25b5c46..3cbbd32 100644
--- a/arch/arm/mach-ixp23xx/pci.c
+++ b/arch/arm/mach-ixp23xx/pci.c
@@ -281,8 +281,10 @@ int ixp23xx_pci_setup(int nr, struct pci_sys_data *sys)
 	if (nr >= 1)
 		return 0;
 
-	pci_add_resource(&sys->resources, &ixp23xx_pci_io_space);
-	pci_add_resource(&sys->resources, &ixp23xx_pci_mem_space);
+	pci_add_resource_offset(&sys->resources,
+				&ixp23xx_pci_io_space, sys->io_offset);
+	pci_add_resource_offset(&sys->resources,
+				&ixp23xx_pci_mem_space, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 5eff15f..8508882 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -472,8 +472,8 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 	request_resource(&ioport_resource, &res[0]);
 	request_resource(&iomem_resource, &res[1]);
 
-	pci_add_resource(&sys->resources, &res[0]);
-	pci_add_resource(&sys->resources, &res[1]);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
 	platform_notify = ixp4xx_pci_platform_notify;
 	platform_notify_remove = ixp4xx_pci_platform_notify_remove;
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index a066a6d..f56a011 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -198,9 +198,9 @@ static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (request_resource(&iomem_resource, &pp->res[1]))
 		panic("Request PCIe%d Memory resource failed\n", index);
 
-	pci_add_resource(&sys->resources, &pp->res[0]);
-	pci_add_resource(&sys->resources, &pp->res[1]);
 	sys->io_offset = 0;
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
 
 	/*
 	 * Generic PCIe unit setup.
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index b26f992..acc7014 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -169,8 +169,8 @@ static int __init ks8695_pci_setup(int nr, struct pci_sys_data *sys)
 	request_resource(&iomem_resource, &pci_mem);
 	request_resource(&ioport_resource, &pci_io);
 
-	pci_add_resource(&sys->resources, &pci_io);
-	pci_add_resource(&sys->resources, &pci_mem);
+	pci_add_resource_offset(&sys->resources, &pci_io, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &pci_mem, sys->mem_offset);
 
 	/* Assign and enable processor bridge */
 	ks8695_local_writeconfig(PCI_BASE_ADDRESS_0, KS8695_PCIMEM_PA);
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 8459f6d..df3e380 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -155,8 +155,8 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 	orion_pcie_setup(pp->base);
 
-	pci_add_resource(&sys->resources, &pp->res[0]);
-	pci_add_resource(&sys->resources, &pp->res[1]);
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 09a045f..d6a9194 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -171,13 +171,14 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	/*
 	 * IORESOURCE_IO
 	 */
+	sys->io_offset = 0;
 	res[0].name = "PCIe I/O Space";
 	res[0].flags = IORESOURCE_IO;
 	res[0].start = ORION5X_PCIE_IO_BUS_BASE;
 	res[0].end = res[0].start + ORION5X_PCIE_IO_SIZE - 1;
 	if (request_resource(&ioport_resource, &res[0]))
 		panic("Request PCIe IO resource failed\n");
-	pci_add_resource(&sys->resources, &res[0]);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
 
 	/*
 	 * IORESOURCE_MEM
@@ -188,9 +189,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	res[1].end = res[1].start + ORION5X_PCIE_MEM_SIZE - 1;
 	if (request_resource(&iomem_resource, &res[1]))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource(&sys->resources, &res[1]);
-
-	sys->io_offset = 0;
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
 	return 1;
 }
@@ -499,13 +498,14 @@ static int __init pci_setup(struct pci_sys_data *sys)
 	/*
 	 * IORESOURCE_IO
 	 */
+	sys->io_offset = 0;
 	res[0].name = "PCI I/O Space";
 	res[0].flags = IORESOURCE_IO;
 	res[0].start = ORION5X_PCI_IO_BUS_BASE;
 	res[0].end = res[0].start + ORION5X_PCI_IO_SIZE - 1;
 	if (request_resource(&ioport_resource, &res[0]))
 		panic("Request PCI IO resource failed\n");
-	pci_add_resource(&sys->resources, &res[0]);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
 
 	/*
 	 * IORESOURCE_MEM
@@ -516,9 +516,7 @@ static int __init pci_setup(struct pci_sys_data *sys)
 	res[1].end = res[1].start + ORION5X_PCI_MEM_SIZE - 1;
 	if (request_resource(&iomem_resource, &res[1]))
 		panic("Request PCI Memory resource failed\n");
-	pci_add_resource(&sys->resources, &res[1]);
-
-	sys->io_offset = 0;
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index 0d01ca7..b466bca 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -244,9 +244,11 @@ static int __init pci_nanoengine_setup_resources(struct pci_sys_data *sys)
 		printk(KERN_ERR "PCI: unable to allocate prefetchable\n");
 		return -EBUSY;
 	}
-	pci_add_resource(&sys->resources, &pci_io_ports);
-	pci_add_resource(&sys->resources, &pci_non_prefetchable_memory);
-	pci_add_resource(&sys->resources, &pci_prefetchable_memory);
+	pci_add_resource_offset(&sys->resources, &pci_io_ports, sys->io_offset);
+	pci_add_resource_offset(&sys->resources,
+				&pci_non_prefetchable_memory, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources,
+				&pci_prefetchable_memory, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index af8b634..14b29ab 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -408,7 +408,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[0].flags = IORESOURCE_IO;
 	if (request_resource(&ioport_resource, &pp->res[0]))
 		panic("Request PCIe IO resource failed\n");
-	pci_add_resource(&sys->resources, &pp->res[0]);
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
 
 	/*
 	 * IORESOURCE_MEM
@@ -427,7 +427,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[1].flags = IORESOURCE_MEM;
 	if (request_resource(&iomem_resource, &pp->res[1]))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource(&sys->resources, &pp->res[1]);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
 
 	/*
 	 * IORESOURCE_MEM | IORESOURCE_PREFETCH
@@ -446,7 +446,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[2].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 	if (request_resource(&iomem_resource, &pp->res[2]))
 		panic("Request PCIe Prefetch Memory resource failed\n");
-	pci_add_resource(&sys->resources, &pp->res[2]);
+	pci_add_resource_offset(&sys->resources, &pp->res[2], sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 90069bc..51733b0 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -219,9 +219,9 @@ static int __init pci_versatile_setup_resources(struct list_head *resources)
 	 * the mem resource for this bus
 	 * the prefetch mem resource for this bus
 	 */
-	pci_add_resource(resources, &io_mem);
-	pci_add_resource(resources, &non_mem);
-	pci_add_resource(resources, &pre_mem);
+	pci_add_resource_offset(resources, &io_mem, sys->io_offset);
+	pci_add_resource_offset(resources, &non_mem, sys->mem_offset);
+	pci_add_resource_offset(resources, &pre_mem, sys->mem_offset);
 
 	goto out;
 
diff --git a/arch/arm/plat-iop/pci.c b/arch/arm/plat-iop/pci.c
index f4d40a2..7276835 100644
--- a/arch/arm/plat-iop/pci.c
+++ b/arch/arm/plat-iop/pci.c
@@ -215,8 +215,8 @@ int iop3xx_pci_setup(int nr, struct pci_sys_data *sys)
 	sys->mem_offset = IOP3XX_PCI_LOWER_MEM_PA - *IOP3XX_OMWTVR0;
 	sys->io_offset  = IOP3XX_PCI_LOWER_IO_PA - *IOP3XX_OIOWTVR;
 
-	pci_add_resource(&sys->resources, &res[0]);
-	pci_add_resource(&sys->resources, &res[1]);
+	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
 	return 1;
 }


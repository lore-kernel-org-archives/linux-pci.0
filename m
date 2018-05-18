Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/5] PCI/VMD: Assign membar addresses from shadow registers
Date: Fri, 18 May 2018 13:27:59 -0600
Message-Id: <20180518192802.20371-3-jonathan.derrick@intel.com>
In-Reply-To: <20180518192802.20371-1-jonathan.derrick@intel.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Certain VMD devices have registers within membar 2 which may shadow the
membar 1 and membar 2 addresses. These are intended to be used in
virtualization, where assigning a guest address wouldn't be translated
in the assignment to root port and child devices because the addresses
exist within the assignment message.

These values will only reflect the membars when enabled in the BIOS, as
determined by a register in the VMD device.

This patch declares this option as a bit in the pci id driver_data, so
that future conforming device ids can be enabled through sysfs new_id if
necessary.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index b10d2bce2993..1544121b74f3 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -24,6 +24,18 @@
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
 
+#define PCI_REG_VMLOCK		0x70
+#define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
+
+enum vmd_features {
+	/*
+	 * Device may contain registers which hint the physical location of the
+	 * membars, in order to allow proper address translation during
+	 * resource assignment to enable guest virtualization
+	 */
+	VMD_FEAT_HAS_MEMBAR_SHADOW	= (1 << 0),
+};
+
 /*
  * Lock for manipulating VMD IRQ lists.
  */
@@ -546,7 +558,7 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
-static int vmd_enable_domain(struct vmd_dev *vmd)
+static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
 	struct fwnode_handle *fn;
@@ -554,6 +566,37 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	u32 upper_bits;
 	unsigned long flags;
 	LIST_HEAD(resources);
+	resource_size_t offset[2] = {0};
+	resource_size_t membar2_offset = 0x2000;
+
+	/*
+	 * Shadow registers may exist in certain VMD device ids which allow
+	 * guests to correctly assign host physical addresses to the root ports
+	 * and child devices. These registers will either return the host value
+	 * or 0, depending on an enable bit in the VMD device.
+	 */
+	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
+		u32 vmlock;
+		int ret;
+
+		membar2_offset = 0x2018;
+		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
+		if (ret || vmlock == ~0)
+			return -ENODEV;
+
+		if (MB2_SHADOW_EN(vmlock)) {
+			void __iomem *membar2;
+
+			membar2 = pci_iomap(vmd->dev, VMD_MEMBAR2, 0);
+			if (!membar2)
+				return -ENOMEM;
+			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
+						readq(membar2 + 0x2008);
+			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
+						readq(membar2 + 0x2010);
+			pci_iounmap(vmd->dev, membar2);
+		}
+	}
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
@@ -600,7 +643,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		flags &= ~IORESOURCE_MEM_64;
 	vmd->resources[2] = (struct resource) {
 		.name  = "VMD MEMBAR2",
-		.start = res->start + 0x2000,
+		.start = res->start + membar2_offset,
 		.end   = res->end,
 		.flags = flags,
 		.parent = res,
@@ -624,8 +667,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		return -ENODEV;
 
 	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource(&resources, &vmd->resources[1]);
-	pci_add_resource(&resources, &vmd->resources[2]);
+	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, 0, &vmd_ops, sd,
 				       &resources);
 	if (!vmd->bus) {
@@ -713,7 +757,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd);
+	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
 	if (err)
 		return err;
 
-- 
2.14.3

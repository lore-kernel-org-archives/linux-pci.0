Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC PATCH 1/4] PCI/VMD: Assign membar addresses from shadow registers
Date: Thu, 10 May 2018 18:49:00 -0600
Message-Id: <20180511004903.19892-2-jonathan.derrick@intel.com>
In-Reply-To: <20180511004903.19892-1-jonathan.derrick@intel.com>
References: <20180511004903.19892-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The new VMD device has registers within membar 2 which may shadow the
membar 1 and membar 2 addresses. These are intended to be used in
virtualization, where assigning a guest address wouldn't be translated
in the assignment to root port and child devices because the addresses
exist within the assignment message.

These values will only reflect the membars when enabled in the BIOS, as
determined by a register in the VMD device.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c | 52 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 930a8fa08bd6..62270aeb7a2e 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -24,6 +24,9 @@
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
 
+#define PCI_REG_VMLOCK		0x70
+#define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
+
 /*
  * Lock for manipulating VMD IRQ lists.
  */
@@ -551,9 +554,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	struct pci_sysdata *sd = &vmd->sysdata;
 	struct fwnode_handle *fn;
 	struct resource *res;
-	u32 upper_bits;
 	unsigned long flags;
 	LIST_HEAD(resources);
+	resource_size_t start, end, membar2_offset;
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
@@ -581,27 +584,34 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	 * according to the platform needs.
 	 */
 	res = &vmd->dev->resource[VMD_MEMBAR1];
-	upper_bits = upper_32_bits(res->end);
+	start = vmd->resources[1].start;
+	end = start + resource_size(res) - 1;
 	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
+	if (upper_32_bits(end))
+		flags |= IORESOURCE_MEM_64;
+	else
 		flags &= ~IORESOURCE_MEM_64;
 	vmd->resources[1] = (struct resource) {
 		.name  = "VMD MEMBAR1",
-		.start = res->start,
-		.end   = res->end,
+		.start = start,
+		.end   = end,
 		.flags = flags,
 		.parent = res,
 	};
 
 	res = &vmd->dev->resource[VMD_MEMBAR2];
-	upper_bits = upper_32_bits(res->end);
+	start = vmd->resources[2].start;
+	end = start + resource_size(res) - 1;
 	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
+	if (upper_32_bits(end))
+		flags |= IORESOURCE_MEM_64;
+	else
 		flags &= ~IORESOURCE_MEM_64;
+	membar2_offset = (vmd->dev->device == 0x28c0) ? 0x2018 : 0x2000;
 	vmd->resources[2] = (struct resource) {
 		.name  = "VMD MEMBAR2",
-		.start = res->start + 0x2000,
-		.end   = res->end,
+		.start = start + membar2_offset,
+		.end   = end,
 		.flags = flags,
 		.parent = res,
 	};
@@ -662,6 +672,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
 	int i, err;
+	u32 vmlock = 0;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
@@ -711,6 +722,29 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return err;
 	}
 
+	/*
+	 * For the new VMD device id, shadow registers exist within the MEMBAR2
+	 * which allow guests to correctly assign host physical addresses to
+	 * the root ports and child devices. These registers will either return
+	 * the host value or 0, depending on an enable bit in the VMD device.
+	 */
+	if (id->device == 0x28c0)
+		pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
+
+	if (MB2_SHADOW_EN(vmlock)) {
+		void __iomem *membar2;
+
+		membar2 = pci_iomap(dev, VMD_MEMBAR2, 0);
+		if (!membar2)
+			return -ENOMEM;
+		vmd->resources[1].start = readq(membar2 + 0x2008);
+		vmd->resources[2].start = readq(membar2 + 0x2010);
+		pci_iounmap(dev, membar2);
+	} else {
+		vmd->resources[1].start = vmd->dev->resource[VMD_MEMBAR1].start;
+		vmd->resources[2].start = vmd->dev->resource[VMD_MEMBAR2].start;
+	}
+
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd);
-- 
2.14.3

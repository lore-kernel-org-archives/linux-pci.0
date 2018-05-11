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
Subject: [RFC PATCH 2/4] PCI/VMD: Add offset to bus numbers if necessary
Date: Thu, 10 May 2018 18:49:01 -0600
Message-Id: <20180511004903.19892-3-jonathan.derrick@intel.com>
In-Reply-To: <20180511004903.19892-1-jonathan.derrick@intel.com>
References: <20180511004903.19892-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Depending on platform configuration, the new VMD device's bus numbers
may require being offset by 128. We determine this requirement by
checking the value of two vendor specific capability registers in the
VMD endpoint:

 VMCAP[0] | VMCONFIG[9:8] | Bus Numbers
----------------------------------------
    0     |       *       |     0-255
    1     |      00       |     0-127
    1     |      01       |   128-255
    1     |      10       |     0-255

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 62270aeb7a2e..fdfc286a1c9e 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -24,6 +24,10 @@
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
 
+#define PCI_REG_VMCAP		0x40
+#define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
+#define PCI_REG_VMCONFIG	0x44
+#define BUS_RESTRICT_CFG(vmcfg)	((vmcfg >> 8) & 0x3)
 #define PCI_REG_VMLOCK		0x70
 #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
 
@@ -556,13 +560,27 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	struct resource *res;
 	unsigned long flags;
 	LIST_HEAD(resources);
-	resource_size_t start, end, membar2_offset;
+	resource_size_t start, end, membar2_offset, busn_start = 0;
+
+	/*
+	 * Depending on the root port configuration, VMD may assign bus numbers
+	 * between 0-127 or 128-255
+	 */
+	if (vmd->dev->device == 0x28c0) {
+		u32 vmcap, vmconfig;
+
+		pci_read_config_dword(vmd->dev, PCI_REG_VMCAP, &vmcap);
+		pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
+		if (BUS_RESTRICT_CAP(vmcap) &&
+		    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
+			busn_start = 128;
+	}
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
-		.start = 0,
-		.end   = (resource_size(res) >> 20) - 1,
+		.start = busn_start,
+		.end   = busn_start + (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 
@@ -636,8 +654,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource(&resources, &vmd->resources[1]);
 	pci_add_resource(&resources, &vmd->resources[2]);
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, 0, &vmd_ops, sd,
-				       &resources);
+	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
+				       sd, &resources);
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
-- 
2.14.3

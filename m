Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBBE3403EE
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751808; cv=none; b=Cyfclrp7Rr8N65ZH7PpMw/TCaLQtlRncYw/9fwLgWoCmKJOPFDIwfnNFyQGqofec93SnRWVVYF6Uq6YAQglNnHtaBi4UqkOiVU6bcOwsh6Jf9XsHIU3pjrTwK30z9OzQULrgQbAkHC/rhOy15R+YlzQ8D2vFmQiSfsB/5PIk96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751808; c=relaxed/simple;
	bh=oG6VytrDVz9vKCyHYRpq7pg3IuWQ6VpSbyzmP2eau80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQ5ac/OLMtNS9k8AK2CXxn78nUV0oriwHnhva2f1Wnq7r9Pt5ZDYk3r1cOSeYzRhZJROhxFPUNonPPvnNXdU0AFsToGVW5V98rY/YacCKeitDdNfjn+edKv7hOJVoWBDxw5zr0zCKfMg+CVllEaejNFdbcYt/wiYx9D5lChgsdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYEnYaVR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYEnYaVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782751807; x=1814287807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oG6VytrDVz9vKCyHYRpq7pg3IuWQ6VpSbyzmP2eau80=;
  b=jYEnYaVREcydewRr2yliTq8G7JZKVuiXSo9CFN2oD0jPyTF8Z0yvlAvp
   sAEF3JVvKerf9kluOKaDD3jMJGlLQtSjL060Zb+VOtek0tOjN+KLJotzg
   Q/fXaqsWBN0PF9zIzvZXpR+Jb3TS9bxSshZdWWmmi/pDQNnMNtSwQDboy
   MmfjXBhHSnhJRfSVBaPBEUhQ42NSPGVQCObF4JiwlzjjIJE/fTyyrVbuI
   AL89YosL7THqbQEwpR5yUzCT/5Ah/46pU7Tp08ZxWt+w5cTVYAQXTuqZr
   QUDRPeV6oiVLyErslSkRhjt6lxX6iZCuzpkJBQQKVERhnyXqAp/16og5O
   w==;
X-CSE-ConnectionGUID: 0rEJ1xyMTSaWOkTGJoFYww==
X-CSE-MsgGUID: EPthVN5FTVa69di0MrvMPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83536663"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83536663"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:50:06 -0700
X-CSE-ConnectionGUID: XY4E/9wmQyu4nrr+DylkIA==
X-CSE-MsgGUID: tmHLKNISSLSGSJdwNk/C6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="252649957"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:50:04 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@intel.com,
	<linux-pci@vger.kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v7] PCI: vmd: Add feature to scan BIOS enumerated devices.
Date: Mon, 29 Jun 2026 16:50:25 +0000
Message-ID: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer VMD  with device ID 0x28c1 has unique settings compared to its
predecessor where BIOS enumerates the entire VMD device tree and
assigns respective configurations.

VMD configuration BAR0 carries over from GNR legacy VMD as the mechanism
to access the configuration space of the devices owned by VMD. The size
of this window is fixed at 256 MB, where each function consumes 4 KB and
every bus consumes 1 MB.

The shadow and scratchpad registers have been relocated from the VMD
configuration space to the VMD MMIO space in VMD BAR4/BAR5, otherwise
refers to as MEMBAR2 or MSI-X bar.

VMD MSI-X remapping enable/disable is no longer supported.

All the VMD driver code needs to do is to obtain bus hide range along
with shadow register values set by BIOS and perform a bus scan.

The commit also involves small refactoring of vmd_enable_domain function.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v7 : Remove early return from vmd_remove_irq_domain.
v6 : Update vmd_domain_reset to use newer ecam bus number calculation.
v5 : Fixing configbar resource end and some spacing issue.
v4 : Updating vmd_set_msi_remapping for supported devices only.
v3 : Hard code configbar .end to 0xff same as probe.c; Adjust membar2
     offset to accommodate more registers in 28C1. Remove redundant
     IORESOURCE_MEM check in vmd_prepare_offsets_and_bus.
v2 : Using PCI features flag instead of devic ID and fixing corner cases
     for vmd_remove_irq.
---
---
 drivers/pci/controller/vmd.c | 180 +++++++++++++++++++++++++++++------
 include/linux/pci_ids.h      |   1 +
 2 files changed, 150 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..a02f2cc3d6ed 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -37,6 +37,12 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/* DMR BAR4 register offsets */
+#define SHADOW_MEMBAR1_28C1		0x2818 /* MEMBAR1 physical address */
+#define SHADOW_MEMBAR2_28C1		0x2820 /* MEMBAR2 physical address */
+#define BASE_ID_REG_28C1		0x2840
+#define MEMBAR2_OFFSET_28C1		0x30d0
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -77,6 +83,15 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/*
+	 * Newer VMD with device ID 0x28c1 has unique settings compared to its
+	 * predecessor where BIOS enumerates the entire VMD device tree and
+	 * stores respective configurations including bus start range and
+	 * shadow registers in VMD MMIO space in VMD BAR4/BAR5, otherwise refers
+	 * to as MEMBAR2 or MSI-X bar.
+	 */
+	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -142,6 +157,7 @@ struct vmd_dev {
 	u8			first_vec;
 	char			*name;
 	int			instance;
+	unsigned long		features;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -366,6 +382,9 @@ static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
 {
 	u16 reg;
 
+	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
+		return;
+
 	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
 	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
 		       (reg | VMCONFIG_MSI_REMAP);
@@ -389,11 +408,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 	}
 }
 
+static unsigned int vmd_bus_to_ecam(struct vmd_dev *vmd, unsigned int busnr)
+{
+	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
+		return busnr;
+
+	return busnr - vmd->busn_start;
+}
+
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start;
-	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
+	unsigned int busnr_ecam;
+	u32 offset;
+
+	busnr_ecam = vmd_bus_to_ecam(vmd, bus->number);
+	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
 		return NULL;
@@ -518,22 +548,37 @@ static inline void vmd_acpi_begin(void) { }
 static inline void vmd_acpi_end(void) { }
 #endif /* CONFIG_ACPI */
 
+static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
+{
+	resource_size_t cfgbar_buses;
+	unsigned int ecam_start;
+
+	cfgbar_buses = resource_size(&vmd->dev->resource[VMD_CFGBAR]) >> 20;
+	ecam_start = vmd_bus_to_ecam(vmd, vmd->resources[0].start);
+	if (ecam_start >= cfgbar_buses)
+		return 0;
+
+	return cfgbar_buses - ecam_start;
+}
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
 	u16 bus, max_buses = resource_size(&vmd->resources[0]);
 	u8 dev, functions, fn, hdr_type;
+	unsigned int ecam_bus;
 	char __iomem *base;
 
+	max_buses = min_t(u16, max_buses, vmd_cfgbar_ecam_space(vmd));
 	for (bus = 0; bus < max_buses; bus++) {
+		ecam_bus = vmd_bus_to_ecam(vmd, vmd->resources[0].start + bus);
 		for (dev = 0; dev < 32; dev++) {
-			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
+			base = vmd->cfgbar + PCIE_ECAM_OFFSET(ecam_bus,
 						PCI_DEVFN(dev, 0), 0);
 
 			hdr_type = readb(base + PCI_HEADER_TYPE);
 
 			functions = (hdr_type & PCI_HEADER_TYPE_MFD) ? 8 : 1;
 			for (fn = 0; fn < functions; fn++) {
-				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
+				base = vmd->cfgbar + PCIE_ECAM_OFFSET(ecam_bus,
 						PCI_DEVFN(dev, fn), 0);
 
 				hdr_type = readb(base + PCI_HEADER_TYPE) &
@@ -661,6 +706,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 	return 0;
 }
 
+static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
+				       resource_size_t *offset1,
+				       resource_size_t *offset2)
+{
+	u64 phys1, phys2, bar4_2840;
+	void __iomem *bar4;
+	u32 base_id;
+	u8 base_bus;
+
+	bar4 = pci_ioremap_bar(vmd->dev, 4);
+	if (!bar4)
+		return -ENOMEM;
+
+	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical addresses. */
+	phys1 = readq(bar4 + SHADOW_MEMBAR1_28C1);
+	phys2 = readq(bar4 + SHADOW_MEMBAR2_28C1);
+
+	/*
+	 * Read and set bus start number from Base ID register. 24-bit Base ID
+	 * register is part of 64-bit shadowed reqid hide range register and
+	 * holds segment, bus, device and function.
+	 */
+	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
+	base_id = bar4_2840 & 0xFFFFFF;
+	base_bus = base_id >> 8;
+	vmd->busn_start = base_bus;
+
+	/* Calculate offsets like vmd_get_phys_offsets() does. */
+	if (phys1)
+		*offset1 = vmd->dev->resource[VMD_MEMBAR1].start -
+			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
+	if (phys2)
+		*offset2 = vmd->dev->resource[VMD_MEMBAR2].start -
+			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
+
+	pci_iounmap(vmd->dev, bar4);
+
+	return 0;
+}
+
 static irqreturn_t vmd_irq(int irq, void *data)
 {
 	struct vmd_irq_list *irqs = data;
@@ -711,6 +796,52 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	return 0;
 }
 
+static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
+					unsigned long features,
+					resource_size_t *membar2_offset,
+					resource_size_t *offset1,
+					resource_size_t *offset2)
+{
+	int ret;
+
+	/*
+	 * Shadow registers may exist in certain VMD device ids which allow
+	 * guests to correctly assign host physical addresses to the root ports
+	 * and child devices. These registers will either return the host value
+	 * or 0, depending on an enable bit in the VMD device.
+	 *
+	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
+	 * in BAR4 shadow registers to determine the base bus number and memory
+	 * offsets.
+	 */
+	if (features & VMD_FEAT_USE_BIOS_INFO) {
+		*membar2_offset = MEMBAR2_OFFSET_28C1;
+		ret = vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
+		if (ret)
+			return ret;
+	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
+		*membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
+		ret = vmd_get_phys_offsets(vmd, true, offset1, offset2);
+		if (ret)
+			return ret;
+	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
+		ret = vmd_get_phys_offsets(vmd, false, offset1, offset2);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Certain VMD devices may have a root port configuration option which
+	 * limits the bus range to between 0-127, 128-255, or 224-255.
+	 */
+	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
+		ret = vmd_get_bus_number_start(vmd);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /*
  * Since VMD is an aperture to regular PCIe root ports, only allow it to
  * control features that the OS is allowed to control on the physical PCI bus.
@@ -780,42 +911,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
+	resource_size_t busn_end;
 	struct pci_bus *child;
 	struct pci_dev *dev;
 	int ret;
 
-	/*
-	 * Shadow registers may exist in certain VMD device ids which allow
-	 * guests to correctly assign host physical addresses to the root ports
-	 * and child devices. These registers will either return the host value
-	 * or 0, depending on an enable bit in the VMD device.
-	 */
-	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
-		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
-		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
-		if (ret)
-			return ret;
-	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
-		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
-		if (ret)
-			return ret;
-	}
-
-	/*
-	 * Certain VMD devices may have a root port configuration option which
-	 * limits the bus range to between 0-127, 128-255, or 224-255
-	 */
-	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		ret = vmd_get_bus_number_start(vmd);
-		if (ret)
-			return ret;
-	}
+	ret = vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
+					  &offset[0], &offset[1]);
+	if (ret)
+		return ret;
 
+	/* Do not let resource[0] end go out of bound.*/
 	res = &vmd->dev->resource[VMD_CFGBAR];
+	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
+	busn_end = min_t(resource_size_t, busn_end, 0xff);
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
 		.start = vmd->busn_start,
-		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
+		.end   = busn_end,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 
@@ -998,6 +1111,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	vmd->dev = dev;
 	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
+	vmd->features = features;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1114,6 +1228,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C1),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_CAN_BYPASS_MSI_REMAP |
+				VMD_FEAT_USE_BIOS_INFO,},
 	{PCI_VDEVICE(INTEL, 0x467f),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x4c3d),
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 24cb42f66e4b..2a8ebe7df92e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2889,6 +2889,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_ICH8	0x284b
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
 #define PCI_DEVICE_ID_INTEL_VMD_28C0	0x28c0
+#define PCI_DEVICE_ID_INTEL_VMD_28C1    0x28c1
 #define PCI_DEVICE_ID_INTEL_ICH9_0	0x2910
 #define PCI_DEVICE_ID_INTEL_ICH9_2	0x2912
 #define PCI_DEVICE_ID_INTEL_ICH9_3	0x2913
-- 
2.52.0


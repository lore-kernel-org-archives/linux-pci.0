Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441D2236EB
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177169; cv=none; b=Pct0q7lzNpFg5PQSWc969VujROY+eM7ZmJ2aFSDhOfXwFxCsdYJU0jiXc5Vr7bQBnbHBtI/pU33yEP/MEyHe7r6ZQ9p8OBcY/mif3TiwY+1oTYkIISewVFUIB0WQCkg7pE/AQSapPi1hiXRnSTv2N8yy4Hk/1dPbNINdcTDIiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177169; c=relaxed/simple;
	bh=emlI7r9GRd/XUiK+W7R89zEog2OdgFXD5AM35a2aNsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2fKOgmQ4nzcEQt4HWeeW98EVeU+qYCgyKABm2ACGfwBJWalSpeLq90GAlczdGdiPNt8WKw2EMNB1f+F/sCplsO3jaz9sN6OQ7NxHvHs3nUj5/yD0Wf1YCLT4Dfg6O7SdxkL4n1XOEAS27znc3CW/vH+gpuUOAtoFROHOxxBCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2oTbYFG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2oTbYFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782177167; x=1813713167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=emlI7r9GRd/XUiK+W7R89zEog2OdgFXD5AM35a2aNsk=;
  b=a2oTbYFGXg4cXId1ZcTzQBGpqqdehQPRLI4uWOMP0zUU/O6NMfXW9prz
   XmNutXm4SfZaaSormsrgIRsViQPMR1FA91l3Fbx7ckxow5KxDBWMlgTsd
   1l0COSl+3ze+DeeGpW/06gkKLQgd5ZLZgS4LEir3w4g8y8JNjFfwZNu4H
   tHV9aKR0heBp6SWxI0uZ9y7PUvIYGhRjqN8+0Ki1f9kRRyy7jPmbRqC7/
   44trBCd2Mkncrr6I9HBywcr6fL/iw4u2WjtEcm7ciq62SkFBuq708KnR/
   ts0jSzPC7+JPh7H55w0Jti38J4w4BID1vQdwGCs2Qlajc7QxIckSJh4BG
   Q==;
X-CSE-ConnectionGUID: 83JkPhDIQ7qmpR71mYYwjQ==
X-CSE-MsgGUID: IlM7fdfWSpeUjk+R9PjBjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86603238"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="86603238"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:12:46 -0700
X-CSE-ConnectionGUID: 7rPs1VzISK+Rz7lZfE6tag==
X-CSE-MsgGUID: 5n0USBuvRzuYAqGCRak5Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248232356"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:12:44 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@intel.com,
	<linux-pci@vger.kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v6] PCI: vmd: Add feature to scan BIOS enumerated devices.
Date: Tue, 23 Jun 2026 01:13:05 +0000
Message-ID: <20260623011305.134792-1-nirmal.patel@linux.intel.com>
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
 drivers/pci/controller/vmd.c | 183 +++++++++++++++++++++++++++++------
 include/linux/pci_ids.h      |   1 +
 2 files changed, 153 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..1cdea70048a2 100644
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
@@ -374,6 +393,9 @@ static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
 
 static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 {
+	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
+		return;
+
 	/*
 	 * Some production BIOS won't enable remapping between soft reboots.
 	 * Ensure remapping is restored before unloading the driver.
@@ -389,11 +411,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
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
@@ -518,22 +551,37 @@ static inline void vmd_acpi_begin(void) { }
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
@@ -661,6 +709,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
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
@@ -711,6 +799,52 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
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
@@ -780,42 +914,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
 
@@ -998,6 +1114,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	vmd->dev = dev;
 	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
+	vmd->features = features;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1114,6 +1231,10 @@ static const struct pci_device_id vmd_ids[] = {
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


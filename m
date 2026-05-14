Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A938B7D2
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795482; cv=none; b=WSLL4Ubbq4rkfPj4xgsGu+a7UczBXfE5v1+6eXbXK1b54yt8ObdJVxDzikPGLKHprkPRpJuvVxtsYR/DWRMoAmeVYO/VNwuB2tL6Aw2RwsJ7ymZLnpeGmvS1PAkUcOZFv4kPgllbhAbgxJnD9+zENzjyeKlLkSh8KsWvdyzrNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795482; c=relaxed/simple;
	bh=HuBSJQFsFbHhirwaTm72EhzgxdI0wG+OVFltvdNyuYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3Qu8OIRUjfYJb5kLnm8P9VgH7u8bpuQ26AcRRdKuWOnYHzOutqfG4yKvqiRDSw91pzbcz8X90ZQxzISnrhAXAyeXFGHJl2maUnynyJ+0DLr0UqZ+Xr9QtQsY/cG5PK3Cz1DNbpD3FnTpwXwVP+TUqtRcI09Pok3SRvojaWZFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC2HVu/s; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC2HVu/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778795481; x=1810331481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HuBSJQFsFbHhirwaTm72EhzgxdI0wG+OVFltvdNyuYU=;
  b=AC2HVu/sfBdpNDM3mh1A+lwbao9vX+MqYEkPzqpDuIivj4ITH1CxqBzp
   KX0BmzzsS05H0Q8K7YRwZ89Hy04ddqLXG3PrGjsRMRSFy7yWs5E0sSxq7
   C0UMqsyq30vF7SdOyj6H/qlXvqv37Hu0mFCq1Rbm3JwJyBRq4W81uw1jS
   FTDvJpkyNZ7TzkMsNxcwHA9k1OSpft8LPXxbbKinPSQZCFxUxYFsB84xu
   pqeH54tES33MxEn3HfWTrAeRbaFU3J3U2Te40pWLyjcmvzLETXV/F6jM9
   fqMHDTY25cTKJwjC08rB5fHlQbr2rxH+PMuCkgXcRzqIzSIRv623+kUen
   g==;
X-CSE-ConnectionGUID: pcdbPf38QymdoBymZzzKxg==
X-CSE-MsgGUID: ceiXwlMJSyKJ1LLvV2JjbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90056555"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="90056555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 14:51:20 -0700
X-CSE-ConnectionGUID: yZDO5d4zQey9/K0m+QjYaQ==
X-CSE-MsgGUID: CuDsNjKPQou1cnFc0xETkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="234235493"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 14:51:19 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>,
	nirmal.patel@intel.com
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v4] PCI: vmd: Add feature to add BIOS enumerated devices.
Date: Thu, 14 May 2026 21:51:31 +0000
Message-ID: <20260514215131.179743-1-nirmal.patel@linux.intel.com>
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

The patch also involves small refactoring of vmd_enable_domain function.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 146 ++++++++++++++++++++++++++++-------
 include/linux/pci_ids.h      |   1 +
 2 files changed, 119 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..6a5879d099a1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -37,6 +37,11 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/* DMR BAR4 register offsets */
+#define SHADOW_MEMBAR1_28C1		0x2818 /* MEMBAR1 physical address */
+#define SHADOW_MEMBAR2_28C1		0x2820 /* MEMBAR2 physical address */
+#define BASE_ID_REG_28C1		0x2840
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -77,6 +82,15 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/*
+	 * Newer VMD  with device ID 0x28c1 has unique settings compared to its
+	 * predecessor where BIOS enumerates the entire VMD device tree and
+	 * stores respective configurations including bus start range and
+	 * shadow registers in VMD MMIO space in VMD BAR4/BAR5, otherwise refers
+	 * to as MEMBAR2 or MSI-X bar.
+	 */
+	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -393,7 +407,12 @@ static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
 	unsigned int busnr_ecam = bus->number - vmd->busn_start;
-	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
+	u32 offset;
+
+	if (vmd->dev->device == PCI_DEVICE_ID_INTEL_VMD_28C1)
+		busnr_ecam = bus->number;
+
+	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
 		return NULL;
@@ -661,6 +680,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
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
+	 * Read and set bus start number from Base ID register.
+	 * 24-bit Base ID register is part of 64-bit shadowed reqid hide
+	 * range register and holds segement, bus, device and function.
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
+	return 0;
+}
+
 static irqreturn_t vmd_irq(int irq, void *data)
 {
 	struct vmd_irq_list *irqs = data;
@@ -711,6 +770,54 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
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
+	 */
+	/*
+	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
+	 * in BAR4 shadow registers to determine the base bus number and memory
+	 * offsets.
+	 */
+	if (features & VMD_FEAT_USE_BIOS_INFO) {
+		if (resource_type(&vmd->dev->resource[4]) == IORESOURCE_MEM) {
+			ret = vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
+			if (ret)
+				return ret;
+		}
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
@@ -784,32 +891,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
+	if(ret)
+		return ret;
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
@@ -880,7 +965,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (ret)
 			return ret;
 	} else {
-		vmd_set_msi_remapping(vmd, false);
+		if (!(features & VMD_FEAT_USE_BIOS_INFO))
+			vmd_set_msi_remapping(vmd, false);
 	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
@@ -1114,6 +1200,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C1),
+                .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
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


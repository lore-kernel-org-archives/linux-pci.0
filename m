Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936A4A92DE
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363276; cv=none; b=pRZoAwz+k0Y80+JgMQk+7ICwMyH5+jaLfIzykhMlqL/E/iglNPq20Imrcx4fboubaScPao3hGhHKvt/RdpgOqGM51arvCzl853fG5/ihYJDDv2O3VymNvhjPvCcbfMDcmswwZQTA0O9GrqaRKNMtIZAxvYe8HoGuooa57teon+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363276; c=relaxed/simple;
	bh=eToAmbW8l+AAktas6WVmM5JbBPys0ZV4Tvt/Y5zN1cM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIEzYWRekdNzJgHdloxFu7nf8aJdovSC1egUr/Ay20tt8iSzX7a2f9cnAmLjybaTieR6U6OjvWRhQFh10yonUXlK72vGu8u8+VpxtmOv/ucr7ofDand2nVIZSbu2SP+t/YKPP960IHGvKShOO+PXztcPah5vr+WcEKaLKWDX3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZoEJEl+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZoEJEl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363271; x=1819899271;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eToAmbW8l+AAktas6WVmM5JbBPys0ZV4Tvt/Y5zN1cM=;
  b=GZoEJEl+9UnaSNA5zd+cJUFElzgCmDWyowdjJOIL5ahLbEBoOro6te+a
   Yf9X9QycrPDvsWmI3KtTMnXtiCAzIEvihuj7sz0/2TzlZXQn++p92ys7I
   yLX6C7VVe/emP9ntdOh2gfXD+C2YLYCfcz8s0JPtBX3qtoM75aoyiqzY8
   945hezN8pNBQV5YRQqGRjloB956IYv3JDw1HlCC0k+1ZNuLQPsifqOUwa
   vQfEdqvWQdfrCr8zYJmVoXEFy7jQlI96E1fOi0aoXNF42+cIwWfSze1QZ
   YmzH03diy89WK1UocxOURfbfuTDHr3JR0NS1BF0s7MmWznfqpl1uTiiIo
   Q==;
X-CSE-ConnectionGUID: LJaT2KzLS0+5ECqph5riww==
X-CSE-MsgGUID: +sOZv3SjReCrS2p1RuQO0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646695"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:30 -0700
X-CSE-ConnectionGUID: i8n/aCenQkmXWf0dY8Z3Bg==
X-CSE-MsgGUID: 6ulcyzTLQgOZJeSm5QdoHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406869"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:28 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 7/8] PCI: vmd: Add support for second rootbus under VMD
Date: Wed,  2 Sep 2026 17:58:43 +0000
Message-ID: <20260902175846.3497854-8-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
References: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from Intel Arrow Lake VMD enhancement introduces second root bus
support with fixed root bus number (0x80). It means that all 3 MMIO BARs
exposed by VMD are shared now between both buses (current BUS0 and
new BUS1).

Add new BUS1 enumeration and divide MMIO space to be shared between
both root buses. Due to enumeration issues with root bus hardwired to a
fixed non-zero value, this patch will work with a workaround proposed
in next patch. Without workaround user won't see attached devices for BUS1
root bus.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 311 +++++++++++++++++++++++++++++++----
 1 file changed, 276 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 681bdd54f050..7e76ef3d7ec8 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -30,6 +31,7 @@
 #define VMD_RESTRICT_0_BUS_START 0x0
 #define VMD_RESTRICT_1_BUS_START 0x80
 #define VMD_RESTRICT_2_BUS_START 0xE0
+#define VMD_RESTRICT_3_BUS_START 0xE1
 
 #define PCI_REG_VMCAP		0x40
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
@@ -48,15 +50,36 @@
 #define BASE_ID_REG_28C1		0x2840
 #define MEMBAR2_OFFSET_28C1		0x30d0
 
+/* Primary Bus Number for VMD devices on root bus 0 */
+#define VMD_PRIMARY_BUS0    0x00
+/* Primary Bus Number for VMD devices on root bus 1 */
+#define VMD_PRIMARY_BUS1    0x80
+
+#define VMD_BUSRANGE0       0xc8
+#define VMD_BUSRANGE1       0xcc
+#define VMD_MEMBAR1_OFFSET  0xd0
+#define VMD_MEMBAR2_OFFSET1 0xd8
+#define VMD_MEMBAR2_OFFSET2 0xdc
+#define VMD_BUS_END(busr) FIELD_GET(GENMASK(15, 8), busr)
+#define VMD_BUS_START(busr) FIELD_GET(GENMASK(7, 0), busr)
+
+/*
+ * Add VMD resources for BUS1, it will share the same MMIO space with
+ * previous VMD resources.
+ */
 enum vmd_resource {
-	VMD_RES_CFGBAR = 0, /* VMD Bus0 Config BAR */
-	VMD_RES_MBAR_1, /* VMD Bus0 Resource MemBAR 1 */
-	VMD_RES_MBAR_2, /* VMD Bus0 Resource MemBAR 2 */
+	VMD_RES_CFGBAR = 0,  /* VMD Bus0 Config BAR */
+	VMD_RES_MBAR_1,      /* VMD Bus0 Resource MemBAR 1 */
+	VMD_RES_MBAR_2,      /* VMD Bus0 Resource MemBAR 2 */
+	VMD_RES_BUS1_CFGBAR, /* VMD Bus1 Config BAR */
+	VMD_RES_BUS1_MBAR_1, /* VMD Bus1 Resource MemBAR 1 */
+	VMD_RES_BUS1_MBAR_2, /* VMD Bus1 Resource MemBAR 2 */
 	VMD_RES_COUNT
 };
 
 enum vmd_rootbus {
 	VMD_BUS_0 = 0,
+	VMD_BUS_1,
 	VMD_BUS_COUNT
 };
 
@@ -109,6 +132,12 @@ enum vmd_features {
 	 * to as MEMBAR2 or MSI-X bar.
 	 */
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
+
+	/*
+	 * Starting from Intel Arrow Lake, VMD devices have their VMD root ports
+	 * on the additional BUS1 root bus.
+	 */
+	VMD_FEAT_HAS_BUS1_ROOTBUS	= (1 << 7)
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -116,7 +145,8 @@ enum vmd_features {
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
 				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
-				 VMD_FEAT_BIOS_PM_QUIRK)
+				 VMD_FEAT_BIOS_PM_QUIRK |		\
+				 VMD_FEAT_HAS_BUS1_ROOTBUS)
 
 static DEFINE_IDA(vmd_instance_ida);
 
@@ -175,6 +205,7 @@ struct vmd_dev {
 	char			*name;
 	int			instance;
 	unsigned long		features;
+	bool			bus1_rootbus;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -579,7 +610,8 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
 }
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
+	/* One ECAM bus consumes 1MB of CFGBAR space. */
+	u16 bus, max_buses = resource_size(&vmd->dev->resource[VMD_CFGBAR]) >> 20;
 	u8 dev, functions, fn, hdr_type;
 	unsigned int ecam_bus;
 	char __iomem *base;
@@ -632,12 +664,24 @@ static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
 	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
+
+	if (vmd->bus1_rootbus) {
+		vmd->resources[VMD_RES_MBAR_1].sibling =
+			&vmd->resources[VMD_RES_BUS1_MBAR_1];
+		vmd->resources[VMD_RES_MBAR_2].sibling =
+			&vmd->resources[VMD_RES_BUS1_MBAR_2];
+	}
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = NULL;
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
+
+	if (vmd->bus1_rootbus) {
+		vmd->resources[VMD_RES_MBAR_1].sibling = NULL;
+		vmd->resources[VMD_RES_MBAR_2].sibling = NULL;
+	}
 }
 
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
@@ -694,7 +738,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 	return 0;
 }
 
-static int vmd_get_bus_number_start(struct vmd_dev *vmd)
+static int vmd_get_bus_number_start(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_dev *dev = vmd->dev;
 	u16 reg;
@@ -713,6 +757,24 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 2:
 			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
 			break;
+		case 3:
+			if (!(features & VMD_FEAT_HAS_BUS1_ROOTBUS)) {
+				pci_err(dev, "VMD Bus Restriction detected type %d, but BUS1 root bus is not supported, aborting.\n",
+					BUS_RESTRICT_CFG(reg));
+				return -ENODEV;
+			}
+
+			/*
+			 * Per Intel VMD specification (e.g., Arrow Lake-S):
+			 * - VMD (on root bus 0) secondary bus start number: 0xE0
+			 *	(devices span 0xE2..0xF0 via VMD_BUSRANGE0).
+			 * - VMD (on root bus 1) secondary bus start number: 0xE1
+			 *	(devices span 0xF1..0xFF via VMD_BUSRANGE1).
+			 */
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
+			vmd->busn_start[VMD_BUS_1] = VMD_RESTRICT_3_BUS_START;
+			vmd->bus1_rootbus = true;
+			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
 				BUS_RESTRICT_CFG(reg));
@@ -852,7 +914,7 @@ static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
 	 * limits the bus range to between 0-127, 128-255, or 224-255.
 	 */
 	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		ret = vmd_get_bus_number_start(vmd);
+		ret = vmd_get_bus_number_start(vmd, features);
 		if (ret)
 			return ret;
 	}
@@ -919,7 +981,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
-static void vmd_configure_cfgbar(struct vmd_dev *vmd)
+static int vmd_configure_cfgbar(struct vmd_dev *vmd)
 {
 	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
 	resource_size_t busn_end;
@@ -933,6 +995,62 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 		.end   = busn_end,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
+
+	if (vmd->bus1_rootbus) {
+		int ret;
+		u16 bus0_range = 0;
+		u16 bus1_range = 0;
+		u8 bus0_start, bus0_end;
+		u8 bus1_start, bus1_end;
+
+		ret = pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &bus0_range);
+		if (ret) {
+			pci_err(vmd->dev, "Failed to read VMD_BUSRANGE0: %d\n", ret);
+			return -EIO;
+		}
+
+		ret = pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &bus1_range);
+		if (ret) {
+			pci_err(vmd->dev, "Failed to read VMD_BUSRANGE1: %d\n", ret);
+			return -EIO;
+		}
+
+		bus0_start = VMD_BUS_START(bus0_range);
+		bus0_end = VMD_BUS_END(bus0_range);
+		bus1_start = VMD_BUS_START(bus1_range);
+		bus1_end = VMD_BUS_END(bus1_range);
+
+		if (bus0_start > bus0_end || bus1_start > bus1_end) {
+			pci_err(vmd->dev,
+				"Invalid bus range(s): BUS0 [%02x-%02x], BUS1 [%02x-%02x]\n",
+				bus0_start, bus0_end, bus1_start, bus1_end);
+			return -EINVAL;
+		}
+
+		if (!(bus0_end < bus1_start || bus1_end < bus0_start)) {
+			pci_err(vmd->dev,
+				"Overlapping bus ranges: BUS0 [%02x-%02x], BUS1 [%02x-%02x]\n",
+				bus0_start, bus0_end, bus1_start, bus1_end);
+			return -EINVAL;
+		}
+
+		/*
+		 * Resize BUS0 CFGBAR range to make space for BUS1
+		 * owned devices by adjusting range end with value stored in
+		 * VMD_BUSRANGE0 register.
+		 */
+		vmd->resources[VMD_RES_CFGBAR].start = bus0_start;
+		vmd->resources[VMD_RES_CFGBAR].end = bus0_end;
+
+		vmd->resources[VMD_RES_BUS1_CFGBAR] = (struct resource){
+			.name = "VMD CFGBAR BUS1",
+			.start = bus1_start,
+			.end = bus1_end,
+			.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+		};
+	}
+
+	return 0;
 }
 
 /*
@@ -963,8 +1081,9 @@ static int vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
 	if (!upper_bits)
 		flags &= ~IORESOURCE_MEM_64;
 
-	name = devm_kasprintf(&vmd->dev->dev, GFP_KERNEL, "VMD MEMBAR%d",
-			      resource_number);
+	name = devm_kasprintf(&vmd->dev->dev, GFP_KERNEL, "VMD MEMBAR%d %s",
+			      membar_number / 2,
+			      resource_number > VMD_RES_MBAR_2 ? "BUS1" : "");
 	if (!name)
 		return -ENOMEM;
 
@@ -984,52 +1103,131 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 {
 	int ret;
 
-	ret = vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
-	if (ret)
-		return ret;
+	if (vmd->bus1_rootbus) {
+		u32 reg = 0;
+		u32 bus1_mbar1_ofs = 0;
+		u64 bus1_mbar2_ofs = 0;
+		resource_size_t mbar1_sz, mbar2_sz;
 
-	ret = vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2, mbar2_ofs, 0);
-	if (ret) {
-		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[VMD_RES_MBAR_1].name);
-		memset(&vmd->resources[VMD_RES_MBAR_1], 0,
-		       sizeof(vmd->resources[VMD_RES_MBAR_1]));
-		return ret;
+		mbar1_sz = resource_size(&vmd->dev->resource[VMD_MEMBAR1]);
+		mbar2_sz = resource_size(&vmd->dev->resource[VMD_MEMBAR2]);
+
+		ret = pci_read_config_dword(vmd->dev, VMD_MEMBAR1_OFFSET,
+					    &bus1_mbar1_ofs);
+		if (ret)
+			return -EIO;
+
+		ret = pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET1, &reg);
+		if (ret)
+			return -EIO;
+		bus1_mbar2_ofs = reg;
+
+		ret = pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET2, &reg);
+		if (ret)
+			return -EIO;
+		bus1_mbar2_ofs |= (u64)reg << 32;
+
+		if (!bus1_mbar1_ofs || bus1_mbar1_ofs >= mbar1_sz) {
+			pci_err(vmd->dev, "Invalid MEMBAR1 offset %#llx (BAR size %#llx)\n",
+				(unsigned long long)bus1_mbar1_ofs,
+				(unsigned long long)mbar1_sz);
+			return -EINVAL;
+		}
+
+		if (!bus1_mbar2_ofs || mbar2_ofs >= mbar2_sz ||
+		    bus1_mbar2_ofs <= mbar2_ofs || bus1_mbar2_ofs >= mbar2_sz) {
+			pci_err(vmd->dev,
+				"Invalid MEMBAR2 split %#llx (shadow offset %#llx, BAR size %#llx)\n",
+				(unsigned long long)bus1_mbar2_ofs,
+				(unsigned long long)mbar2_ofs,
+				(unsigned long long)mbar2_sz);
+			return -EINVAL;
+		}
+
+		/*
+		 * Resize BUS MEMBAR1 and MEMBAR2 ranges to make space
+		 * for BUS1 owned devices by adjusting range end with values
+		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
+		 */
+		ret = vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
+					   mbar1_sz - bus1_mbar1_ofs);
+		if (ret)
+			return ret;
+
+		ret = vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+					   mbar2_ofs, mbar2_sz - bus1_mbar2_ofs);
+		if (ret)
+			return ret;
+
+		ret = vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_1, VMD_MEMBAR1,
+					   bus1_mbar1_ofs, 0);
+		if (ret)
+			return ret;
+
+		ret = vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_2, VMD_MEMBAR2,
+					   bus1_mbar2_ofs, 0);
+		if (ret)
+			return ret;
+	} else {
+		ret = vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
+		if (ret)
+			return ret;
+
+		ret = vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+					   mbar2_ofs, 0);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
-			  resource_size_t *offset)
+static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
+			  struct pci_sysdata *sd, resource_size_t *offset,
+			  u8 primary)
 {
+	u8 cfgbar = bus_number * 3;
+	u8 membar1 = cfgbar + 1;
+	u8 membar2 = cfgbar + 2;
+	struct pci_bus *vmd_bus;
 	LIST_HEAD(resources);
 
-	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
-	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
+	pci_add_resource(&resources, &vmd->resources[cfgbar]);
+	pci_add_resource_offset(&resources, &vmd->resources[membar1],
 				offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
+	pci_add_resource_offset(&resources, &vmd->resources[membar2],
 				offset[1]);
 
-	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
-						  vmd->busn_start[VMD_BUS_0],
-						  &vmd_ops, sd, &resources);
-	if (!vmd->bus[VMD_BUS_0]) {
+	vmd_bus = pci_create_root_bus(&vmd->dev->dev,
+				      vmd->busn_start[bus_number], &vmd_ops, sd,
+				      &resources);
+
+	if (!vmd_bus) {
 		pci_free_resource_list(&resources);
 		return -ENODEV;
 	}
 
+	/*
+	 * pci_create_root_bus() does not initialise bus->primary.
+	 * Set it here before any scanning so bridge traversal logic
+	 * sees the correct upstream bus number from the start.
+	 */
+	vmd_bus->primary = primary;
+
 	/* Don't copy _OSC control flags in VM, it disables features.*/
 	if (!offset[0] || !offset[1])
 		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-					   to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
+					   to_pci_host_bridge(vmd_bus->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
+		dev_set_msi_domain(&vmd_bus->dev, vmd->irq_domain);
 	else
-		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
+		dev_set_msi_domain(&vmd_bus->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
+	vmd->bus[bus_number] = vmd_bus;
+
 	return 0;
 }
 
@@ -1042,7 +1240,15 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(bus);
-	vmd_domain_reset(vmd_from_bus(bus));
+
+	/*
+	 * vmd_domain_reset() walks the full VMD CFGBAR aperture, so a single
+	 * invocation from BUS0 resets bridge windows for the whole VMD domain,
+	 * including BUS1. Running it again during BUS1 enumeration would
+	 * re-clobber windows already assigned for BUS0.
+	 */
+	if (bus->primary == VMD_PRIMARY_BUS0)
+		vmd_domain_reset(vmd_from_bus(bus));
 
 	/*
 	 * When Intel VMD is enabled, the OS does not discover the Root Ports
@@ -1093,7 +1299,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (ret)
 		return ret;
 
-	vmd_configure_cfgbar(vmd);
+	ret = vmd_configure_cfgbar(vmd);
+	if (ret)
+		return ret;
 
 	/*
 	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
@@ -1151,7 +1359,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	ret = vmd_create_bus(vmd, sd, offset);
+	ret = vmd_create_bus(vmd, VMD_BUS_0, sd, offset, VMD_PRIMARY_BUS0);
 	if (ret) {
 		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
 		pci_bus_release_emul_domain_nr(sd->domain);
@@ -1163,8 +1371,34 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			       &vmd->bus[VMD_BUS_0]->dev.kobj, "domain"),
 	     "Can't create symlink to domain\n");
 
+	if (vmd->bus1_rootbus) {
+		ret = vmd_create_bus(vmd, VMD_BUS_1, sd, offset, VMD_PRIMARY_BUS1);
+		if (ret) {
+			pci_warn(vmd->dev,
+				 "Can't create BUS1: %d, continuing with BUS0 only\n",
+				 ret);
+
+			vmd->resources[VMD_RES_MBAR_1].sibling = NULL;
+			vmd->resources[VMD_RES_MBAR_2].sibling = NULL;
+			vmd->resources[VMD_RES_BUS1_CFGBAR] = (struct resource){};
+			vmd->resources[VMD_RES_BUS1_MBAR_1] = (struct resource){};
+			vmd->resources[VMD_RES_BUS1_MBAR_2] = (struct resource){};
+			vmd->bus1_rootbus = false;
+			vmd->bus[VMD_BUS_1] = NULL;
+		}
+
+		if (vmd->bus1_rootbus)
+			WARN(sysfs_create_link(&vmd->dev->dev.kobj,
+					       &vmd->bus[VMD_BUS_1]->dev.kobj,
+					       "domain1"),
+			     "Can't create symlink to domain1\n");
+	}
+
 	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
 
+	if (vmd->bus1_rootbus)
+		vmd_bus_enumeration(vmd->bus[VMD_BUS_1], features);
+
 	return 0;
 }
 
@@ -1263,6 +1497,13 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
+
+	if (vmd->bus1_rootbus && vmd->bus[VMD_BUS_1]) {
+		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
+		sysfs_remove_link(&vmd->dev->dev.kobj, "domain1");
+		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
+	}
+
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
@@ -1359,4 +1600,4 @@ module_pci_driver(vmd_drv);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Volume Management Device driver");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION("0.6");
+MODULE_VERSION("0.7");
-- 
2.43.0


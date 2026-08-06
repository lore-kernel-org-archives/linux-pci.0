Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AA418348
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045829; cv=none; b=d8Fi44hlOd9/sDknzGPYPFX1WjWHzW5U3iULISljCSKgQob3y6m7xTQCOpyecr5uXorWp4cF0Jaz1IIJGJEIpLyJS/+1wLdZTClLiq0Scgd7mpGcv7kaNDGlH93DKuUhAPaCOKAolRBTTgBIdX19NLmWo/fVB/yJccqdEy6EFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045829; c=relaxed/simple;
	bh=YXgsxx9JVDNfviQxGgGeeZJBxDUVarpiXi/R9f0vV2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0qqzZKskIfCrcGBkEHg2sQXSH1C/wLScRRiVvznGfTKRTsHQBllX6zTs2cyCRgpoP0FyXwQ5KbENdgvgUQbTmoN9pRUb70qx7O6lQUF0q6bFYgnoeEeMLfwH4KZ7jSgQ3IItLntwkjhszKz7kG71yYQtk+4r6pQy+ee8YWgXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6JjLav7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6JjLav7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045821; x=1817581821;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YXgsxx9JVDNfviQxGgGeeZJBxDUVarpiXi/R9f0vV2M=;
  b=m6JjLav7dFrsyEYIXXaajigXgMdIRIDVeMV1PYYr8j8QFV0Ry7xJYodC
   e8K8JfF/ShExMx9NZiUy0x3yQdIrXGQ+5Z3GtE6kY+LkD+KnsBvBsbq4w
   U0rnVqZxyL+/nIqLB9n2EDrndYMU/8d1Uhw3pPQ1/Kc1mOMee36CwdbgA
   YewVhxsBRBIrA6WhUCo8AmyNhm3G4SRyoDyfsM0km0uEVgIwEFmFAq/ZG
   mCFOID+sVzKpn1ZQOCXGcsOTNit/pcNmiHTmLQ1kYXDdrC7p1z3yP085l
   wc4Ia5xb9PgjCvKGFQjdfL7XpRfpBtD+dU4YTg5cX0PLRE4VMx9+nzHEQ
   w==;
X-CSE-ConnectionGUID: c21HZI7ZSYuojiazNr7N7Q==
X-CSE-MsgGUID: 5XUdMDePSXuegoDmaGkA0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622537"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622537"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:14 -0700
X-CSE-ConnectionGUID: tONa9jjoReizKt4ovdYZ2w==
X-CSE-MsgGUID: I7kysKIeS0CoKK7outAsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923414"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:12 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 5/8] PCI: vmd: Replace hardcoded values with enum and defines
Date: Thu,  6 Aug 2026 22:13:44 +0000
Message-ID: <20260806221351.38592-6-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f88a72b6309e..78e8bdf7c3d7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -26,6 +26,11 @@
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
 
+/* VMD restriction value determines secondary start bus number */
+#define VMD_RESTRICT_0_BUS_START 0x0
+#define VMD_RESTRICT_1_BUS_START 0x80
+#define VMD_RESTRICT_2_BUS_START 0xE0
+
 #define PCI_REG_VMCAP		0x40
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
 #define PCI_REG_VMCONFIG	0x44
@@ -37,6 +42,13 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+enum vmd_resource {
+	VMD_RES_CFGBAR = 0, /* VMD Bus0 Config BAR */
+	VMD_RES_MBAR_1, /* VMD Bus0 Resource MemBAR 1 */
+	VMD_RES_MBAR_2, /* VMD Bus0 Resource MemBAR 2 */
+	VMD_RES_COUNT
+};
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -135,7 +147,7 @@ struct vmd_dev {
 	struct vmd_irq_list	*irqs;
 
 	struct pci_sysdata	sysdata;
-	struct resource		resources[3];
+	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
@@ -520,7 +532,7 @@ static inline void vmd_acpi_end(void) { }
 
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[0]);
+	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
 	u8 dev, functions, fn, hdr_type;
 	char __iomem *base;
 
@@ -568,8 +580,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
@@ -643,13 +655,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = 0;
+			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = 128;
+			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 2:
-			vmd->busn_start = 224;
+			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -775,7 +787,7 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 {
 	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
 
-	vmd->resources[0] = (struct resource){
+	vmd->resources[VMD_RES_CFGBAR] = (struct resource){
 		.name = "VMD CFGBAR",
 		.start = vmd->busn_start,
 		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
@@ -838,8 +850,8 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 
 	ret = vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
 	if (ret) {
-		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[1].name);
-		memset(&vmd->resources[1], 0, sizeof(vmd->resources[1]));
+		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[VMD_RES_MBAR_1].name);
+		memset(&vmd->resources[VMD_RES_MBAR_1], 0, sizeof(vmd->resources[VMD_RES_MBAR_1]));
 		return ret;
 	}
 
@@ -851,9 +863,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 {
 	LIST_HEAD(resources);
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
+	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
+				offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
+				offset[1]);
 
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
-- 
2.43.0


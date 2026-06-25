Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2112A3BED32
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367683; cv=none; b=IkcGAxyASfvqIESGx6iOD0u5M0qbT6u4wwNFu5tI41eFG7ZKWtKru5ukz3g/6RSpRAZn9Fa1HPt6HqhylJ0BtM7ihjj9gzk3wLJNHb1egstetFp3M7jgnj0b6f8g+9XOVajMUbCWEe05Zj1FPCPddVIbTqSr3RKGjYn5y8O4+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367683; c=relaxed/simple;
	bh=X5CNB6K//VnXimQ9T45UbmgZzn6B/7GFSIdFDVGGuQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7wwlw9+oECR6sGYRvTZxl3VkPPengbQqhh6MgxoQ/ZN1iLI9w14N0CTs2DIQweJrp3UVwD59qYV3wYgdL/vTHfuN5DK4veFX6jJvA73agL5jB3USXOats+Ag6XniLEvevzEwq6q6kSGv+w7f6l3BAF8MfRRLajpurB8YPP181E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiCJLBKE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiCJLBKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367681; x=1813903681;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=X5CNB6K//VnXimQ9T45UbmgZzn6B/7GFSIdFDVGGuQo=;
  b=PiCJLBKE5fqQD+TLMb6jyjaqgvIdy0uGlSVW2VX8VZCzj7uYs8KfjLjB
   Quv5e9OInifeHg5nyIikkKxB/PMWORkpyMjRwkZQavdQ+ztxc8TD0pA66
   dwXu9Hu5hbmDmg3E3zbemhzGG/9iCRo8ImB0WOh56R8Rr6CvsX20YV0XV
   rfHI/ZKDCbaFh7wYyScUln48aTL5sMfpd8I6VW+n89vGthfcPa0LbHD+C
   mjKkhiW4577BZFaD3rWn9Dv0zGRwrX3GEid4whobXpdEnLLLslYwEQmtD
   lT/n1PHh4Kh9q81MfTUCLEIDd+8dzytMM6l6XkbWhlZ/Qtnplc58AAUUo
   g==;
X-CSE-ConnectionGUID: rY5xnTfCQcCH9R7HnY/amA==
X-CSE-MsgGUID: nQ1XecFbSVqgUyH25/wfrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021835"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:01 -0700
X-CSE-ConnectionGUID: Y5ZN/svHRhqDQf+Ri7cVtg==
X-CSE-MsgGUID: LcYoo6IAR2SFHJbOF7Iqew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725491"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:58 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 5/8] PCI: vmd: Replace hardcoded values with enum and defines
Date: Thu, 25 Jun 2026 08:29:34 +0000
Message-ID: <20260625082940.1290740-6-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
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
 drivers/pci/controller/vmd.c | 43 ++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index c0a953df5f23..9ff82a24e859 100644
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
@@ -794,7 +806,8 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
  *
  * Function fills resource buffer inside the VMD structure.
  */
-static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
+static void vmd_configure_membar(struct vmd_dev *vmd,
+				 enum vmd_resource resource_number,
 				 u8 membar_number, resource_size_t start_offset,
 				 resource_size_t end_offset)
 {
@@ -830,9 +843,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1104,8 +1119,8 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_remove_root_bus(vmd->bus);
 
 	/* CFGBAR is static, does not require releasing memory */
-	kfree(vmd->resources[1].name);
-	kfree(vmd->resources[2].name);
+	kfree(vmd->resources[VMD_RES_MBAR_1].name);
+	kfree(vmd->resources[VMD_RES_MBAR_2].name);
 
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
-- 
2.43.0


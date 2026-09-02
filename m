Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330D4A92C2
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363268; cv=none; b=ZvOY1fo7qtcNg3cvnKoWEMNrm6B4ZN/zY4jrlLtl2xDVQgYerUip/+Dgx515aRpTUPnRk2K02WeEepvBFml/tX4xlFov7ibF5S5QVlYWhSlQmjP7wQnA5/897/RQdJSQO+s2VsBdIrdRxEp785ZxeIgbRkVHh8b6t3qMWpmMxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363268; c=relaxed/simple;
	bh=hj9HuOaIHtrvi/VQuqRrnBMYJj0qVtxj1es0oPunoIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRQ5YqcsT60Spz40hGjuKG1itUR50SSMmcTFRPc164QcGW81WGisoOjoRMqF4jlXuoLU/wvihQgXwBuyqj5vlFzI5suQ/LriqLQJ/OpqNd/osMzOn/KC32pFX+xbafvH7D75Kifx0CgyS4y1J+0xRkJg2MpeGx7pOl+RdRKBj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggIc1Yb+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggIc1Yb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363264; x=1819899264;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hj9HuOaIHtrvi/VQuqRrnBMYJj0qVtxj1es0oPunoIw=;
  b=ggIc1Yb+IM0a+RzDLp0taG4TWygZr4YSR4SbCnvo9xp2hTt4NthUiHT9
   AZiBk1Nh1CfNhTI79Lf7TOZa3Ef2YyX6Wm1QKcB6c60Vmq4iMNlqkyTCQ
   eFPaLgZ5PQz/7RcWQ68Aiz/symJkwIU1Kyyiyw0ZbvvS0/V+P61/xiS25
   +et76gObSCrS6SwzjxuwT7NxqcpmJbxxRTCgissvWNcbPyySQeSVkV/ZR
   Jog4/sb5vumjlE+o/C49YGRd1rq0D5++jLgEH8JM7HScBmyAT6OMw39+H
   PwP/gooM4H3JKFahDQQcikBBQ7XueSysMrIwXmGhGEadeptTFhhG3WH9q
   w==;
X-CSE-ConnectionGUID: OmFytidAQZmnaYmFAS+pIQ==
X-CSE-MsgGUID: Ih2DRk2tRYu75hyzJ0lVWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646681"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646681"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:23 -0700
X-CSE-ConnectionGUID: BIBjV/KFSRO+BYRTaK44OA==
X-CSE-MsgGUID: bbTNJYr4SomuvygpKKG1qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406824"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:22 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 5/8] PCI: vmd: Replace hardcoded values with enum and defines
Date: Wed,  2 Sep 2026 17:58:41 +0000
Message-ID: <20260902175846.3497854-6-szymon.durawa@linux.intel.com>
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

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 45 ++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e19b7fcb2025..79ae4a62e29e 100644
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
@@ -43,6 +48,13 @@
 #define BASE_ID_REG_28C1		0x2840
 #define MEMBAR2_OFFSET_28C1		0x30d0
 
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
@@ -150,7 +162,7 @@ struct vmd_dev {
 	struct vmd_irq_list	*irqs;
 
 	struct pci_sysdata	sysdata;
-	struct resource		resources[3];
+	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
@@ -562,7 +574,7 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
 }
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[0]);
+	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
 	u8 dev, functions, fn, hdr_type;
 	unsigned int ecam_bus;
 	char __iomem *base;
@@ -613,8 +625,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
@@ -688,13 +700,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -910,7 +922,7 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	/* Do not let resource[0] end go out of bound.*/
 	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
 	busn_end = min_t(resource_size_t, busn_end, 0xff);
-	vmd->resources[0] = (struct resource) {
+	vmd->resources[VMD_RES_CFGBAR] = (struct resource) {
 		.name  = "VMD CFGBAR",
 		.start = vmd->busn_start,
 		.end   = busn_end,
@@ -967,14 +979,15 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 {
 	int ret;
 
-	ret = vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
+	ret = vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
 	if (ret)
 		return ret;
 
-	ret = vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
+	ret = vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2, mbar2_ofs, 0);
 	if (ret) {
-		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[1].name);
-		memset(&vmd->resources[1], 0, sizeof(vmd->resources[1]));
+		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[VMD_RES_MBAR_1].name);
+		memset(&vmd->resources[VMD_RES_MBAR_1], 0,
+		       sizeof(vmd->resources[VMD_RES_MBAR_1]));
 		return ret;
 	}
 
@@ -986,9 +999,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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


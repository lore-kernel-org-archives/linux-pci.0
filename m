Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981772;
	b=K17OY1ovUiv7dglQh5XpgODoMUeT0kbejv01pxuh/rCLzfhG4HsBwFfBvG5UAm7qVWBR
	 nJl1dDiooqSKAQADl3SlEtlGGe8Nt3xbu3JqHg1eNTUg9F8lDvYhyf0ej7j3UpBUS5Nha
	 kDMTLPAR2bhfbAgD//j9DdFl2GR8wHuWsJtgtE5nDI4cIIVCb7P9EGd2T9NLKVCzMQGDK
	 /aP2QTzgPz7Rjbwa9PYdYU6kMVgaTWAAEGQdMfj6s8A5BEmBtLR08zy+bCd2KKa+qR7bf
	 dUEni6+up2cJ4OfEZOkc+J/l3julnGtshveENwt0l/kbBBXJBRc8dzqbrIvFk9jAp6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981772;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hsl0QQWybUPfLDhb5yec+bu7WKSDxZCbELPP28t1jv4=;
	b=3zqtteSDzBHYSwK4tzMU6CuDJhIilZ6FEGZs+MepGv/PWd9kqfhG690BAw2FFoHBgD5E
	 AcYo7GqwYVs3cUoWgNb4pfXh87Ppn5BKW1gXvFvv5/LgyGcGqz3B4VSod8v9vwYwC1F1F
	 GWyauCR4gOHdZ6RfX4Gda24XFCI7RID+7dM3tdK1ZJqIrNbj8cn+cfUU2IM4lwq0m0EBF
	 gkKuk6UfCuOH4Xmg0JhvxWOkUxnFFq7CRjUBVIyMejsnwm3kISEwKkVRI+QA0zOtgbOfA
	 IHpDZJBm0J82DWuv2oBjayi1m8idMrQsgKbRAxhUW7ebyMINjy8fxHkJDnmYk8U1zTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nSNRpvm1;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A931606D802;
	Fri,  6 Nov 2026 16:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A931606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nSNRpvm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981772; x=1825517772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnkdNf3iCWDtNXj5pCbxys1qyiUGC1kosmViSL5C99Q=;
  b=nSNRpvm13Bjj55R/ALqmNH0SySCVqZJeCHGJiDOgKWgECWl9DbyrBFhP
   r/UMGyj53c5qzEt6VjTRGY3K+kzp/b4aI/q72Gr/s7FFK6/itnk6gy6o0
   xwKZg/BrIYC18PnW2aTDI7QLIxE0kuvKu+EA4hNv0BT2W7VqneWSXdpD0
   JPE5uUPuvejz0fc5CcbLCwkDaKQhYwaQHS2+vGkEbtwQD/BgWGrhoTDrv
   yfXHR7aJDxD8ioNzaVGrjghMn1IXYLZpal8AEjvfD4R7OFn5SYzhxSTvg
   JY62AIKq/Fok/2gkF8CKBNmb9UeSrWMPAjCKYCvpZXeX0VJyILuWQk6+A
   A==;
X-CSE-ConnectionGUID: YS7iHauRQjKyYxqrJR+OSg==
X-CSE-MsgGUID: MfmIolr+S/CI5ZF4UaDS+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889319"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:12 -0800
X-CSE-ConnectionGUID: Fw1wY8wyQTKPJ6f/JZQFPg==
X-CSE-MsgGUID: yaphdGjvSw2/wEBSFxJweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341907"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:10 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/7] PCI: vmd: Replace hardcoded values with enum and defines
Date: Fri,  6 Nov 2026 18:42:53 +0000
Message-ID: <20261106184256.4130-6-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 52 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2acabe05e909..09d3bf35c934 100644
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
@@ -179,7 +191,7 @@ struct vmd_dev {
 	struct vmd_irq_list	*irqs;
 
 	struct pci_sysdata	sysdata;
-	struct resource		resources[3];
+	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
@@ -590,7 +602,7 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
 	unsigned int ecam_start;
 
 	cfgbar_buses = resource_size(&vmd->dev->resource[VMD_CFGBAR]) >> 20;
-	ecam_start = vmd_bus_to_ecam(vmd, vmd->resources[0].start);
+	ecam_start = vmd_bus_to_ecam(vmd, vmd->resources[VMD_RES_CFGBAR].start);
 	if (ecam_start >= cfgbar_buses)
 		return 0;
 
@@ -598,14 +610,15 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
 }
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[0]);
+	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
 	u8 dev, functions, fn, hdr_type;
 	unsigned int ecam_bus;
 	char __iomem *base;
 
 	max_buses = min_t(u16, max_buses, vmd_cfgbar_ecam_space(vmd));
 	for (bus = 0; bus < max_buses; bus++) {
-		ecam_bus = vmd_bus_to_ecam(vmd, vmd->resources[0].start + bus);
+		ecam_bus = vmd_bus_to_ecam(vmd, vmd->resources[VMD_RES_CFGBAR].start +
+					   bus);
 		for (dev = 0; dev < 32; dev++) {
 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(ecam_bus,
 						PCI_DEVFN(dev, 0), 0);
@@ -649,8 +662,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
@@ -726,14 +739,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = 0;
+			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = 128;
+			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 3:
 		case 2:
-			vmd->busn_start = 224;
+			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -959,10 +972,10 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
 	resource_size_t busn_end;
 
-	/* Do not let resource[0] end go out of bound.*/
+	/* Do not let resource[VMD_RES_CFGBAR] end go out of bound.*/
 	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
 	busn_end = min_t(resource_size_t, busn_end, 0xff);
-	vmd->resources[0] = (struct resource) {
+	vmd->resources[VMD_RES_CFGBAR] = (struct resource) {
 		.name  = "VMD CFGBAR",
 		.start = vmd->busn_start,
 		.end   = busn_end,
@@ -1019,14 +1032,15 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
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
 
@@ -1038,9 +1052,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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


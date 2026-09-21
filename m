Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C244D6AC
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000297; cv=none; b=cGoEQMrSOGVFptxQWCCvB43nvamoj4rdJZzsiy2U3JsjnWlfNDIgy+rzsP8vgdElD5ZuVr3o6wyZfdjwBpff0zH8FujquWs5tAd1oY/T6x0dqlCuRx9yo8uHDuZ5ZGxzCcpynoP2lm7KtIzPA6eSCMNigU8BpXFy5sknxBl0Fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000297; c=relaxed/simple;
	bh=FSP23mJTcdMJDbMsJgh43EA/viaslb6zg7j5jxWdcco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyKwG98KiAs4tL5gwi5Hw6X0TOAO1YiFtcZVuIjGYYr1UkS1rgrZ6Fk06WSD2dNcw4q2gSSDYu8LCPAMoFHmG6fpq0UIpKP0/ULpbjpyuYDjdai/KZys0snVmRAH9FIRHRrseCufYqRE65lnXgw1kGUuRn6ntCfH2ctob+tG9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brQcHkdH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brQcHkdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000296; x=1821536296;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FSP23mJTcdMJDbMsJgh43EA/viaslb6zg7j5jxWdcco=;
  b=brQcHkdH3VlcHqfYGbeI4gsjBUMzC0h/RtMbjiQhtwzcdYK52SRep2kM
   Svlgj9ZutFhBuuA26wc13fVs8ZWpyZv6eI13mjdirS6yx6AW8QEoHY5ER
   9uDz1TQuQ56+Ervb87XyWH9sqD6BSgulTgSAZAN2l7tOoPq2NI4RVuciZ
   gUJrKXp1DvsN+ba4gn9rCaFPL5rh6Cn4Hm7X6nvzoejPhBwmy62E0LuPt
   5OtVbcjttpztnfsVFsMUzJxYElGStA9MqQ3xhMyp68dARHPQjQE/9v/2h
   1gjodfzCBba+pw6rI21HpIxP2sYaR8GZjMAe2fSinIbglLRcmlvAMD7uM
   Q==;
X-CSE-ConnectionGUID: EQTxvN88R86O/s1tLVYg3A==
X-CSE-MsgGUID: yQaIeHRnT36nJP3rN7mpSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108366"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108366"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:15 -0700
X-CSE-ConnectionGUID: wfGngwm4S/+/nUB6diy2eg==
X-CSE-MsgGUID: qFvrKM/QRl2948b4YBZMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654390"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:14 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 5/8] PCI: vmd: Replace hardcoded values with enum and defines
Date: Mon, 21 Sep 2026 16:43:11 +0000
Message-ID: <20260921164316.3860312-6-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
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
index 8b59b369f126..b7c4e22deee5 100644
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
@@ -690,14 +702,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -913,7 +925,7 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	/* Do not let resource[0] end go out of bound.*/
 	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
 	busn_end = min_t(resource_size_t, busn_end, 0xff);
-	vmd->resources[0] = (struct resource) {
+	vmd->resources[VMD_RES_CFGBAR] = (struct resource) {
 		.name  = "VMD CFGBAR",
 		.start = vmd->busn_start,
 		.end   = busn_end,
@@ -970,14 +982,15 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
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
 
@@ -989,9 +1002,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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


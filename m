Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039357;
	b=0LtaoS6TQr147r3JmtkwrJGo/7kQ4bFO8ERrwtt9vA7+mNUac82BS87tt3/4kcNU3bRa
	 jvVJ7kKy9P2YgV3PWinx9LZTPn7ByMwfggJvzhTJqfP+C734+xoRisKQnN0p1c63ugt/P
	 1sqKHDXRwcrOCO9wiZCjQ5ISVHDvY7UzGkaB8spTzaD45bohBV5GRoQM6YGO686derhXe
	 30btx01Y2Td7AAxsBRQWoQNx0QMW3WrMjVHtYBAE3/FLNHrmMmZJCfglvFSm2WNbDOum7
	 F9q7s9LQWBqzhfwU4Szw9SpWmj1V2kZyT/pSNJIXmj+cmswHSuAWVO+FIr3NyKuS1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039357;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2MLrqt+GUM0f3y9eyD203JdQ2SEZO2AUc5pd8y9hPHg=;
	b=1wo2v0R8RqjRpbOs2c6TxgmU6lH2L0Ot6LeFc4uTWhHIi/vZzsMVwv01vWj9O4dmrAbr
	 qZTHMmbtvSX70TlY/d8c4i2xAcMP6bfknDdM2fls+Miif/yL2P3Z1+UllKPR2jIsn4DZC
	 BspiCy13QOsCWrU1qbgoeBr7y5+oj2Hq9EwqFMaO3LGGRA2zpOC/j3ZXQlArMx/iR+Iv8
	 eg4t+oo40zXoXz7mlf2jjHj8hp1waOiJzAgAtYmv2eua/yq7pJDFe9eyBrj3TJ3nsMCUP
	 atvCNLNScmbi9b6PGiriYDzocM//qihRjzlM4AlycphmhMPfyLgR1W/iNP8wDJQeJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AQ3ZbWmy;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A541606A335;
	Mon, 26 Oct 2026 18:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A541606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AQ3ZbWmy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039357; x=1824575357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ye9oJ2wiNKDXIqB9hLG+TzGMLKOS2iiflvQtoXVdaYE=;
  b=AQ3ZbWmyJsw9G8ZUqNmsjthvVBjN0ESOzISTNkhUZOiC6dIq6bnwY/Ar
   +TZp6IiI9MYqsJwKoYx1N5ub7eEq6IfKuUrTBP74kErOvwfS7JSPgiBO0
   fiVe6NS4udswH54qi7N1tkgvO9qQ18X2pXOST8mK2vmQIegxX8RkqKoPo
   v1ns+Ris4hfVJU7085CG2G7FfNtR3rivH8823y+nE6IRc2LuUW2ymdFOC
   fj1vDIfwF4lFfC4QpDH1ez7yyGCwfg/mhS0PHAqkrvuy65sSqnr7oBPiW
   CT6a0cC2wPDbSxW+Fnasqj+sxm+RjM2BZyOzVlnrsvzMEOZLbzNYa/GN9
   g==;
X-CSE-ConnectionGUID: cW0nfFZwTsaRZsJEDe8PNA==
X-CSE-MsgGUID: J54yjalZQZSPG1WdYeAeRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601021"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:17 -0700
X-CSE-ConnectionGUID: 3EDd2l2KSLqz4MXZpeyD8w==
X-CSE-MsgGUID: FI9LJTPvRWCRkhBrF22zcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720103"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:14 -0700
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
Subject: [PATCH v9 5/7] PCI: vmd: Replace hardcoded values with enum and defines
Date: Mon, 26 Oct 2026 20:54:58 +0000
Message-ID: <20261026205502.3502574-6-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
References: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
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
index 8b59b369f126..f85dd2d7c4af 100644
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
@@ -554,7 +566,7 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
 	unsigned int ecam_start;
 
 	cfgbar_buses = resource_size(&vmd->dev->resource[VMD_CFGBAR]) >> 20;
-	ecam_start = vmd_bus_to_ecam(vmd, vmd->resources[0].start);
+	ecam_start = vmd_bus_to_ecam(vmd, vmd->resources[VMD_RES_CFGBAR].start);
 	if (ecam_start >= cfgbar_buses)
 		return 0;
 
@@ -562,14 +574,15 @@ static resource_size_t vmd_cfgbar_ecam_space(struct vmd_dev *vmd)
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
@@ -613,8 +626,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
@@ -690,14 +703,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -910,10 +923,10 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -970,14 +983,15 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
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
 
@@ -989,9 +1003,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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


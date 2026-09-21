Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3A4A2E1A
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000299; cv=none; b=mQXaITgelS+NkT+Xa1fSMPPVBwp+HztktEOtsFPzQxAFc358yaOMk0U1xBVsmyColEWoYIlXLfNbg2nagv5ZpoOVq47l9TIK5KrpRvu0F9Uua9twJOTWgU5tV9MQWs3UT1beV2nwiVINXDN6DgkFCfhA4sYVD2ljDJczYdfdT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000299; c=relaxed/simple;
	bh=4aQ5gxjMBOJPJA+QOKcutMX+GVSmJkbyYWqxhvAVo4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6tkOyXC++jAfF39vAxx1yWnRSq0nY4d5Hiel5jjwdSXO0WfCTOzqN8DokhKIO22tY8l37ANQAeVf6oDsSIkPWFSrgKzsM1o1YmSFFbAr5VPpRrYdOtlP/PikXAggdOdmhkSvogLvGC6OPfpDjnNzHq4sctJ5be8j1iYF/PsaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrMbiujT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrMbiujT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000297; x=1821536297;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4aQ5gxjMBOJPJA+QOKcutMX+GVSmJkbyYWqxhvAVo4M=;
  b=YrMbiujTLLFQaM41MXB5nrPZ87ZaFQt3055DRwMhUuzH6m23HnFq/+CI
   AyagmTxlEMjs6yP6hp6vJvJoHoGfP8Y3cgRbGjOgw6JnwYtUkpvbvpeHq
   +vwcUmK+HLVKRrowAvlRPKCfLN8dRG5b43GYkX4kp0lL01bczfqvDYiBM
   QzpvVEQC08BXegL/QoSsWQ6LEBBiRUQKnMYLrnsmX6ETgc30IZ9w3OzjI
   dopOaH0hJeXCSF90+V2XZdnfOVJ8zsEhEmkGFnzJ48Za/V//GHVKwWVol
   IiKWG7StYU0FEFfSEh4X5Q4Al4ALQXenXOyv78YrICA3NCii5ieKpnUsQ
   A==;
X-CSE-ConnectionGUID: 3/nHU7J0RMSwtfcB/Tllcg==
X-CSE-MsgGUID: PqUoh6LiRD+ifFA/McK+Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108371"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108371"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:17 -0700
X-CSE-ConnectionGUID: Z2sntBd2QTS3z2+F5F2MTg==
X-CSE-MsgGUID: jqY7QrEkRp6lh0pWAAQyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654396"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:16 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 6/8] PCI: vmd: Convert bus and busn_start to an array
Date: Mon, 21 Sep 2026 16:43:12 +0000
Message-ID: <20260921164316.3860312-7-szymon.durawa@linux.intel.com>
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

Convert bus and busn_start from scalar to an array to support
multiple VMD buses in the future. No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 47 +++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b7c4e22deee5..c6b5e693916c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -55,6 +55,11 @@ enum vmd_resource {
 	VMD_RES_COUNT
 };
 
+enum vmd_rootbus {
+	VMD_BUS_0 = 0,
+	VMD_BUS_COUNT
+};
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -164,8 +169,8 @@ struct vmd_dev {
 	struct pci_sysdata	sysdata;
 	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
-	struct pci_bus		*bus;
-	u8			busn_start;
+	struct pci_bus		*bus[VMD_BUS_COUNT];
+	u8			busn_start[VMD_BUS_COUNT];
 	u8			first_vec;
 	char			*name;
 	int			instance;
@@ -425,7 +430,7 @@ static unsigned int vmd_bus_to_ecam(struct vmd_dev *vmd, unsigned int busnr)
 	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
 		return busnr;
 
-	return busnr - vmd->busn_start;
+	return busnr - vmd->busn_start[VMD_BUS_0];
 }
 
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
@@ -702,14 +707,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 3:
 		case 2:
-			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -746,7 +751,7 @@ static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
 	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
 	base_id = bar4_2840 & 0xFFFFFF;
 	base_bus = base_id >> 8;
-	vmd->busn_start = base_bus;
+	vmd->busn_start[VMD_BUS_0] = base_bus;
 
 	/* Calculate offsets like vmd_get_phys_offsets() does */
 	if (phys1)
@@ -923,11 +928,11 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	resource_size_t busn_end;
 
 	/* Do not let resource[0] end go out of bound.*/
-	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
+	busn_end = vmd->busn_start[VMD_BUS_0] + (resource_size(res) >> 20) - 1;
 	busn_end = min_t(resource_size_t, busn_end, 0xff);
 	vmd->resources[VMD_RES_CFGBAR] = (struct resource) {
 		.name  = "VMD CFGBAR",
-		.start = vmd->busn_start,
+		.start = vmd->busn_start[VMD_BUS_0],
 		.end   = busn_end,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
@@ -1008,9 +1013,10 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
 				offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
+						  vmd->busn_start[VMD_BUS_0],
+						  &vmd_ops, sd, &resources);
+	if (!vmd->bus[VMD_BUS_0]) {
 		pci_free_resource_list(&resources);
 		return -ENODEV;
 	}
@@ -1021,13 +1027,13 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	 */
 	if (!vmd_in_guest)
 		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-					   to_pci_host_bridge(vmd->bus->bridge));
+					   to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
 	else
-		dev_set_msi_domain(&vmd->bus->dev,
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
 	return 0;
@@ -1162,10 +1168,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return ret;
 	}
 
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj,
+			       &vmd->bus[VMD_BUS_0]->dev.kobj, "domain"),
+	     "Can't create symlink to domain\n");
 
-	vmd_bus_enumeration(vmd->bus, features);
+	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
 
 	return 0;
 }
@@ -1262,9 +1269,9 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	pci_stop_root_bus(vmd->bus);
+	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
-	pci_remove_root_bus(vmd->bus);
+	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-- 
2.43.0


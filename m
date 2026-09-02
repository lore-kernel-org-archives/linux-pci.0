Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C234A3D5D
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363272; cv=none; b=FEOp5TXdm2/wpUe/z27/QDC2ZIRgmWW2EWf2rwim06iGOKTZIkP69TjHAqaa34bsn4oQ9GmbVvwSpalEWSkZx7s3uAFkiiTwJolPUzZ6+fQzYzcworfLt/HjMYSimemyK1cF5HAHMhUWpyc57bqk8EWhIXTav3uPC4Nvee6EoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363272; c=relaxed/simple;
	bh=qKqUPatBBx6+rqotUuqQQtEZ2fAjUV28gd2S9Xc5OLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI1OZA3IfWeFQ24ZU3n0iiO+LSW8fobQ8r1RfN7TFuujM6eaA1R7Bhnf90qc09yeMdHaAfByehd6V7YrQJTBDX/bJk2W4jCTYkuzIMJMUjq+z76AIEiQwVgLYzsMiz5ulsGmqJ994m4OWJss1BhfeJrxMi/CZWQAem1HZ8IOQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpeeFKla; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpeeFKla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363269; x=1819899269;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qKqUPatBBx6+rqotUuqQQtEZ2fAjUV28gd2S9Xc5OLM=;
  b=LpeeFKla64DG4gFP+FBGFPblSHFmI5zX2264sXgu7h4i9asqW3TXRdJE
   3Tj04UDjVqBUUe5cN1zh4cRsoa+x66Z/xmJzKS8IrrbBoY8BHO5weJ7qC
   qN9rdUudSB6/QgWIzk6AT9DmjMyhlEDrgb15QTjQw111UxEc8MCWT+UsH
   FUZrGkwAkhL6TAh5yclyRc9ctBlmfVpmLkwy/YAcFaqttMBOqADjeIFDK
   qFdhY5aMc4uyGjc8AkyYXfrfcvBvkFYc/97pfhwRhCT/WQqsgSey74lCz
   A6XvI/CKxhq+SASyFkxdsN2cNEwHF0ivV9chKPf61tbEUelK7gzocz4xC
   A==;
X-CSE-ConnectionGUID: p/EpB+VXQcKbcfhRst72Ug==
X-CSE-MsgGUID: SspMDmzPQ7aBq+47Sq+yww==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646689"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646689"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:26 -0700
X-CSE-ConnectionGUID: xc8nAK3YQbuDXV2/r72Rgw==
X-CSE-MsgGUID: 2Ge/cQhLTh6E6V+qKDHXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406851"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:25 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 6/8] PCI: vmd: Convert bus and busn_start to an array
Date: Wed,  2 Sep 2026 17:58:42 +0000
Message-ID: <20260902175846.3497854-7-szymon.durawa@linux.intel.com>
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

Convert bus and busn_start from scalar to an array to support
multiple VMD buses in the future. No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 47 +++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 79ae4a62e29e..681bdd54f050 100644
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
@@ -700,13 +705,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 2:
-			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -743,7 +748,7 @@ static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
 	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
 	base_id = bar4_2840 & 0xFFFFFF;
 	base_bus = base_id >> 8;
-	vmd->busn_start = base_bus;
+	vmd->busn_start[VMD_BUS_0] = base_bus;
 
 	/* Calculate offsets like vmd_get_phys_offsets() does. */
 	if (phys1)
@@ -920,11 +925,11 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -1005,9 +1010,10 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1015,13 +1021,13 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	/* Don't copy _OSC control flags in VM, it disables features.*/
 	if (!offset[0] || !offset[1])
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
@@ -1153,10 +1159,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
@@ -1253,9 +1260,9 @@ static void vmd_remove(struct pci_dev *dev)
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


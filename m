Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082D3BED66
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367685; cv=none; b=ewN8BdPoVJIHS33bD6qPTmAjqI1UatW/DcNU3RZaOT1kwpIqtR8rzfIt6zgzD8lrSzW7M9v0G1Jrs0XYjqtiD06Bk/NM5UcK7/kJUGDsSmdnp0HOboNSGx/TxcypG3vNbcuIAdp6egCnQF3asi25+pEoWQZ/MbhFCbYRJ8YTre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367685; c=relaxed/simple;
	bh=Lah4eobdJfMRX70qjykabpV6WmB0Uq16fPGuxv91q7Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMbQgYmD9MYY+x+h1j9rMv0ocaTAYLjX3D3wT781byBDhmXzxCcfLoSBmCWwVLINQorwBchS4BXqDnJZRKtVLOeLAcUdSXE4cPzjq61aBA/l8JqhbZhNU281ucsxsLM3E3bljiTR0Kj9QoZ/OBvB7HlJmH2xC2S57YcReBk+o2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4QOPVG5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4QOPVG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367682; x=1813903682;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Lah4eobdJfMRX70qjykabpV6WmB0Uq16fPGuxv91q7Q=;
  b=P4QOPVG5xEiJB3iL8/u21Glqn6DRvQnQAotnoxugqmU8HoLyWbpfuDDp
   sR8ECNKyjvob3XSd2d0JdgCx15aV/I2dcbt4x5SMXQScKq/l5XC+SFlZ0
   H2lU2Tv5IvH+XuG331A2vk7JYplSyJEqOrQxc+Jxq9H5gqJbBRA2l24Bd
   NGgluOmsGzXIkNXF0h6XQaCyyMXPZxgbn+JBR+vFAkLNn6eiYINfv5gXN
   fLtq2FgKdTGaWrAZrs6v3ma5DBVqgMiEsa35XCnXA8L4XuXQmM/VUp1lg
   YKvQGIXG0Hb6BY+qOmIZ18/WcULZW+yPLpIODlSiQM7ZrFawqYcVS2f5y
   g==;
X-CSE-ConnectionGUID: NwMgNNqcQnOAZMOm4H+dgA==
X-CSE-MsgGUID: 0II88xgCQUqL2edb/jDyow==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021838"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:02 -0700
X-CSE-ConnectionGUID: wWdtfLvPTby4g1YKHUw2/Q==
X-CSE-MsgGUID: V7RMv0MHQSuPIFzyjEURRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725513"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:00 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 6/8] PCI: vmd: Convert bus and busn_start to an array
Date: Thu, 25 Jun 2026 08:29:35 +0000
Message-ID: <20260625082940.1290740-7-szymon.durawa@linux.intel.com>
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

Convert bus and busn_start from scalar to an array to support
multiple VMD buses in the future. No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 46 +++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9ff82a24e859..2bfc16875d91 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -49,6 +49,11 @@ enum vmd_resource {
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
@@ -149,8 +154,8 @@ struct vmd_dev {
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
@@ -404,7 +409,7 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start;
+	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
 	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
@@ -655,13 +660,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -789,8 +794,9 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 
 	vmd->resources[VMD_RES_CFGBAR] = (struct resource){
 		.name = "VMD CFGBAR",
-		.start = vmd->busn_start,
-		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
+		.start = vmd->busn_start[VMD_BUS_0],
+		.end = vmd->busn_start[VMD_BUS_0] +
+		       (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 }
@@ -849,9 +855,10 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
 				offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
+						  vmd->busn_start[VMD_BUS_0],
+						  &vmd_ops, sd, &resources);
+	if (!vmd->bus[VMD_BUS_0]) {
 		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
@@ -859,13 +866,13 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	}
 
 	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+		to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
 	else
-		dev_set_msi_domain(&vmd->bus->dev,
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
 	return 0;
@@ -1015,10 +1022,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
@@ -1114,9 +1122,9 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	pci_stop_root_bus(vmd->bus);
+	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
-	pci_remove_root_bus(vmd->bus);
+	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
 
 	/* CFGBAR is static, does not require releasing memory */
 	kfree(vmd->resources[VMD_RES_MBAR_1].name);
-- 
2.43.0


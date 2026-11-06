Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981775;
	b=3KQZUyjOGZ7iAEz0nBofnv2ju1P3wtAZJfXBVybJI0aeUmb3meKuHzKP8/C33SFHZVNB
	 BHmrpa+pAq4qZPTvtbA5wllskVpaHt7gJKpzFy30IiqiF1UdMVbIILK/WnL1uuawPDyso
	 HbBQOGFUpjiJ0cDm3Hvm+viHsmrvvOPchAORcjDFgJ7S7dIgqMUtFTOg52qd6N2K6ArE8
	 GEOc+yyPBwqHqXTLO1C2s7ljaSztGXLc7ajzCEGcPckkgSeTLFB19CUuB+EHeVFWxL+Vz
	 uHp46xUg3iDy9AIALdYjSOuneqmaIzMexKK0K9awoW/Hfmu9oM/lWizvrYZWB0ogmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981775;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WmCJv6xh2uQf28IF7XzJcCJf6KPQ/RKnUHBkCzuxbDE=;
	b=l5cUiyAiHOuHyyMDGaXbKoOGBRoo4bPvyXmFkVmVrCsHXRlETiBVytfQhWeCvryc9neq
	 cOopx4k4wwIoVSdpEkRvvDEWJ2polzj/zQEi5hEA0otVYLKhJ/4f00iLGHZnTlYZIJA9Y
	 agIjL/3Y93xH/j0diHGRWhm4mQx9K2gQc4cmKF2F4lqtHAR2kcUbVai2AEBssFfAS/b6D
	 3XrZZwFJ2PXIH0gPrJx8Xz7wmDUDgrTN2uOOTg8svtwdHXrjalePyPBazTGN30W7atNla
	 h+jFJTf7rG9mrTHrDnG2cvi1x9n2jADi9umdhBu0B+OJ4xIV7/XSJWQRFupFrI3mqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W81E2a73;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF62606A32C;
	Fri,  6 Nov 2026 16:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF62606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W81E2a73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981775; x=1825517775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R81F1ujtvLrcgOalXjPABvU4Ik47+8GC+WDlfNWSd90=;
  b=W81E2a73lMWCEypvngRwKh6wc7ql3NPHczmxO09Nm3aAjApMIMheE8Te
   tcWzlgsQC5U3oh8/XS0WGOS+ll1G8mj8EqNjkPwScBlUsgYPrsvsZqxue
   Ouwy8FUUCsb0yJ726Yuthgu4disKMjjqgk70DHnmiRmjrlPbMh+HioKb2
   3+J8oz3b6AzOeeG4vlJiMTVikOMln1gwpYHZgfqHDhaLqVEP1eLTCcTSA
   JXChUXYTZMkFj1mbJJI6SrbYZJXCPezPPgQ8FhVYhPA8iw//CbXg3Tr3I
   HfNExfs58kd6M6+eNm1VR69XNe5C/vN+6csfkUkXm3TBV7eUsfbdb7wvn
   g==;
X-CSE-ConnectionGUID: guAs4FZuTxa1Loc8C1gT/A==
X-CSE-MsgGUID: yKNiYDhNRs6T6YOeAVR2gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889325"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889325"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:15 -0800
X-CSE-ConnectionGUID: b3I1IKXpRoWz724mCCcNMA==
X-CSE-MsgGUID: VJYDNksdQHyI2yiWIsMI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341909"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:12 -0800
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
Subject: [PATCH v10 6/7] PCI: vmd: Convert bus, busn_start and sysdata to an array
Date: Fri,  6 Nov 2026 18:42:54 +0000
Message-ID: <20261106184256.4130-7-szymon.durawa@linux.intel.com>
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

Convert bus, busn_start and sysdata in vmd_dev struct from scalar
to an array to support multiple VMD buses in the future.
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 64 +++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 09d3bf35c934..5733faf972d1 100644
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
@@ -190,11 +195,11 @@ struct vmd_dev {
 	int msix_count;
 	struct vmd_irq_list	*irqs;
 
-	struct pci_sysdata	sysdata;
+	struct pci_sysdata	sysdata[VMD_BUS_COUNT];
 	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
-	struct pci_bus		*bus;
-	u8			busn_start;
+	struct pci_bus		*bus[VMD_BUS_COUNT];
+	u8			busn_start[VMD_BUS_COUNT];
 	u8			first_vec;
 	char			*name;
 	int			instance;
@@ -203,7 +208,10 @@ struct vmd_dev {
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
 {
-	return container_of(bus->sysdata, struct vmd_dev, sysdata);
+	struct pci_sysdata *sd = bus->sysdata;
+
+	return pci_get_drvdata(sd->vmd_dev);
+
 }
 
 static inline unsigned int index_from_irqs(struct vmd_dev *vmd,
@@ -412,7 +420,7 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 	};
 
 	info.fwnode = irq_domain_alloc_named_id_fwnode("VMD-MSI",
-						       vmd->sysdata.domain);
+						       vmd->sysdata[VMD_BUS_0].domain);
 	if (!info.fwnode)
 		return -ENODEV;
 
@@ -461,7 +469,7 @@ static unsigned int vmd_bus_to_ecam(struct vmd_dev *vmd, unsigned int busnr)
 	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
 		return busnr;
 
-	return busnr - vmd->busn_start;
+	return busnr - vmd->busn_start[VMD_BUS_0];
 }
 
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
@@ -739,14 +747,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -783,7 +791,7 @@ static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
 	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
 	base_id = bar4_2840 & 0xFFFFFF;
 	base_bus = base_id >> 8;
-	vmd->busn_start = base_bus;
+	vmd->busn_start[VMD_BUS_0] = base_bus;
 
 	/* Calculate offsets like vmd_get_phys_offsets() does */
 	if (phys1)
@@ -973,11 +981,11 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	resource_size_t busn_end;
 
 	/* Do not let resource[VMD_RES_CFGBAR] end go out of bound.*/
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
@@ -1058,9 +1066,10 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1071,13 +1080,13 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1133,7 +1142,7 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
-	struct pci_sysdata *sd = &vmd->sysdata;
+	struct pci_sysdata *sd = &vmd->sysdata[VMD_BUS_0];
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	bool vmd_in_guest;
@@ -1212,10 +1221,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
@@ -1252,7 +1262,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
+	vmd->sysdata[VMD_BUS_0].domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->features = features;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
@@ -1292,7 +1302,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto out_release_instance;
 
 	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
-		 vmd->sysdata.domain);
+		 vmd->sysdata[VMD_BUS_0].domain);
 	return 0;
 
  out_release_instance:
@@ -1312,14 +1322,14 @@ static void vmd_remove(struct pci_dev *dev)
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
 	ida_free(&vmd_instance_ida, vmd->instance);
-	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
+	pci_bus_release_emul_domain_nr(vmd->sysdata[VMD_BUS_0].domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.43.0


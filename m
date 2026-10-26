Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039359;
	b=bOUDskSdUVFU4q0hK/6tpz6TZtIx5JosVgBzry95VoCOGHAo8or1kdvZtG1S9119lBPq
	 kJB9ZD8OUvfXxcNGVxYiXp/P2e3RQecxxUxCB66CCuOn9RsrpOzgDJ0ApDhZdg+nhvtgr
	 q0C9yiTvPmJQwQaH2YAo0Fr254XwtGrShTtnHs/TbTvHxoza4yZQZTJE/ysK6wW6+f52Q
	 yfeVp+ThtO0emMcBPeppqzxJYQ7ntZM8JZwhBea+pb+PfgOivBdxuzaVlQz6QO/TjI/o9
	 5GOQstHve298cJng/JNn3tjgeLNe13xUXPE9RPwhcikkogvTHROHF5qnxS3fQxxitvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039359;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tGkff6AcUMot1adtzXNBFbb0cxuWo0XfVc7jJlSclxI=;
	b=Al4DSBeM3WwAJsph3uq/HVMexXVC7az9i5UPHU0yv3TUfLPb0mf5NGrlGZ2hR5IOV0mC
	 /IDoclyIkNGWdi/BqS39YKKRJTnid47HgT2vX1goUoxihZBwtP6EsSnJMVOyPqkdGt2F6
	 4Tdh3f2pRJPdKRof7rnUdXWwVezGmWVB9TlntnGFsz1AwMp8fO3a/AmvPCNkESMUOFTPw
	 4ODQ4RV/YJ3XxJZFci4e3F/Pm2VS7I3UK+4h2BNSOMvTA0K1Fl4QMW//BbhrChO/hBQrl
	 KGHWr5tMCX9nWaYEOxk9TUmJX360X+GvQJJNo9Th4ag8Z2XRymOCzty5kGUe3Ax753A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Afgg29M/";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28413606A323;
	Mon, 26 Oct 2026 18:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28413606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Afgg29M/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039360; x=1824575360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R28tRFQrfN9dAqZ9pw0DKCxu/7klyMjeCDfNEZda7xg=;
  b=Afgg29M/vuSmiKWZAtSOJmqMlphFshvh5jTkwJDRcIW0+rygkCnQ9HGN
   aTsQ9C12cQmb6j/VhLJwK41mwr+fMhRnhj5M7ySx6EYdxeoAp9XO8j+Lq
   Xvz/qC5S4/a2hdHcI0pCBltiz9XR9EQ6dPXp19orFktBpaKIB/mCWX4y6
   EYbGOs0YzYadqN20vYPSEQ1m+VTTRngeHeGYOFpTuOnwBHc2xG/dUh4Bg
   nwOffmNxP8MZ5r3Qwgb5Dxsz0tvID/dttFSH+8IhdBN/gArxLByD7wuK2
   1CjaHxZxRLpGuBfJHuEUrZVFPlsF3h/rHcwIOBgef6J6DdXe1jpqsHdLk
   w==;
X-CSE-ConnectionGUID: UlymaF92QFetsD67CQRRcQ==
X-CSE-MsgGUID: JjgGim1SSEWHfABubnqg1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601027"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:20 -0700
X-CSE-ConnectionGUID: seAWLZxzQzK938gEpw8k5w==
X-CSE-MsgGUID: uiAAvFznTfGFXUFWI4aUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720108"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:17 -0700
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
Subject: [PATCH v9 6/7] PCI: vmd: Convert bus, busn_start and sysdata to an array
Date: Mon, 26 Oct 2026 20:54:59 +0000
Message-ID: <20261026205502.3502574-7-szymon.durawa@linux.intel.com>
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
index f85dd2d7c4af..1db974ed760f 100644
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
@@ -161,11 +166,11 @@ struct vmd_dev {
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
@@ -174,7 +179,10 @@ struct vmd_dev {
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
 {
-	return container_of(bus->sysdata, struct vmd_dev, sysdata);
+	struct pci_sysdata *sd = bus->sysdata;
+
+	return pci_get_drvdata(sd->vmd_dev);
+
 }
 
 static inline unsigned int index_from_irqs(struct vmd_dev *vmd,
@@ -376,7 +384,7 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 	};
 
 	info.fwnode = irq_domain_alloc_named_id_fwnode("VMD-MSI",
-						       vmd->sysdata.domain);
+						       vmd->sysdata[VMD_BUS_0].domain);
 	if (!info.fwnode)
 		return -ENODEV;
 
@@ -425,7 +433,7 @@ static unsigned int vmd_bus_to_ecam(struct vmd_dev *vmd, unsigned int busnr)
 	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
 		return busnr;
 
-	return busnr - vmd->busn_start;
+	return busnr - vmd->busn_start[VMD_BUS_0];
 }
 
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
@@ -703,14 +711,14 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
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
@@ -747,7 +755,7 @@ static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
 	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
 	base_id = bar4_2840 & 0xFFFFFF;
 	base_bus = base_id >> 8;
-	vmd->busn_start = base_bus;
+	vmd->busn_start[VMD_BUS_0] = base_bus;
 
 	/* Calculate offsets like vmd_get_phys_offsets() does */
 	if (phys1)
@@ -924,11 +932,11 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -1009,9 +1017,10 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1022,13 +1031,13 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
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
@@ -1084,7 +1093,7 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
-	struct pci_sysdata *sd = &vmd->sysdata;
+	struct pci_sysdata *sd = &vmd->sysdata[VMD_BUS_0];
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	bool vmd_in_guest;
@@ -1163,10 +1172,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
@@ -1203,7 +1213,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
+	vmd->sysdata[VMD_BUS_0].domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->features = features;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
@@ -1243,7 +1253,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto out_release_instance;
 
 	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
-		 vmd->sysdata.domain);
+		 vmd->sysdata[VMD_BUS_0].domain);
 	return 0;
 
  out_release_instance:
@@ -1263,14 +1273,14 @@ static void vmd_remove(struct pci_dev *dev)
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


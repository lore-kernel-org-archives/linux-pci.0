Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9474A64D6
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363260; cv=none; b=GfQKNTLnZ+B6nK8BuSo+GnmZ9LTgpg5OcQQF+TM73FTR75TLLhvoKHYSXqsugRLFCyLuSHljF1bEfSa1JfXFtUEv79IJuLK5YsnL20O89XVudHxFz+nx9vpCCBb6CALrC3gHEJgbz+vtelVkPkx7vZzTYjN3OL8YGmVz6pR8n5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363260; c=relaxed/simple;
	bh=BLRBZ093OePpW91T62fSNDHRvmGVFTg7cSeCMAgZpJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isVZL3fOxENvMW9Uwmdb+kZjaUXZduLr2Mxi29acWSQGXaeVXvpavq2Iv4lQp+fqjBvaaPs496wh9Iv2UXSoHx2adqfmXDnot55LW8iubC9uhrtakICDCAYB1hx4/IaTQMhkeW5RxJk+Q5OigwBR0/NVU5+BHLnd4g4jCujVbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJkec2vx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJkec2vx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363258; x=1819899258;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BLRBZ093OePpW91T62fSNDHRvmGVFTg7cSeCMAgZpJk=;
  b=NJkec2vxMtSLXSVTGDjgX28r9gPymA18Rm+ipvI1zYxq/0hONkCU0R2l
   anJjFfyIy2I0W4ZsR74weekRlr+CMUxg5JmFnoTe/azcSz/v420/e7hM6
   q0uQHDDcsdJhdtXD5kLIFIZVXMmsE2/0aLtUGcqQPAsnX/1NwhG9ef+oD
   GrX36JluVr7gtiG5j301i0zs3HV6EnYwoaYzeIPpaCxR1qJDGJMqdGeuf
   A2XZD6V9po5CrgXuQ0MyiH9/gtT5jDqSjeMzF0BtIi3YDbLuXU1KtS6Kp
   VSvoT205xFE7OCyGsTXupU2E1VJXsNe5jnORYARZHliWewpOFH6Fxn2Ne
   A==;
X-CSE-ConnectionGUID: N/7KF/7iQ1qEGS+aeCNL0g==
X-CSE-MsgGUID: H5lMDGfjSieQjc+FAstbKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646675"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:18 -0700
X-CSE-ConnectionGUID: j8uHCcbWTJC1si6wBlDRrA==
X-CSE-MsgGUID: sZ9EOrF0TBWDFkJs/cSkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406788"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:17 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 4/8] PCI: vmd: Add vmd_create_bus()
Date: Wed,  2 Sep 2026 17:58:40 +0000
Message-ID: <20260902175846.3497854-5-szymon.durawa@linux.intel.com>
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

Move the VMD bus initialization code to a new helper vmd_create_bus().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 57 ++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 213aba6fc9bb..e19b7fcb2025 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -981,6 +981,37 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 	return 0;
 }
 
+static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			  resource_size_t *offset)
+{
+	LIST_HEAD(resources);
+
+	pci_add_resource(&resources, &vmd->resources[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+
+	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
+				       &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		pci_free_resource_list(&resources);
+		return -ENODEV;
+	}
+
+	/* Don't copy _OSC control flags in VM, it disables features.*/
+	if (!offset[0] || !offset[1])
+		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+					   to_pci_host_bridge(vmd->bus->bridge));
+
+	vmd_attach_resources(vmd);
+	if (vmd->irq_domain)
+		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
+
+	return 0;
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -1032,7 +1063,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	int ret;
@@ -1086,10 +1116,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -1104,27 +1130,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	ret = vmd_create_bus(vmd, sd, offset);
+	if (ret) {
+		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
 		pci_bus_release_emul_domain_nr(sd->domain);
-		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
-		return -ENODEV;
+		return ret;
 	}
 
-	/* Don't copy _OSC control flags in VM, it disables features.*/
-	if (!offset[0] || !offset[1])
-		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-					 to_pci_host_bridge(vmd->bus->bridge));
-
-	vmd_attach_resources(vmd);
-	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-	else
-		dev_set_msi_domain(&vmd->bus->dev,
-				   dev_get_msi_domain(&vmd->dev->dev));
-
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 
-- 
2.43.0


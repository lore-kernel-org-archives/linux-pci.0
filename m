Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC023E325
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045827; cv=none; b=dvM6pbSApHmN10kLwpLwaAQLdR7ke/IA8OcM+xeIzATl6i8hINEJRz71IhshPh2AH+dqpwogO/QKsaIYg2EFsNxQIL5sQVR6X/fO3igFVRE4/J0tL/nSh1OvLlyPonKVaYZHKteWVHrpwnxRPrK8s6/pS6AHCLp6NC7MeKKtee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045827; c=relaxed/simple;
	bh=gLrWEY0vo8wzK8+lA49/1UlCc2pKf9gNCGUdi30VkpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzajNq6jXMaMQe1jaGT4DRoOx4tnvTPVUOdNcZXQpB+N1hKNAdjql5pHlkGRxeIcCFuANO4Fx/rlaovX+K1Ui8u8kfwF0y20Qyl+k/iPfnyU0TbQiZ6kCopEqj+OO8xSBI9iTLRxH4vS/TFixc1WfSeRAiTeYJa1BqcfeUNvixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8tyu05u; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8tyu05u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045820; x=1817581820;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gLrWEY0vo8wzK8+lA49/1UlCc2pKf9gNCGUdi30VkpA=;
  b=F8tyu05ubOeMf4YajzbK/pORFUMCxtGaeVB46Yyqj0Yuh1oiOpgK5eUW
   O1aEFlqimLDr8SYyKktvEN9C6KsIlAVL3QpC85KcIlhaYHKxoiAf/ZTTa
   7JFIbUcoMqrC5sJieR5jxqJhR+OhkvRYQAooCagMY++VZuCojBvipd3HA
   dyvsnhSS/YIIjJ5GDdFK53oPyXyXdNzIucreYQQJJAfImf0hfEtf+Rx/o
   bHi5ktRi+2LPMU+OM48eC6Fq5oDIx12PJlxANVbcOx/Z0/jSjccPQVZK/
   JuhhwER/axG+QLGwEnwr1kHk4CKvTrbEEjlGWMjp5IJEu/KyZPY1QGyg0
   Q==;
X-CSE-ConnectionGUID: H2VnX9VWRO+qAtI0MQQyxg==
X-CSE-MsgGUID: mNHdWQ+oQcule/cnLm3U+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622534"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622534"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:11 -0700
X-CSE-ConnectionGUID: dXPb65o8Q9a3I3cS2Drs8Q==
X-CSE-MsgGUID: zmo8ROj0QieHVaYRPZm4ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923408"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:10 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 4/8] PCI: vmd: Add vmd_create_bus()
Date: Thu,  6 Aug 2026 22:13:43 +0000
Message-ID: <20260806221351.38592-5-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
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
 drivers/pci/controller/vmd.c | 53 ++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 62bc9b91300b..f88a72b6309e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -846,6 +846,35 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
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
+	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+				   to_pci_host_bridge(vmd->bus->bridge));
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
@@ -897,7 +926,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	int ret;
@@ -973,10 +1001,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -991,25 +1015,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
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
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
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


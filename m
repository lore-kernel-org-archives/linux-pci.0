Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F544D6AC
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000295; cv=none; b=uG7maa2jSeXKO3L8483e7OmiyExu9zltU4XavT8k9W+G6kX8G0jJEK8FWjfFI3hC6sdsgFPM5kTqqZg4Fa9+hVKwTwkRadgy0YNh3KnvSx3kky6YVZYpYjNjuXeRyaZ6kViJaotx0SXTTYC+bF5l5jaKGbXlWQ6bujYRtD8uZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000295; c=relaxed/simple;
	bh=xMRMFTwt8iVqx2yP5dAWMkxsBzNxdFfdyRf4tzonz3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHv9RiXoHQOVFjPPVQgHincwdMqCAiKWcUgmV2Tw5XqKkeJv8WoNLgLZPYmNpR3bwRQymEceFtPrHT/sVSmVuAWQi2IQdtxVQnTSTK0/9OeISV0u/1msKJ76Y1C0MKk9ErvzOpBrzulxOBBloULFY3AtiKtYQS+vEePivZcllbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQkIKtTH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQkIKtTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000294; x=1821536294;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xMRMFTwt8iVqx2yP5dAWMkxsBzNxdFfdyRf4tzonz3E=;
  b=MQkIKtTHUw3VYfPA8ECfzg0gtRsp5GRixFgOizfw3entAnlrszI49sqc
   Ejk6Cc+P/5U58cV/LpuSdkfS0JD6suHteBwnr81DKrWBfiIGeusN4Uuak
   rBXcz2Lp7rfh0JM6gmVMF1Vd36GLrf+AbCB0VGOdaC8JO9tfFFU2zCdyh
   R2xp1G9tIiS8BBoEApGlQJcghhLcFADZozTVsGu2jam/q/f4Hpzd/D5MK
   BaHr8oRqz+VW85YvTvgMkoQUZ1no5HOPxRXxSClJgzfFcXSIi0UB9C1OB
   uGz96pJNwfgTQHDj7tmo5e8TyIBsv1y7zw6jDZGGlzNWHjA6LRtb+rwk/
   Q==;
X-CSE-ConnectionGUID: fAAitNv+QVaDT5dKWI8Aig==
X-CSE-MsgGUID: punAZ/FZS96h1PRXN6Zkxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108359"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108359"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:13 -0700
X-CSE-ConnectionGUID: bCuW2vdnT3+uKH1ek5oDiA==
X-CSE-MsgGUID: JCWVVPKRQMixXiHIXbNbGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654385"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:13 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 4/8] PCI: vmd: Add vmd_create_bus()
Date: Mon, 21 Sep 2026 16:43:10 +0000
Message-ID: <20260921164316.3860312-5-szymon.durawa@linux.intel.com>
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

Move the VMD bus initialization code to a new helper vmd_create_bus().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 63 ++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index ed6d03656885..8b59b369f126 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -984,6 +984,40 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 	return 0;
 }
 
+static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			  resource_size_t *offset, bool vmd_in_guest)
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
+	/*
+	 * Don't copy _OSC control flags from root bridge if running in a VM, as
+	 * they don't reflect the physical root bridge capabilities.
+	 */
+	if (!vmd_in_guest)
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
@@ -1035,7 +1069,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	bool vmd_in_guest;
@@ -1092,10 +1125,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -1110,30 +1139,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	ret = vmd_create_bus(vmd, sd, offset, vmd_in_guest);
+	if (ret) {
+		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
 		pci_bus_release_emul_domain_nr(sd->domain);
-		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
-		return -ENODEV;
+		return ret;
 	}
 
-	/*
-	 * Don't copy _OSC control flags from root bridge if running in a VM, as
-	 * they don't reflect the physical root bridge capabilities.
-	 */
-	if (!vmd_in_guest)
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


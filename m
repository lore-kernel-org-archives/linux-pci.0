Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A117BB21
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045815; cv=none; b=JTkx9ww6jVX96XXQw53puUJLtBATdWTC+Wfdw3PHCZNnHgIQcTxRqyJELycUAU44iAQ6+1lkgrasY8vQjFwEw8ymq7QpxSRGImJPCMwuOc3ILBzyEbWAEMGomSIKh83uNWone+fD7uf5YPfha+2uYHHXulh8Ea58d79e38PGa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045815; c=relaxed/simple;
	bh=auD4bGKxFVTW+jI8oGeYyI0GbOIbZMiBKBcz/7/p0iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYI30H70mgf3VhkxYmxPsm3IBySe86tZIg+xV/pPLTHwqH4rhRYsXb+atKqiTiztEcXoH7ZRiZVQvTEc2UtmglOsfudII755Fen9IMmKQ9Gp0vorY0wsjWGgmBDrXS4kD/0zgQIU5PXT0sgxvHEnLLFGd2uuAG1cGt5SS2AfWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MemH+jid; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MemH+jid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045804; x=1817581804;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=auD4bGKxFVTW+jI8oGeYyI0GbOIbZMiBKBcz/7/p0iM=;
  b=MemH+jidZ4No3Vgl3eX00HSDQRDxZ4DM0VMadepC57lscOCgOyeG8gy+
   G9AhySddGLe3aslHIZMWenHnX4YUIDjanSryM8oEcGohb1A4K+Q/pDcpR
   bWw7yoUtALOY82vokU8xY4xIdE4hQHqbPDEw6tj6hL58VE0ryllAfVopa
   8Bit6k6maiXwx/vUbCkXUcKO5TrJAk/qbE+LCD46V/CtCdrhvNQ2eHggX
   a6UJ+gbEYhwbrO0NGjmJISozgeIbaNUj+zGM47VsjUoG4pDjznnHMioJ2
   vgGofANL7Zs1nbMlTOPo4yhsaKUYnN2Oj7l66Mkw1jWNEwgsczTDPpy7u
   A==;
X-CSE-ConnectionGUID: mHhREMaiRhCwQ6nyxoNE2g==
X-CSE-MsgGUID: vYapI9Z6SnS43FB29PDdSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622516"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:49:59 -0700
X-CSE-ConnectionGUID: CwtHftPgTxWAxbjXWkaqig==
X-CSE-MsgGUID: seUKlc8gRDq77uf0O/6bbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923371"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:49:57 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 1/8] PCI: vmd: Add vmd_bus_enumeration() helper function
Date: Thu,  6 Aug 2026 22:13:40 +0000
Message-ID: <20260806221351.38592-2-szymon.durawa@linux.intel.com>
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

Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 89 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..070b247b3fbb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -771,6 +771,54 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
+{
+	struct pci_bus *child;
+	struct pci_dev *dev;
+	int ret;
+
+	vmd_acpi_begin();
+
+	pci_scan_child_bus(bus);
+	vmd_domain_reset(vmd_from_bus(bus));
+
+	/*
+	 * When Intel VMD is enabled, the OS does not discover the Root Ports
+	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
+	 * a reset to the parent of the PCI device supplied as argument. This
+	 * is why we pass a child device, so the reset can be triggered at
+	 * the Intel bridge level and propagated to all the children in the
+	 * hierarchy.
+	 */
+	list_for_each_entry(child, &bus->children, node) {
+		if (!list_empty(&child->devices)) {
+			dev = list_first_entry(&child->devices, struct pci_dev,
+					       bus_list);
+			ret = pci_reset_bus(dev);
+			if (ret)
+				pci_warn(dev, "can't reset device: %d\n", ret);
+
+			break;
+		}
+	}
+
+	pci_assign_unassigned_bus_resources(bus);
+
+	pci_walk_bus(bus, vmd_pm_enable_quirk, &features);
+
+	/*
+	 * VMD root buses are virtual and don't return true on pci_is_pcie()
+	 * and will fail pcie_bus_configure_settings() early. It can instead be
+	 * run on each of the real root ports.
+	 */
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	pci_bus_add_devices(bus);
+
+	vmd_acpi_end();
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -780,8 +828,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	struct pci_bus *child;
-	struct pci_dev *dev;
 	int ret;
 
 	/*
@@ -923,45 +969,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 
-	vmd_acpi_begin();
-
-	pci_scan_child_bus(vmd->bus);
-	vmd_domain_reset(vmd);
+	vmd_bus_enumeration(vmd->bus, features);
 
-	/* When Intel VMD is enabled, the OS does not discover the Root Ports
-	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
-	 * a reset to the parent of the PCI device supplied as argument. This
-	 * is why we pass a child device, so the reset can be triggered at
-	 * the Intel bridge level and propagated to all the children in the
-	 * hierarchy.
-	 */
-	list_for_each_entry(child, &vmd->bus->children, node) {
-		if (!list_empty(&child->devices)) {
-			dev = list_first_entry(&child->devices,
-					       struct pci_dev, bus_list);
-			ret = pci_reset_bus(dev);
-			if (ret)
-				pci_warn(dev, "can't reset device: %d\n", ret);
-
-			break;
-		}
-	}
-
-	pci_assign_unassigned_bus_resources(vmd->bus);
-
-	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
-
-	/*
-	 * VMD root buses are virtual and don't return true on pci_is_pcie()
-	 * and will fail pcie_bus_configure_settings() early. It can instead be
-	 * run on each of the real root ports.
-	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(vmd->bus);
-
-	vmd_acpi_end();
 	return 0;
 }
 
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5F3BED06
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367676; cv=none; b=tu1ofRz+29RaYAiy2cIyt9bQrJsPDCpuA+aDqSK2cHs5Z9afDtollsz9dhQwBobUu2Pd+0KpkqmgL5MaHVCGJNyf+M9zmKE1iDRigrF6t/3hFfCzvaSXTWJl+bbimNtMeKlJR1sUGkrgHhSOWV6d0GHe4gu5M1dcRStQjD243CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367676; c=relaxed/simple;
	bh=auD4bGKxFVTW+jI8oGeYyI0GbOIbZMiBKBcz/7/p0iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwd/Wl6i1DiEZq7keEr7/GJ7sfllBqnTQvjpxQiOwrMA4UjvoLF5UA2RilbOzYiAOKLjUQqeuhifhLGAwr9xFFS1E6a5A83vGTx91jVE9tLZtrQdvo5wdJMiJc918m2nYS/jLxOPft7ShlsEM9bBEvqKlqxdsfmal0wMY9P4jbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAYKF3zm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAYKF3zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367674; x=1813903674;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=auD4bGKxFVTW+jI8oGeYyI0GbOIbZMiBKBcz/7/p0iM=;
  b=aAYKF3zmq3DL0dKdUuT5wyqg1X4h+K1SHtUKZk6TYpvgV6q0XBWD+9kM
   QlOaTUDkxP9DeMx5FRjqrBbGwd6DZxHSlbHGJ4reJpqBFwlfFxi6v4leN
   NMOQIy6lzDkwmPWG7PWK4gaYIzH82wV/cQzF3jVyKmVfc8kkM+p5KvAt/
   isjBZeKGWLrTtu9GgbsCCfxHAhUdTQ7vecuVwNWByHMVymxaS2073ELYw
   BuhuscfWuX1HaJVKxRC/jCG0o+QP7HLTu9IMX6Uu2kl4P1BQh+jXcR1FC
   zFFyKUckj6H8bkbe8kQQpY/ye13UB6YfFzi2310k55Y67/y2HSRVxZAIF
   w==;
X-CSE-ConnectionGUID: AcNYnXqsQTy7QJHmVxU0Rw==
X-CSE-MsgGUID: f65oEJhGRAmiOkwV2i+5Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021820"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:53 -0700
X-CSE-ConnectionGUID: rKHaRtz5RJyHikL3Jmo4KQ==
X-CSE-MsgGUID: tCsMKYRGStau/bOpvlkmnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725389"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:51 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 1/8] PCI: vmd: Add vmd_bus_enumeration() helper function
Date: Thu, 25 Jun 2026 08:29:30 +0000
Message-ID: <20260625082940.1290740-2-szymon.durawa@linux.intel.com>
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


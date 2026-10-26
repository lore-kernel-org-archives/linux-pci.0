Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039347;
	b=r2mFtfrjxvnIydvyeU77KKleylvTryPx6+d49GDTCI+9SBMStfLkHHShfBxKdGHNI6k6
	 GOjS9Fkkfpk3POc1CzMRgGXb6OEZ1zRj9VHzrn0rDMj8niYdFhE4y/ahlq0eLUHdg99pQ
	 59Rjl2I1vNcExRvrVi76PaqpEGdzEH8Qbxp0c89eDLv25WD6pi2XftI8pCw62RiAMl484
	 +QhqQshk2o07W/EHe8Vx6P0F/suenXc0rX8WDRqlh9TG2ahU+Vp7XEHb3kU1kC/AsLomq
	 Daa6Tn1GwynbfTvvMjtC4zA9BS+2SHTJYppYSM96Uxadfpfuit7JvwC3RXg+Cp0gDkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039347;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NI9RLlWYIDJdLe+KSbe1fNuqdLrRNfJQlntLDLstp0=;
	b=FlptPeKm49/A8CI+U8N+lR/k6ptNe/2FjgnvYufzBMng6p9hKwd8GOMZCa6r3bbCF5GD
	 IMOzOhzdoWXHCVknuWeNJv7Ilx4MGDJ7q6OJsFsn8pnk/WNW3Lx3rN8tx5CMsiaPxZPgG
	 /xVjrC/FlEId1ib59vSXyCJn3JN/2OLh2d/Isi/bBJYW0kdrgq4gD6ItVOlsLfjG639tl
	 OPNBlHR66QkBV4Gx/WFHm96g65K47lZByLeN+sktETVmqQdzwWd2ZDZ5Q5EBjnzxfpZ1v
	 0zRnpbz4jy1iq509ieGPnw1j96sNkjknshr+FKTUdY4dBdD5ZUZ76eb9n7A3mIwM6HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YhmCh4L3;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BE606A320;
	Mon, 26 Oct 2026 18:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YhmCh4L3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039348; x=1824575348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wK0dBj7SJKraA3sG/2JxBtdzXhiGQ0NAg+PD9/zCtXM=;
  b=YhmCh4L3dR2QxhTm4Scvc5Twhfgt4wD01Y+BXjmeoafEpC7DKmuPysBA
   TUSzWThBxWN8zEaoMApOMrE6Uo1gsMmqyJROL2qCrSB6d6ezlSRdW5D9Y
   n2p71rr9L20lSbxE/mPbBfue/MN8BXE/umIc8fSPi8j/5wvJm/FQXaEED
   Dhl58IB+7mmNlbE9ASuRDODN/gxuw8DLjUHIgvkEIv9sTEM1U+HzbX7bV
   YqjWcyo2c++R5hWi7XVDZvtOOXIFdpd0fEaQ5RT9MlnrlgGXCKN9yy1Ll
   sGUzyM4y1ny/gopwod6fs17HyoNS692K/x1+pqbJbFcPfcbVwGQ0pmStc
   A==;
X-CSE-ConnectionGUID: gOmvlcioToOtVVtyVY2/Ig==
X-CSE-MsgGUID: /eJRtFzaTHSaPqBLiCTtlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601001"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:07 -0700
X-CSE-ConnectionGUID: uty7sdDRQ+e4s0FMpNdDxQ==
X-CSE-MsgGUID: h1W0OpwgQiOrKy2QF3nEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720087"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:05 -0700
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
Subject: [PATCH v9 1/7] PCI: vmd: Add vmd_bus_enumeration() helper function
Date: Mon, 26 Oct 2026 20:54:54 +0000
Message-ID: <20261026205502.3502574-2-szymon.durawa@linux.intel.com>
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

Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 89 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 241023ecf677..57d5e917dc45 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -905,6 +905,54 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -915,8 +963,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	resource_size_t busn_end;
-	struct pci_bus *child;
-	struct pci_dev *dev;
 	bool vmd_in_guest;
 	int ret;
 
@@ -1047,45 +1093,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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


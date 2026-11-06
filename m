Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981770;
	b=jJG5xNVlR9NoayS97JU9TIEWbexlgpMlemeOj+QZfyt23I4s3DZRWRYCHehoNfZyqnh6
	 mLrpaRsTYg+BCmkNyUmoDiKGmwgO2sEibgSFPa6cQypzpMLG9TMpb2C9BcUSeuhNBWVKg
	 KMsj7C6nPcvkv19EuI56OdQ1Zlm6OGlcyDEFK2qqaVJ5BIrJi7rOmh7vEKKB/0aVtJOuK
	 821RUj+YERT+cuuqVe8RkJe7ZHQtBWxMrFBcp0L7b2s66vwIL2Nc9SjABRKj2cJomVAyM
	 x6SIcAXGqfJQ0Kwq68yEvukjoKgXEZhyNLGkfpIYgmYDSWUOlwG3eJul3TudQdSGQGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981770;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6SJDFW9IeQX+vqdIKCDn3KJdcy7UtxXhRhedD/6Wmug=;
	b=S9pCbWRh7XIt9JOADKUtaqpJwVH7mlydML0+BMTVN1KTgpHvK9n00MUDalEnpMPA6Tzc
	 vv2HqnTCZqIZK+Vtwrnquhh9Ii97HUXrTb9b4kERvscxy8N1lrfV2kUsJAYSpRGySMM0+
	 KmFiuP79M/qcpjB1d/rL3JGJp1R3U7iZx/hn1QQCVjZkek49xvp7DE+kpEnpvZhP1Ebxr
	 RCOMcFXMnlwxyPb0Z4FmEay/4VChCeXvMThixRRCqVIuaTqIorWPZX3S6m4iyzWHtV9ND
	 QOvwuJXPd9W38b0PRx6ytP1dC0XNpo+5995iCUp1/5sbEbzGoBTXiiQ/IPh476vXQfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IhG0CosQ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D4606A329;
	Fri,  6 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899D4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IhG0CosQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981769; x=1825517769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0mnuRhzQjyjsma7eeDskpSrtFsJ748S1jTydbrnsn4=;
  b=IhG0CosQsovT6X+cMgHE6SyxM2d9sgWPTEge+augtQcgOgOQGrXEysBH
   x/dLpgJlG4+90gOubAR1I29ZQBV53Qc/NDL13vP2tHG3wO3eDEI22dvRs
   4ACBUCoP4Phwn/Qq5DZVFOnWRh4OA0ZDzXEdxIhxOWCz+pnGHpvb4GN9U
   Fj+S3tGlw9S3RmwuUrn3A5t55SGjqBZrsDXIVDzzvwLL5CsofcDNcIp6U
   gVTsRKcK6z3DhYTxiR1Qz0ue9ocMl61p5gwcThguOrLSEYsudIp2/ZGDo
   WoUb8IyJ/igjQaFkqy5BnDRZiNIPO6rO4uviu1eLBNvX4wmGFkTmxSGsB
   A==;
X-CSE-ConnectionGUID: juvCmibCRUuQ94/C0/Lv9w==
X-CSE-MsgGUID: Tv0pHlmfSRW9usGa1q8sMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889292"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:02 -0800
X-CSE-ConnectionGUID: wqceXbVhR0W6VHIXM3E/bw==
X-CSE-MsgGUID: vquto4LSSnaIBBKZkSujoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341882"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:15:59 -0800
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
Subject: [PATCH v10 1/7] PCI: vmd: Add vmd_bus_enumeration() helper function
Date: Fri,  6 Nov 2026 18:42:49 +0000
Message-ID: <20261106184256.4130-2-szymon.durawa@linux.intel.com>
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

Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 89 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d97a832785e..e4ac04936320 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -954,6 +954,54 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -964,8 +1012,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	resource_size_t busn_end;
-	struct pci_bus *child;
-	struct pci_dev *dev;
 	bool vmd_in_guest;
 	int ret;
 
@@ -1096,45 +1142,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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


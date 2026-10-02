Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E1411689;
	Fri,  2 Oct 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975929; cv=none; b=Q9r+a7nDNau+rzw3DUniTUVsX4jWfA8DBVbWAXf/I83iBFiAYHZSseM4t5d3n9wo9wxPmC6r67Lp9fg6gMoBwn+CbR9B3WZn3KKjcO2W/OuPFTOttBRMTolUc7MwrHh3BYlNOrJsbBM4zgrWlAu55NZVghyAAD2+yiLekHhC640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975929; c=relaxed/simple;
	bh=Zgel6F26O8rDJV9aWvjns+2W5OYGtWYaFv+PJL6gySQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2uZ3Vjkl9ftCU72kRUxx9obGwHFAsV/8wRlc127qkt2hy0wLHD4VConhIqJELJ8rK5MdU1mUXh+XmLxeHLGHl713+3Fn6dmFaBwWTF386vwnT560QX22rwCCvH9tB2kKPndFUdv7hbW0R5/sywEYfcx7RtwkT5SLF3w/6+dqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fjr6ap1r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fjr6ap1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790975928; x=1822511928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zgel6F26O8rDJV9aWvjns+2W5OYGtWYaFv+PJL6gySQ=;
  b=Fjr6ap1rAeQNQuAsGfljOGivV3LXGruAxY7XcmB5g3frbLAFzTO78AI/
   TXZWqku+2pJRKE+XelD0ecgnCJnuLzc0n7ZeNNtcHccAmlyre3BC3ErgE
   ARVnWntRCzHvHyvs5Ei5lzzfUVCc/u+RyTFm/AjOsjGIyqW/CF228VlGU
   U0y+HM8U041POSyazbNv/Oz1bt6tO+amTc1JZuJRoZ70QxDq3Y4TbW8lh
   l42Bg7EnUaoYVfH7ucX8Fz9Ll4IXzQdQGg3U9orcyFFXK6Yq7EFUymhu1
   lFa6UaW7iyhmvmngkKjrCWd+QIYfjWaK2gvIFLC0Ak46ec8MhYhK92rru
   w==;
X-CSE-ConnectionGUID: oPMqdbS7QnSgInyizX214A==
X-CSE-MsgGUID: VhoNX1uQQMGDi6YwJ/sptA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101077491"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101077491"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:44 -0700
X-CSE-ConnectionGUID: MMjAyLEpQN26zNVgNK+5cg==
X-CSE-MsgGUID: 5Vo8Ukp6Rv6ipxQKwGtq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274987382"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:44 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	lukas@wunner.de,
	terry.bowman@amd.com,
	kanie@linux.alibaba.com,
	olof@lixom.net
Subject: [PATCH v15 2/4] PCI/ACPI: Tidy _OSC control bit checking
Date: Fri,  2 Oct 2026 14:18:26 -0700
Message-ID: <20261002211828.1293177-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add OSC_OWNER() helper to prettify checking the _OSC control bits to learn
whether the platform has granted us control of PCI features.  No functional
change intended.

[bhelgaas: split to separate patch, commit log]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
Changes since v14

 * No change.

v14 posting
https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com

Changes since v13

 * No change.  Picked up Rafael's Acked-by.

v13 posting
https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com

 drivers/acpi/pci_root.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 88c65f34e305..756dc2f055f5 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -993,6 +993,12 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 	__acpi_pci_root_release_info(bridge->release_data);
 }
 
+#define OSC_OWNER(ctrl, bit, flag)		\
+	do {					\
+		if (!((ctrl) & (bit)))		\
+			flag = 0;		\
+	} while (0)
+
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -1003,6 +1009,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int node = acpi_get_node(device->handle);
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
+	u32 ctrl, ext_ctrl;
 
 	info->root = root;
 	info->bridge = device;
@@ -1028,21 +1035,21 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
-		host_bridge->native_shpc_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
-		host_bridge->native_dpc = 0;
-
-	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
-		host_bridge->native_cxl_error = 0;
+
+	ctrl = root->osc_control_set;
+	ext_ctrl = root->osc_ext_control_set;
+
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
+		  host_bridge->native_pcie_hotplug);
+	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
+		  host_bridge->native_shpc_hotplug);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
+
+	OSC_OWNER(ext_ctrl, OSC_CXL_ERROR_REPORTING_CONTROL,
+		  host_bridge->native_cxl_error);
 
 	acpi_dev_power_up_children_with_adr(device);
 
-- 
2.43.0


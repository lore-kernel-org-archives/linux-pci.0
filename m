Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2D3CFF61;
	Tue, 22 Sep 2026 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109997; cv=none; b=WfLIIpFAJFv9g7K4YnwGT2eQW51QxuzWhZFxYcYY6e/gjMRej/iUlpztRKWZLrH9at66BFB37kC0TjYwckcG95o81zm3YEJBqVq3F2srYRr77zx6sEmiHdCZKdYaaOR/zr/pjCCO9GqC7XByL+HNC/OhSf9xM6MPEGLJXdO2Aq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109997; c=relaxed/simple;
	bh=iIVS5CBhZ1HRSGJtKi/LGzHmblaidcpDzv2j3C/tEVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIoq51koUZb4IWcUWV0Qfk/KYY9Ft+oN+q3JYUIubsl6WhbGtXlN9zR9CW7aI3Lo2K7sUXbdI14ldD3VlRQvtH5Swqpxf99HLcXL4UF/6gvz0Yv9ZyyEkQcKn9ZUPLPS4WPbHvzn+l1tz7O8eJuzW7shWQKFJ3YjEFzwsAKwKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBLtBLwB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBLtBLwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790109991; x=1821645991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iIVS5CBhZ1HRSGJtKi/LGzHmblaidcpDzv2j3C/tEVs=;
  b=HBLtBLwB+/t1CpFPJBznvIewM5Rfu78h2N9QOdPAfVzqigLqZO5RSyuo
   CIJsRVmVx/cmduGkfqe/5uFE3oosmko9MQQ79UN4avhEewZJ5uJqH/EEt
   1AolifMqKcHITxCfFHS2t03i3J0n+bFONOYWNV9uZct0k8Jtm2UxYHRVs
   ZNuCWN0fJRTStI+vbXIWRnzU53rP/KLbqlr8nj1n4bS+7PkLgr3iprngX
   tldaxQh53G5DxjNUZUDCHgzDTqKK+XeHUW335JSfGZo0YVwx46hYd9Dkc
   bs5Ld0mJOOhcm41Y8IX72oEimmreQuDWt2Ev3oFEMh9qTlqdjodMXUMMH
   Q==;
X-CSE-ConnectionGUID: Evsf+WBmTBm/iLeDD2+CEw==
X-CSE-MsgGUID: uoSA/FErSw6foQxxGD2zpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90621943"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90621943"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:52 -0700
X-CSE-ConnectionGUID: a48FMc76SseMBcEX7WyC1g==
X-CSE-MsgGUID: PV2IEJXUQTOnY/UsEnLMng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272493146"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:51 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	lukas@wunner.de,
	terry.bowman@amd.com,
	kanie@linux.alibaba.com,
	olof@lixom.net,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v14 2/4] PCI/ACPI: Tidy _OSC control bit checking
Date: Tue, 22 Sep 2026 13:45:46 -0700
Message-ID: <20260922204548.3884906-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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


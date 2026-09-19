Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C1382394;
	Sat, 19 Sep 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835227; cv=none; b=kNAce14Qj0+WO6+33bVJg0zVf8a5OE+z+vf1sbQBlVbj7QyEmW6WH/Bs9+PY/CJob+eaiqCCu23ln5etK8Bw1/X/w4BUHMVDO8nv/9xBqFSyp1t3P5EvR/5aJHxTWcdqcFj+Xu4rL8lbQpYfmAiaFimuUgjpukqhfVvDi598bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835227; c=relaxed/simple;
	bh=Twrfbx7XknL5uR8rjzSc78GsWqmuoofdHKSwhzF9hb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI69t8VPzRy7uFeQjeo23rFxz2+Am2VaCqPn3P5URKQLSZL2xvZaOSOD3hrBjzg0ocYz1+aBBLaZwk10TGEOhKar1yi/ORnnhuBILkJQTlZayTg2Mun336mSoBIfsSremdeEd87NEB5WBntd4Va+R5JrV28pRjFwVZCERL+pyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6KccOnO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6KccOnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789835225; x=1821371225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Twrfbx7XknL5uR8rjzSc78GsWqmuoofdHKSwhzF9hb0=;
  b=J6KccOnORczJbdJHrixB0k2/qRQmDpdBfhgfWdR2dtLroI+n+hKoA6ug
   jtPVhgWTmfvoWGcOoQ6MNm/YgZP9QSDKDfmAjJY1rFHLTs2fc8aatMe3b
   efNcs7PuJcx2QMPP8gQPm5APQhbHmv0dUGikf1TXC7nW5ukTyAQab/Jcz
   ZtGkMF06RZt9zSxMzQeenyjIimKF09OlvQWQDo2mx6F3mr80GvaH2ms+w
   iXirhA9inOqNYFz1YiTeN44CkA0me6zC/6+doTbCGndLvs4bg5JJz2rPd
   VPwYiJtkUkdi0AnYp35DCnEIVeed/wp2sOjKHTH27NQvhqX+xT0d+BCi6
   g==;
X-CSE-ConnectionGUID: lOZ43QNGRauRh0t7Z9I6HA==
X-CSE-MsgGUID: Cf7xswgrRGOBj23yUP+K3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94187238"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94187238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
X-CSE-ConnectionGUID: Entq9IhkTFCXjrYkW+nNCw==
X-CSE-MsgGUID: cn9qJY3cQeqnLfy6CshmRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272186120"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:03 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH v13 3/5] PCI/ACPI: Tidy _OSC control bit checking
Date: Sat, 19 Sep 2026 09:26:53 -0700
Message-ID: <20260919162655.3499010-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
Changes since v12

 * Rebased to v7.3-rc3.  Parenthesized the OSC_OWNER() arguments, as
   checkpatch --strict asks.
 * Also convert native_cxl_error, which v12 left open coded.  Its bit comes
   from the extended control word, so that word gets its own ext_ctrl
   local.

v12 posting
https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/

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


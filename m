Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D14334A5;
	Tue, 22 Sep 2026 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109993; cv=none; b=M3Y22Is5cC1qcDys/4HH8AcgMj/qP3SD1pf1zQdTvQHrEG/XqapPd7hpvVvVrFGhJfXGDPc58mNug33/ssxgaOL070rm8Wi9hnmZu7qZIRpd4wIe4uzXuUmYusMLv2VaF4TSZejUckSBYq+WFuZrQOeYh+h0zwvoGDgFyCon/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109993; c=relaxed/simple;
	bh=kryAAzTAeZCZMWTsC4otulpVZ8szVC1RX2hypxRdDN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkAIaFOpg88hpRSCdfvf1W5GKFu93UbaR+Oc1+DtGA7OqI+0zp7rnWDZXQTapgE4/F7fMFvsFK6eZMszjGHmmXbudrrO9CT6r1sGMDPoeectvnAF+rd//YGKlGENMJtUOzMgwdG1QTExe2dvOn2g/YuudbLzDlxluV6H+IknVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9koUWlb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9koUWlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790109988; x=1821645988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kryAAzTAeZCZMWTsC4otulpVZ8szVC1RX2hypxRdDN4=;
  b=g9koUWlbbjYhrA2ZUIX02qd5R6M9Tdqi45yCyNXQ3K6kjvGu2Ne9VwkI
   y1rsfBzrDqRYpr9hI+R1VsEjcAHC6joRSGzqYAi+I7eNKeMtxNoOHVT3N
   vGu5tG6IsMS3TLj5ev+v6XwpfMutt+AcGIBs1Gt9WMRLQ6a/aNTgxqjIu
   O2HosFTdUER59I8Lb+vQYDQ5dq3YO63n6KLHnwn/FM+L958bqsfERFeDn
   SfQ2BBWCz6ba5hmorqrpn1nyW2L7e08IY2t5HAxDlfAB4k6h8wEfpCORG
   F1D73Bo8CI+iyK9JSRbmSJ/psz1foF8L/gZuBBxEjkV99c58C4HxqMkpG
   w==;
X-CSE-ConnectionGUID: yafLHq36Ts2W0eorwFKvIA==
X-CSE-MsgGUID: M9mYmickTfWAbJV85+TPwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90621936"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90621936"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:52 -0700
X-CSE-ConnectionGUID: 0uJUlXfgS9WME37A1KC8YQ==
X-CSE-MsgGUID: s7LUF9a8TamXdFzoU6+uTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272493142"
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
Subject: [PATCH v14 1/4] PCI: Assume control of portdrv-related features only when portdrv enabled
Date: Tue, 22 Sep 2026 13:45:45 -0700
Message-ID: <20260922204548.3884906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
so default to native handling of them only when CONFIG_PCIEPORTBUS is
enabled.

Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
defaulting those to native regardless.

[bhelgaas: commit log]
Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Changes since v13

 * Use a local IS_ENABLED(CONFIG_PCIEPORTBUS) variable instead of
   #ifdef (Lukas Wunner)

v13 posting
https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com

 drivers/pci/probe.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..1e487a213eb0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -658,6 +658,8 @@ static const struct device_type pci_host_bridge_type = {
 
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
+	bool port_services = IS_ENABLED(CONFIG_PCIEPORTBUS);
+
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
 	INIT_LIST_HEAD(&bridge->ports);
@@ -668,12 +670,12 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
-	bridge->native_aer = 1;
-	bridge->native_pcie_hotplug = 1;
+	bridge->native_aer = port_services;
+	bridge->native_pcie_hotplug = port_services;
 	bridge->native_shpc_hotplug = 1;
-	bridge->native_pme = 1;
+	bridge->native_pme = port_services;
 	bridge->native_ltr = 1;
-	bridge->native_dpc = 1;
+	bridge->native_dpc = port_services;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
 	bridge->dev.type = &pci_host_bridge_type;
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE742123B;
	Tue, 22 Sep 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110010; cv=none; b=bPi2j03RAcqEtIbldCb8ozR6PzCvrRypzPWiZjpjoci+TCrOUXVc94LFLjnsFykgA1A3LzoJ/oJ7uLMtE90yGIOduH4nPFPz3CwxZXWipl13t8IjrUvlTW6UvrVjSFUNM3HBxcvBTW7H45Twwl4TKumhXha0E3QBVumKAJTGf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110010; c=relaxed/simple;
	bh=E5+YzZdrYmTMbKAzQIriZso5wCj704vMnY83i1W8O68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xggcip6ZfkPvhQi6Aa3Tzsw0ux1kx62UrUXrEQ/pN0bkg8fjcsfq1qD0OoOzXZ6iDoOJUOCN0aXvheTFZTIC+liZLYJJYboeSymRqKGrHBBCLi8DaemVAeY3gTUh7ccc2wWGjlsS2/ErQwAsh9x23/Y5yuMBd1VUv84wg2w8DAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDJXM8nz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDJXM8nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790109997; x=1821645997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5+YzZdrYmTMbKAzQIriZso5wCj704vMnY83i1W8O68=;
  b=gDJXM8nzGPKu8OIGngi5R1eGV3nL+bWzwXUG2LqFDYPnW+4vz2nfmdZg
   fdTnCGwsM4ma/mnMvtPOXyiXPe809nXNPEQv4wXtQIgDbcfd0q8IGLWJI
   2whU1jACs4iPn+lvj963pXR21vT8AbpB5rN8AwUgh6YwCNDORcPP4ND4R
   QZ+W3melndmY2goUSzdgFJqtp7kTi8Ochd/sAjDS/6n3ZKN2uK3YRn6py
   LK+nWDSJppVDcdSihoahSV/KkpS35AlI6SDqhMKFtb0vL4b7TUI8qMCdy
   fll69ZBuZT04oTbkXeahN+AH9skgNYoYJcPH/xkYa8OGUJmrs/nWyqsUM
   A==;
X-CSE-ConnectionGUID: M+8V3VW7TKqhkvvYDd9TJg==
X-CSE-MsgGUID: ssH29zw6Qruw3ZMVucOYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90621964"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90621964"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:52 -0700
X-CSE-ConnectionGUID: lBMJkxepTdeHwJnaA/nE4w==
X-CSE-MsgGUID: nH8u/6D/TZGP623pV87W7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272493150"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:52 -0700
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
Subject: [PATCH v14 4/4] PCI: Centralize pci_aer_available() checking
Date: Tue, 22 Sep 2026 13:45:48 -0700
Message-ID: <20260922204548.3884906-5-sathyanarayanan.kuppuswamy@linux.intel.com>
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

From: Bjorn Helgaas <bhelgaas@google.com>

"pci=noaer" tells us not to use AER.  pci_aer_available() reports that,
and it also reports the other cases where the OS cannot use AER at all,
namely CONFIG_PCIEAER=n and MSI being unavailable.

Set host_bridge->native_aer from pci_aer_available() when we initialize
the host bridge, so callers only have to look at native_aer and we do not
have to test pci_aer_available() separately in each of them.

Do this in pci_init_host_bridge() rather than in acpi_pci_root_create()
so it also covers host bridges that are not described by ACPI and never
reach acpi_pci_root_create().

This subsumes the CONFIG_PCIEPORTBUS check for native_aer, since
pci_aer_available() is false when CONFIG_PCIEAER=n and PCIEAER depends on
PCIEPORTBUS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v13

 * No change.

v13 posting
https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com

 drivers/pci/pcie/portdrv.c | 3 +--
 drivers/pci/probe.c        | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 32fc623dd410..9f8c6dd434c5 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -239,8 +239,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 #ifdef CONFIG_PCIEAER
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
-	    dev->aer_cap && pci_aer_available() &&
-	    host->native_aer)
+	    dev->aer_cap && host->native_aer)
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1e487a213eb0..e1ca8096bcd5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -670,7 +670,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
-	bridge->native_aer = port_services;
+	bridge->native_aer = pci_aer_available();
 	bridge->native_pcie_hotplug = port_services;
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = port_services;
-- 
2.43.0


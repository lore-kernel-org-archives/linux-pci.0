Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C47311C32;
	Fri,  2 Oct 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975933; cv=none; b=gwdcRUgKY1O3dqwYwq2t4n1tnYhytyAYZbtj6wjXFI/9u1+pxIRoPF4+Yqz5mxsNjmoePJDRACUeZnF1I/v6KFt8lwzFAl8AFk3cedGO4LEORq8l0f0zEoxJx6KOrh5N3BJeBoJk3qyGiuOF2yPVQwl+XObA9dnvcpzjyqDLlgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975933; c=relaxed/simple;
	bh=O6D0RU4OEuhqnVHA4P2Q+B91nPZTEqSHMJcCa7l7ElY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owjpdDglU0mk36qXK+/TB80HdpKzilqfTwaRr6p3XH0+PDMTqWqNPbTiPCq+EO+0rINtvA7OPhFjhCoF7sPUjB1r2R/JktPa4uS+MiTIA4YNOTsKulsyRxcZXm3/LEMQDx6ktsbabHLnWx0Z0rLQV+ZDSFNBN/obACazCjM+cCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AicpgAVH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AicpgAVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790975930; x=1822511930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O6D0RU4OEuhqnVHA4P2Q+B91nPZTEqSHMJcCa7l7ElY=;
  b=AicpgAVHsdZ5C/NFkxzXeiW3UjiwSkHSxKpbkVaBXh0X94jYNrz5j3Mx
   mUge+TAfKryE/o+6EqRhnaKjyC3XjPGKyuq9sh2APv7AocVlzxKpW3ONi
   0YWJRyJ7kk8FDJqSz+Qn/IjbRMbaywfODx6yX8SiyawbuqkqEo6eXWDfV
   3U4Aky4khsPZcHABwf81WK8KArsKgY1dJ4XG/+ElYcTCcDrAMlnSl/8wN
   FcR79yMExeYcuGgvmxKc0qilzzmXSDOuTghWR7wCNT++e1iAIVvaZsddU
   TOb4Et9NlkXSA8RRO5cm/IZCqzhPJxNAkUw/RMSUpEwmmmZjS4fgIfa7e
   A==;
X-CSE-ConnectionGUID: 3cxbC+muR7OQNupjF2epVg==
X-CSE-MsgGUID: ezysHUrnQw2P4zLfcPSlVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101077505"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101077505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:45 -0700
X-CSE-ConnectionGUID: VLh0I9NkRHKcdB6iSdKq2A==
X-CSE-MsgGUID: Lt2V8q4URUWiCeISYrxVMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274987384"
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
Subject: [PATCH v15 4/4] PCI: Centralize pci_aer_available() checking
Date: Fri,  2 Oct 2026 14:18:28 -0700
Message-ID: <20261002211828.1293177-5-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Changes since v14

 * No change.

v14 posting
https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com

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


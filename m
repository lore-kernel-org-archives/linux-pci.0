Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE13890F0;
	Sat, 19 Sep 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835238; cv=none; b=qzV3KJs8EYNqtv1sWMWxTRgu4cRlpNBbA7c3gCnIKpwnU8FLjffrcVNIl0THvyyUt5O1JCp0dDGHJlHPWMsFZQe+eFxYjQNaCgA8S4s0NxGD8cTKmgsqSc2fhV5mtgTltM913td2/usUgr3ZbiubfGLoY8nQkseAXTzUs1DTIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835238; c=relaxed/simple;
	bh=hMEIkU0IZiY8MhFIZ3Isk3Eao21uFP9lZDWi9G1NZH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTu8fTpaU5RGOmatszJLAZBmyN0ZRj8g+esJ1A3IKNL7DWWe+onb2u3Fxxg5TFyBf+cky9Rlhoa7+V20LE0cUok0hcfjuLtedVXnRJPVH+IyNMtNhcM3pQP1TmCAvlNnAML11TU0IjsduW+tD97thzw9FBUubiQZ1+fsj1Qsius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpEn7e+t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpEn7e+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789835227; x=1821371227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMEIkU0IZiY8MhFIZ3Isk3Eao21uFP9lZDWi9G1NZH4=;
  b=lpEn7e+taYnXUjv7/9eYZnremZxhOK1rgLpnG+NDmtQlI+KGKwC6xWsW
   n4aMv6HNblhBnpm7I5VSZ3HFY0UOXJF5/pY7CG0RpjHeh+Gr+yylRFRcO
   nAG7W9937cpDR9WtpSOgy/NzzSc6sobW3IgVSX5GrlPVg0YMk0X1JWE8n
   4MjdS32N1d9AoHx8PUqT2HBBcwQR5JVNPCyS3P7NNy0FXkRCA/yObHQLR
   WXJfZR7lycah2fRT7zUIXOZWEQk3+zAhvE3r0ukScg4triPz6YAAgV7sh
   eu4SeprDVeslROsWrGMD/ZExSipLO/aCwev1vknC1J9/OqIvLQPkb3BV8
   Q==;
X-CSE-ConnectionGUID: qBi3S0ktT9WZIlcUpEQ0jw==
X-CSE-MsgGUID: O8wBMZpsSMex+E61IAEldg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94187248"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94187248"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:03 -0700
X-CSE-ConnectionGUID: omDgAUvATJ6xj50wW72h5g==
X-CSE-MsgGUID: 8Xg3kZzSSyap4gE7ZQ217w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272186122"
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
Subject: [PATCH v13 5/5] PCI: Centralize pci_aer_available() checking
Date: Sat, 19 Sep 2026 09:26:55 -0700
Message-ID: <20260919162655.3499010-6-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v12

 * Rebased to v7.3-rc3.
 * Set native_aer from pci_aer_available() in pci_init_host_bridge()
   rather than clearing it in acpi_pci_root_create(), so "pci=noaer" also
   works on host bridges that ACPI does not describe.
 * pci_aer_available() stays in the DPC arm of
   get_port_device_capability(), where pcie_ports_dpc_native still needs
   it.

v12 posting
https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/

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
index 5f7eb6bc438b..0429f5671c63 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -669,7 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * OS from interfering.
 	 */
 #ifdef CONFIG_PCIEPORTBUS
-	bridge->native_aer = 1;
+	bridge->native_aer = pci_aer_available();
 	bridge->native_pcie_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_dpc = 1;
-- 
2.43.0


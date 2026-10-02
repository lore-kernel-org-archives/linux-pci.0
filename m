Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8EA3D3CF4;
	Fri,  2 Oct 2026 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975926; cv=none; b=Gr2YMRDFwC+5tQYxkCFs2AgVpwvXkYQHh6uLCw6ckfzdsxgYCrjGqYTALTA/RhQdo9bSwbMgS1SaOcOKo4yoyZyAyIMDVfaGqOKtnWtOyFAMYIWvE/gTgH5XelxlT7u4IDNO8kSQhCurbhjeMjsTzNEBguptTKtqv2phH9fXHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975926; c=relaxed/simple;
	bh=71ldRLoJxjL7OqgffoArTrgFUxA2+EIxJ+3Jv9AIx58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYFe1+pGPjHGiwd38BgtV0WXjdFTjExudkMdGMZX/oo1a+K0SijkjwKqFe+vOZFqMugfq4K/sVqIsjSowxr6h5E0+YlTldK80MSwoTns+ZBgpJ+LdN+EkVbMYUkPIdl6pIHxO5bggOIaL9hN3gWFi5zyVPFwuK9s7b22huRPAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx6Xlpzd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx6Xlpzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790975925; x=1822511925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=71ldRLoJxjL7OqgffoArTrgFUxA2+EIxJ+3Jv9AIx58=;
  b=Sx6XlpzdAg3d173vmln7Bsu3DWGzdy8SPX408vhtQOos4RGb/SFx7y+F
   HL9KtjwJDn3Qzpa5U5KgY72LW4I1WYLsvajqreRxVPHkdNJgCdu+zK5AF
   k+IpDGN3eB3qOE5A49JVUMheF+QqavVcV0SGn98ZrSQnTf1S7Gl8qVHz6
   WDjQqf3p64Ygl4GHtnFnqkBVxcXBYErsLgHrzvwlo4hIxqznajKkNPCDJ
   6noUhAR7bLCD6bbOKK3oBXUEbNjMoXwEeupAdE2ihqLnlgKI0AD+wDhHs
   bllxqy9KyrC4Cz278B4sf5NeEEMty2kOYgnLJWSwQog1nzCyDjo6gFxpv
   g==;
X-CSE-ConnectionGUID: vcyTuDKhS2qlMAZWvhukjw==
X-CSE-MsgGUID: UiU2qbW2ThC66C5/BLKjFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101077477"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101077477"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:44 -0700
X-CSE-ConnectionGUID: xPIxSpAJQgyjfd8rVXEksQ==
X-CSE-MsgGUID: SF/iMmAlTDymqkiVli3HnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274987380"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:43 -0700
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
Subject: [PATCH v15 0/4] Simplify PCIe native ownership
Date: Fri,  2 Oct 2026 14:18:24 -0700
Message-ID: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revives Bjorn's v12 from November 2020, rebased onto v7.3-rc3.

  https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/

The goal is unchanged.  Decide who owns each PCIe port service in one
place, when we interpret the _OSC results in acpi_pci_root_create(), so
that everywhere else only has to look at host_bridge->native_X.  For AER
specifically, host_bridge->native_aer becomes the single answer to the
question "may Linux touch the AER Capability?".  Today callers each have
to remember to also test pcie_ports_native and pci_aer_available().

I posted v11.  Bjorn took it over at v12, split the _OSC changes in two
and deferred the "pcie_ports=dpc-native" work.  The v12 review comments
were agreed but never respun, and the series stalled.  v13 was that
respin.

  https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com [v11]

Bjorn suggested reviving it in response to Guixin Liu's report that
"pcie_ports=native" no longer enables DPC.  The DPC service binds on
host_bridge->native_aer, and that flag did not reflect the command line,
so DPC stayed off when firmware retained AER control.  Patch 3 fixes it
by making the flag reflect it.

  https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@linux.alibaba.com/

Patch 3 has a side effect worth calling out.  drivers/cxl/core/ras.c did
not exist in 2020 and tests host_bridge->native_aer with no
pcie_ports_native fallback, so it has been quietly ignoring
"pcie_ports=native".  Centralizing the check fixes that.

Binding the DPC service on host_bridge->native_dpc, rather than on
native_aer, is left for a separate patch on top of Lukas's series that
removes the DPC/AER dependency, as agreed with Bjorn.  That change
alters behavior, so it does not belong in this cleanup.

  https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
  https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas

Changes since v14:
  * Patch 3: fold "pcie_ports=dpc-native" into the _OSC control mask as
    well, so host_bridge->native_dpc and the "OS native features" line
    reflect it (Bjorn).
  * Picked up Guixin's Reviewed-by on patch 3.

v14 posting
https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com

Changes since v13:
  * Lukas suggested dropping AER cap check fix (patch 1 of v13). He has
    a series underway to fix it cleanly (removing DPC/AER dependency).
    So dropped the patch as suggested.
    https://lore.kernel.org/r/aq95LGUHL-pnmTlr@wunner.de
  * Addressed use of IS_ENABLED(CONFIG_PCIEPORTBUS) instead of #ifdef
    (Lukas).
  * Added Fixes tag in patch 3 (Guixin Liu).
  * Added Acks from Rafael.

v13 posting
https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com

Bjorn Helgaas (1):
  PCI: Centralize pci_aer_available() checking

Kuppuswamy Sathyanarayanan (3):
  PCI: Assume control of portdrv-related features only when portdrv
    enabled
  PCI/ACPI: Tidy _OSC control bit checking
  PCI/ACPI: Centralize pcie_ports_native checking

 drivers/acpi/pci_root.c           | 78 +++++++++++++++++++++++++------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  6 +--
 drivers/pci/pcie/aer_cxl_rch.c    |  2 +-
 drivers/pci/pcie/err.c            |  2 +-
 drivers/pci/pcie/portdrv.c        |  7 ++-
 drivers/pci/pcie/portdrv.h        |  2 -
 drivers/pci/probe.c               | 10 ++--
 include/linux/pci.h               |  2 +
 10 files changed, 80 insertions(+), 34 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.43.0


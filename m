Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCB51CF40;
	Tue, 22 Sep 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109985; cv=none; b=i/K9qdMOteffPUB38TciZ0R/5SGRPpVadhO7fSPmmzlRokIKGpwjSVUwZLMpy2uFMszajBvPr5hS71alJLMiuSZmguZjpKWKLePM7zLzUlJQsbqY3KiCaEk/Opswi2bhsx/+JwVLPeCg9ZNYRvmWkOn6/Fh7DiDx7MrgkKa0bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109985; c=relaxed/simple;
	bh=ahJ5jMB62hvYPKiEtUcqnZq2PC1IZZMCL5/H7hIsgSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmSWoCM38Ls54YAlLjFPYQnpRGW/+LELjXKdMOrd/LDoytKIqvPYxQGudwwZ8dDt2teOH30LpwUVOpn/RDXTpeaBNMpO8nDp37Iu/63KQvwlaPG/X4SU9+V4g3tRBaHLa9aydmzpfTcGPXL+2ShCEgX6Gx0qUvJEpKS8s7NIZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOtSz+L+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOtSz+L+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790109956; x=1821645956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ahJ5jMB62hvYPKiEtUcqnZq2PC1IZZMCL5/H7hIsgSM=;
  b=mOtSz+L+ROU7QLsb3IYbQjWHATGIDvDswaURWjBv0aR1J3Thp6oAN/KZ
   fHag4VcaoSX8lB3D4uD/8gtm3YKVRlu4J3TgSq18NOXnjPe/5QcRAn2Rr
   f/I7DqXbxvtqbCbcqkjt6L9rCuk+xYf8XBJFLWeU5zGLpdzdHEK9th+jU
   mHjzEhSfNPf/qJRxqou00xm2s7rYGuRw7dGRIqjKt1IKGhh8PFp59OIzd
   bZ37BXgHvSwzbGklRuyeRz7+QiySnzHdGHYhtYX3PpRY27m2Fn+BKujiC
   DQEkmie0RGhq/HvGsM9CMxRK4v8DQcvoS1R2TJToNFp36hKpVJQH+zj3V
   w==;
X-CSE-ConnectionGUID: G6bdaC9fTeOrPN2w+1LG4Q==
X-CSE-MsgGUID: DhchZSJIQvq6tVrmqhAK5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90621928"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90621928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:45:52 -0700
X-CSE-ConnectionGUID: NSkGA7SUQUakGgvsCp6Mmw==
X-CSE-MsgGUID: pL/B+VoUSVGrpaFC4h0/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272493136"
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
Subject: [PATCH v14 0/4] Simplify PCIe native ownership
Date: Tue, 22 Sep 2026 13:45:44 -0700
Message-ID: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Two things are left for later, to keep this series a cleanup.

 * pci_aer_available() stays in the DPC arm of
   get_port_device_capability(), because "pcie_ports=dpc-native" still
   needs it there.
 * We still gate the DPC service on native_aer and ignore
   OSC_PCI_EXPRESS_DPC_CONTROL, as Bjorn noted in the v12 cover letter.
   Fixing it changes behavior, so it wants its own patch.

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

 drivers/acpi/pci_root.c           | 73 ++++++++++++++++++++++++-------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  6 +--
 drivers/pci/pcie/aer_cxl_rch.c    |  2 +-
 drivers/pci/pcie/err.c            |  2 +-
 drivers/pci/pcie/portdrv.c        |  7 ++-
 drivers/pci/probe.c               | 10 +++--
 8 files changed, 73 insertions(+), 32 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.43.0


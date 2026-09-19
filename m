Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6C1ACEDE;
	Sat, 19 Sep 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835225; cv=none; b=KSBthpi2C1PMGVUKkYOdTbtc5C3AnJhPoVOwlflTMwMECvu/uRD09O1KYa6eaUKUY7qCiV5fX2Bai/RmeDAWj0tNtztObTzOknnQociESdBjz7yfsE7JgOQB/GrVBjuQGUPohvNUJkHzkErbL7CO30drrVuT54AslIpfwl+q8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835225; c=relaxed/simple;
	bh=gMG/ycsZEmlaAH6XbU1mHxZDiRkqecqn/AJn+2IQXbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7PYJMrh/012EXPz1Epu1bhH+18MyJ8DGT8oG6tAUkIOiVt0Sa/yI2KmCesdH4AYcVREYwInH5iU84bzGoLziMu9w+IcEZ8Qy5Ezcmx6EhpdsfKxcMNzNL3lwqA9SHeaF+8D3X+Q10eNscIDdZMu7ONWR+5G4becBUw5BGSPrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqPignpK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqPignpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789835223; x=1821371223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMG/ycsZEmlaAH6XbU1mHxZDiRkqecqn/AJn+2IQXbI=;
  b=XqPignpKzkh5rDYX2w/GpEZfpxLBioyBnCkf6dhomboshZK3NCj3u5w0
   rbDY9qIjgCiJoeLaGAOUINfyMrNbF8eER3x6zGsOgfnILWQ2FBHDsOYyZ
   QnbBkNRaMMe5+tYj4qdSQIl77xy6RRqm88yPpPKTk58La8evOUoAed4ad
   wkpClgh8JwdnNt33zhH2wuO1rYtDb88+VZwUBnZHPX0QMvUJq2El5i+Lj
   JEICBp8fM74e3/xYL57YOX/qS3M8OZwPAsUwENfjx3XmK80/M02u9EDBr
   ef8S9aR0kSB6YUENRxGmLZEp3ydVCWSBS11S/D+dmfkcWdwNb8MaQAwB5
   g==;
X-CSE-ConnectionGUID: MZ9cIuRBQb+PEVkKTJRMDg==
X-CSE-MsgGUID: PHBhK8wwRK+8tXtKpaBEww==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94187222"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94187222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
X-CSE-ConnectionGUID: HwIPKBcIQK+joo342LZEiw==
X-CSE-MsgGUID: fuS4YiYGT3y5IpPli07tYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272186113"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH v13 0/5] Simplify PCIe native ownership
Date: Sat, 19 Sep 2026 09:26:50 -0700
Message-ID: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
were agreed but never respun, and the series stalled.  v13 is that
respin.  Each patch carries its own changelog.

  https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com

Bjorn suggested reviving it in response to Guixin Liu's report that
"pcie_ports=native" no longer enables DPC.  The DPC service binds on
host_bridge->native_aer, and that flag did not reflect the command line,
so DPC stayed off when firmware retained AER control.  Patch 4 fixes it
by making the flag reflect it.

  https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@linux.alibaba.com/

Patch 4 has a side effect worth calling out.  drivers/cxl/core/ras.c did
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

Bjorn Helgaas (2):
  PCI/DPC: Ignore devices with no AER Capability
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
 drivers/pci/pcie/dpc.c            |  3 ++
 drivers/pci/pcie/err.c            |  2 +-
 drivers/pci/pcie/portdrv.c        |  7 ++-
 drivers/pci/probe.c               |  8 ++--
 9 files changed, 75 insertions(+), 31 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.43.0


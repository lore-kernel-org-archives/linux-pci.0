Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E44973B3;
	Wed,  7 Oct 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392332; cv=none; b=j4te4DgbTdquSHr2xMcR/S8RVVk5PIvbGSEzPJIojLVCFhX5rr5OQcDwVEEjyO6a4ONcpI3jw/gtl8eF8uNS9tPJAoTTHYaDlekipx92YSkBObc2eMJFxdSI0RbsR0+91M1V89N3XWOkALod9ElRqQl6kPPq7c8dI0vsHJ0Xz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392332; c=relaxed/simple;
	bh=6iqHZsqpvteXmL6sNGwR9F9Bzy1GD3Dpn977hegP82E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCLhvtU+ky4Tm/SNjgU+/0m0oJsyh+PMwQF3iifFKRDG5EhinQ8FoAfyTQRMvVvmGGYFYNcXm5iVwP5Az1NyhSBvOWfspPb/pmN6iu93XhrJ5IZjHLS3gopjhLGi/nomhRxILLVU5Te2Aq0j6cwMfio9HLbhcT+uzUhlcz2oJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1QTvANx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1QTvANx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392331; x=1822928331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6iqHZsqpvteXmL6sNGwR9F9Bzy1GD3Dpn977hegP82E=;
  b=h1QTvANxlRu1PBMhTzQERLojZrvb3DkYndgfASLK1I7yG5QgtvQvfnUe
   xU8sqArKY37rOZAjhRUt/1/Lxkyn5v4vQ0aCv1t2cGmabBn9uq7bbIyUd
   IhtQ1MJBVOky0VGiM8RJVTqbqG0gopPetKxrrmjeShtTj+FjFUWi4pymW
   pj7iwI14bqX/E+62OLOrw6H0cAHmlxorWeJdehLOPgzOkInhHPoHGBQEH
   x1+vcG7bNcnj7jSiVJ4JkBSRvjs73PT7dabsf/mnTv/uhVi5d79ZGyoEG
   9o75WarL+MfAo4Sju2u3XdjTv2RP5wSJ2uqy6zNmK5fvWMzZmpPBDhAAw
   Q==;
X-CSE-ConnectionGUID: EUpw79VdTY29/GWViPlN9A==
X-CSE-MsgGUID: oK8re+zBRvy9/BdPHIkkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="263207"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="263207"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
X-CSE-ConnectionGUID: ZzJ3RpdPQDyniPoJlTVY0g==
X-CSE-MsgGUID: ng8wbUprTHy0xHaCuJfzhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306958464"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PCI/DPC: Decide DPC ownership with host_bridge->native_dpc
Date: Wed,  7 Oct 2026 09:58:36 -0700
Message-ID: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes host_bridge->native_dpc the single decider for whether
Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
ownership".

  https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas

Today the DPC service binds on host_bridge->native_aer, AER availability
and "pcie_ports=dpc-native".  host_bridge->native_dpc is only consulted
by pci_dpc_recovered().  After this series, native_dpc is the end result
of everything that decides DPC ownership, and portdrv binds the DPC
service on it.

The series applies on top of two others:

  - pci/portdrv, which has patches 1-3 of v15 of "Simplify PCIe native
    ownership".  They fold "pcie_ports=native" and "pcie_ports=dpc-native"
    into the _OSC control mask, so native_dpc already reflects the
    command line.

    https://lore.kernel.org/r/20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com

  - Lukas's "Error reporting for AER-incapable devices".  It removes the
    AER Capability requirement from the DPC driver.

    https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de

Patch 1 removes CONFIG_PCIE_EDR, which was another knob in deciding
whether to request DPC control in _OSC.

Patch 2 stops requiring pci_aer_available() to bind the DPC service,
since the DPC driver does not depend on MSI or on the AER driver.

Patch 3 requests DPC control only together with AER control, as PCI
Firmware r3.3, sec 4.5.2.4, requires.

Patch 4 binds the DPC service on host_bridge->native_dpc and logs a
message when the OS assumes DPC control that _OSC did not grant.

Kuppuswamy Sathyanarayanan (4):
  PCI/EDR: Remove CONFIG_PCIE_EDR
  PCI/portdrv: Don't require AER to bind DPC service
  PCI/ACPI: Request DPC control only together with AER control
  PCI/portdrv: Bind DPC service based on host_bridge->native_dpc

 drivers/acpi/pci_root.c    | 26 +++++++++++++++++++++++---
 drivers/pci/pcie/Kconfig   |  9 ---------
 drivers/pci/pcie/Makefile  |  5 ++++-
 drivers/pci/pcie/dpc.c     |  5 +++--
 drivers/pci/pcie/portdrv.c |  7 +------
 include/linux/pci-acpi.h   |  4 ++--
 6 files changed, 33 insertions(+), 23 deletions(-)


base-commit: 4fe37866b0d92cdc45b62954a76489a9d9f8bd73
prerequisite-patch-id: e0eafcb39f15c38f3acfa601dfce07a6f0832ce1
prerequisite-patch-id: 83e8185612e785fad80790d4a0c20fa68ab12ce7
prerequisite-patch-id: 8e9e2b06f55249ff57c7d7f43918ee82f79d1450
prerequisite-patch-id: 78ad13a1c423c3ee50122237c4bd0fdedf2d1e00
prerequisite-patch-id: 0c4b9d46eea86635c431382aef2bf576a3bb5691
prerequisite-patch-id: 2d1a35309e750427352c6fe0d9bb62c4453c6252
prerequisite-patch-id: c1ed9c8ac6123e0a65ae0d7ba3183dd46477edf7
-- 
2.43.0


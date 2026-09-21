Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E546F4BB
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000290; cv=none; b=srvAQ2ymn7ynszawaNOappnvMk2fmWAZ9Hi/OjuQrOubHKtz2IKkKlz+uJ7HbgHVD51YimoQdRs76C9lB5TzXe+axVsCiyf/iX4/cws6jiKiR4W+a5fYDrpKXFta0PWMDtVpXs993aHxuNftnZPSgB0rZky/txPxceUXcC8z8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000290; c=relaxed/simple;
	bh=6uTlcnL21Ne0AuirPC55v03M4RSODFBh8qHaCfMDL3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8Xe+ZjQsUlwxvt+VRytGC1hlcPFlzgj5P+RvQWOKJAD3UiN041afednZT8Q9sqtAdoOVMXbSl3Fvhh0ybGs5W18d6E79ZXUGsTOuNDF2GhyFkDSLFTsQiegTpXEkp4AM+ADrRXsHlyfOH7BS3vy1nX1wpYVoBrpZXfd1izPU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzZ+Sugm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzZ+Sugm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000288; x=1821536288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6uTlcnL21Ne0AuirPC55v03M4RSODFBh8qHaCfMDL3Y=;
  b=mzZ+SugmM5pzUTtQBzyDoDHXiJjZaH2Z0D4sS8gk0M94jDpcsu8bksKo
   EGNn7dCmAqbWg/RuU6yUdHSJfeWA71HxkH8y02Cy7nB79USEYqHaQdZx+
   QrfOrHJdxwOwyRQaDMuRyR50GnLpD4kTizIviSZlWG05N4jcxFgYxS8G7
   BmJVGVOvpAHxvuSJ06zzZseJ/eIPA2pJFjaZ8vxUBlNpQn4FywAz7N3AT
   IZPhiPtRsIe2DbqshoqlskbY84YSp2NbQAC/ufKlrzWu9RYl48spb6rOh
   Kt9c4EHynXXYZ1GagxtGROJJa/1e6qm5NYwPiXJtOEeOf3NiZNZZVvn8y
   A==;
X-CSE-ConnectionGUID: 3l1zZh2tSK6aPR4Gf91nEg==
X-CSE-MsgGUID: In3t3z15T6q+GjXDb1OXKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108336"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108336"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:07 -0700
X-CSE-ConnectionGUID: 2HJtaVlVTOCKwvDOwgfimg==
X-CSE-MsgGUID: zz5uAIBXTuyJuUoV3xXhmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654347"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:06 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 0/8] VMD add second root bus support
Date: Mon, 21 Sep 2026 16:43:06 +0000
Message-ID: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for a second VMD root bus.

Today the VMD driver can enumerate and manage devices only behind the
first VMD root bus. Starting with Intel Arrow Lake, VMD may expose a
second root bus (BUS1), and devices behind that bus are not discovered
by the current driver.

The hardware model for Intel Arrow Lake VMD is slightly different
from earlier VMD generations:

- CFGBAR, MEMBAR1, and MEMBAR2 are shared by both VMD root buses.
- BUS1 uses a fixed primary bus number in hardware.
- Interrupt handling remains based on the existing VMD MSI/MSI-X and
  irq_domain model; this series does not introduce a separate interrupt
  domain for BUS1.

To support that layout, the series first refactors the current code so
resource setup, bus creation, and enumeration are split into helpers.
It then partitions the shared CFGBAR/MEMBAR apertures between BUS0 and
BUS1, creates a second root bus, and adds a VMD-specific workaround for
the fixed BUS1 primary bus number so PCI core bridge scanning does not
reassign BUS1 and lose subordinate device discovery.

Patch overview:

- Patches 1-4 extract helper functions for bus enumeration, CFGBAR and
  MEMBAR configuration, and root-bus creation.
- Patch 5 replaces hardcoded resource indices and constants with enums
  and defines.
- Patch 6 converts single-bus state into per-root-bus arrays.
- Patch 7 adds BUS1 resource partitioning and second-root-bus support.
- Patch 8 keeps the BUS1 root bus number aligned with the hardware-fixed
  primary bus number so PCI core bridge scanning does not reconfigure it
  and lose BUS1 subordinate enumeration.

Tested on an Arrow Lake platform with NVMe devices present behind both
VMD root buses. With the series applied, devices behind BUS0 and BUS1
are enumerated and become visible to the kernel. Without patch 8,
devices behind BUS1 are not discovered.

Changes from v1:
- splitting series into more commits, requested by Bjorn
- adding helper functions, suggested by Bjorn
- minor typos and unclear wording updated, suggested by Bjorn

Changes from v2:
- wording update in commit logs, suggested by Bjorn

Changes from v3:
- using GENMASK() instead of manual bits shifting, suggested by Bjorn
- converting decimal number to hex representation, suggested by Bjorn
- wording update in commit logs, suggested by Bjorn

Changes from v4:
- Update Dan's email address
- Resending the whole series to the correct mailing list

Changes from v5:
- Fixed correctness issues in BUS/resource layout in patches 7 and 8
- Fixed lifetime and use-after-free issues in patches 3 and 7
- Fixed resource tree integrity issues in patch 7
- Fixed error-path leaks across patches 3, 4, and 5
- Fixed allocation failure handling in patch 3
- Note on Sashiko feedback: Pre-existing warnings (unrelated to
  this feature series) were left untouched.

Changes from v6:
- Refactoring the series to align with recent changes in link below:
 https://patchwork.kernel.org/project/linux-pci/patch/20260629165025.268836-1-nirmal.patel@linux.intel.com/
- Fixed double free of the IRQ domain and emulated domain number
- Fixed a race with concurrent readers when modifying sibling pointers
- Fixed the MEMBAR2 split equations in
  vmd_configure_membar1_membar2()
- Fixed hardcoded resource indices in vmd_configure_membar()

Changes from v7:
- wording update in commit logs in patch 8, suggested by Bjorn

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <djbw@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Szymon Durawa (8):
  PCI: vmd: Add vmd_bus_enumeration() helper function
  PCI: vmd: Add vmd_configure_cfgbar() helper function
  PCI: vmd: Add vmd_configure_membar() and
    vmd_configure_membar1_membar2()
  PCI: vmd: Add vmd_create_bus()
  PCI: vmd: Replace hardcoded values with enum and defines
  PCI: vmd: Convert bus and busn_start to an array
  PCI: vmd: Add support for second rootbus under VMD
  PCI: vmd: Workaround for hardwired BUS1 bus number

 drivers/pci/controller/vmd.c | 633 ++++++++++++++++++++++++++++-------
 1 file changed, 510 insertions(+), 123 deletions(-)

-- 
2.43.0


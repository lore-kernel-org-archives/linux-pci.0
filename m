Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039346;
	b=JjOJHuGLALy8rrj3U3DpdgpDg2tGO6aVGJ9CQU3Zo1udGj40vj9NefGQBqeleVdqxNaj
	 qcUgCYcFKBON9T8XIGtUnorKJ6iofOMSWXWuJF7bBxwZ09c7vRgO8AoSOz3HtjYbd8PXE
	 sYYgz8Tb/sZfdY4mA/BPb4P4L3h6I9pUzJToDDLXNstQOLFbi1moBeGwO91aZDmg/DqIY
	 iDGf6DUgyEoknJTaLfwejF4uoviPQcqMFBAV9tI3w8QGxBEzI8tFm5urqS9x3nuWBu7yW
	 5ghzOQqTbiZzK3CnYgkNjYEXYgBX+SMj1w0LILMOX+ad+iqiYC3sXTj7LhJbcqBUMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IWScLLUM6vSNoGJtI8uM6XnkCz3Cf8EDLBeUgktuvyc=;
	b=F4cTkJHngsrAu2u0fkjOgAjSQjAqrp/6DlE8ApZchrmLL5VNTfavos3nawY4vhFD6ok9
	 Wvo1LsIvi9Rt+ew2QLNcpVRInMWtJwHP8wfPCrpu+tHBc3v4xvxelIV/PtZnpWgueYw/B
	 d7HSHuAI6dgPKhgcnTpOTddPZ23Vv8R7HNgndJpq2pyoDgsfpVoPhIfIbF+DnrWXQvWZ9
	 HL/APSe2IyZCONTbvpKWn1fXCZL8nlkSbrwyCciAkmz7cBy6tFy+aOktHtfEYiUBbbeYF
	 pq+0FtKOECmwYnr2wW6lBpQt7CzRSpxkm0ItzUlSVBaGCxI1gCM6k1a00EsUAoBtV+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvlVhVPF;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107E606A31F;
	Mon, 26 Oct 2026 18:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5107E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvlVhVPF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039346; x=1824575346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Squ+X+dHLfmfHqNxzVlAZAEqmPdqY2Q0JmAc3dqtHdo=;
  b=mvlVhVPFrRaCvFtro3cvk3ch0m3OMKX6U3qdJ/N7YJyKiekhtEvnQUha
   s/yRvBwkXd4Tz56oz/6xYyLT2raVp+/2+QUo0sWBCT1O4zSlZaeKhjus8
   zKPLgkgeuGHP/gqM/5o+oucYK0CykJFqCGONnOZ42ZcDoYm22ZZ0MG1Bm
   O6K4g/lgcl98joC7lssMhshGILK0nSBvPq3U4OhaM41+C2SgLizhKzzke
   LNjKCqrN8RVz0ti2hn0GuvxaPLvCkJGJnSUhMgrX+f3LKqWv3+QNCO4Zn
   w+3x/rc8Ww/FI/UKp0YdvhTa4e0ADsvwHAxC0ZHAEG9unrTCkDWHX90kl
   g==;
X-CSE-ConnectionGUID: kAU6oNfOSpCVsHZYoP0DgQ==
X-CSE-MsgGUID: 0YNv8RgtTL2ogB7xL4ZyNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1600998"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1600998"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:05 -0700
X-CSE-ConnectionGUID: f+f1tJHtSQqwEF7LIKTX9g==
X-CSE-MsgGUID: /igHDuSWSa+R8liF5cK95g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720084"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:03 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/7] VMD add second root bus support
Date: Mon, 26 Oct 2026 20:54:53 +0000
Message-ID: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
- Root ports on BUS1 have PCI_PRIMARY_BUS hardwired to 0x80.
- Interrupt handling remains based on the existing VMD MSI/MSI-X and
  irq_domain model; this series does not introduce a separate interrupt
  domain for BUS1.

To support that layout, the series first refactors the current code so
resource setup, bus creation, and enumeration are split into helpers.
It then partitions the shared CFGBAR/MEMBAR apertures between BUS0 and
BUS1 and creates a second root bus in its own emulated PCI domain.
Reads of PCI_PRIMARY_BUS from BUS1 root port bridges are emulated to
return the actual root bus number, so PCI core bridge scanning does not
detect a mismatch and lose BUS1 subordinate device discovery. This
replaces the separate workaround patch used in v8.

Patch overview:

- Patches 1-4 extract helper functions for bus enumeration, CFGBAR and
  MEMBAR configuration, and root-bus creation.
- Patch 5 replaces hardcoded resource indices and constants with enums
  and defines.
- Patch 6 converts single-bus state (bus, busn_start, sysdata) into
  per-root-bus arrays.
- Patch 7 adds BUS1 resource partitioning, a separate PCI domain for
  BUS1, PCI_PRIMARY_BUS read emulation for BUS1 root ports, and
  second-root-bus support.

Tested on an Arrow Lake platform with NVMe devices present behind both
VMD root buses. With the series applied, devices behind BUS0 and BUS1
are enumerated and become visible to the kernel.

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

Changes from v8:
- Dropped patch 8 ("PCI: vmd: Workaround for hardwired BUS1 bus
  number") along with the issues Sashiko reported against it. The
  hardwired BUS1 primary bus number is now handled in patch 7 by
  emulating PCI_PRIMARY_BUS reads for BUS1 root port bridges in
  vmd_pci_read(), and BUS1 is assigned its own emulated PCI domain.
- Patch 6: sysdata is converted to a per-root-bus array as well.
- Patch 7: Fixed a data race reported by Sashiko where the MEMBAR
  .sibling pointers were assigned manually while the resource tree
  could be walked concurrently. BUS0/BUS1 MEMBAR resources are now
  inserted and removed with request_resource()/release_resource().
- Patch 7: Fixed an issue reported by Sashiko where resizing the CFGBAR
  start address for BUS1 caused vmd_domain_reset() to skip the root
  buses. The reset now starts from busn_start[VMD_BUS_0] and covers
  the whole CFGBAR aperture when BUS1 is present.
- Patch 7: BUS1 setup failures (domain allocation or bus creation) now
  release BUS1 resources and fall back to BUS0 only.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Szymon Durawa (7):
  PCI: vmd: Add vmd_bus_enumeration() helper function
  PCI: vmd: Add vmd_configure_cfgbar() helper function
  PCI: vmd: Add vmd_configure_membar() and
    vmd_configure_membar1_membar2()
  PCI: vmd: Add vmd_create_bus()
  PCI: vmd: Replace hardcoded values with enum and defines
  PCI: vmd: Convert bus, busn_start and sysdata to an array
  PCI: vmd: Add support for second rootbus under VMD

 drivers/pci/controller/vmd.c | 727 ++++++++++++++++++++++++++++-------
 1 file changed, 592 insertions(+), 135 deletions(-)

-- 
2.43.0


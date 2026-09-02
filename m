Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB74A6CEE
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363248; cv=none; b=udjiq6eguVyhrVAev8gHizItwnoVIAumuD2cfPnd5Yf8fwv1KWcIez7rIGU8Cj2Tvej2Rp9+QBRkvNQLMUQEVXxRaBJ6nkPbiaZaR2DoHiqW+q3WHMqBktORgZ2wWp7L0LK7OetooJw5pBwfen2UN1tf+ldEgmIo43RKRJ/uTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363248; c=relaxed/simple;
	bh=gZlA4qL+GSHlSOW7VJtQ+VKsOaSpfecTfllX9mWYZmU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MtmdUg08V0+RZ8kBW9MLqSczC+M7MLuat9WFfqkaAwoaL+0P0XCe1KPby4ue+FtsSmvRPxg0OMVGhBGW4rF2NxVAjxFOm8HK0eiwukj8ZOpwRxwStmA+XlgUta1uIypMxX2mf/irvSfAJ1a4G6YJvLoeViQf1JmU1zZK9uCug1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgJiFKi3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgJiFKi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363246; x=1819899246;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gZlA4qL+GSHlSOW7VJtQ+VKsOaSpfecTfllX9mWYZmU=;
  b=RgJiFKi3GLECGVbh4MzcPofydcHTRU3zrCKHBm1WdIZo5so0UzvjZhGM
   mqHOTIxx6aRUpHbTIJylMM+uRsJRrlphfcdrzaVlFsUhPZCMVEZaiTmzQ
   3okxc979znyltaBb3WKTb/Boa4ehJKcIGJLftzaYHZV/cqiJecnCjRjkH
   5xXbZkZ+ELn4TVQ8BOXQv5KLa9RJJdi6btnZXkGW2enbVqhBYvaJW500C
   MuqF6gIII0H8vOyzLl5+a5G/hjW7YsBKMa7JMdwIiNlqQDRMZkFB3037C
   s5VPB0KeqBNIsWuzqa5sMP6E5hiMw77EkJ1kZ7Gi/is+zULivKaBmTziY
   w==;
X-CSE-ConnectionGUID: KzkH9fy6Tbu6RO+rCXSoKg==
X-CSE-MsgGUID: OMUtSZttRiqDxgfPv73KTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646652"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646652"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:05 -0700
X-CSE-ConnectionGUID: XFZrZKe0R8CdbZxzL0s9tA==
X-CSE-MsgGUID: cgkD1gWMQYSj4B7/OHt5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406725"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:04 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 0/8] PCI: vmd: Add support for second rootbus under VMD
Date: Wed,  2 Sep 2026 17:58:36 +0000
Message-ID: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements second rootbus support inside Intel VMD
module. Current implementation allows VMD to take ownership of devices
only on first bus (Rootbus0). Starting from Intel Arrow Lake, VMD exposes
second bus (Rootbus1) to allow VMD to own devices on this bus as well.
VMD MMIO BARs (CFGBAR. MEMBAR1 and MEMBAR2) are now shared between
Rootbus0 and Rootbus1. Reconfiguration of 3 MMIO BARs is required by
resizing current MMIO BARs ranges. It allows to find/register VMD Rootbus1
and discovers devices or root ports under it.

Patches 1 to 6 introduce code refactoring without functional changes.
Patch 7 implements VMD Rootbus1 support and patch 8 provides workaround
for rootbus number hardwired to fixed non-zero value. Patch 8 is necessary
for correct enumeration attached devices under VMD Rootbus1. Without it
user cannot access those devices as they are not visible in the system,
only drives under VMD Rootbus0 are available to the user.

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
- Addressed review feedback from Sashiko AI:
 * Critical correctness in bus/resource layout in patches 7 and 8
 * Lifetime and Use-After-Free risks in patches 3 and 7
 * Resource tree integrity issues in patch 7
 * Memory leak issues on error paths across patches 3, 4 and 5
 * Allocation failure handling in patch 3
- Note on Sashiko feedback: Pre-existing warnings (unrelated to
  this feature series) were left untouched.

Changes from v6:
- Refactoring the series to align with recent changes in link below:
 https://patchwork.kernel.org/project/linux-pci/patch/20260629165025.268836-1-nirmal.patel@linux.intel.com/
- Fixing Sashiko's suggestions regarding:
 * double free of the IRQ domain and emulated domain number
 * race with concurrent reader when modifying the sibling pointers
 * the MEMBAR2 split equations in vmd_configure_membar1_membar2()
 * hardcoded resource indices in vmd_configure_membar()

Szymon Durawa (8):
  PCI: vmd: Add vmd_bus_enumeration() helper function
  PCI: vmd: Add vmd_configure_cfgbar() helper function
  PCI: vmd: Add vmd_configure_membar() and
    vmd_configure_membar1_membar2()
  PCI: vmd: Add vmd_create_bus()
  PCI: vmd: Replace hardcoded values with enum and defines
  PCI: vmd: Convert bus and busn_start to an array
  PCI: vmd: Add support for second rootbus under VMD
  PCI: vmd: Add workaround for bus number hardwired to fixed non-zero
    value

 drivers/pci/controller/vmd.c | 621 ++++++++++++++++++++++++++++-------
 1 file changed, 502 insertions(+), 119 deletions(-)

-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BE418379
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045819; cv=none; b=DViYy20+wAVfq5jRWxH0LR8g+ufvI9I3bxYpyneXPmjJtWobFjYREwBd6lqPw+Ro0DNG7cCkljfcQYl7YUabhxnNRhn9b4bWVZN/GJql50Hkq+jbQW7oB8D/AE25hiC7YwLER7DA08BE2bh8LjTJizGsn9eCak3HOAvp+ImQ2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045819; c=relaxed/simple;
	bh=3jPDSGoxggn1zKUVnp5tsUf5ccQZJX3ENolm+Kf3xW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+IsVLb9ECVJrn13oKY3xeAGYNnyolm2PjejIkZLSbXjaQzoBFhk/W9PqG8ciQk1dqd5bLb7NCvzXXjHhIbCRt6AyfTlCp6H7Wwi3BC6iBX++G70TMC1v7NQ4GBlFhTmRLZkVB27ajkL3cWw6mP0o4cCOhE1G7AZ1/0hnoNNfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCR3ubTg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCR3ubTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045809; x=1817581809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3jPDSGoxggn1zKUVnp5tsUf5ccQZJX3ENolm+Kf3xW4=;
  b=ZCR3ubTgex/oZHho2FzlYx5VApEqZnlwjckrRMB3exGFAhtXpbeiXCFk
   I20gXuniD2Hx1nd/AsROfMJrQzPHsrkZAYXjn/VV55ou2va5uq6+jUBww
   EuOxK7h794LA3woRC+qskoQNs6XFFbRUg8sqn+udDlIr4dBckgbQPHPbp
   U8wsv4pgDBdBocvpZ8ljOnFxa4n3oRRA2KTxP2ZPMZMA0REluLKsveTGn
   tCSn6LB6mMmhshubGIu0bJxOr78FDJeRi8YTZskqSzbB2Rxin3tsw67za
   ZweFqSLZw1pwxPFMHRIVzYGVrsdl3i5/6TFqyk2/g9uRx9Kcz0Hkr0Eqi
   A==;
X-CSE-ConnectionGUID: CaPc6zdGQwGvEX4FmFucsQ==
X-CSE-MsgGUID: OResXEM4Q8S6ZWYAv6WTKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622513"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:49:54 -0700
X-CSE-ConnectionGUID: 4St9IlvxRBy4GO/r7XzqGw==
X-CSE-MsgGUID: KlKfRGZUToSlPKHPJiYg5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923367"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:49:52 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 0/8] VMD add second root bus support
Date: Thu,  6 Aug 2026 22:13:39 +0000
Message-ID: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
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
  PCI: vmd: Add workaround for bus number hardwired to fixed non-zero
    value

 drivers/pci/controller/vmd.c | 612 ++++++++++++++++++++++++++++-------
 1 file changed, 497 insertions(+), 115 deletions(-)

-- 
2.43.0


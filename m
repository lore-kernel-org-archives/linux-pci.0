Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126B37104C
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076669; cv=none; b=GZX1L6U9o+G6CXaYyMmYuNmhJ+5xnIEBN0L84fjHZMGGG/7+ZmSRQxW7POz5ToVpaRxq7NvSVJH+aJjHubjZ5EChpx5fFKkU5cyj2xFOAlwmWlTOMXc0HCa6f3WNBDk/T16z3WxzddHTrjyqwbqk5dprZE/jL/DQbe4xwItGBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076669; c=relaxed/simple;
	bh=V6v9W6QBhOWAxmO9DYhVqHQyI//KCEVDRfDBZnzuv0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIKxEZ0N5zMzXge0bzN1Qk1P35f7M4bPxbNdv6eHSr+xH59VnzA4m9kKoLuOumwqBT60k95muH5g+NfN/NLs2cGFg7z95TzRjfh6RMQqEF4yeLNrm83F65yJgg8ubheuFIdV/Ycgza2IEo96A6qt3PuiqKKZLS0aZ0XS+A21kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uc7lRs2h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uc7lRs2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781076667; x=1812612667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6v9W6QBhOWAxmO9DYhVqHQyI//KCEVDRfDBZnzuv0U=;
  b=Uc7lRs2hIMTO/4Bjb0ZKNqkB6/8cRjzBk3TFirCadIN8iwv0Y+FcOP4t
   zTVuedyLj8Cs2KQDekFJJVOAqz+U269tzqnrRd2lMX44Dri/UpTkCDARk
   LWHbdSUFcaxwuwipbgg3oRTeIMGG1d/k1JBGTxTRZlXKvIVuD3oJ/C0km
   byENNFJn+jCuQj9KD8HOY0QCFySRdHWWwdQN+Ye8+gkKSVQfqpDwmcBUn
   gzRfL2PQDCFH6H/MIhPfQTlwtubqLTx0ftz1swB7dyHVNGDCxY0Wa4bfm
   VXFLEgYI+d394GIWTGN9kZJGW2th6y+2phUltSYQw9ROl39qTUkY1MBnm
   A==;
X-CSE-ConnectionGUID: rUZZzKquQqu9ne/nf7BpSg==
X-CSE-MsgGUID: rBnVn/HBRySHPJDpVAeMPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81973752"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81973752"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 00:31:07 -0700
X-CSE-ConnectionGUID: CLh5PFEvR4u7+TfZRyVVnw==
X-CSE-MsgGUID: GBWODLlBTUOaSdqx38uHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="247953161"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 00:31:05 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 0/8] VMD add second root bus support
Date: Wed, 10 Jun 2026 09:51:36 +0000
Message-ID: <20260610095147.200818-1-szymon.durawa@linux.intel.com>
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

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
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

 drivers/pci/controller/vmd.c | 488 +++++++++++++++++++++++++++--------
 1 file changed, 376 insertions(+), 112 deletions(-)

-- 
2.43.0


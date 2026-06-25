Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EF3BED42
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367674; cv=none; b=cTfNn1pJ1Lou7Gf6Sb2fthVSsdjSZm905JDjwDrUXGXRepZtaMdnz1/hSqvxVwcHq8WANGEe5uimupNeZGIZYMuJfGCfuESBhXAJsRA3SPi83rSLUER30IKsEFSOCZN6onIjT1JA5PxRXEAuT55cfnCdF7/YPaaSxD2DC0HwDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367674; c=relaxed/simple;
	bh=O5K0lhypuQ1vj3b5w1mbj+ePpbKrKQ8EOdDhNjgKeDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWwhP5H1feW+dH3mMwpyCWIHImaPHsXMSzk13e5Y/LXxUZc+j1jWElkd6bmWuT2+bXL+Ba0Cwc1rkvhMcObin4P+WDjCAPC06ol657rYnwwTcCD8DRNhexZyL+wBd+r0CSj4AwE/hZMGFZ+fsN18gMH4ro1v8phMSQTjRdE5Iew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BryzYDyl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BryzYDyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367672; x=1813903672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5K0lhypuQ1vj3b5w1mbj+ePpbKrKQ8EOdDhNjgKeDY=;
  b=BryzYDylKnHCgQXJrVA081nC8RNH3rFjOZYYZ+mipP64v4V7JG1U3v8p
   sgolNO/V00rr07qzDF12og5O/AHnJHixCEociPuUbilygDXXdwx+z/TlP
   SwzRCIKjsGMc0xhvvNqo1qvB42tAmqakt8w09W/7Zx6EdeSu4hKDXZTZo
   hwEuEm0rtNQ1UhmiQeSUZ51W8apF/bXG5duP8DojsAY/12Xf0DWC/bKFD
   vp39xbOBB6/b2dKDAhfvCAjbxTZ7egV3JrLgZaBDDRquB19I/NpDrjvAT
   ni8MXZTtz3a8Df80nCV2EpjbUS207rH57bYCJjiDm7efCL+faJfSO3DuL
   g==;
X-CSE-ConnectionGUID: xdz9Xxd+SO2BIHjY4F+JGg==
X-CSE-MsgGUID: tKltuJcIQ/G0hXM9F3Gi4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021817"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:52 -0700
X-CSE-ConnectionGUID: BCj9zx97QE6XTcgEZnzOUw==
X-CSE-MsgGUID: XikxPFPpRL+uBvVdy3v32A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725361"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:49 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 0/8] VMD add second root bus support
Date: Thu, 25 Jun 2026 08:29:29 +0000
Message-ID: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
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

 drivers/pci/controller/vmd.c | 488 +++++++++++++++++++++++++++--------
 1 file changed, 376 insertions(+), 112 deletions(-)

-- 
2.43.0


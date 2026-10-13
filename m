Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC3217F27;
	Tue, 13 Oct 2026 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897002; cv=none; b=X8K3sCu5gPWFVjhyEGcig8neFRPkttitzfthLikNwaZi3dCSql1MSC2wkQao1/89uBIcCIQXRsigBts0CgJ+mQomm+OX0QlrYEyZ7MqwnvFXiDxJNkozTo46YaUSHLb552CO1uneB8a2Y0NiTZghYuSpgGl0Ci0R5MC6fjXlno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897002; c=relaxed/simple;
	bh=rxSq5u9RCYb1LKnGoS9AupL2AuEBkfp61ec1e/hhuPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTVkj11NcI0SJ+W+XI9AZtlN6+CZrgCDgfbjn5bV2qaqAULZMZhDnZFgnHWDqLmKxIDCcsA0x8OYAz4oxY1odpxqjPwO3sGpEu1T9x8jMWbNwEDZA/qgr7wRbdAC8MoJMbXD9amGMUrKd9MdnFfHgaV/37uDutqjNXBL1zGwnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU0VyxSp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU0VyxSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897001; x=1823433001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rxSq5u9RCYb1LKnGoS9AupL2AuEBkfp61ec1e/hhuPM=;
  b=FU0VyxSpLe9sAxXYyqXjbXzNOfZS+TT5jBWGrHliX1R/bvaxjv5xRhsE
   eOm5DMpj9k7UhWlzjDEoyYWSC/I8jTE8GtBcMDYqeurBkdVq5tOtvKP+C
   ha97YFehPYYDGOkCMcX83zRXo27mu8wrNbr3UI2WFzdqigmfeH3Ory0OF
   sKCf0kUL5Zyp+DEK7j2RQ2OtKaMvDs9jQt6TD8V/MoivESG8ETSngAFKD
   /8w/lfkfyDcQOv7iTScSiW2PHDjsNc/LGaG7MmnzrwimPXFvm2h6fNGzB
   iMjsfzYw4XWdZFIP7qgeR2xegWyZu+KzNZTEi2GgrQdwhLtbCRuxcQrMw
   Q==;
X-CSE-ConnectionGUID: Qturo2VoRKGcEA9VdKF5OA==
X-CSE-MsgGUID: sEiR0sH8RpGPCRvCad+jLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="505980"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="505980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:00 -0700
X-CSE-ConnectionGUID: wmPvWrISTRmoER8Tm+iwNQ==
X-CSE-MsgGUID: 02xAWUFERbmvXXglFOBHeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1247508"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:09:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/8] PCI: Resource placement algorithm fixes
Date: Tue, 13 Oct 2026 16:09:34 +0300
Message-ID: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series generalizes resource placement algorithm. The commit
9036bd0efcb6 ("PCI: Align head space better") special cased one
composite resource remainder case to fix a regression (in a long chain
of regression fixes). Unfortunately, it introduced another regression
(or a few, to be more accurate).

Instead of building more special tricks, generalize the PCI resource
placement algorithm so it returns placements that gives better chances
for the greedy assignment algorithm to find suitable space for
subsequent assignments.

In short words, the new approach tries to find a placement for the
current resource that blocks as little of the free space range as
possible, considering both alignment and continuous free span of the
remaining free space.

In addition, the series corrects composite resource sizing to account
for gaps that have to be added due to alignment constaints and
remainder space not fully connecting (filling space all the way to
the bridge window align).

More detailed explanations in the patches themselves.

Unfortunately, this also causes yet another regression due to shuffling
resources around, even if the resulting arrangement seems just as valid
as any other. The workaround quirk is in the last patch.

I find it likely that after this series the resources are packed tight
enough to solve also
  https://bugzilla.kernel.org/show_bug.cgi?id=220016
from more than a year back but that remains to be seen (if we can still
get the reporter to test it).


I've another series coming up to improve pci=resource_alignment locking
as I realized the current approach allows parameter change to race with
the fitting and assignment algorithm.


v3:
- Add roundup/down_pow_of_two64() (new patch) to avoid problems if
  resource_size_t is 64-bit and unsigned long is 32-bit + use __ffs64()
  (multiple potential issues mentioned by sashiko)
- Do not print res->parent in parisc debug code as the resource is never
  in the resource tree (found by sashiko).
- Do not override user-alignment with the remainder moves (sashiko)
- Consider optional sizes properly when sizing bridge window gaps (sashiko)
- Move genoa quirk under arch/x86/
- Rename quirk's static resource variable

v2:
- Add patch to cleanup parisc debug print (do dyndbg conversion)
- Add patch to prevent remainder tricks when alignment override is used
  (found by sashiko)
- Do not use PCIBIOS_MIN_IO/MEM but 1U as min align. The former seem
  address space lower bounds even if parisc arch code misleadingly
  uses them for ALIGN() call.
- Fix res->end + 1 overflow case (found by sashiko)
- Tweak debug print formatting
- Reworked the iomem black hole quirk (now based on the bridge)


Ilpo Järvinen (8):
  resource: Mark free space assigned
  PCI/parisc: Clean up resource debug print & use dynamic debug
  PCI: Honor alignment overrides
  PCI: Fix nesting windows with remainder at the left edge
  linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants
  PCI: Place resources to either edge of the window
  PCI: Fix composite resource sizing
  PCI/quirks: Avoid certain address on Genoa systems

 arch/alpha/kernel/pci.c          |   3 +-
 arch/arm/kernel/bios32.c         |   5 +-
 arch/m68k/kernel/pcibios.c       |   4 +-
 arch/mips/pci/pci-generic.c      |   5 +-
 arch/mips/pci/pci-legacy.c       |   5 +-
 arch/parisc/kernel/pci.c         |  20 +--
 arch/powerpc/kernel/pci-common.c |   5 +-
 arch/sh/drivers/pci/pci.c        |   5 +-
 arch/x86/pci/fixup.c             |  36 +++++
 arch/x86/pci/i386.c              |   5 +-
 arch/xtensa/kernel/pci.c         |   5 +-
 drivers/char/agp/intel-gtt.c     |   5 +-
 drivers/gpu/drm/i915/i915_gmch.c |   5 +-
 drivers/pci/pci.c                |   5 +-
 drivers/pci/pci.h                |   4 +
 drivers/pci/setup-bus.c          |  88 +++++++++++-
 drivers/pci/setup-res.c          | 223 +++++++++++++++++++++++++++----
 include/linux/log2.h             |  52 +++++++
 include/linux/pci.h              |  33 ++++-
 kernel/resource.c                |   1 +
 20 files changed, 445 insertions(+), 69 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3


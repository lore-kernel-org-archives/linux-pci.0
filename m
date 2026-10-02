Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A2370AE5;
	Fri,  2 Oct 2026 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940824; cv=none; b=MZgWB9ELQaWv985cnvTpcPgnp7WoQKNgfiQsiU3iIKjeK91EgOi/19XVIGEJi6ZE6xPQrX8vMkfVXcchBrVxguFn9S/ETrrwSIDTT9XMMsdf4JmHMKEgMB0gyl/tS70oY/c2/lnPTaqRR3rtvy8Tk0ztKh8nxYBTHIwnUeNSiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940824; c=relaxed/simple;
	bh=r6CWrnw1f0smbbNB2XTiSi9XyKGkwRBcnBzHu61b+Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBRg4NWHKJydIPpKy9Co3erIVbOyySqmjVAnPVaT6b4Z4xlabzvQ/5SLKfhZSaNkev6+u5qKW2TdkLZo4scMXWCECTy0Kbdi5rV0RRLyxzylgHoX/Tf4jYUi3C5hTDviwZbdBgFuU8epiXE7ylLIWBdY1EzKAzdS0GntxW/QEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qygi6DRo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qygi6DRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940821; x=1822476821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r6CWrnw1f0smbbNB2XTiSi9XyKGkwRBcnBzHu61b+Jc=;
  b=Qygi6DRolfr3N5fl/McmsFddC8UVQU1/0IJDfDXDIqUTovV4YJwoHITO
   EqK/2rXSkWW4WyT5okK2AIHKkav6en1fFsVTEcITT8SHs5amKpdSKKA1Y
   kbYS5ITmxJ+v+aBZIwMXtzSYigzDsGrfnyglNwhNOoJvmpW0NyulJ8RRb
   Iw5s0m8czabzDr8pJuid7VagnOUMCC26dPpqTblgIn4hW+MLo1FL/v5AJ
   FLFb+awxX5g63k4ONTItEZoCKUi4MDnU0pB0OBsZQpcoqj8lF6RjxKAHH
   c+s1I872h42NfMjFFg6Mssl+rr1XRuYIUuwn2ZFiQEjcjRjJ93s0s1NDM
   g==;
X-CSE-ConnectionGUID: Q/mTwLSFQdKkTPSLo/MyHg==
X-CSE-MsgGUID: 4c1SZ0hqTNWs9qMEFKd/kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659710"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90659710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:33:40 -0700
X-CSE-ConnectionGUID: JXJvfIbcSu2ddzLzrYktsQ==
X-CSE-MsgGUID: MByScocJQ0ys5fR2n4Mhkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279969436"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:33:35 -0700
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
Subject: [PATCH v2 0/7] PCI: Resource placement algorithm fixes
Date: Fri,  2 Oct 2026 14:33:08 +0300
Message-ID: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
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

Ilpo Järvinen (7):
  resource: Mark free space assigned
  PCI/parisc: Clean up resource debug print & use dynamic debug
  PCI: Honor alignment overrides
  PCI: Fix nesting windows with remainder at the left edge
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
 arch/x86/pci/i386.c              |   5 +-
 arch/xtensa/kernel/pci.c         |   5 +-
 drivers/char/agp/intel-gtt.c     |   5 +-
 drivers/gpu/drm/i915/i915_gmch.c |   5 +-
 drivers/pci/pci.c                |   5 +-
 drivers/pci/pci.h                |   4 +
 drivers/pci/quirks.c             |  35 +++++
 drivers/pci/setup-bus.c          |  83 ++++++++++-
 drivers/pci/setup-res.c          | 227 +++++++++++++++++++++++++++----
 include/linux/pci.h              |  27 +++-
 kernel/resource.c                |   1 +
 19 files changed, 385 insertions(+), 69 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3


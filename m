Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972636;
	b=2QE2GKfZwphfk/skXMki+V4rEegO4XIYwWUQvzlUnGNrpUmGm/LFWuivqqywY5wbmdnG
	 d5DgnYNXwodjMlLydIRldNPOAnv47b0aLmneTNkEOyy+zSrogg+YdjxDIx5f3E+p7rIJC
	 EMvyjEmdrqA58vggXcS8SgXhO08gy82FK0yduMSnS5vVwU2r8aZnzz/QVQyVCTKUST/QL
	 Iiv7dM5UlnuFX7PgN4zu0ILFsaH8XKdXYScrxj5jFSWm7aTfRj5xsPi8aPjMLEllbAb5e
	 OA80kJWT1nk8ZMlXjtzqhJH5y9EDOyBTpzI/P25iPJbAbn509IETj+Tj/bADzghoTLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972636;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A2HQVLi/niQOn9liXTHTxJVCiAMeXHKl3UTtnPtj3+g=;
	b=TqxgNhcW1IGUGI1KugAQOAC5K0+DnXtFDhZhgTzZYcO9wMj/XpqbZArBXAtdLynB01r5
	 6L3U2eOKsR02rONJGMuKGl+gr2XdydHsbRA/OVaxWPf1CdeoSObRi1WM6BBG0Vt5zz0oL
	 DhwH8N/pc/eL5B5JbJ/oCJqIV7w8DaZVS0L2fGGCPus6T84jYL9LJF0r29RnWunUhO7eE
	 GVjVRyrAzQPJ3oW3qzsl0/KywrzADiLixcPN3AFxUPL3lIrE5Z5HrGNWOqaRvsyMT1LmV
	 2nTM0C/QaW6WmcMbbDYT04AwuOqKSCDA5nv9qnBI9rmFnD/LGSfybmb1A5mg2puDhxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jd9UneNS;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5010606A326;
	Fri,  6 Nov 2026 13:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5010606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jd9UneNS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972634; x=1825508634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ogwsI8rx7GLy4TXfzfm/FL+dP+W5KRDZUqwE/jbY1ec=;
  b=Jd9UneNSEOaUagShBcDtjgBEjq4aFCiFvZBOQfoAAbUKnQvmWCuuvhkv
   zDXfDi1WXhh0WoTf9BuBgc78cZpUwlMwSiIhJW42LzuqATCw748mcO7Q/
   MTnsyvGhGMalCiuhesVUq5IpIJwxIU9MwDSEbWVD561d9AASb3wwVXUKT
   SvyrJshMMJkYFjSGPhS0qY9afZotl1VBAW/PADICQoSxxut+d5c2q3bzi
   VvPqxx/p4NRou/hyEoTVY1yCPwEMg5/bSaB1K5/wB2yklgM9yBYpQ9MOo
   dxqLAne0YiQ19LQyY85R3Q/yGEZIitULqCOyJClegK28PStIL+yRtTzI0
   Q==;
X-CSE-ConnectionGUID: tqdw2B0bT6SnB2OH+siDaw==
X-CSE-MsgGUID: /I2MdxMPSQK0N+edleHG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2812191"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2812191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:43:54 -0800
X-CSE-ConnectionGUID: 1YzqR4PXRxiSGmBZUUkihA==
X-CSE-MsgGUID: HngEHbAwSTqU/yLxrs6eeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7609713"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:43:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
Date: Fri,  6 Nov 2026 15:43:21 +0200
Message-ID: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V4 got quite many comments from sashiko, some of them were a bit
sketchy (bogus scenarios such as IOV BARs on a bridge) but there was
still good feedback hidden under the clearly flawed facade.

There have been major changes so any retesting is appreciated (the
4 candidates patch is largely the same so I kept the Tested-by tags but
everything around has been changing so even that is on the borderline
when it comes to the validity of the existing tags).

I ended up dropping the nested window fix which I had anyway realized
would not be necessary with the current resource code. I had earlier
planned to change the resource side code to only try start addresses
that qualify to size+align requirements and had thus kept the nested
win fix. But it just makes PCI side more complicated requiring extra
tweaks and checks. With that patch dropped, pci_align_resource() can
alone decide the placement making the code much simpler.

Second major change is rewriting the gap calculation, which required
including pbus_size_mem() refactoring that I was planning on doing
anyway.

As with v4, the quirk is not included and one approach should still
be selected to solve the Genoa/Zen4 iomem blackhole but that's not
likely the one I proposed within my series so I left it out.

This series also does not attempt to address cases where user alignment
override does not propagate to window size calculations and thus not
into the align given to resource placement code (reported by sashiko).
These are pre-existing issues and while they should be fixed
eventually, I've no plans on increasing the scope and complexity of
this series that is focused on solving real regressions caused by the
commit 9036bd0efcb6 ("PCI: Align head space better").

For those who haven't read the previous version intros (no changes
from v4 in this):

This series generalizes the resource placement algorithm. The commit
9036bd0efcb6 ("PCI: Align head space better") special cased one
composite resource remainder case to fix a regression (in a long chain
of regression fixes). Unfortunately, it introduced another regression
(or a few, to be more accurate).

Instead of building more special tricks, generalize the PCI resource
placement algorithm so it returns placement that gives better chances
for the greedy assignment algorithm to find suitable space for
subsequent assignments.

In short words, the new approach tries to find a placement for the
current resource that blocks as little of the free space range as
possible, considering both alignment and continuous free span of the
remaining free space.

In addition, the series corrects composite resource sizing to account
for gaps that have to be added due to alignment constraints and
remainder space not fully connecting (filling space all the way to
the bridge window align).

More detailed explanations in the patches themselves.

Unfortunately, this also causes yet another regression due to shuffling
resources around. I've left my quirk out of this version as it seems
the least likely approach to be used to resolve the issue. Some approach
should still be applied but that decision seems largely independent of
this series. The main part of the quirk discussion is here:

  https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen@linux.intel.com/

I find it likely that after this series the resources are packed tight
enough to solve also
  https://bugzilla.kernel.org/show_bug.cgi?id=220016
from more than a year back but that remains to be seen (if we can still
get the reporter to test it).


I planning on making another series to properly honor
pci=resource_alignment and improve locking as I realized the current
approach allows parameter change to race with the fitting and
assignment algorithm.

v5:
- Reordered series, "simple" patches first
- Added patch to skip resource with IORESOURCE_DISABLED
- Added patches to fix __ffs*() (__ffs64 & zero handling)
- Fix 2 more 1UL -> 1ULL, renamed roundup/down funcs to _u64
- Rework considering user/arch min align, always take it into
  account during placement if present (sashiko)
- Rename pci_init_pci_resreq_data() -> pci_init_resreq_data() and make
  it non-inline func
- Drop nested window fix (unnecessary and w/o complexity is less)
- Rename .user_align -> .min_align
- Use struct to store candidate selection parameters
- Rework candidate selection precedence
- Calculate odd-multiple starting "2 blocks resource" using both blocks
- Add a tie breaker to candidate selection using alignment of the left
  edge
- Do not use candidate logic if there's no full block or
  rr->min_align > align (the latter is due to pre-existing problems
  elsewhere).
- If no candidate is possible, return right edge of the empty res
  (not strictly necessary because one of the candidates is at res->start
   and the caller should use large enough align if user align is present
   but it doesn't hurt either)
- Refactor pbus_size_mem() to support the new gap calculation
- Reworked gap calculation entirely
- Added debug print to sizing function
- Fix many grammar errors / typos / consistency improvements

v4:
- Drop my own quirk patch (one approach should still be picked!)
- Use 1ULL to not lose bits in 32-bit case (sashiko)
- Copy avail flags from full_avail.flags (sashiko)
- Always return "resize" from pci_specified_resource_alignment() (sashiko)

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


Ilpo Järvinen (14):
  resource: Mark free space assigned
  parisc/PCI: Clean up resource debug print & use dynamic debug
  PCI: Don't size or assign disabled BARs
  PCI: Use __ffs64() for resource_size_t typed align
  PCI: Prevent zero align from reaching __ffs64()
  linux/log2.h: Add 64-bit roundup/down_pow_of_two_u64() variants
  PCI: Derive aligns[] array size in a define
  PCI: Honor alignment overrides
  PCI: Place resources to either edge of the window
  PCI: Separate align/raw size calculation from pbus_size_mem()
  PCI: Calculate bridge window with optional sizes from scratch
  PCI: Move size/align calculation fully into __pbus_size_mem()
  PCI: Fix composite resource sizing
  PCI: Add debug printing to window sizing

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
 drivers/pci/pci.c                |   4 +-
 drivers/pci/pci.h                |   6 +
 drivers/pci/setup-bus.c          | 263 ++++++++++++++++++++-----------
 drivers/pci/setup-res.c          | 246 ++++++++++++++++++++++++++---
 include/linux/log2.h             |  52 ++++++
 include/linux/pci.h              |  15 +-
 kernel/resource.c                |   3 +-
 19 files changed, 510 insertions(+), 151 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3


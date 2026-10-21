Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587009;
	b=M4Y0/JZgpdcb7ophnjpDtc2tOJP4LHuE7d19G0JCKQvCV2++IMtHtRyHhw0FQtrvlniw
	 p7/9kzW5IxlMWE3DCn1GYQHMhtihYPKtLaYGkSdVRjmKru23h8/u2ruM0caeRtibteQzD
	 r5BCCfuuoEDfQo/xWDeiWe42fP23/skYaIPK9O2ouVS8bLkEACDUEv8q44Hblrjlgzh7e
	 AjKys5TJwYS5grZVB+5OVH+adEcfL2ej2NvWHhXCExVdZ1mU9WBV+pPS3JfpZAdTapsJJ
	 Q6aT8W63wZ4VL8s34EvD2nqZ/reT4yD95noqSoYokahgY0M6za6/3+57rT80lKQzPyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587009;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gBb8uBAmMlkm/cdR9+bGhzgZKE+/jopoS+IA5oyimP8=;
	b=w8XTAgtCdskdp1EFbPUG2JwBKgAg2GUU3OqH1HLJXDn+8E4dxMXwRkwyRTyMFGOo+0H0
	 DnQV7n6gNAHHZlfnZVzLKUHgmpdwgUj76/SuvwZhZsOVOUw1Spe0szPDzeEz9fmNjjt6G
	 TUdf4RShCxpjpZJv0sBZx8e2tUCsKcUN8c64/SOXfTnVc7B3jGAtlwVE56CNAm+g/XYJG
	 Yr0MzK+3HE+n82NkaWZ6uwZbzatCgplX9NHKCcJLRUiQvPwdvoBVd4pHCWwGO+TA+mjhJ
	 HlohFEUqKpXRMvHPLMMeGrtEAV8yFrG9Br1+EqI6fFq6P4XPbFeiMKj5RhdmED384lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UtIE7IjY;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86286606A31B;
	Wed, 21 Oct 2026 12:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86286606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UtIE7IjY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587009; x=1824123009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ftYK8aqAiaMC6HFBzOvt2uB1COq6Xp9MrgY0PwqjlA=;
  b=UtIE7IjYDtgMuss3GpwlagqWj/6CcuRK53Z9QMHPHwBWg2/4fBXZxiqO
   L4n3cN4DHaZOKvnYQ7AsnnBunxZkKKhn9OlMsaLjWLLiiJSxQntGHIkrH
   6kzq8pmBFk7EbOfrQ17zU3woC0nHV884N5GbkjplgyMbzZmCo3jyehxkW
   xTBNKscsQkTgvgGZNl0aHAPC1u3fCUJi8TYZw3aP9kzeknpzdIUPfuCps
   QxcdZbXYXYVCVWYCOISUtq4yqYq7O3TXj5qLi6H89dYbA5RxB5jB7th/y
   /L5prtgsyLS6kTiWQkVYTQ/BFZJjIUVKWNM66zbBY9oUBm+2O8J7qXUWh
   Q==;
X-CSE-ConnectionGUID: CY0EBY6/TmuqDyIneTNw9w==
X-CSE-MsgGUID: Yi+UOVqNQg2u2VBRg+apcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1326056"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1326056"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:08 -0700
X-CSE-ConnectionGUID: indkkJ69S5Sg+8hG7kgK5Q==
X-CSE-MsgGUID: epAppy4hTamDIC713rLGMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3184009"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:03 -0700
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
Subject: [PATCH v4 0/7] PCI: Resource placement algorithm fixe
Date: Wed, 21 Oct 2026 15:49:45 +0300
Message-ID: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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

Hi,

v4 resolves a few sashiko findings. Also, the quirk I had in v3 is
not part of this as there are other approaches discussed in v3 thread
that seemed more preferred over the approach I had in v3.

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


I've another series coming up to improve pci=resource_alignment locking
as I realized the current approach allows parameter change to race with
the fitting and assignment algorithm.


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


Ilpo Järvinen (7):
  resource: Mark free space assigned
  PCI/parisc: Clean up resource debug print & use dynamic debug
  PCI: Honor alignment overrides
  PCI: Fix nesting windows with remainder at the left edge
  linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants
  PCI: Place resources to either edge of the window
  PCI: Fix composite resource sizing

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
 drivers/pci/pci.c                |   7 +-
 drivers/pci/pci.h                |   4 +
 drivers/pci/setup-bus.c          |  88 +++++++++++-
 drivers/pci/setup-res.c          | 223 +++++++++++++++++++++++++++----
 include/linux/log2.h             |  52 +++++++
 include/linux/pci.h              |  33 ++++-
 kernel/resource.c                |   3 +-
 19 files changed, 412 insertions(+), 70 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929183;
	b=N+GjzuZVhm7rmnGZYONEjOZ1Pbj7HpUWwJBGj0hQEDYjiop6hYemHBjF9YboiePFHMoA
	 moWIKTC00tRgcKLDZbRiEgsBg3/Mf+Su96GvzuIi5W87Q4hHMtD4FXCOAJlrmmiHmHyaW
	 1TzX7ui6d5gDgv//2H0QTD3QvoBXpJ9fNsqETZiXTt3Mha4TdpEI/IgCUhLwbJz3FDpxv
	 SNrL/YnTk1yw8peb9AkoeASk4mhFF2xpbcf8QBIMZnf+PClpmqDMwSQafKm12ZX9DUFhf
	 ZTwXp+qxWe1/y4LDeDUw4IAQ6awnVjSoRckbuVLh5rDzz0JZ7EUT+MVPSkZUn61Tgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=1oSyfEiyPa5M64GqTlwiK/kqrG7nKBY6UKFITE/cfaY=;
	b=v3QgMeYj02NBXDHKjeZEcbWg5wKkp11R/kQusuVc/WyB07FKep89xTPjUvXsN9OYG37v
	 N8BXVpiudcj3vMEX8UFESk2mAXxWnbxWmpv7Ix5AkIfsEFaIWEeNDa9Wtk8/SNfTED9Sp
	 cyjkypB+sFZwvDWlEpbeLv+UrhiDCVpiFQ2fHltxm+PZo0jydpIcC24u79nAyJyFHblBK
	 SsJqpfcKJfguVc9Rlo3kmNF+A2w2AgJVIEYLtj8NqUAmGVr/4dCDllYzKly+0G+rSr22e
	 c1eH9iwKEmLX1bnTP2mbXt3GzE9UyhGXZlKU8PXlhvrmtE9ITt6SmWqwdiQLacDfLlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZMnX38c;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60E606A32A;
	Tue, 17 Nov 2026 15:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D60E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZMnX38c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794929183; x=1826465183;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tv6b/UcDJMHTqGBRpknGolfH67hi3rtVQpx+9gC/OD0=;
  b=bZMnX38c6ICLPhZS7lzdzV4ytz+8nY4s3KZDPGOoLuSBnah6Y/2tmXgC
   84T+n1Uus7aRT7uuVRe2bvVc1h2seYF97UUh/YyppS5tz0ow73gJRXWSg
   O4cpOb2NhOjsMbSwsaiIYmYIBSjsLr1/bu+QlLb3KtnizhxC4WgUGtlta
   FDD1ha8/CpXK8NQ1uGi+PuOHoughcL5LCLfNRUX5TR5WJ06lw1cKmNMXI
   9v8eFnK67HkbqQeAE12P0R/OZpfjPwUALv/bPakn1fntLgBe1bea5ODlv
   aAqJ1y1wGWmqEQ2oviuMtmU5k/h9Rae2x/ENM2Fx6QmhEIORU/HfQZ1t0
   A==;
X-CSE-ConnectionGUID: MNwKZYh3SOW0ZjR0OUC0tw==
X-CSE-MsgGUID: iu5/3VI8TT+j7d3yvZ49AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3586329"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3586329"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:26:22 -0800
X-CSE-ConnectionGUID: UknR30TwSBWTqaFDoghmeg==
X-CSE-MsgGUID: DO5y2C1wTmG54ZlZZkqorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11800274"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.79])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:26:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Nov 2026 17:26:12 +0200 (EET)
To: Nikolas Joshua Britton <nbritton@exabit.io>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Mesih Kilinc <Mesih.Kilinc@sony.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <3c409ad1-f1b8-07bf-1ee5-bc5e57b49c1b@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1821310296-1794928013=:1563"
Content-ID: <34503efc-05c3-0142-039b-13f4531ab372@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1821310296-1794928013=:1563
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ff6fd057-236c-72e3-a3cb-7394b11a52e5@linux.intel.com>

Tag from the other thread:

Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>

On Fri, 6 Nov 2026, Ilpo J=E4rvinen wrote:

> V4 got quite many comments from sashiko, some of them were a bit
> sketchy (bogus scenarios such as IOV BARs on a bridge) but there was
> still good feedback hidden under the clearly flawed facade.
>=20
> There have been major changes so any retesting is appreciated (the
> 4 candidates patch is largely the same so I kept the Tested-by tags but
> everything around has been changing so even that is on the borderline
> when it comes to the validity of the existing tags).
>=20
> I ended up dropping the nested window fix which I had anyway realized
> would not be necessary with the current resource code. I had earlier
> planned to change the resource side code to only try start addresses
> that qualify to size+align requirements and had thus kept the nested
> win fix. But it just makes PCI side more complicated requiring extra
> tweaks and checks. With that patch dropped, pci_align_resource() can
> alone decide the placement making the code much simpler.
>=20
> Second major change is rewriting the gap calculation, which required
> including pbus_size_mem() refactoring that I was planning on doing
> anyway.
>=20
> As with v4, the quirk is not included and one approach should still
> be selected to solve the Genoa/Zen4 iomem blackhole but that's not
> likely the one I proposed within my series so I left it out.
>=20
> This series also does not attempt to address cases where user alignment
> override does not propagate to window size calculations and thus not
> into the align given to resource placement code (reported by sashiko).
> These are pre-existing issues and while they should be fixed
> eventually, I've no plans on increasing the scope and complexity of
> this series that is focused on solving real regressions caused by the
> commit 9036bd0efcb6 ("PCI: Align head space better").
>=20
> For those who haven't read the previous version intros (no changes
> from v4 in this):
>=20
> This series generalizes the resource placement algorithm. The commit
> 9036bd0efcb6 ("PCI: Align head space better") special cased one
> composite resource remainder case to fix a regression (in a long chain
> of regression fixes). Unfortunately, it introduced another regression
> (or a few, to be more accurate).
>=20
> Instead of building more special tricks, generalize the PCI resource
> placement algorithm so it returns placement that gives better chances
> for the greedy assignment algorithm to find suitable space for
> subsequent assignments.
>=20
> In short words, the new approach tries to find a placement for the
> current resource that blocks as little of the free space range as
> possible, considering both alignment and continuous free span of the
> remaining free space.
>=20
> In addition, the series corrects composite resource sizing to account
> for gaps that have to be added due to alignment constraints and
> remainder space not fully connecting (filling space all the way to
> the bridge window align).
>=20
> More detailed explanations in the patches themselves.
>=20
> Unfortunately, this also causes yet another regression due to shuffling
> resources around. I've left my quirk out of this version as it seems
> the least likely approach to be used to resolve the issue. Some approach
> should still be applied but that decision seems largely independent of
> this series. The main part of the quirk discussion is here:
>=20
>   https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen@l=
inux.intel.com/
>=20
> I find it likely that after this series the resources are packed tight
> enough to solve also
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D220016
> from more than a year back but that remains to be seen (if we can still
> get the reporter to test it).
>=20
>=20
> I planning on making another series to properly honor
> pci=3Dresource_alignment and improve locking as I realized the current
> approach allows parameter change to race with the fitting and
> assignment algorithm.
>=20
> v5:
> - Reordered series, "simple" patches first
> - Added patch to skip resource with IORESOURCE_DISABLED
> - Added patches to fix __ffs*() (__ffs64 & zero handling)
> - Fix 2 more 1UL -> 1ULL, renamed roundup/down funcs to _u64
> - Rework considering user/arch min align, always take it into
>   account during placement if present (sashiko)
> - Rename pci_init_pci_resreq_data() -> pci_init_resreq_data() and make
>   it non-inline func
> - Drop nested window fix (unnecessary and w/o complexity is less)
> - Rename .user_align -> .min_align
> - Use struct to store candidate selection parameters
> - Rework candidate selection precedence
> - Calculate odd-multiple starting "2 blocks resource" using both blocks
> - Add a tie breaker to candidate selection using alignment of the left
>   edge
> - Do not use candidate logic if there's no full block or
>   rr->min_align > align (the latter is due to pre-existing problems
>   elsewhere).
> - If no candidate is possible, return right edge of the empty res
>   (not strictly necessary because one of the candidates is at res->start
>    and the caller should use large enough align if user align is present
>    but it doesn't hurt either)
> - Refactor pbus_size_mem() to support the new gap calculation
> - Reworked gap calculation entirely
> - Added debug print to sizing function
> - Fix many grammar errors / typos / consistency improvements
>=20
> v4:
> - Drop my own quirk patch (one approach should still be picked!)
> - Use 1ULL to not lose bits in 32-bit case (sashiko)
> - Copy avail flags from full_avail.flags (sashiko)
> - Always return "resize" from pci_specified_resource_alignment() (sashiko=
)
>=20
> v3:
> - Add roundup/down_pow_of_two64() (new patch) to avoid problems if
>   resource_size_t is 64-bit and unsigned long is 32-bit + use __ffs64()
>   (multiple potential issues mentioned by sashiko)
> - Do not print res->parent in parisc debug code as the resource is never
>   in the resource tree (found by sashiko).
> - Do not override user-alignment with the remainder moves (sashiko)
> - Consider optional sizes properly when sizing bridge window gaps (sashik=
o)
> - Move genoa quirk under arch/x86/
> - Rename quirk's static resource variable
>=20
> v2:
> - Add patch to cleanup parisc debug print (do dyndbg conversion)
> - Add patch to prevent remainder tricks when alignment override is used
>   (found by sashiko)
> - Do not use PCIBIOS_MIN_IO/MEM but 1U as min align. The former seem
>   address space lower bounds even if parisc arch code misleadingly
>   uses them for ALIGN() call.
> - Fix res->end + 1 overflow case (found by sashiko)
> - Tweak debug print formatting
> - Reworked the iomem black hole quirk (now based on the bridge)
>=20
>=20
> Ilpo J=E4rvinen (14):
>   resource: Mark free space assigned
>   parisc/PCI: Clean up resource debug print & use dynamic debug
>   PCI: Don't size or assign disabled BARs
>   PCI: Use __ffs64() for resource_size_t typed align
>   PCI: Prevent zero align from reaching __ffs64()
>   linux/log2.h: Add 64-bit roundup/down_pow_of_two_u64() variants
>   PCI: Derive aligns[] array size in a define
>   PCI: Honor alignment overrides
>   PCI: Place resources to either edge of the window
>   PCI: Separate align/raw size calculation from pbus_size_mem()
>   PCI: Calculate bridge window with optional sizes from scratch
>   PCI: Move size/align calculation fully into __pbus_size_mem()
>   PCI: Fix composite resource sizing
>   PCI: Add debug printing to window sizing
>=20
>  arch/alpha/kernel/pci.c          |   3 +-
>  arch/arm/kernel/bios32.c         |   5 +-
>  arch/m68k/kernel/pcibios.c       |   4 +-
>  arch/mips/pci/pci-generic.c      |   5 +-
>  arch/mips/pci/pci-legacy.c       |   5 +-
>  arch/parisc/kernel/pci.c         |  20 +--
>  arch/powerpc/kernel/pci-common.c |   5 +-
>  arch/sh/drivers/pci/pci.c        |   5 +-
>  arch/x86/pci/i386.c              |   5 +-
>  arch/xtensa/kernel/pci.c         |   5 +-
>  drivers/char/agp/intel-gtt.c     |   5 +-
>  drivers/gpu/drm/i915/i915_gmch.c |   5 +-
>  drivers/pci/pci.c                |   4 +-
>  drivers/pci/pci.h                |   6 +
>  drivers/pci/setup-bus.c          | 263 ++++++++++++++++++++-----------
>  drivers/pci/setup-res.c          | 246 ++++++++++++++++++++++++++---
>  include/linux/log2.h             |  52 ++++++
>  include/linux/pci.h              |  15 +-
>  kernel/resource.c                |   3 +-
>  19 files changed, 510 insertions(+), 151 deletions(-)
>=20
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>=20

--=20
 i.
--8323328-1821310296-1794928013=:1563--

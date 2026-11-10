Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304064;
	b=bqbo+IFlE1oXUbKv1ADy4pZ/Ao945CEX9lCMZqobQDELDOsZrPNJhkr0kAlkX+2hzrI2
	 o6SibnA59+vyVHCvHHrEbyXwFVvVPxWjB7SP3zRvTeEilmDlmJ5Zn1iQSOyLkwYfRyvI/
	 Z+Kl1IhRZLDF6EAxGmpshLFCqCNRsmwJZvb0GwYSA9i5pi1qRTD4/YIhn8LjDswNSwqLh
	 ESOjVxIJAQaCS7+4dz2M/jcVBSkaBn+XcIHW8k3eyjur01B02OzGVVS/t5BrNw99zqzeT
	 EmLgt6qA5mV/0Ed7rUkwnMFu7GnVq5Ymtf8Ud3aRdi3y89+eG/pwwV8uBkhASYN28RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304064;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=FgmOhvpj0UHALAwf/FSnZ1VypVdHTz+uahT3fItghJ0=;
	b=kiMHGW45Uql0lvZcWN0lVC++vaPMoTs732taVwmHECTiy9uoq/sBd9qlH6ZXus7fN3N+
	 LiOWQUafjzLDB39o2atZmw67lfH7ojexIUaAeWvciiDqWnK+7GXo7tufw9zKZN0iKYMpk
	 FXo7pbRQXqCg596Nx86lGQ4Wnzd6FZBuF2Nl3hlEi4Gz93N5gc/C29TKw6c0Uv5LSDjXp
	 dMyOYn4rIs9hJls+E7rK45buTVVZ9Q/JhErMkCK3nTuFkOvhur1L9YtO+pkheT+ANcKmr
	 c5eFCWPXav059c8iYVR+NS9b8IAciIMcXgd7lVNqT/ToP1HlkbALvYHr8C0/rdOwgTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kB9lmlYL;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24B606A321;
	Tue, 10 Nov 2026 09:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D24B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kB9lmlYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304064; x=1825840064;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=OVfmjWMH24D4U+PSNU47zUyKVGJ05wpU+p2k88nmQRY=;
  b=kB9lmlYLiFYWkyxHUMBxwNVtgF4M/7aMDWX3LvImaUYYTMF2icCcSeQu
   eKSbMtQAEBEUSj7nS27BZXbLdfIvHYRrkn/okdlPhsGACmOVEOh7y4ZLC
   sPVDssCUb7mmpO1xV5faSVpuGi9/VA5wOgF0IiV8SMCMnkPDpnY0pincM
   1Q1SvC13HAjEy0rB8YWVUp0aGc2+t50EhKbNTFGpJTIyKF08gW19dtvHx
   zKr1HAsEnN1g69fm0e+Cu0LHbs15H/HQ4Povx745Ln4HupnGkAKABMoRl
   iW6eklwBucLdWjZn/uQ50ftR0vrrMwZyW4cHrb421JNh9D0OoHYNgj6Aj
   A==;
X-CSE-ConnectionGUID: v/DjCc18TKyFUl2w3UqxmA==
X-CSE-MsgGUID: sFwxOVmESr+eyUDAVqd35w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3070493"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3070493"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:47:42 -0800
X-CSE-ConnectionGUID: q1OoFYy0RgqHmTIWoJNHzQ==
X-CSE-MsgGUID: cjZid9CeSymZ/+EWOIjEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8439692"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:47:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Nov 2026 11:47:34 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello <superm1@kernel.org>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Mesih Kilinc <Mesih.Kilinc@sony.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
In-Reply-To: <20261109232700.GA345907@bhelgaas>
Message-ID: <f37d6958-086b-0006-8fbc-c4c15369b796@linux.intel.com>
References: <20261109232700.GA345907@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-172469154-1794303066=:1229"
Content-ID: <43d7fb74-215b-7c14-d9e6-6de1516de7e0@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-172469154-1794303066=:1229
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <29aba17c-1458-12f7-58b5-0355de5d5021@linux.intel.com>

On Mon, 9 Nov 2026, Bjorn Helgaas wrote:

> On Fri, Nov 06, 2026 at 03:43:21PM +0200, Ilpo J=E4rvinen wrote:
> > V4 got quite many comments from sashiko, some of them were a bit
> > sketchy (bogus scenarios such as IOV BARs on a bridge) but there was
> > still good feedback hidden under the clearly flawed facade.
> >=20
> > There have been major changes so any retesting is appreciated (the
> > 4 candidates patch is largely the same so I kept the Tested-by tags but
> > everything around has been changing so even that is on the borderline
> > when it comes to the validity of the existing tags).
> >=20
> > I ended up dropping the nested window fix which I had anyway realized
> > would not be necessary with the current resource code. I had earlier
> > planned to change the resource side code to only try start addresses
> > that qualify to size+align requirements and had thus kept the nested
> > win fix. But it just makes PCI side more complicated requiring extra
> > tweaks and checks. With that patch dropped, pci_align_resource() can
> > alone decide the placement making the code much simpler.
> >=20
> > Second major change is rewriting the gap calculation, which required
> > including pbus_size_mem() refactoring that I was planning on doing
> > anyway.
> >=20
> > As with v4, the quirk is not included and one approach should still
> > be selected to solve the Genoa/Zen4 iomem blackhole but that's not
> > likely the one I proposed within my series so I left it out.
> >=20
> > This series also does not attempt to address cases where user alignment
> > override does not propagate to window size calculations and thus not
> > into the align given to resource placement code (reported by sashiko).
> > These are pre-existing issues and while they should be fixed
> > eventually, I've no plans on increasing the scope and complexity of
> > this series that is focused on solving real regressions caused by the
> > commit 9036bd0efcb6 ("PCI: Align head space better").
> >=20
> > For those who haven't read the previous version intros (no changes
> > from v4 in this):
> >=20
> > This series generalizes the resource placement algorithm. The commit
> > 9036bd0efcb6 ("PCI: Align head space better") special cased one
> > composite resource remainder case to fix a regression (in a long chain
> > of regression fixes). Unfortunately, it introduced another regression
> > (or a few, to be more accurate).
> >=20
> > Instead of building more special tricks, generalize the PCI resource
> > placement algorithm so it returns placement that gives better chances
> > for the greedy assignment algorithm to find suitable space for
> > subsequent assignments.
> >=20
> > In short words, the new approach tries to find a placement for the
> > current resource that blocks as little of the free space range as
> > possible, considering both alignment and continuous free span of the
> > remaining free space.
> >=20
> > In addition, the series corrects composite resource sizing to account
> > for gaps that have to be added due to alignment constraints and
> > remainder space not fully connecting (filling space all the way to
> > the bridge window align).
> >=20
> > More detailed explanations in the patches themselves.
> >=20
> > Unfortunately, this also causes yet another regression due to shuffling
> > resources around. I've left my quirk out of this version as it seems
> > the least likely approach to be used to resolve the issue. Some approac=
h
> > should still be applied but that decision seems largely independent of
> > this series. The main part of the quirk discussion is here:
> >=20
> >   https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen=
@linux.intel.com/
> >=20
> > I find it likely that after this series the resources are packed tight
> > enough to solve also
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D220016
> > from more than a year back but that remains to be seen (if we can still
> > get the reporter to test it).
> >=20
> >=20
> > I planning on making another series to properly honor
> > pci=3Dresource_alignment and improve locking as I realized the current
> > approach allows parameter change to race with the fitting and
> > assignment algorithm.
> >=20
> > v5:
> > - Reordered series, "simple" patches first
> > - Added patch to skip resource with IORESOURCE_DISABLED
> > - Added patches to fix __ffs*() (__ffs64 & zero handling)
> > - Fix 2 more 1UL -> 1ULL, renamed roundup/down funcs to _u64
> > - Rework considering user/arch min align, always take it into
> >   account during placement if present (sashiko)
> > - Rename pci_init_pci_resreq_data() -> pci_init_resreq_data() and make
> >   it non-inline func
> > - Drop nested window fix (unnecessary and w/o complexity is less)
> > - Rename .user_align -> .min_align
> > - Use struct to store candidate selection parameters
> > - Rework candidate selection precedence
> > - Calculate odd-multiple starting "2 blocks resource" using both blocks
> > - Add a tie breaker to candidate selection using alignment of the left
> >   edge
> > - Do not use candidate logic if there's no full block or
> >   rr->min_align > align (the latter is due to pre-existing problems
> >   elsewhere).
> > - If no candidate is possible, return right edge of the empty res
> >   (not strictly necessary because one of the candidates is at res->star=
t
> >    and the caller should use large enough align if user align is presen=
t
> >    but it doesn't hurt either)
> > - Refactor pbus_size_mem() to support the new gap calculation
> > - Reworked gap calculation entirely
> > - Added debug print to sizing function
> > - Fix many grammar errors / typos / consistency improvements
> >=20
> > v4:
> > - Drop my own quirk patch (one approach should still be picked!)
> > - Use 1ULL to not lose bits in 32-bit case (sashiko)
> > - Copy avail flags from full_avail.flags (sashiko)
> > - Always return "resize" from pci_specified_resource_alignment() (sashi=
ko)
> >=20
> > v3:
> > - Add roundup/down_pow_of_two64() (new patch) to avoid problems if
> >   resource_size_t is 64-bit and unsigned long is 32-bit + use __ffs64()
> >   (multiple potential issues mentioned by sashiko)
> > - Do not print res->parent in parisc debug code as the resource is neve=
r
> >   in the resource tree (found by sashiko).
> > - Do not override user-alignment with the remainder moves (sashiko)
> > - Consider optional sizes properly when sizing bridge window gaps (sash=
iko)
> > - Move genoa quirk under arch/x86/
> > - Rename quirk's static resource variable
> >=20
> > v2:
> > - Add patch to cleanup parisc debug print (do dyndbg conversion)
> > - Add patch to prevent remainder tricks when alignment override is used
> >   (found by sashiko)
> > - Do not use PCIBIOS_MIN_IO/MEM but 1U as min align. The former seem
> >   address space lower bounds even if parisc arch code misleadingly
> >   uses them for ALIGN() call.
> > - Fix res->end + 1 overflow case (found by sashiko)
> > - Tweak debug print formatting
> > - Reworked the iomem black hole quirk (now based on the bridge)
> >=20
> >=20
> > Ilpo J=E4rvinen (14):
> >   resource: Mark free space assigned
> >   parisc/PCI: Clean up resource debug print & use dynamic debug
> >   PCI: Don't size or assign disabled BARs
> >   PCI: Use __ffs64() for resource_size_t typed align
> >   PCI: Prevent zero align from reaching __ffs64()
> >   linux/log2.h: Add 64-bit roundup/down_pow_of_two_u64() variants
> >   PCI: Derive aligns[] array size in a define
> >   PCI: Honor alignment overrides
> >   PCI: Place resources to either edge of the window
> >   PCI: Separate align/raw size calculation from pbus_size_mem()
> >   PCI: Calculate bridge window with optional sizes from scratch
> >   PCI: Move size/align calculation fully into __pbus_size_mem()
> >   PCI: Fix composite resource sizing
> >   PCI: Add debug printing to window sizing
>=20
> It looks like the early ones are straightforward and good-to-go.  How
> many could we just apply in order to get them out of the way?
> I'm guessing at least the first six (up to and including "PCI: Derive
> aligns[] array size in a define")?

Those should as safe as it gets.

The honor user alignment request change would be safe as well when it=20
comes to not yet hitting the regression territory but since I've not=20
tested intermediate configurations that extensively I'd keep it either-or=
=20
for the rest.

> You mentioned "this also causes yet another regression" so I assume
> there's something we're not quite ready to merge yet?  I'd like to get
> the rest in linux-next as soon as we can.

The regression is the same genoa iomem blackhole we discussed in the v3=20
thread:

https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen@linux=
=2Eintel.com
/

There were multiple possible possible ways to quirk this and it comes down=
=20
to which one you (Bjorn) prefer. I just left my quirk patch out of these=20
v4 and v5 series because it seemed the least likely to be the one taken.

If you want me to test a specific quirk approach on the affected system,=20
just let me know. I already did test reverting your change that freed the=
=20
e820 reserved regions for iomem use and that did prevent the regression.


(I now seem to realize I forgot to include Mario while sending v5. I've=20
added him to this now.)

Mario was willing to pursue contacting the reporters of the earlier=20
problems with a pre-prepared branch to test to see if my placement series=
=20
could resolve the issues reported (earlier). Depending the results of that=
=20
test, we might have yet another way to quirk it.

Mario,

There were quite many changes in v5 so I'd prefer the test branch using=20
v5.

--=20
 i.
--8323328-172469154-1794303066=:1229--

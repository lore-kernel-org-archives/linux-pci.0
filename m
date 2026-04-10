Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF93BE166
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822995; cv=none; b=dhIY0jtsQ8ywj1rnpltVOzYBwzORCpNZ16Igur7RNl9xLNqs9udROgbPl+t8LhFiNpWIWhGSlIMlyKyGj6WeUGCdiiZyJtuiIz4WkSvMT0jBAUXQdvDCrN0TU2U0w1OBVPuRYc6NmwLSXkp/yUrE1nxPy/yWtpd/dU0DjnE4qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822995; c=relaxed/simple;
	bh=9gCMdefJXz10+y5IWju912g21V9zEtlju+DcX5zheO8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KlCjJv6LL3TuDus+GaNLeFcF5Z/XmYwNCp9J42zGN8kKK61kaDyLigXJ1OR29YhtKAo6ja/iD6i92kedD/MZ7+Y+rwBH9earmr3jJtj5A/q22+q1O3C/L87h6dsdXLc4KxZbkrBbC9JcDWy8v8ZBuc+SM/b7oWSnn+1q5JSyR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeSKNv4E; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeSKNv4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775822992; x=1807358992;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9gCMdefJXz10+y5IWju912g21V9zEtlju+DcX5zheO8=;
  b=eeSKNv4EIKCjYrJG+QkXlexRWGqhZ07do5qRz24HvQNRyYIQJ+CndRuW
   46XlKSqH2tbau8nxQ5lXZNGS5e/qyUdWsXikrFMICGz3hmTnD/Vmq1XQr
   PHsNOkm+3lK37VQFNK60re2w9u5KE3NZ22xlTwS3+VYll8ic9Tusk6SQW
   3AsWQHQH9sKgyqz2/jbP1yWkR/max0yygP8Hq33T9SQl/fzCb/SB0CdIM
   rZ67szJCVAuu2lVnieCR3KILBK1spkn2sqKQJ1zrJ0qBAKL53sWFMzPhd
   r/3d3LhEeefS59qY1qIPm8MK2n7QpQdzBQvFPqda48X6Tz25PhLBsGGvO
   w==;
X-CSE-ConnectionGUID: yyhdc48pTyS5dFQ8IipLhg==
X-CSE-MsgGUID: ijhtGjdkRtyefcV6iY23Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76747952"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76747952"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 05:09:51 -0700
X-CSE-ConnectionGUID: vxTcZqAaR6GbHXDjoziMog==
X-CSE-MsgGUID: v7ryE5wCT3GrM/om/lza4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="230796578"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 05:09:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 15:09:44 +0300 (EEST)
To: =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <7bcf3ae7-14b4-4300-9e62-579bc2546032@app.fastmail.com>
Message-ID: <55b06aeb-f29a-065f-c8fb-e2ba1116ee7a@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info> <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com> <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com> <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com> <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com> <6be0aaae-2ade-46cb-b7fc-f03cee21d260@app.fastmail.com> <19d6f7e4-25e1-c5a4-fa42-73bbba4741ab@linux.intel.com>
 <7bcf3ae7-14b4-4300-9e62-579bc2546032@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1185673444-1775822189=:1195"
Content-ID: <3b19e377-c038-282a-231a-c529798d245b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1185673444-1775822189=:1195
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <47357136-b029-6c94-9f8b-18ce86c90cc1@linux.intel.com>

On Fri, 10 Apr 2026, Jonas H=F6glund wrote:
> On Wed, 8 Apr 2026, at 10:43, Ilpo J=E4rvinen wrote:
> > On Wed, 8 Apr 2026, Jonas H=F6glund wrote:
> >>=20
> >> Sorry, I'm slightly unsure what I should be building and testing here.
> >> Is it fine to check out the pci/resource branch as it is and test that=
,
> >> or should I make sure to pick the patches from that branch atop e.g.
> >> 7.0-rc6?
> >
> > The latter is better because pci/resources is based at 7.0-rc1 and sinc=
e=20
> > then, there have been two fixes that went through -rc series (I'm not s=
ure=20
> > if either is relevant for your usecase, probably not but to be on safe=
=20
> > side it's better to include them as well).
> >
> > BUT, it's easier to just merge pci/resource on top of -rc6 so you don't=
=20
> > need to pick the patches by hand). I think the merge should go cleanly.
> >
>=20
> Hi,
>=20
> I built 7.0-rc7 with these commits from pci/resource rebased atop it:
>=20
>   8cb08166 (pci/resource) PCI: Fix alignment calculation for resource siz=
e larger than align
>   9036bd0e PCI: Align head space better
>   8bbe8cec PCI: Rename window_alignment() to pci_min_window_alignment()
>   38ec53e1 parisc/PCI: Clean up align handling
>   3fa40d30 MIPS: PCI: Remove unnecessary second application of align
>   4dd6e1aa m68k/PCI: Remove unnecessary second application of align
>   0734cb24 ARM/PCI: Remove unnecessary second application of align
>   66475b5d resource: Rename 'tmp' variable to 'full_avail'
>   f699bcc8 resource: Pass full extent of empty space to resource_alignf c=
allback
>   edfaa81d resource: Add __resource_contains_unbound() for internal conta=
ins checks
>   1ee4716a PCI: Fix premature removal from realloc_head list during resou=
rce assignment
>   dc4b4d04 PCI: Prevent shrinking bridge window from its required size
>   92427ab4 PCI: Prevent assignment to unsupported bridge windows
>=20
> Here's the dmesg and iomem map:
>   https://up.firefly.nu/pub/amdgpu-egpu-7.0.0-rc7-pci-resource.dmesg.txt
>   https://up.firefly.nu/pub/amdgpu-egpu-7.0.0-rc7-pci-resource.iomem.txt
>=20
> The thunderbolt dock is connected at the 52-second mark, and "works" as
> well as before (external GPU and monitors are functional from a user
> perspective).  Looks to me like something is still up with the bridge
> window/BAR handling... but I wouldn't know how much of that is down to
> the pci subsystem vs how amdgpu uses it.

Thanks for testing. The pre-existing fixes in pci/resource seem to resolve=
=20
the regressions.

The remaining problems is bridge window that is pinned by sibling devices:

  6030000000-6051ffffff : PCI Bus 0000:3a
    6030000000-60501fffff : PCI Bus 0000:3b
      6030000000-60401fffff : PCI Bus 0000:3c
        6030000000-60401fffff : PCI Bus 0000:3d
          6030000000-60401fffff : PCI Bus 0000:3e
            6030000000-603fffffff : 0000:3e:00.0
            6040000000-60401fffff : 0000:3e:00.0
      6040200000-60480fffff : PCI Bus 0000:58

[   60.147972] amdgpu 0000:3e:00.0: BAR 0 [mem 0x6030000000-0x603fffffff 64=
bit pref]: releasing
[   60.147978] amdgpu 0000:3e:00.0: BAR 2 [mem 0x6040000000-0x60401fffff 64=
bit pref]: releasing
[   60.147982] pcieport 0000:3d:00.0: bridge window [mem 0x6030000000-0x604=
01fffff 64bit pref]: releasing
[   60.147985] pcieport 0000:3c:00.0: bridge window [mem 0x6030000000-0x604=
01fffff 64bit pref]: releasing
[   60.147988] pcieport 0000:3b:01.0: bridge window [mem 0x6030000000-0x604=
01fffff 64bit pref]: releasing
[   60.147991] pcieport 0000:3a:00.0: bridge window [mem 0x6030000000-0x605=
01fffff 64bit pref]: was not released (still contains assigned resources)
[   60.147994] pcieport 0000:00:07.2: bridge window [mem 0x6030000000-0x605=
1ffffff 64bit pref]: was not released (still contains assigned resources)
[   60.148003] pcieport 0000:3b:02.0: disabling bridge window [mem 0x000000=
00-0x000fffff 64bit pref disabled] to [bus 57] (unused)

The bridge window at 6040200000-60480fffff pins 6030000000-60501fffff in=20
place. The resize for 0000:3e:00.0's BAR currently only releases=20
0000:3e:00.0's resources and those upstream bridge windows that do not=20
have other children.

The sibling bridge window that causes the pinning seems entirely empty as=
=20
is highlighted by the last log line (but itis  noticed in a too late stage=
=20
to help with the problem). It would be possible to release the pinning=20
sibling and then perform resize through sysfs manually but...

=2E..There are currently (at least) three recent reports which have this=20
same problem, and one of the reporters started preparing a patch for it:

https://lore.kernel.org/linux-pci/29a5ee31baf8be7d07617beea016c3f6d03934bf.=
camel@ieee.org/T/#m114098e75df55a4ac5a3e9e0c6e948b12ce81ecd

So hopefully we soon have a kernel solution for it without requiring=20
manual intervention through sysfs.


--=20
 i.
--8323328-1185673444-1775822189=:1195--

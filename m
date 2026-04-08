Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926F39F192
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645020; cv=none; b=btsWZqWRmai9dO+GlBtuvW6JL5XI9sZBP+qmvC5m++zxrTpsohLYgd9gWQUIv1NAyuo3x06EmCcKlghp5CrdiwT+xS+tlQbawnuge3M8YInRZxXad29hd1aY8+reEsNnPRJ5M0jayNxZzwfnvf4xofTcNkQz3N9BaBZFpCgO84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645020; c=relaxed/simple;
	bh=JaHOzzzOd9hgdKvBjSdciCtQk405rot7Jd3muc1fkQs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MtfLIYXgAgdem2oGoM6hAMeKiYdvz72wwhsA524FO8FIjCvszeldTKAbeVamW77aL+l3ZjE+zrjtot+o/iJIIQwTEz/nnkxTpKUINfUcpGays4sQ+wMdae8eic0edFussMxbAhpo5gYXzhpKXoUBWiEluQoXxuuT6tZbItZ4k9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIAI5RKU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIAI5RKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775645019; x=1807181019;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JaHOzzzOd9hgdKvBjSdciCtQk405rot7Jd3muc1fkQs=;
  b=lIAI5RKUyGaNObfHDYzEvJVckU60CjtYt/6R3a6nQFZPOKcwCND0byME
   Vb/bHMt2xHkwJGEifZNTuIp3TlTbxQ1AABbnGeWUebVL0Re+0Zxjzp1BA
   tphdmpSRWmn2uCKwZ3GxSRMjRZaQ4r5/jMb2eVnQKgXFE0edYp+3T/UPR
   to0Rkq5lU+Ga5agSfLnG5KT0KqeMfgn9lpNRCe0UFGFZrWAWzz+HBfyEo
   N2+IKLvNLyqksyTIJxEvN56YkP2zIos1JEyofeIqnfkVkRjadUOQG8WAz
   tWN1tr+qBzmX+cYYbvfOHFsannCoce27yG7gVpHjZ7VZdLgU2zPeSCBOQ
   A==;
X-CSE-ConnectionGUID: RIowYozmQd+AaO+AO6UsBQ==
X-CSE-MsgGUID: UH1WEGvuSn6i4FOEUTualg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76587775"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76587775"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:43:39 -0700
X-CSE-ConnectionGUID: GOYYf7YkRSKfvJ1P7UY9lQ==
X-CSE-MsgGUID: dpxUq6DLR8K3+F083YojsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="224142569"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:43:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Apr 2026 13:43:33 +0300 (EEST)
To: =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <6be0aaae-2ade-46cb-b7fc-f03cee21d260@app.fastmail.com>
Message-ID: <19d6f7e4-25e1-c5a4-fa42-73bbba4741ab@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info> <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com> <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com> <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com> <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com> <6be0aaae-2ade-46cb-b7fc-f03cee21d260@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1727003339-1775645013=:971"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1727003339-1775645013=:971
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Apr 2026, Jonas H=C3=B6glund wrote:
> On Tue, 7 Apr 2026, at 07:26, Ilpo J=C3=A4rvinen wrote:
> >>=20
> >> Here are dmesg logs (with the appropriate dyndbg cmdline flag) for bot=
h
> >> cases, in case it's useful:
> >>=20
> >> https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
> >> https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt
> >>=20
> >>=20
> >> That's good enough on my end, knowing the issue is addressed already
> >> upstream and slated for 7.1.  I'm happy to test anything else if it'd
> >> be useful (for eventual backports or so), but otherwise I think I'll
> >> just pick thoes patches from the pci/resource tree for now.
> >
> > Hi,
> >
> > Thanks. It certainly looks the commit dc4b4d04e1ca ("PCI: Prevent=20
> > shrinking bridge window from its required size") I referred to above mi=
ght=20
> > indeed help here (For Thorsten's convinience: as mentioned above, it is=
=20
> > currently in the pci/resource branch slated for 7.1).
> >
> > With the extra debug enabled, "shrunken by" lines appear in the log whi=
ch=20
> > indicates the hotplug memory distribution algorithm goes to mess with t=
he=20
> > calculated bridge window sizes in between resource sizing and resource=
=20
> > assignment and my fix aims to prevent that from happening.
> >
>=20
> Sorry, I'm slightly unsure what I should be building and testing here.
> Is it fine to check out the pci/resource branch as it is and test that,
> or should I make sure to pick the patches from that branch atop e.g.
> 7.0-rc6?

The latter is better because pci/resources is based at 7.0-rc1 and since=20
then, there have been two fixes that went through -rc series (I'm not sure=
=20
if either is relevant for your usecase, probably not but to be on safe=20
side it's better to include them as well).

BUT, it's easier to just merge pci/resource on top of -rc6 so you don't=20
need to pick the patches by hand). I think the merge should go cleanly.

> > If that fix does not help or does not fully solve the issue, please do=
=20
> > take a new log with that patch included into the kernel (preferrably wi=
th=20
> > all the fixes that are currently in the pci/resource branch so we don't=
=20
> > hit yet another issue that already has a fix). If you need to take more=
=20
> > logs, please include also /proc/iomem dump (as figuring the iomem layou=
t=20
> > from dmesg is pretty tedious and error prone).
> >
>=20
> Will include /pro/iomem with future dumps.
>=20
>=20
> > Also if you see this line, it's worth to posting the log (even if thing=
s=20
> > would appear as working):
> >
> > amdgpu 0000:3e:00.0: Not enough PCI address space for a large BAR.
> >
> > ...I'll see if I can somehow improve that as well (not a guarantee but=
=20
> > it's still worth taking a look, it appears also in the case you labeled=
=20
> > "good").
> >
>=20
> Ok. Yeah, "good" was a bit of a misnomer, was simply meant as short for
> "docks successfully" (as far as the visual feedback as a user goes).
>=20
>=20
> I'll get to building and testing after confirmation what I should build.
>=20
> Thanks,
> Jonas
>=20

--=20
 i.

--8323328-1727003339-1775645013=:971--

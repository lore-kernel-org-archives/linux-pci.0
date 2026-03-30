Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C982FFDE3
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881210; cv=none; b=NBn/7U8lVIUeMWqp8d+BRdrm6758yPBSS6iw4+UVzofmIU6oifFBFM24kSFM5cQcha8kKMq3GAQfPvbly8Lg6Px329JSzj76REjprHsQnOSlYfsxMqm0dTvo0ilCM343nkaXa8//zehxFNHl2rcHXyLb3oB1171U8z2jeHrECZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881210; c=relaxed/simple;
	bh=EJDYmWiip0C6AEVDsb5lFb2OSfd3udanPdD09BGg9OM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hx+R95BgaHqJtMp6aDAM91UuTe6K/xpwB949ehXpQafMBBKr+7pfxzAuT+0Iuy9EOZQP9m26mG0dSc2BOYvkcajXitl4NU9dYVit8xPukt4ob1mHNQT45pv828/j6uvDfpEmcWcFTj1cL+DBqZAhhbMKFHrFc0FR1UCqJRofHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3goL3e8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3goL3e8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774881208; x=1806417208;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EJDYmWiip0C6AEVDsb5lFb2OSfd3udanPdD09BGg9OM=;
  b=H3goL3e8L36cWIw0dyMOEZnQ1Jrj2YHAseG5zofK+ZdKpklVJYQEHL/a
   IgYaL2fFdOvSu9vBSiQt4AE6CTeDAQ5krz5URahSAQWToIIzeJ/iikkJh
   xdnynHdT4IJMZVjs0Bml9ZzxH6D7BeTvB6ECJ4TR5GhPRaCrXk5ZjFFhS
   ojPW98lH4GllQwleW/Dd7grn09Up5OYH+y/ZdMT/aRNMlDYX//no34yqM
   Z1YT1mMhxrvB1IYdZvGgVAwuOdWwEtShuaZtp/HnH6aBa7Fj88ROTu/31
   MIMVvCoa1wj+uK5M3oSyT3Hke8ig0/BTik/KcMkTrO8VEF+iVAjVD4E5C
   A==;
X-CSE-ConnectionGUID: 7gJwlJ6BSH6sHpZWGiEHtQ==
X-CSE-MsgGUID: gGgxun8ZSBOvVggh0LUs1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98484571"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98484571"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 07:33:28 -0700
X-CSE-ConnectionGUID: 7qoeVi9PQoW8qSXwvdWASg==
X-CSE-MsgGUID: fOnn8wntQzCdPBfZuXKwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226326602"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 07:33:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Mar 2026 17:33:22 +0300 (EEST)
To: Thorsten Leemhuis <regressions@leemhuis.info>, 
    =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
Message-ID: <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-550039827-1774878051=:968"
Content-ID: <b364258d-96bc-40d4-f95e-6a49701fe2e2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-550039827-1774878051=:968
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9a77dced-5a63-1f76-e93c-dc34e9d6399c@linux.intel.com>

On Mon, 30 Mar 2026, Thorsten Leemhuis wrote:

> [adding author and committer to list of recipients while dropping stable
> from CC, as the problem seems to happen in mainline, too]
>=20
> On 3/28/26 00:02, Jonas H=F6glund wrote:
> >=20
> > I have an AMD GPU in an external Thunderbolt enclosure that recently
> > stopped working with the latest longterm kernel release.  The GPU in
> > question is an AMD RX 6750 XT.
> >=20
> >     [...]
> >     amdgpu 0000:3e:00.0: amdgpu: vm size is 262144 GB, 4 levels, block =
size is 9-bit, fragment size is 9-bit
> >     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: =
releasing
> >     amdgpu 0000:3e:00.0: amdgpu: Problem resizing BAR0 (-16).
> >     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: =
assigned
> >     amdgpu 0000:3e:00.0: amdgpu: VRAM: 12272M 0x0000008000000000 - 0x00=
000082FEFFFFFF (12272M used)
> >     amdgpu 0000:3e:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x0000=
00001FFFFFFF
> >     resource: resource sanity check: requesting [mem 0x0000000000000000=
-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0x000a0000=
-0x000bffff window]
> >     ------------[ cut here ]------------
> >     WARNING: CPU: 7 PID: 2260 at arch/x86/mm/pat/memtype.c:720 memtype_=
reserve_io+0xfd/0x110
> >     [...]
> >=20
> > Searching for the issue I found this very similar report from last year=
:
> > https://lkml.org/lkml/2025/6/9/88
> >=20
> > so I suppose this might be a re-regression of the same issue(?).

I'm skeptical it's exactly the same issue even if the end result is the=20
same.

The resource fitting algorithm has been in a state of constant flux due to=
=20
various fixes and improvements into it over all the recent two years.
Unfortunately, fixing one thing (or even moving towards fixing an issue)=20
may break another thing due to how different resource interact.

> > I checked out latest longterm (v6.18.20) and bisected, which took me to
> > commit b855d99 (upstream commit 3958bf16), which is
> > "PCI: Stop over-estimating bridge window size".
>=20
> Ilpo, Bjorn: Jonas in a subthread later confirmed that this problem
> happens with 7.0-rc5, too, so it's likely something for you.
>=20
> Side note: I noticed the "PCI: Improve head free space usage" series
> referred to the commit in question; wondering if that is related:
> https://lore.kernel.org/all/20260324165633.4583-1-ilpo.jarvinen@linux.int=
el.com/

That "PCI: Improve head free space usage" series is certainly fixing two=20
known corner case with the commit 3958bf16e2fe ("PCI: Stop over-estimating=
=20
bridge window size") but with only heavily filtered logs, I'm unable to=20
confirm if it applies to this case as well.

From=20the limited logs, I suspect this is primarily a BAR resize rollback=
=20
failure which leaves the resources into a state worse than they were prior=
=20
to the resize. The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR=20
resize rollback path") attempts to rectify that. The entire series is here=
=20
(not all of it went to stable):

https://lore.kernel.org/all/20251113162628.5946-1-ilpo.jarvinen@linux.intel=
=2Ecom/T/#m9b0e316c94f7abc0686e58f902d05ff35aeac3ac

The fixes to that series are here:

5528fd38f230 ("PCI: Fix Resizable BAR restore order")
08d9eae76b85 ("PCI: Fix BAR resize rollback path overwriting ret")

(I'm sorry how complex this all is.)

--=20
 i.

> > After the bisect I tried reverting the commit on top of v6.18.20 (going
> > back to the old way of calculating alignment), and this is sufficient
> > for the eGPU to dock properly again.
> >=20
> > I've attached a longer excerpt of the kernel logs from a failing boot
> > (let me know if a full dmesg would be helpful and I can find somewhere
> > to upload it).  I've also attached an excerpt when connecting the eGPU
> > in a "good" case, since I figured the memory adress ranges could be
> > useful.
> >=20
> >=20
> > Hardware:
> >   Machine: Dell XPS 13 9310 (0991)
> >   GPU: AMD RX 6750 XT
> >   Dock: EXP GDC TH3P4G3
> >=20
> > Distribution: NixOS
> > Architecture: x86-64
> >=20
> > #regzbot introduced: b855d99
> >=20
> > Let me know if any additional information would be helpful.
> >=20
> > Thanks,
> > Jonas
>=20
--8323328-550039827-1774878051=:968--

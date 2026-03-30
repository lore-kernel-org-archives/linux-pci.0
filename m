Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABB3624A7
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884833; cv=none; b=R8LX0UDkcXW6w6gRXBgzhsoYpE5g9r9Ak/kzU4/BgEYpdY2MLvTxZbnQ+sUuLiOfxnc3v5HksOqqFOD/8qKs8sdqguNIodB1veJHTXPUpKD1zpgyN9IQ7veIxPUQvHYYD+XrMW5PgpYSMMYuSlzRFAUwB4Fto/9kAY9IQQhRU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884833; c=relaxed/simple;
	bh=UqVNErAUZYZIIhf18ocFSOwvhEEFO3n4zrKxb6KW06Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HvK/x2emKe1Cp8IjWnOoMsD6FsEAd4EA2FCsHN4RCyFV6O2QmzQQ4NhuA7C31HOdBM0irDOMI/asxcs3adnIe/I7Noto2wb+OSZAu5OgGSIlP6Es+qXCzrOPnwFUrxwHfKNvom+YKzFviWpGw6cLiAq1QQdPneIU1cKMsYEYnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOiWR4zC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOiWR4zC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774884831; x=1806420831;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UqVNErAUZYZIIhf18ocFSOwvhEEFO3n4zrKxb6KW06Y=;
  b=aOiWR4zCG6YAZHAKpApqjFH+OlBB8iM7i09jR8W7VPcKvGiH0sCITd+o
   ysDK+PkPa+Lk3Gn3vzmcWu7h6shLU/L0M+Yt/7MKj7rExG4r0tjD0y1Mh
   iNgBy+PuZ0M6kMRbmfeZoFXL/ZyVQe+Usbjikaf8LwR4HonFZ0hCeOLFS
   RvQgmOvotaUqvbrsx8xmPoLxopyOn78Lr+lwmKI0XIHZ7ZY8mZOjaOCIY
   qQIe+LshReVCJk6pi/fvcETlhI37euC7btMwGV1DP6WbjBv9coOh+gk6C
   vugz1uriFTpvj/NlzO7Lq0E5spvBX8jr10CtCjzpAmOWuCL058kvfCI7x
   A==;
X-CSE-ConnectionGUID: j0Qscq2KQMSIBJJyqU+zQw==
X-CSE-MsgGUID: CYQzqdcGSkWm7ASiFgII+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86499048"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86499048"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 08:33:45 -0700
X-CSE-ConnectionGUID: mn7xzpYNTcaoipKNzSoo4Q==
X-CSE-MsgGUID: b3tsWBoITaOUVDlHzde8yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="221216780"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 08:33:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Mar 2026 18:33:40 +0300 (EEST)
To: Cristian Cocos <cristi@ieee.org>
cc: linux-pci@vger.kernel.org
Subject: Re: ReBAR over Thunderbolt
In-Reply-To: <c0b1932ca75fc5eebb3aad97b76f88a9607875e3.camel@ieee.org>
Message-ID: <1b2f8cf5-777f-87b6-2829-50a6532e36df@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>   <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>  <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>  <2f6838fa-dd7f-848d-4788-8b04a23b5753@linux.intel.com>
 <c0b1932ca75fc5eebb3aad97b76f88a9607875e3.camel@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1710853029-1774884820=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1710853029-1774884820=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Mar 2026, Cristian Cocos wrote:
> On Mon, 2026-03-30 at 16:23 +0300, Ilpo J=C3=A4rvinen wrote:
> > > [=C2=A0 292.204936] pcieport 0000:02:00.0: bridge window [mem
> > > 0x6000000000-
> > > 0x60f04fffff 64bit pref]: was not released (still contains assigned
> > > resources)
> > > [=C2=A0 292.204937] pcieport 0000:00:07.0: bridge window [mem
> > > 0x6000000000-
> > > 0x60ffffffff 64bit pref]: was not released (still contains assigned
> > > resources)
> >=20
> > These 2 lines indicate where the reason likely lies. BAR resize
> > attempted to release these windows but there are some sibling
> > resources that prevent the resize from succeeding. I cannot see what
> > those resources are from these excerpts.
> >=20
> > Basically, the resize walks upwards in the PCI hierarchy and tries to
> > free any bridge window it encounters in order to allow them to be
> > sized freely (enlarged). The device whose BAR is being resized has
> > its resources released prior to the resize commencing, but any other
> > device under any of those bridge windows are not and they pin their
> > bridge windows in-place (it won't be possible to release them in the
> > general case as some of those devices may be in use at this point).
> >=20
> > It may be possible to workaround this problem by manually removing
> > the sibling devices that pin the relevant bridge windows, performing
> > resize through sysfs manually, and then rescanning (but with GPUs it
> > may be problematic if it's the primary GPU).
>=20
> Thank you. Your suggestion does indeed work! The resize succeeds after
> removing the three empty TB downstream ports that were pinning the
> bridge windows. The BAR went from 256 MB to 16 GB.

Great.

> However, it appears
> that the re-probe after rebinding hits an amdgpu driver bug: Failed to
> create device file mem_info_preempt_used (EEXIST from stale sysfs),
> which cascades to sw_init of IP block <gmc_v12_0> failed -17 =E2=86=92 NU=
LL
> deref in amdgpu_discovery_fini.

This problem is beyond PCI so I'm not of much help with it.

I suggest reporting this to amdgpu people (see the MAINTAINERS file)=20
with logs, they may be able to help.

> Be that as it may, I do see a workaround happening via a udev rule or
> systemd service that removes the three empty ports immediately after TB
> hotplug and before amdgpu binds. However, I can't help but feel that it
> is the kernel that should handle this sort of situations without any
> user side involvement. The problem (and please take this as a
> suggestion) seems to be that the kernel's PCI resource allocator
> speculatively assigns those three empty (see topology excerpt below)
> ports large prefetchable bridge windows "just in case" a device appears
> behind them later. That's what eats up the 4 GB root port window. If
> the allocator didn't hand out speculative windows to empty ports =E2=80=
=94 or,
> even better, if it checked ReBAR capabilities on the one port that does
> have a device and gave it priority =E2=80=94 the resize would work withou=
t
> removing anything.
>=20
> Laptop (Raptor Lake-P SoC)
>   =E2=94=94=E2=94=80 00:07.0  Integrated TB4 root port          =E2=86=90=
 laptop
>        =E2=94=94=E2=94=80 02:00.0  8086:5786 Switch Upstream     =E2=86=
=90 Razer Core X V2
>             =E2=94=9C=E2=94=80 03:00.0  Switch Downstream =E2=86=92 GPU p=
ath (04=E2=86=9205=E2=86=9206:00.0)
>             =E2=94=9C=E2=94=80 03:01.0  Switch Downstream =E2=86=92 empty
>             =E2=94=9C=E2=94=80 03:02.0  Switch Downstream =E2=86=92 empty
>             =E2=94=94=E2=94=80 03:03.0  Switch Downstream =E2=86=92 empty
>=20
> Again, please take this suggestion for what it's worth (i.e. my $.02),
> and many thanks for your attention to this matter.

I am already looking into resizable BAR aware resource fitting, hopefully=
=20
we'll get there in this year. However, it's a very complex change due to=20
fallbacks that have to be put into place and has various prerequisites=20
that I've been slowly upstreaming (and fixing the issues they've caused).

I've also considered not assigning bridge windows that do not have any=20
real resources underneath them (but still consider them in the sizing=20
decisions). It's not trivial to realize though, the assignment logic=20
heavily depends on those placeholders resources to satisfy alignment=20
constraints (so I've been thinking of walking through the assigned=20
resources post-assignment algorithm and releasing to empty windows=20
at that point to avoid violating the alignment constraints without extra=20
state tracking logic).


--=20
 i.

--8323328-1710853029-1774884820=:968--

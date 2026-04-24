Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C93F23B4
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056044; cv=none; b=MiWpOUgL8l7Lu5I3MIYHNuLEf61wjJOESXTuvBMLOm8nwRwLyVJ88/SqoeiIY9pQYGLRQLQgwdtqpY/UiBYNx8L50yG/5HzN7DYKlAD0G1ND1S4gCE3nUUdm7TmM2FeV/tnpBjTr4AoCPZp8rwWneoYJVuhfwsjkbC7aUnlV6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056044; c=relaxed/simple;
	bh=ehFgGv/oqbLNDEVtIy+xd4EHLTlZfX4FxD9SMis63lY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LkZ1WhS4yRFgFIW+9f4lnCTGQKy4PY1LtfkxIvKudzJjDjNJ494ybdYtmRrmPm3IpV+uNZRzAz+88db3UyGQ7hCGkoxolWaEB+G+tdSLz2mfy4jOPZ5ZHpK78VMeJPwpraPVF5NW1hRqHJWYovK/WmgHA8qFzBSNIudQ4nAvmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZZINGIS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZZINGIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777056041; x=1808592041;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ehFgGv/oqbLNDEVtIy+xd4EHLTlZfX4FxD9SMis63lY=;
  b=NZZINGIStAnvnm2SwgIe9HD60bhbFrAwrRLPz+nvbR44pTQQGbcIbeqA
   2CGd/QtT8ITVZB2GA7NinUNu7BtfER2PIsNyn6tAi6IyhLzga2aiEBI/x
   Rukkj3WXvpTki0XeAoiy4NQGWbaEWUStv5bRPmj95BSIn10AlYc5PZx4O
   7bf3dPtfGYff7XQfab3df5VS5L32rsd8GEQ90X0zL+pbxDElyPDe0j9gh
   mYppDrDSjesWN7max2bVvP2qjHGutwGU6J1nxi3bXxdbJk39F33c9k9Jg
   G2WInqzjGmpQMEIJszyvgIucc0r1AZeYliQ1cjWqngOPH55SC3t4kkOWV
   w==;
X-CSE-ConnectionGUID: aTb+YTFEQiKa3luU9mUk+w==
X-CSE-MsgGUID: F2SyZAo1QHCdcw3/rw0rjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="89125527"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="89125527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:40:40 -0700
X-CSE-ConnectionGUID: gNm6MNjVQoWbo1nrMz+JLQ==
X-CSE-MsgGUID: tZKH6KbDSxOngD60khfypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="256529462"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:40:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 21:40:34 +0300 (EEST)
To: Maarten Lankhorst <dev@lankhorst.se>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] PCI: Fix resizable bar fails due to bridge memory
 region
In-Reply-To: <eddf0632-81c5-49cb-b3a8-ef172d3ccb1c@lankhorst.se>
Message-ID: <bdcc18c0-0d75-fcfc-5ab4-3b42bdcbe7e9@linux.intel.com>
References: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se> <ee594d2d-f5c8-271b-e883-9d43a47ad4ff@linux.intel.com> <92850c9a-808e-47b9-ae5f-fa10c4bda3ce@lankhorst.se> <990a7758-46eb-3fc8-2714-a2b117720241@linux.intel.com>
 <eddf0632-81c5-49cb-b3a8-ef172d3ccb1c@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1411989971-1777053984=:958"
Content-ID: <c0045560-0761-15ad-1fe1-c5dfee3adbea@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1411989971-1777053984=:958
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <958f26d7-4df1-be36-e515-095c74d2cc35@linux.intel.com>

On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
> Den 2026-04-24 kl. 19:42, skrev Ilpo J=E4rvinen:
> > On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
> >> Den 2026-04-24 kl. 17:04, skrev Ilpo J=E4rvinen:
> >>> On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
> >>>
> >>>> I encountered a problem that I have on my system, where I cannot res=
ize
> >>>> the bar because one of the bridges has a=20
> >>>
> >>> You're missing words from here. But I can guess you've that extra BAR=
 on=20
> >>> in-card the bridge.
> >>>
> >>>> If I take a look at the topology, the GPU shares the memory region w=
ith a bridge,
> >>>>
> >>>> +-[0000:64]-+-00.0-[65-68]----00.0-[66-68]--+-01.0-[67]----00.0
> >>>>
> >>>> The specific bridge likely causing a failure is:
> >>>>
> >>>> 65:00.0 PCI bridge: Intel Corporation Device e2ff (rev 01) (prog-if =
00 [Normal decode])
> >>>>         Flags: bus master, fast devsel, latency 0, IRQ 32, IOMMU gro=
up 1
> >>>>         Memory at 382400000000 (64-bit, prefetchable) [size=3D8M]
> >>>>         ....
> >>>>
> >>>> Which causes upstream bridge 64:00.0 initially to allocate the regio=
n
> >>>> [38fe0000000-38ff0000000) for the GPU, and [382ff0000000..382ff07fff=
ff]
> >>>> for the bridge device.
> >>>>
> >>>> Bridge 64 is big enough for 1 BMG with a 32 GB bar and the second 8 =
MB allocation:
> >>>> pci_bus 0000:64: resource 9 [mem 0x382000000000-0x382fffffffff windo=
w] (64GB window)
> >>>>
> >>>> The reason for failure is that bridge 65 has a 8 MB memory region as=
signed,
> >>>
> >>>> and previously it was ignored when reallocating.
> >>>
> >>> What does this mean? I don't think it was ever ignored while=20
> >>> reallocating??
> >>>
> >>> Note that kernel has become much more verbose in explaining why thing=
s=20
> >>> fail so perhaps the added message is confusing you (they won't appear=
 in=20
> >>> the old kernels).
> >>>
> >>>> Failing case:
> >>>> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384=
MiB
> >>>> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref=
]: releasing
> >>>> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]: releasing
> >>>> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]: releasing
> >>>> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07ff=
fff 64bit pref]: was not released (still contains assigned resources)
> >>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pre=
f]: can't assign; no space
> >>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pre=
f]: failed to assign
> >>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pre=
f]: can't assign; no space
> >>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pre=
f]: failed to assign
> >>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pre=
f]: can't assign; no space
> >>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pre=
f]: failed to assign
> >>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pre=
f]: can't assign; no space
> >>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pre=
f]: failed to assign
> >>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assi=
gn; no space
> >>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to =
assign
> >>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assi=
gn; no space
> >>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to =
assign
> >>>> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> >>>> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >>>> pcieport 0000:64:00.0:   bridge window [mem 0x382fe0000000-0x382ff07=
fffff 64bit pref]
> >>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0x382fe0000000-0x382feff=
fffff 64bit pref]
> >>>> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> >>>> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> >>>> pcieport 0000:66:01.0:   bridge window [mem 0x382fe0000000-0x382feff=
fffff 64bit pref]
> >>>>
> >>>> Working with the patch below:
> >>>> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384=
MiB
> >>>> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref=
]: releasing
> >>>> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]: releasing
> >>>> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]: releasing
> >>>> pcieport 0000:65:00.0: BAR 0 [mem 0x382ff0000000-0x382ff07fffff 64bi=
t pref]: releasing
> >>>> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07ff=
fff 64bit pref]: releasing
> >>>> pcieport 0000:64:00.0: bridge window [mem 0x382000000000-0x3824007ff=
fff 64bit pref]: assigned
> >>>> pcieport 0000:65:00.0: bridge window [mem 0x382000000000-0x3823fffff=
fff 64bit pref]: assigned
> >>>> pcieport 0000:65:00.0: BAR 0 [mem 0x382400000000-0x3824007fffff 64bi=
t pref]: assigned
> >>>> pcieport 0000:66:01.0: bridge window [mem 0x382000000000-0x3823fffff=
fff 64bit pref]: assigned
> >>>> xe 0000:67:00.0: BAR 2 [mem 0x382000000000-0x3823ffffffff 64bit pref=
]: assigned
> >>>> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> >>>> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >>>> pcieport 0000:64:00.0:   bridge window [mem 0x382000000000-0x3824007=
fffff 64bit pref]
> >>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823fff=
fffff 64bit pref]
> >>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >>>> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823fff=
fffff 64bit pref]
> >>>> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> >>>> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> >>>> pcieport 0000:66:01.0:   bridge window [mem 0x382000000000-0x3823fff=
fffff 64bit pref]
> >>>> xe 0000:67:00.0: [drm] BAR2 resized to 16384MiB
> >>>>
> >>>>
> >>>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> >>>> ---
> >>>> I'm not 100% this is the correct fix, I don't know why the bridge it=
self has
> >>>> a memory region, why the kernel allocates it and when it's supposed =
to
> >>>> be used. Not a PCI expert. :-)
> >>>
> >>> I don't know why it is there either. Nothing in the portdrv really us=
es it=20
> >>> for anything. There is patchset somewhere lying around which adds a q=
uirk=20
> >>> that releases the "extra" BAR.
> >>
> >> Thank you, I've taken a look at that patch series. It looks like patch=
 1/2
> >> would help a lot.
> >=20
> > I should one day find time to finish that series, Bjorn didn't like how=
=20
> > the code didn't "disable" BAR.
> >=20
> > I did some (unset) work towards placing the BARs outside the bridge=20
> > window but my algorithm was quite basic (just found min & max window
> > addresses and put BAR outside of that range but then I thought maybe I=
=20
> > should add the possiblity for placing the BAR into the gap in the middl=
e to
> > allow placement of a large BAR in cases where 32-bit mmio blocks low-en=
d +=20
> > 64-bit mmio range blocking the top of the address space.
> >=20
> >> I'm wondering if it will completely fix the issue, it is still possibl=
e
> >> that in the same config I have 2 identical cards, where resizing might
> >> work, but when GPU1's VRAM BAR is already bound, it might be unable
> >> to resize GPU2's VRAM BAR for the same reason as this patch.
> >=20
> > It is always possible to find cases where a sibling pins the shared bri=
dge=20
> > window in place.
> >=20
> >> What would be the best way to handle this case?
> >=20
> > The best way is to size them into the largest possible sizes right from=
=20
> > the beginning. But when doing that, nothing must break (introducing=20
> > regressions is not okay) so it kernel must be able to graciously fallba=
ck=20
> > to smaller sizes when there isn't enough space available for the larges=
t=20
> > size.
> >=20
> > What makes it complicated is that sizing and assignment are done very m=
uch=20
> > separately, so retrying with a smaller size is complicated. I'm working=
=20
> > toward this kind of solution but there are various things that have to =
be=20
> > fixed first.
>=20
> How feasible would it be to add a quirk to resize the bar (or reserve eno=
ugh
> space for max) very early before any allocations are done?

I don't think that is viable.

Resizing is way more complicated than touching a single BAR because how=20
the bridge windows work and how resource sizes interact.

No solution is allowed to cause regressions which could easily happen=20
_much later_ into the resource allocation (very much after the quirk has=20
finished). How'd you rollback the size changes the quirk caused at that=20
point???

What such a quirk would effectively do is make rolling back the size=20
changes an intractable problem, so any regression would be unfixable=20
except by piling in more and more hacks which isn't viable way forward.

> I doubt any user of resizable bar is going to hotplug their GPU's.

eGPUs connected over Thunderbolt are hotpluggable (whether the=20
hotpluggability occurs in practice in those cases is another question=20
though, or if the eGPU just sits there always connected).

--=20
 i.
--8323328-1411989971-1777053984=:958--

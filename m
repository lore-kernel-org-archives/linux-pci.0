Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069883624CE
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052580; cv=none; b=XEDE5GDk6DenhHdFDBM15sjDW1hgcdNsnLySAZwJ1Hk1KvuY7u666xtv7F8y8qA3m3psX8ZDbnXP+eGz+zTBad3tPQsOqlCyIGH/SzwLaGE8TjYRl1u3ZtCm52OfwdsplPYr7a55X2ev3+dLeb74zZEf4ijN6KffvgcDBWnwKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052580; c=relaxed/simple;
	bh=ie4CDtYFrQRyD464W2OX/4dxxPPunGjCi3qEovTZ4jQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ubOhFxkB0LfYEMjhxQ5iyTgipUXyqPa5dUB5ltY0nDRYrRanZcgEiGjL0CldBKsDTAynX7ZhF4nqqc2n/vS3cptAenqxXL5ejGExswEQrJAT40mc9AoWOkDMp3/R7JJV4UlQ0/edOr82cD6eUNco4xeAjxf18NxBZkrNpqrdyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDM06/2r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDM06/2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777052578; x=1808588578;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ie4CDtYFrQRyD464W2OX/4dxxPPunGjCi3qEovTZ4jQ=;
  b=RDM06/2rdGVlWsRZM51FCMkOb5nI5ewbSUFesQrl6j2lGQmfURFH/KmJ
   r+pC8KdoLctb3OMDbEKevUsG1QG7ZR1RZIy0voXPATEcrsuj+lYrL+RrQ
   f5LXH7/VRbphyRyuw6JOvI2G8pI7bX138TrTq+ITIKVkh/gW4QhIya9ZD
   y5eWN0bHpHhbjJ1KxhPwrsNPtpYLPbKDDrRmxjlODsufygxHeTG1Tduoq
   JwTjGLJ1C1yPhOlgXdGo5inxFaK8Ox7m7rrYV7hsbwbVyq4MrlrhXiY/V
   +nB9/heGKqL2DaKKXkw/FaPNI1c7ukgFn1PjmLlpYvby0nr3aaXIAVkFX
   A==;
X-CSE-ConnectionGUID: vTZ8AwI+QT2Pya1L2BQflA==
X-CSE-MsgGUID: CbMe6SXlSL2z21Icgu7RFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="80620183"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="80620183"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 10:42:57 -0700
X-CSE-ConnectionGUID: g1/LdeG0QjeSSjdwDQW49g==
X-CSE-MsgGUID: UTG05WiiRnCYoygpNdHrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="233307013"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 10:42:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 20:42:48 +0300 (EEST)
To: Maarten Lankhorst <dev@lankhorst.se>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] PCI: Fix resizable bar fails due to bridge memory
 region
In-Reply-To: <92850c9a-808e-47b9-ae5f-fa10c4bda3ce@lankhorst.se>
Message-ID: <990a7758-46eb-3fc8-2714-a2b117720241@linux.intel.com>
References: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se> <ee594d2d-f5c8-271b-e883-9d43a47ad4ff@linux.intel.com> <92850c9a-808e-47b9-ae5f-fa10c4bda3ce@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1684128750-1777052568=:958"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1684128750-1777052568=:958
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
> Den 2026-04-24 kl. 17:04, skrev Ilpo J=C3=A4rvinen:
> > On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
> >=20
> >> I encountered a problem that I have on my system, where I cannot resiz=
e
> >> the bar because one of the bridges has a=20
> >=20
> > You're missing words from here. But I can guess you've that extra BAR o=
n=20
> > in-card the bridge.
> >=20
> >> If I take a look at the topology, the GPU shares the memory region wit=
h a bridge,
> >>
> >> +-[0000:64]-+-00.0-[65-68]----00.0-[66-68]--+-01.0-[67]----00.0
> >>
> >> The specific bridge likely causing a failure is:
> >>
> >> 65:00.0 PCI bridge: Intel Corporation Device e2ff (rev 01) (prog-if 00=
 [Normal decode])
> >>         Flags: bus master, fast devsel, latency 0, IRQ 32, IOMMU group=
 1
> >>         Memory at 382400000000 (64-bit, prefetchable) [size=3D8M]
> >>         ....
> >>
> >> Which causes upstream bridge 64:00.0 initially to allocate the region
> >> [38fe0000000-38ff0000000) for the GPU, and [382ff0000000..382ff07fffff=
]
> >> for the bridge device.
> >>
> >> Bridge 64 is big enough for 1 BMG with a 32 GB bar and the second 8 MB=
 allocation:
> >> pci_bus 0000:64: resource 9 [mem 0x382000000000-0x382fffffffff window]=
 (64GB window)
> >>
> >> The reason for failure is that bridge 65 has a 8 MB memory region assi=
gned,
> >=20
> >> and previously it was ignored when reallocating.
> >=20
> > What does this mean? I don't think it was ever ignored while=20
> > reallocating??
> >=20
> > Note that kernel has become much more verbose in explaining why things=
=20
> > fail so perhaps the added message is confusing you (they won't appear i=
n=20
> > the old kernels).
> >=20
> >> Failing case:
> >> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384Mi=
B
> >> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]:=
 releasing
> >> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382feffffff=
f 64bit pref]: releasing
> >> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382feffffff=
f 64bit pref]: releasing
> >> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07ffff=
f 64bit pref]: was not released (still contains assigned resources)
> >> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]=
: can't assign; no space
> >> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]=
: failed to assign
> >> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]=
: can't assign; no space
> >> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]=
: failed to assign
> >> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]=
: can't assign; no space
> >> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]=
: failed to assign
> >> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]=
: can't assign; no space
> >> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]=
: failed to assign
> >> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign=
; no space
> >> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to as=
sign
> >> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign=
; no space
> >> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to as=
sign
> >> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> >> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >> pcieport 0000:64:00.0:   bridge window [mem 0x382fe0000000-0x382ff07ff=
fff 64bit pref]
> >> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >> pcieport 0000:65:00.0:   bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]
> >> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> >> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> >> pcieport 0000:66:01.0:   bridge window [mem 0x382fe0000000-0x382feffff=
fff 64bit pref]
> >>
> >> Working with the patch below:
> >> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384Mi=
B
> >> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]:=
 releasing
> >> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382feffffff=
f 64bit pref]: releasing
> >> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382feffffff=
f 64bit pref]: releasing
> >> pcieport 0000:65:00.0: BAR 0 [mem 0x382ff0000000-0x382ff07fffff 64bit =
pref]: releasing
> >> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07ffff=
f 64bit pref]: releasing
> >> pcieport 0000:64:00.0: bridge window [mem 0x382000000000-0x3824007ffff=
f 64bit pref]: assigned
> >> pcieport 0000:65:00.0: bridge window [mem 0x382000000000-0x3823fffffff=
f 64bit pref]: assigned
> >> pcieport 0000:65:00.0: BAR 0 [mem 0x382400000000-0x3824007fffff 64bit =
pref]: assigned
> >> pcieport 0000:66:01.0: bridge window [mem 0x382000000000-0x3823fffffff=
f 64bit pref]: assigned
> >> xe 0000:67:00.0: BAR 2 [mem 0x382000000000-0x3823ffffffff 64bit pref]:=
 assigned
> >> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> >> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >> pcieport 0000:64:00.0:   bridge window [mem 0x382000000000-0x3824007ff=
fff 64bit pref]
> >> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823fffff=
fff 64bit pref]
> >> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> >> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> >> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823fffff=
fff 64bit pref]
> >> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> >> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> >> pcieport 0000:66:01.0:   bridge window [mem 0x382000000000-0x3823fffff=
fff 64bit pref]
> >> xe 0000:67:00.0: [drm] BAR2 resized to 16384MiB
> >>
> >>
> >> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> >> ---
> >> I'm not 100% this is the correct fix, I don't know why the bridge itse=
lf has
> >> a memory region, why the kernel allocates it and when it's supposed to
> >> be used. Not a PCI expert. :-)
> >=20
> > I don't know why it is there either. Nothing in the portdrv really uses=
 it=20
> > for anything. There is patchset somewhere lying around which adds a qui=
rk=20
> > that releases the "extra" BAR.
>=20
> Thank you, I've taken a look at that patch series. It looks like patch 1/=
2
> would help a lot.

I should one day find time to finish that series, Bjorn didn't like how=20
the code didn't "disable" BAR.

I did some (unset) work towards placing the BARs outside the bridge=20
window but my algorithm was quite basic (just found min & max window
addresses and put BAR outside of that range but then I thought maybe I=20
should add the possiblity for placing the BAR into the gap in the middle to
allow placement of a large BAR in cases where 32-bit mmio blocks low-end +=
=20
64-bit mmio range blocking the top of the address space.

> I'm wondering if it will completely fix the issue, it is still possible
> that in the same config I have 2 identical cards, where resizing might
> work, but when GPU1's VRAM BAR is already bound, it might be unable
> to resize GPU2's VRAM BAR for the same reason as this patch.

It is always possible to find cases where a sibling pins the shared bridge=
=20
window in place.

> What would be the best way to handle this case?

The best way is to size them into the largest possible sizes right from=20
the beginning. But when doing that, nothing must break (introducing=20
regressions is not okay) so it kernel must be able to graciously fallback=
=20
to smaller sizes when there isn't enough space available for the largest=20
size.

What makes it complicated is that sizing and assignment are done very much=
=20
separately, so retrying with a smaller size is complicated. I'm working=20
toward this kind of solution but there are various things that have to be=
=20
fixed first.

--=20
 i.

--8323328-1684128750-1777052568=:958--

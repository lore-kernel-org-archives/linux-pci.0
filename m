Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35B4E1C60;
	Fri,  9 Oct 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547310; cv=none; b=BgKbXW+rgOSI4t1f/pCEzcEMvNDaWoHAL6cHWuekHmoj05xOgPQZss/WWH3us+JvcJ/gllTbEqpWpOqpb+tynERjMc8rdrTA+t0UXFAiwwOP6VfjbiuzW0b1UH6+wLZUApLd6VcGygU/gH1Mk55NQLi90cZ3/TX3vRbrv7jABRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547310; c=relaxed/simple;
	bh=qmfY4qX6AqQUEI5YpwWh4TpNNyCv4is+uyS6k/CPcxg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cqO0xypWRQ35jfSlgw0MzhVBqhfLvlj24qrMg891u82FsOkzY6nnURzx0+aQOD5jJPSm3tmIxKdqmgcOr3JfhYwNfa7X4VbyJcvCv9ZqnQs+O/J2ye/gpZUjpCaWJKaURIRWq19yl24W8/3HEqI2TLIeENjU5a4ySspLTG4K4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7M0PkTy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7M0PkTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791547306; x=1823083306;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qmfY4qX6AqQUEI5YpwWh4TpNNyCv4is+uyS6k/CPcxg=;
  b=B7M0PkTy8JaKaB565dUCvCHs5YOf2Of7J+ftop+N2v4Sf5elkoVZXCCS
   Hh5ijK4Tz5rqyjBApgw35gc7J3I20MJdtN8y9gvkC1ON75Xq01K129b9H
   8ql1P+wgqX3Mbx72HWJ7scRHWSaFykEnJPUkm8W5zoRMlLeoifYFd5c4I
   EwSsiPNKfqX1PzqtG8U0QqNnDJHqgBV6MELWTgC22Rf7OauC5zwGkvpf0
   K3+ZaKGITRsratmdc8Y/8rTwjHGu1AVTuKkVo1g/Lg5ByGnyqy9Va7l6W
   jZLRCtfDA6ptIyBW1qQzrI/whENfic1NYcS9Xi6Go+MbxN1/ZpDhYJejc
   w==;
X-CSE-ConnectionGUID: 34U4oMRNRmSQUnl7KskWCQ==
X-CSE-MsgGUID: coNHuXC1QK+FsV65fRB7Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="229421"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="229421"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:01:45 -0700
X-CSE-ConnectionGUID: Teap6Jq7Ss6bF5Ba5IcMHw==
X-CSE-MsgGUID: JkkCKXQPTeqxywp4VTTYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2123354"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:01:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 15:01:37 +0300 (EEST)
To: Borislav Petkov <bp@alien8.de>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <20261004154428.GAasJ0XCWdso81YdwH@fat_crate.local>
Message-ID: <2b4985b1-064f-552d-0803-f285779b5dba@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com> <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com> <20261004154428.GAasJ0XCWdso81YdwH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-363935522-1791289612=:3116"
Content-ID: <e6241b11-6da0-c274-ef17-a1f71b937c92@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-363935522-1791289612=:3116
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2ed94c43-ec6e-14e6-0d57-88009ffbba85@linux.intel.com>

On Sun, 4 Oct 2026, Borislav Petkov wrote:

> On Fri, Oct 02, 2026 at 02:33:15PM +0300, Ilpo J=E4rvinen wrote:
> > While testing the resource placement changes, tests hit a case where
> > igb fails to probe when BAR 0 is placed at 0x9c000000:
> >=20
> >    90000000-9cffffff : PCI Bus 0000:a0
> >   -  90000000-902fffff : PCI Bus 0000:a1
> >   -    90000000-900fffff : 0000:a1:00.0
> >   -      90000000-900fffff : igb
> >   -    90100000-901fffff : 0000:a1:00.0
> >   -    90200000-90203fff : 0000:a1:00.0
> >   -      90200000-90203fff : igb
> >   +  9be00000-9c0fffff : PCI Bus 0000:a1
> >   +    9be00000-9befffff : 0000:a1:00.0
> >   +    9bf00000-9bf03fff : 0000:a1:00.0
> >   +    9c000000-9c0fffff : 0000:a1:00.0
> >      9c100000-9c17ffff : amd_iommu
> >      9c180000-9c1803ff : IOAPIC 8
> >=20
> >   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=
=3D1M]
> >   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=
=3D16K]
> >   -       Expansion ROM at 90100000 [disabled] [size=3D1M]
> >   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=
=3D1M]
> >   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=
=3D16K]
> >   +       Expansion ROM at 9be00000 [disabled] [size=3D1M]
> >=20
> > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > ------------[ cut here ]------------
> > igb: Failed to read reg 0x18!
> > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold=
+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > ...
> >  igb_get_invariants_82575+0xff/0xf00 [igb]
> >  igb_probe+0x3c8/0x1190 [igb]
> >  local_pci_probe+0x3b/0x80
> >=20
> > It turns out there is a 64kB iomem black hole at 9c000000 that returns
>=20
> Can we please debug that "It turns out" thing and try to find out what re=
ally
> is going on here.
>=20
> Can you pls explain what your machine looks like so that we can try to
> reproduce it and see what's going on?

It's Poweredge R6625. AFAIK, there's nothing fancy on it, just the I210=20
added. (I don't admin it but can just run large-scale validation tests on=
=20
it so I could have gaps in my knowledge).

> Does it have latest BIOS, microcode, etc etc? If it doesn't, can you upgr=
ade
> and try again?

BIOS was updated to the latest and the problem persists.

> I guess dmesg, hwinfo, kernel .config would be good starters, privately i=
s
> fine too.

dmesg is in the ticket, I added config there.

--=20
 i.
--8323328-363935522-1791289612=:3116--

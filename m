Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983417;
	b=C3WjW6URcH8S/VRRgWQRrXXc5SXT2oxn3zeEzbQg27mEBz3s8o4v/YvoZAIkCLZAYXy5
	 2VGd4LuVjbdBucUNMArg5rLpPAKGr+W50aqD72zcJD2jy6Q4do2MrW77xLMMhS1QG7VZ8
	 qWU7FBNCAzAXoHRxg1x/PWHS+P+UTsq4zWncwhLeSK6D+2yVYURRJf0429pdojpV2/rS/
	 +4nlQIpzwDH4J5SGf6Z5QwJOzPRnCCAYoB/aXDz2qI0F5SOm5H+g9PZdstMXfgqEbknoC
	 PIcod+GQewPNxQAxfOBUR3TYnLesqrb2MXtukmONiNoiycGrJoZMf7drGW8dlt8uWsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983417;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=us6ixY8W3UTKAej6p/8rxcwNKirAySpEJwx0ogy/mTE=;
	b=LsqXth7cpETyn2i6i4nLxFnHd5hmBb7Kjh0VpHwqUpYpvVIWOmWoZSqaW7taXABldqBF
	 vMC8xzYVjthDSPChnuukPdFQFX44hoEAtEEg+f5ixW1uwWbrQdNo20e1slbAfMzsqJzGZ
	 dG7PQTmelEsxCgR3lZGGES4nWX7LKVFNsDLvoF4cjHWQYjkh5F+GeDlovRGQivm4fWsC7
	 EJ3ZG0zsMawcChkQD85C5CFO9fmLtxd3gDio/IikcAI7I9S34e3+qlNEkEGuhjQtsGNkq
	 ln6xB+hxPToAr+nt+32CGlSNBQMAVwalYJbgsHLzR4dq3OJPy+XRNXxgTogVoO50vjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQOIdibp;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B8606A326;
	Fri,  6 Nov 2026 16:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A61B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQOIdibp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793983417; x=1825519417;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=MtAYB1Tc16jEdD5vhwGbhz2IBJwJwK45LUW1VZ9l3ec=;
  b=WQOIdibpbGoc3kokl2XcV4sEFM//v69CxzigOglgTRj9A6cj+a0fig3J
   KAsOx5US2oraQIlzTmELNqSEcpYoJNPGPp2txaEHYJg+d/FxfOQTPMHRM
   az8t6rAZm0Vb6P3e3Rkwq5L+Q3pv8nTtNsxHLWfrY7VkGDdZXPKRliQBq
   PvS52uEr8tf4ud+9x7aCBj9xq/QRnrmg255r+Enjv6bLmHzYZ8JKe8KtU
   CUD3oWBgSCCxHCBT4pKS5xev2hnxSlG4xMN2hsVn4i6t51f/a4TbnUEp8
   sW7N6sLpuI6JdSN3i3yIEhitdXMNyhdZ5EXFES9+Qd3jebMgpuWelnkUo
   Q==;
X-CSE-ConnectionGUID: uiA/FdHoT+eQXVHKRkQGBA==
X-CSE-MsgGUID: LlH+TfToR8WclxR3Pl3EyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2697224"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2697224"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:43:36 -0800
X-CSE-ConnectionGUID: gKRMVcsrTWmqOuLPEHXQFQ==
X-CSE-MsgGUID: p7eGWecCS+awl3UuXaUivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9080995"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:43:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 18:43:28 +0200 (EET)
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
In-Reply-To: <20261106152642.23118-1-nbritton@exabit.io>
Message-ID: <a4723f5d-b948-b5da-4f86-4c822bd2d8b3@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com> <20261106152642.23118-1-nbritton@exabit.io>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2046532658-1793979215=:2032"
Content-ID: <f9d0a09d-42df-fbfc-27b0-d6763622f861@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2046532658-1793979215=:2032
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f5d1156c-9447-0811-6b74-38981169920a@linux.intel.com>

On Fri, 6 Nov 2026, Nikolas Joshua Britton wrote:

> On Fri, 6 Nov 2026, Ilpo J=E4rvinen wrote:
> > There have been major changes so any retesting is appreciated (the
> > 4 candidates patch is largely the same so I kept the Tested-by tags but
> > everything around has been changing so even that is on the borderline
> > when it comes to the validity of the existing tags).
>=20
> I retested v5 on the Mac Pro 7,1 from my report (two Vega II Duo cards,
> four Vega 20 dies behind two root ports, BAR0 resized to 32G on every
> die).
>=20
> v7.3 and later don't boot on this machine for reasons unrelated to this
> series, so I tested on v7.2.15 plus 5012a6953208 ("PCI: Do not add
> hotplug reservation multiple times"), which 11/14 and 12/14 depend on.
> All 14 patches then apply as posted, and drivers/pci/setup-bus.c and
> drivers/pci/setup-res.c come out byte-identical to v7.4-rc1 + v5.
>=20
> Every BAR is assigned, both root port windows are 96G, and all four dies
> get their 32G BAR0. The first root port:
>=20
>   pci 0000:06:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit =
pref]: assigned
>   pci 0000:07:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit =
pref]: assigned
>   pci 0000:08:08.0: bridge window [mem 0x9f7ffe00000-0x9ffffffffff 64bit =
pref]: assigned
>   pci 0000:08:10.0: bridge window [mem 0x9e800000000-0x9f0001fffff 64bit =
pref]: assigned
>   pci 0000:0b:00.0: BAR 0 [mem 0x9f800000000-0x9ffffffffff 64bit pref]: a=
ssigned
>   pci 0000:0b:00.0: BAR 2 [mem 0x9f7ffe00000-0x9f7ffffffff 64bit pref]: a=
ssigned
>   pci 0000:0e:00.0: BAR 0 [mem 0x9e800000000-0x9efffffffff 64bit pref]: a=
ssigned
>   pci 0000:0e:00.0: BAR 2 [mem 0x9f000000000-0x9f0001fffff 64bit pref]: a=
ssigned
>=20
> The second root port (14:00.0) has the same layout at 0xbe800000000.
>=20
> Compared with v4, the two die chains swapped ends of the window: 08:08.0
> and the windows nested below it (09:00.0, 0a:00.0) now sit at the top,
> with the 2M BAR2 at their left edge. That is the case the dropped
> nested-window fix covered, and it still assigns without that patch.
> amdgpu binds all four dies and compute across them works.

Also the candidate selection precedence change impacts ordering. TBH, I=20
liked the v4 order better because it really tried to preserve the left=20
edge for large blocks better but there were just so many corner cases with=
=20
it so v5 now uses the largest contiguous size before the largest natural=20
size. I might revisit this at some point but getting these regressions=20
addressed in mainline is more important than perfection and my=20
preferences.

> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>

Thanks for testing.

All looks promising, sashiko came up nothing interesting. It took=20
quite long to get to that point but I think the overall feel I've the=20
series feels much more polished now than what v4 was.

--=20
 i.
--8323328-2046532658-1793979215=:2032--

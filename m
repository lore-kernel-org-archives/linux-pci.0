Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF584D90A0;
	Mon, 28 Sep 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605860; cv=none; b=KmVEaabwPsKKtdrsO28cuLEhu317Mj0KsuA608+19VMsXnbbLG4xi/EGrWY/pUyBEskikQmJ5bxyb/lK6XLw0TeU7Hfm/ysbEV+YqsHmDswYBBT2d9FWNf6DA+N1fLsFmlXTNT+PRae1Fq6BA9umCvbxjbuoH3mVOivGsQpJqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605860; c=relaxed/simple;
	bh=9MBlU9XTRfB8eMdGchj04q2v3x03mVXvVlUras1jgbU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jhSosl7eKGQEgiI5FSWqOCcinIVM5Pamav6tZz4X3m7cLaJSq7voBv3L6sw42aGoM5YxAR+s2bmWueZEys5sRCK6/GmTldhMYqPtpfu2z8Yii9+bGYHS2+j4FH+MyXWBNoAD+5gATIpUFwsWihts2nfNjDpUVJw3O4dIJmvfrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YySLJJJO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YySLJJJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790605854; x=1822141854;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9MBlU9XTRfB8eMdGchj04q2v3x03mVXvVlUras1jgbU=;
  b=YySLJJJOKny8KbOosI7IYYPukaUVhvwZXIVay98VQlZUASXneDZjloWF
   X9ZpxrW2o5YyrxijObOODcP8OOKrc4WaW7fSYCYAq4GtWO/giET9t7uFr
   nUgbP7Ja772yiElSBFwHQ6oTb5SMJX2PYg01QwMW5CelL7/GQdsmr51/+
   z8MihZtet1iZZz/Es1ucZXJszvwX4eL0I+x+xkcWaozoEuWBeKNmXJ7zv
   h6fvCpLQ+fbpeimtMyaYdcinGC+Uj9xwRHn4YVRC7ZUVvsF+M5/kqMeAx
   nbA3G2JsX4FuJlOBrfVST1UCO/MAv+MAN0hDqnBeaibzkeZl2UHKh7guM
   A==;
X-CSE-ConnectionGUID: /PQzj86+SCmIdn9Lb0k7aQ==
X-CSE-MsgGUID: uoK98z99S5asoFiVU0kc/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="95120095"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="95120095"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 07:30:49 -0700
X-CSE-ConnectionGUID: sCESdLwwTMi5dIDjVL+HnQ==
X-CSE-MsgGUID: r/L8Vz58TOmb7Z6NKfZYxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274179313"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 07:30:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 17:30:41 +0300 (EEST)
To: David Laight <david.laight.linux@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
In-Reply-To: <20260928141936.2539ad5f@pumpkin>
Message-ID: <77f7d79b-d3fb-0576-0b6d-eef4efd8d634@linux.intel.com>
References: <20260924202056.GA2001522@bhelgaas> <447e3daa-c8a5-2b0c-2c6d-3f3eb92e94cc@linux.intel.com> <20260928141936.2539ad5f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1559651554-1790605687=:1168"
Content-ID: <325da4a9-3c51-89d0-c980-a86453a369ca@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1559651554-1790605687=:1168
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <afd7b8a3-c690-79fa-f3d3-dc5b8bf8c1be@linux.intel.com>

On Mon, 28 Sep 2026, David Laight wrote:

> On Mon, 28 Sep 2026 15:20:13 +0300 (EEST)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Thu, 24 Sep 2026, Bjorn Helgaas wrote:
> >=20
> > > [+cc Rafael, ACPI resource question]
> > >=20
> > > On Wed, Sep 23, 2026 at 04:17:55PM +0300, Ilpo J=E4rvinen wrote: =20
> > > > While testing the resource placement changes, my tests hit a case w=
here
> > > > igb fails to probe when BAR 0 is placed at 0x9c000000:
> > > >=20
> > > >    90000000-9cffffff : PCI Bus 0000:a0
> > > >   -  90000000-902fffff : PCI Bus 0000:a1
> > > >   -    90000000-900fffff : 0000:a1:00.0
> > > >   -      90000000-900fffff : igb
> > > >   -    90100000-901fffff : 0000:a1:00.0
> > > >   -    90200000-90203fff : 0000:a1:00.0
> > > >   -      90200000-90203fff : igb
> > > >   +  9be00000-9c0fffff : PCI Bus 0000:a1
>=20
> Is that valid?
> I'm no expect but I wouldn't expect an address range to cross a power of =
2 boundary.

Hi,

Bridge windows are defined by a base/limit pair, both with 1M granularity.=
=20
There's nothing that disallows a bridge window crossing a power of 2=20
boundary in the spec (AFAIK).

Note that after this quirk is applied reshuffling the device BAR=20
resources, the same crossing is still there and the device works.

Perhaps you mixed this up with BAR resources that indeed must to be=20
naturally aligned.

--=20
 i.


> David
>=20
> > > >   +    9be00000-9befffff : 0000:a1:00.0
> > > >   +    9bf00000-9bf03fff : 0000:a1:00.0
> > > >   +    9c000000-9c0fffff : 0000:a1:00.0
> > > >      9c100000-9c17ffff : amd_iommu
> > > >      9c180000-9c1803ff : IOAPIC 8
> > > >=20
> > > >   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [=
size=3D1M]
> > > >   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [=
size=3D16K]
> > > >   -       Expansion ROM at 90100000 [disabled] [size=3D1M]
> > > >   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [=
size=3D1M]
> > > >   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [=
size=3D16K]
> > > >   +       Expansion ROM at 9be00000 [disabled] [size=3D1M]
> > > >=20
> > > > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > > > ------------[ cut here ]------------
> > > > igb: Failed to read reg 0x18!
> > > > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.=
cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > > > ...
> > > >  igb_get_invariants_82575+0xff/0xf00 [igb]
> > > >  igb_probe+0x3c8/0x1190 [igb]
> > > >  local_pci_probe+0x3b/0x80
> > > >=20
> > > > Apparently, the igb driver bails out, after its initial sanity chec=
k
> > > > detects an unexpected ~0 read. Hacking around the sanity check just
> > > > results in more failures down the road so the sanity check itself i=
s not
> > > > the cause for the failure.
> > > >=20
> > > > The resource placement looks valid so the actual placement patches =
seem
> > > > to work normally.
> > > >=20
> > > > All other possible 1M address I could test (with a hack patch) did =
work. =20
> > >=20
> > > Super weird.  Is it possible there's some other device there?  It's
> > > conceivable ACPI might have a _CRS method describing it.  I think
> > > there are ACPI devices for which we don't reserve space mentioned in
> > > _CRS.  Maybe Rafael knows a debug option to log everything in _CRS? =
=20
> >=20
> > Now that you mentioned it, there certainly something going on with=20
> > that address:
> >=20
> > [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x0000000090000000-0x000000009bffffff]
> > [    0.000000] BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x000000009d000000-0x00000000a8ffffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000a9000000-0x00000000a9ffffff]  =
device reserved
> > ...
> > [    0.000000] efi: Remove mem48: MMIO range=3D[0x80000000-0x8fffffff] =
(256MB) from e820 map
> > [    0.000000] e820: remove [mem 0x80000000-0x8fffffff] device reserved
> > [    0.000000] efi: Remove mem49: MMIO range=3D[0x9c000000-0x9cffffff] =
(16MB) from e820 map
> > [    0.000000] e820: remove [mem 0x9c000000-0x9cffffff] device reserved
> > [    0.000000] efi: Remove mem50: MMIO range=3D[0xa9000000-0xa9ffffff] =
(16MB) from e820 map
> > [    0.000000] e820: remove [mem 0xa9000000-0xa9ffffff] device reserved
> >=20
> > But given the comment above efi_remove_e820_mmio() it sounds like this =
is=20
> > a red herring.
> >=20
> > In any case, the address is inside the provided root bus resource:
> >=20
> > [    4.854840] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus a0-bf])
> > ...
> > [    4.854848] PCI host bridge to bus 0000:a0
> > [    4.854848] pci_bus 0000:a0: root bus resource [io  0x6000-0x6fff wi=
ndow]
> > [    4.854848] pci_bus 0000:a0: root bus resource [mem 0x90000000-0x9cf=
fffff window]
> > [    4.854848] pci_bus 0000:a0: root bus resource [mem 0x71d60000000-0x=
7fcffffffff window]
> > [    4.854848] pci_bus 0000:a0: root bus resource [bus a0-bf]
> >=20
> > > Does igb seem sensitive about this exact address on a variety of
> > > machines?  If so I would expect some kind of igb hardware erratum for
> > > it. =20
> >=20
> > I've not heard anything to that effect.
> >=20
> > But existance of the sanity check itself in the igb driver looks almost=
=20
> > like a smoking gun so I don't know what to think of it.
> >=20
> > I'm also inclined to think that the placement approaches out there so f=
ar=20
> > might not have covered that many addresses but used the left edge of th=
e=20
> > window. So this series, when it often moves resources to right edge of =
the=20
> > window, goes to what might not be on well-charted territory.
> >=20
> > > Do other non-igb devices work at that address? =20
> >=20
> > Unfortunately there are not other devices underneath the RP so I might =
not=20
> > be able to test this.
> >=20
> > > > Add quirk to reshuffle igb resources, use BAR 3 to block the proble=
matic
> > > > address.
> > > >=20
> > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >=20
> > > > I know this is ugly and I don't like it either but do not know bett=
er
> > > > way to avoid the regression.
> > > >=20
> > > > I've tried with iommu=3Doff and that did not resolve the issue.
> > > >=20
> > > > I also managed to prove igb works with the same resource layout in
> > > > another system. So identifying the case should probably be tightene=
d
> > > > by matching with more devices than the one used by igb. This is ope=
n
> > > > to discussion. =20
> > >=20
> > > I guess this answers one of my questions above. =20
> >=20
> > Yeah.
> >=20
> > But then there's the sanity check in igb which hints otherwise.
> >=20
> > > > ---
> > > >  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 56 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index de9bbccda21f..e6f3e2ab1fd4 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,=
 0x1536, rom_bar_overlap_defect);
> > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overl=
ap_defect);
> > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overl=
ap_defect);
> > > > =20
> > > > +/*
> > > > + * The igb driver probe (due to reads returning ~0 unexpected) whe=
n BAR 0
> > > > + * appears at 0x9c000000. The cause is unknown. =20
> > >=20
> > > I suppose this is missing "fails"?  "igb driver probe fails"? =20
> >=20
> > Obviously, thanks.
> >=20
>=20
--8323328-1559651554-1790605687=:1168--

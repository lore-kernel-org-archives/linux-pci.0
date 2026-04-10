Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7D73463;
	Fri, 10 Apr 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843536; cv=none; b=sBLaunzpp4ZuUEOYB1x8arrv0JrU3gONBk96/9/HGvB4G1xWg/abIQAeaDyvm5A55A1396o77RVrDCOrxrQLni1OqfOI6iChoOIdUnTRMLJlBQKjqC9x+jiCZRYC/wCf2OUKV4QxxfCjio2bZ5vgmhR6keyH74eozuXmWVlpNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843536; c=relaxed/simple;
	bh=LJTedmk++KoZHRY+NxOICzm/1baOqnTkQt1qfB5CZhs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HCgCYVsgjlRn/m+li7jKow8/hjCd3tFQvO3UAWQssFLsuaGBzP5Dz849SPVeCQNCxIkUUl5WRJXgAtF2w+ygHIT8ykJ77j8lKXiZGF+lNGzI5W2YpETeoPVDzcGiBYUM4z4gTN2BNMl2QhFYGKiOl1mlybcebwjTXn0EUNpGLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFlpTv+q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFlpTv+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775843534; x=1807379534;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=LJTedmk++KoZHRY+NxOICzm/1baOqnTkQt1qfB5CZhs=;
  b=AFlpTv+qhhbi7CjY2vibRXn7Cmzhjwmgz2k2orPrMKj/lrYUdK1e84BB
   6B/tgRslZbtchbIP2kMi5/5BhJADhRDSo5etkIkJpxdLg1X2HdMj3Bunv
   R83W5LnLhs1LicuZxW1ClMq1JWDr2lNQcdqOLJyJ1RiCwaBpfC784g6X8
   5BSIGf1SiHCIBN7U6S2k03QxozFpJYKLT/zTIgGxFF8WV82yOTfeIEKBJ
   VZ9rzIOdz/ezEpC2vIJcJ2EmtsHDkMV/W7EMWRbpwRDTCdHJHqoYbKR/n
   Wnb1cY5vT1EfceXwxra1Pg5FFWwXOA0Z2pJMXBZAPF8hXNmCJRs/1iKgf
   Q==;
X-CSE-ConnectionGUID: n0j3ozlBT6+TWpQLprC11A==
X-CSE-MsgGUID: MaDGX8CERi+6M+nxsCm5HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76830500"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76830500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 10:52:13 -0700
X-CSE-ConnectionGUID: xpyzCYsgTQ2pDDI9D6JcYQ==
X-CSE-MsgGUID: 33p7khnnR8yTRVFaYi+mKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222665235"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 10:52:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 20:52:07 +0300 (EEST)
To: Ratheesh Kannoth <rkannoth@marvell.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, vidyas@nvidia.com, bhelgaas@google.com, 
    Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: clarification: PCI device not getting enumerated
In-Reply-To: <abojekUtFrMxM1RB@rkannoth-OptiPlex-7090>
Message-ID: <2fd5b6c3-ee08-b73b-5d9d-4823d282f0ab@linux.intel.com>
References: <abkqm_LCd9zAM8cW@rkannoth-OptiPlex-7090> <20260317210640.GA84423@bhelgaas> <abojekUtFrMxM1RB@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1950899332-1775840123=:1195"
Content-ID: <2692f4b0-f161-3e21-36f4-e424fd9c5f5a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1950899332-1775840123=:1195
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <39a77d0b-2a6e-b676-0b3b-1f17aa624cd0@linux.intel.com>

On Wed, 18 Mar 2026, Ratheesh Kannoth wrote:

> On 2026-03-18 at 02:36:40, Bjorn Helgaas (helgaas@kernel.org) wrote:
> > On Tue, Mar 17, 2026 at 03:49:07PM +0530, Ratheesh Kannoth wrote:
> > > Hi,
> > >
> > > Below commit breaks PCI enumeration of a marvell PCI endpoint (177d:a=
0e2).
> > > I am not familiar with PCI code, could you please help in debugging/f=
ixing this ?
> > >
> > > Before the commit, the kernel set PCI_REASSIGN_ALL_BUS. So pcibios_as=
sign_all_busses() was true,
> > > and in pci_scan_bridge_extend() the kernel took the =E2=80=9Creassign=
=E2=80=9D path and used EA
> > > (and pci_ea_fixed_busnrs()) to assign bus numbers.
> > >
> > > commit 7246a4520b4bf1494d7d030166a11b5226f6d508
> > > Author: Vidya Sagar <vidyas@nvidia.com>
> > > Date:   Wed May 8 23:11:38 2024 +0530
> > >
> > >     PCI: Use preserve_config in place of pci_flags
> > >
> > >     Use preserve_config in place of checking for PCI_PROBE_ONLY flag =
to enable
> > >     support for "linux,pci-probe-only" on a per host bridge basis.
> > >
> > >     This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
> > >     !PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() ta=
kes care
> > >     of reassigning the resources that are not already claimed.
> >
> > This commit appeared in v6.11.  Apparently on v6.6, 0002:1b:00.0 is
> > detected, and in the v6.12 dmesg below, we don't enumerate it.
> >
> > It looks like 7246a4520b4b can still be reverted cleanly from
> > v7.0-rc1.  Can you collect the complete dmesg logs from v7.0-rc1
> > (where I assume we won't see 0002:1b:00.0) and from v7.0-rc1 with
> > 7246a4520b4b reverted (where I assume we *will* see it) and output of
> > "sudo lspci -vv"?  Use the same kernel config and DT for both, of
> > course.
> Please find dmesg, lspci -vv and device tree output for v7.0-rc1 and v7.0=
-rc1 with patch reverted
> at bottom of this email. Used same kernel config and DT for both.
>=20
> >
> > I don't understand some of the v6.12 dmesg log:
> >
> >   3.187193] pci-host-generic 878000000000.pci: Memory resource size exc=
eeds max for 32 bits
> >   3.313087] pci 0000:00:01.0: PCI bridge to [bus 01] (subtractive decod=
e)
> >   3.319878] pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000ffff=
f]
> >   3.723673] pci 0000:01:00.0: [177d:a075] type 00 class 0x088000 PCIe E=
ndpoint
> >   3.730924] pci 0000:01:00.0: BAR 0 [mem 0x87e0fc000000-0x87e0fc03ffff =
64bit]: from Enhanced Allocation, properties 0x0
> >   3.741710] pci 0000:01:00.0: BAR 4 [mem 0x87e0fcf00000-0x87e0fcffffff =
64bit]: from Enhanced Allocation, properties 0x0
> >
> >   3.448655] pci 0000:00:0c.0: PCI bridge to [bus 02] (subtractive decod=
e)
> >   3.455454] pci 0000:00:0c.0:   bridge window [mem 0x00000000-0x000ffff=
f]
> >   4.425308] pci 0000:02:00.0: [177d:a075] type 00 class 0x088000 PCIe E=
ndpoint
> >   4.432561] pci 0000:02:00.0: BAR 0 [mem 0x87e0f9000000-0x87e0f903ffff =
64bit]: from Enhanced Allocation, properties 0x0
> >
> >   5.744082] pci-host-generic 878020000000.pci: Memory resource size exc=
eeds max for 32 bits
> >   5.799532] pci 0002:00:00.0: PCI bridge to [bus fa] (subtractive decod=
e)
> >   5.806322] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000ffff=
f]
> >   5.820632] pci 0002:00:01.0: PCI bridge to [bus fb] (subtractive decod=
e)
> >   5.827423] pci 0002:00:01.0:   bridge window [mem 0x00000000-0x000ffff=
f]
> >
> > - The "Memory resource size exceeds max for 32 bits" warnings are
> >   interesting.  Is this a DT error?
>
> I dont see any errors as such. Could you guide me how to locate this issu=
e, or suggest any command to check
> the same.

I'm sorry I only noticed this thread now.

Take a look for "root bus resource" lines in your log. When the size of=20
those exceeds 4G, the warning is printed if the mem resource does not have=
=20
IORESOURCE_PREFETCH set (which implies 64-bit window in the old way things=
=20
were spec'ed). That resource printout includes "pref" when the flag is=20
present.

For such resource, I think having IORESOURCE_PREFETCH and=20
IORESOURCE_MEM_64 would be appropriate. And also for any resource that is=
=20
expected to require >4G address even if size itself is small enough.=20
Unfortunately things have not been very consistent when it comes to root=20
bus resources.

The resource bits are given in DT along with the address range (but I'm=20
not an DT expert by any means so I state something stupid when it comes=20
to DTs, take it with a grain of salt :-)):

# pci feild (phys.hi)

npt000ss bbbbbbbb dddddfff rrrrrrrr

n: Relocateable Flag. (0 means relocation, 1 means impossible)
p: Prefetch Flag. (0 means impossible 1 means possible)
t: Aliased Flag.
ss: space code
  00: compositional space
  01: I/O space
  10: 32bit memory space
  11: 64bit memory space

I think your ranges have 0x03... which would seem to say they were 64-bit=
=20
but that flag did not get set (or got cleared) for some reason as there's=
=20
not "64-bit" in the root bus resource printouts.

I suspect the warning goes away if you change 0x03... to 0x43... but you=20
also need to pay attention that pci_parse_request_of_pci_ranges() requires=
=20
also one non-prefetchable resource within each set of root bus resources=20
so or it will trigger another warning if you change them all.

I'm not sure if it resolves the primary issue.

> > - There should only be one subtractive decode bridge per segment, but
> >   there are many here.
> >
> > - Most of the bridge windows look uninitialized ([mem
> >   0x00000000-0x000fffff]), and we don't seem to reassign them, so BARs
> >   of the downstream devices shouldn't be reachable.
> >
> > - Interesting to see so much "Enhanced Allocation"; that's very
> >   unusual.
> >
> > - I guess your DT must have "linux,pci-probe-only"; seems like that
> No.
>=20
> +++ fdt dump from uboot +++
>=20
> crb106-pcie> fdt print /soc/pci@878020000000
> pci@878020000000 {
>         compatible =3D "pci-host-ecam-generic";
>         device_type =3D "pci";
>         msi-map =3D <0x00000000 0x00000037 0x00020000 0x00010000>;
>         bus-range =3D <0x00000000 0x000000ff>;
>         #size-cells =3D <0x00000002>;
>         #address-cells =3D <0x00000003>;
>         dma-coherent;
>         linux,pci-domain =3D <0x00000002>;
>         reg =3D <0x00008780 0x20000000 0x00000000 0x10000000>;
>         iommu-map =3D <0x00000000 0x00000039 0x00020000 0x00010000>;
>         ranges =3D <0x03000000 0x00008400 0x00000000 0x00008400 0x0000000=
0 0x000001f5 0x00000000 0x03000000 0x00000009 0xfc000000 0x00000009 0xfc000=
000 0x00000000 0x03040000>;


--=20
 i.
--8323328-1950899332-1775840123=:1195--

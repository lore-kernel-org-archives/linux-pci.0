Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15A497395
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994054; cv=none; b=awYqjg8oLizKVWL1v6D8d1NiT7ayNUdL/LPFZU9e34wOrNi6wvnUvzTLPQrnO+8u3zS0LwHK4x1pQ4fc0h1LlaJFcXzjzRzP7WndOmEncDp3p4hSKUSqt3WSebOcTEYQd2SNodhtsqBItCuKzoYQhCEmAb3EBy0Sn+jgUnZ2Af4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994054; c=relaxed/simple;
	bh=PRPxU/CYr3KU58h2Z16Av/4ZD3KrKC7FQxnsPW/MF+E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aOozAI4eM6dmLx71+dt5RAzyIPEKxpH6qdwwz8Q6T/OQWtgQWnYDzzIR+Ey1pizf6BB1A3K3jp2GRniZ67L9637zggWBFdGbRdjwKCys+4u9GNn9tu+Ne34Ila/dqnE9zqV8Qa7BxTgrRkN+ohIv3mzPIn2i9t15EMPd1ruHr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVWJcTBB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVWJcTBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789994047; x=1821530047;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=PRPxU/CYr3KU58h2Z16Av/4ZD3KrKC7FQxnsPW/MF+E=;
  b=lVWJcTBBAK38ZGPAkUGyr0uDl9Jby0slfvq0J8xWD+yTwb4WOE63vrjr
   0Mdv716UBCNe+Xzz7GBnssDYZyJoRxMlRS+3kH4KOkpwju5M7FjvjaUSg
   Qj9JFSFbrdCe9udNZ0XYZznf0JriYOLhfYP4QTbVDE0Rt/xW4+ou8mPL5
   zko9ru7TZabRBCCWsvEG5D/RweLJhGF31rkgRfotNc7Or2z4izwMxf/JT
   ntwxJKg3gPSO0UgRjsJbs6MfFmDyL0/urUdch7PJ4wEwa+fcrP9ojDaX1
   cnCV7mGjBDR0dthYq4Olems9geccPK11Fb7Zfq+FTbfwhJSukoOJdsBxP
   w==;
X-CSE-ConnectionGUID: UxaR9F5QSj2OQKLyeqnbCg==
X-CSE-MsgGUID: EtfE0/lPT2WOwgj7i8ugGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94328211"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="94328211"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:34:04 -0700
X-CSE-ConnectionGUID: GUeJX+p1RbiqpedYP1xN0w==
X-CSE-MsgGUID: gqt+G5qiQLyS9Ru7aD0NtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3666311"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:34:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Sep 2026 15:33:52 +0300 (EEST)
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
cc: Nikolas Joshua Britton <nbritton@exabit.io>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
    "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
In-Reply-To: <BY3PR13MB4865407C39BBCF92A742BDF781842@BY3PR13MB4865.namprd13.prod.outlook.com>
Message-ID: <785368ec-0649-b1ee-d4ff-f8111480e799@linux.intel.com>
References: <20260903063124.9316-1-nbritton@exabit.io> <9b63ab96-338a-82aa-3bf7-e56b545a3b47@linux.intel.com> <BY3PR13MB4865407C39BBCF92A742BDF781842@BY3PR13MB4865.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-92614102-1789993967=:1213"
Content-ID: <a0ea16cc-cb46-441f-ae30-25f8e214cce1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-92614102-1789993967=:1213
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0cdef58c-c58e-caf3-650f-3e579cd55f3c@linux.intel.com>

On Mon, 21 Sep 2026, Grochowski, Maciej wrote:

> Hi Ilpo, Nikolas,
>=20
> I have similar instance of what appears to be the same
> multi-composite-resource case.
>=20
> The simplified topology is:
>=20
> =C2=A0 =C2=A0 AST2720 root complex (0001:00:00.0)
> =C2=A0 =C2=A0 =C2=A0 `-- PM50052 Switchtec (0001:01:00.0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `-- eight downstream bridges
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `-- endpoi=
nts 0001:03:00.0 ... 0001:0a:00.0
>=20
> Each endpoint has a 16 MiB BAR2 and a 4 MiB BAR0, both 64-bit
> prefetchable. BAR4 is suppressed by platform policy. Each child bridge
> window is therefore 20 MiB with 16 MiB alignment.
>=20
> pbus_size_mem() accounts for the eight children as 160 MiB. Their
> observed placement uses 32 MiB strides, so the occupied span is 244 MiB.
> Five endpoints receive their BARs; the remaining three do not. The host
> has a 4 GiB prefetchable aperture.
>=20
> I currently carry the max() -> ALIGN() change locally. It grows the
> parent window to 256 MiB and restores all eight endpoints. We use it only
> to unblock this fixed topology and agree that it is not a general
> solution.
>=20
> Ilpo, if you have any work-in-progress code for this, I would be happy
> to test it on this N>=3D8 topology and return allocator traces, lspci out=
put.=C2=A0
> I would much rather help validate the general fix
> than carry the local max() -> ALIGN() workaround into deployment.

Hi,

Thanks for the report.

I do have a series to fix a few regression, likely also this one.

The current trouble is that one of the fixes reshuffles resources in many=
=20
cases which result in one driver failing to probe properly in the tests I=
=20
did in our lab. I suspect my series is still correct and the device/driver=
=20
just fails to work properly with a particular set of resource addresses.

So far, I've not had much luck in root causing the problem and it=20
still requires at least some workaround (a quirk) which I'm only now=20
preparing. This is why I've not yet submitted them but it should be ready=
=20
in a few days. I'm sorry about the extra delay.

--=20
 i.

> Regards,
> Maciej
>=20
> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date: Thursday, September 3, 2026 at 4:54=E2=80=AFAM
> To: Nikolas Joshua Britton <nbritton@exabit.io>
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; regressions@lists.linux.dev <regressions@lists.lin=
ux.dev>;
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: PCI: bridge window undersized when child bridge windows are =
larger than
> their alignment (regression since 3958bf16e2fe, v7.0)
>=20
> On Thu, 3 Sep 2026, Nikolas Joshua Britton wrote:
>=20
> > Hi,
> >
> > On a Mac Pro 7,1 with two Radeon Pro Vega II Duo cards, enabling 32 GB
> > Resizable BARs leaves exactly half the GPU dies with no BAR at all. The
> > shared root-port prefetchable window is sized as the plain sum of its t=
wo
> > child bridge windows, but each child secretly requires a 32 GB-aligned
> > start, so the window that gets allocated is ~32 GB smaller than the spa=
n
> > that is actually needed. The second child of each pair loses,
> > deterministically.
> >
> > There is 1 TiB of free space in the host bridge's _CRS window, so this =
is
> > not address-space exhaustion.
> >
> > This is a regression. On the same machine, with the same script
> > (resize-amdgpu-bars,https://urldefense.com/v3/__https://github.com/exab=
it-io/resize-amdgpu-bars__;!!HUFU
> Ugx-IQ7VcAu3Ktk!DSmzn4BJhDHHjgz9X64_VKu7J2iJYBrJlaenlhDoLhvZyShd55JpgyzFk=
jP5BluDsdC
> Nhw0gZivtlTPuwP6UyFZd2FbvPT1fdA$ ,
> > which performs the sequence under "Reproduction" below at boot) and the
> > same sequence of operations, Ubuntu's 6.8.0-138 (upstream 6.8.12),
> > 6.11.0-29, 6.14.0-37 and 6.17.0-42 kernels all size the shared window a=
t
> > 96 GiB (48 GiB per child) and all four dies get their 32 GiB BAR on the
> > first attempt, every time (each kernel tested from a full power-off).
> > 7.0.0-30 is based on upstream 7.0.12 and fails identically from a cold
> > boot and from a warm reboot. I have traced it to commit 3958bf16e2fe
> > ("PCI: Stop over-estimating bridge window size"), first shipped in v7.0=
;
> > analysis and a proposed one-line fix are below. Ubuntu's setup-bus.c is
> > byte-identical to v7.0.12, which already includes 8cb081667377 ("PCI:
> > Fix alignment calculation for resource size larger than align") and
> > dc4b4d04e1ca ("PCI: Prevent shrinking bridge window from its required
> > size"), so those do not cover this case; current master has no further
> > change to this logic.
> >
> >
> > System
> > ------
> >
> >=C2=A0=C2=A0 Machine:=C2=A0 Apple Inc. MacPro7,1, BIOS 2103.160.2.0.0
> >=C2=A0=C2=A0 Fails:=C2=A0=C2=A0=C2=A0 7.0.0-30-generic (Ubuntu 24.04 HWE=
, 7.0.0-30.30~24.04.1,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 upstream 7.0.12)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 self-built upstream v7.0.12, unpatched, Ubuntu config trimmed
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 with localmodconfig (control; fails identically)
> >=C2=A0=C2=A0 Works:=C2=A0=C2=A0=C2=A0 6.8.0-138-generic=C2=A0 (Ubuntu 24=
=2E04 GA, upstream 6.8.12)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 6.11.0-29-generic=C2=A0 (Ubuntu 24.04, linux-generic-6.11)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 6.14.0-37-generic=C2=A0 (Ubuntu 24.04, linux-generic-6.14)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 6.17.0-42-generic=C2=A0 (Ubuntu 24.04, linux-generic-6.17)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (all four: identical 96 GiB window layout, 4/4 dies, one
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 4-node XGMI hive, no traces; verified 2026-09-02)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 self-built v7.0.12 + the patch below (same config as the
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 control): 4/4 dies, 128 GiB root-port window, cold boot and
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 warm reboot, no traces
> >=C2=A0=C2=A0 Cmdline:=C2=A0 ro log_buf_len=3D16M pci=3Drealloc mitigatio=
ns=3Doff
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (the 6.x and the self-built 7.0.12 boots also carried
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 intremap=3Dno_x2apic_optout; it has no bearing on this)
> >=C2=A0=C2=A0 GPUs:=C2=A0=C2=A0=C2=A0=C2=A0 4x Vega20 [1002:66a3], two di=
es per Vega II Duo card
> >=C2=A0=C2=A0 BAR0 ReBAR capability: 256MB 512MB 1GB 2GB 4GB 8GB 16GB 32G=
B
> >=C2=A0=C2=A0 BAR2 (doorbell): 2MB, fixed in practice
> >
> >
> > Topology
> > --------
> >
> > Each Duo card presents two dies behind ONE root port, each die on its o=
wn
> > sub-bridge chain:
> >
> >=C2=A0=C2=A0+-[0000:06]-+-00.0-[07-0e]--00.0-[08-0e]--+-08.0-[09-0b]--00=
=2E0-[0a-0b]--00.0-[0b]--0
> 0.0=C2=A0 Vega20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> \-10.0-[0c-0e]--00.0-[0d-0e]--00.0-[0e]--00.0=C2=A0 Vega20
> >=C2=A0=C2=A0+-[0000:16]-+-00.0-[17-1e]--00.0-[18-1e]--+-08.0-[19-1b]--00=
=2E0-[1a-1b]--00.0-[1b]--0
> 0.0=C2=A0 Vega20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> \-10.0-[1c-1e]--00.0-[1d-1e]--00.0-[1e]--00.0=C2=A0 Vega20
> >
> > So 08:08.0 and 08:10.0 are siblings sharing the prefetchable window of
> > 07:00.0 / 06:00.0. Each subtree contains one Vega20 with BAR0 =3D 32 GB
> > (alignment 32 GB) plus BAR2 =3D 2 MB, i.e. each child bridge window is
> > 32 GB + 2 MB =3D 0x800200000.
> >
> > Both cards fail identically. Card 2 (16:00.0 / 18:08.0 / 18:10.0) is
> > omitted below for brevity; its trace is byte-for-byte analogous.
> >
> >
> > The arithmetic
> > --------------
> >
> >=C2=A0=C2=A0 host bridge _CRS window=C2=A0=C2=A0 0x90000000000-0x9ffffff=
ffff=C2=A0=C2=A0 1 TiB free
> >=C2=A0=C2=A0 06:00.0 / 07:00.0 window=C2=A0 0x90000000000-0x910003fffff=
=C2=A0=C2=A0 0x1000400000
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (64 GiB + 4 MiB)
> >
> >=C2=A0=C2=A0 08:08.0 window assigned=C2=A0=C2=A0 0x90000000000-0x908001f=
ffff=C2=A0=C2=A0 0x800200000
> >=C2=A0=C2=A0 next free address=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x90800200000
> >=C2=A0=C2=A0 08:10.0 needs 32 GiB alignment, so its next legal start is
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x91000000000
> >=C2=A0=C2=A0 08:10.0 would then end at=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x91800200000
> >=C2=A0=C2=A0 but the parent window ends at=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x91000400000=C2=A0 <-- ~32 GiB short
> >
> >=C2=A0=C2=A0 span actually required=C2=A0=C2=A0=C2=A0 0x90000000000-0x91=
800200000=C2=A0=C2=A0 0x1800200000
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (96 GiB + 2 MiB)
> >=C2=A0=C2=A0 span allocated=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1000400000
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (64 GiB + 4 MiB)
> >=C2=A0=C2=A0 shortfall=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x7ffe00000
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (32 GiB - 2 MiB)
> >
> > The telling detail: 0x90800200000 + 0x800200000 =3D 0x91000400000, whic=
h is
> > *exactly* the parent window's exclusive end. In other words, had the ch=
ild
> > bridge windows only needed ~1 MiB alignment, the two of them would have
> > fit perfectly, to the byte. The sizing pass produced a window that is
> > correct if and only if the children can be packed back-to-back, which
> > they cannot, because the assignment pass then enforces the real 32 GiB
> > alignment inherited from the BAR inside each child.
> >
> >
> > Good kernel, for comparison
> > ---------------------------
> >
> > Same hardware, same steps, 6.17.0-42 (6.8, 6.11 and 6.14 are identical)=
=2E
> > The parent is sized for the worst-case packing, and both children fit:
> >
> >=C2=A0=C2=A0 0000:06:00.0: 90000000000-917ffffffff [size=3D96G]=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <- shared parent
> >=C2=A0=C2=A0 0000:08:08.0: 90000000000-90bffffffff [size=3D48G]
> >=C2=A0=C2=A0 0000:08:10.0: 90c00000000-917ffffffff [size=3D48G]
> >=C2=A0=C2=A0 0000:0b:00.0: Region 0: Memory at 90000000000 (64-bit, pref=
etchable) [size=3D32G]
> >=C2=A0=C2=A0 0000:0e:00.0: Region 0: Memory at 91000000000 (64-bit, pref=
etchable) [size=3D32G]
> >
> > i.e. 96 GiB =3D 3 x 32 GiB: each child gets (32 GiB + 2 MiB) rounded up=
 to
> > the next 32 GiB boundary plus slack, so the second child's aligned star=
t
> > is always inside the parent. That is the 3A + eps span from the arithme=
tic
> > below, and 7.0 allocates 2A + 2 eps instead.
> >
> >
> > dmesg (7.0)
> > -----------
> >
> > Sizing and assignment of the shared window, then the two children:
> >
> >=C2=A0=C2=A0 pci 0000:06:00.0: bridge window [mem 0x90000000000-0x910003=
fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0 pci 0000:07:00.0: bridge window [mem 0x90000000000-0x910003=
fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0 pci 0000:08:08.0: bridge window [mem 0x90000000000-0x908001=
fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0 pci 0000:08:10.0: bridge window [mem size 0x800200000 64bit=
 pref]: can't assign;
> no space
> >=C2=A0=C2=A0 pci 0000:08:10.0: bridge window [mem size 0x800200000 64bit=
 pref]: failed to
> assign
> >
> > The failure then cascades down the losing chain, and the endpoint is le=
ft
> > with neither BAR0 nor BAR2:
> >
> >=C2=A0=C2=A0 pci 0000:0c:00.0: bridge window [mem size 0x800200000 64bit=
 pref]: can't assign;
> no space
> >=C2=A0=C2=A0 pci 0000:0d:00.0: bridge window [mem size 0x800200000 64bit=
 pref]: can't assign;
> no space
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: =
can't assign; no space
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: =
failed to assign
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: c=
an't assign; no space
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: f=
ailed to assign
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 5 [mem 0x74600000-0x7467ffff]: assign=
ed
> >
> > Note BAR5 (the 512 KB register aperture, non-prefetchable) still gets
> > assigned. That matters for the downstream impact described below: the
> > device is half-alive rather than obviously dead.
> >
> > Resulting state, from lspci -vv. The entire losing chain has no
> > prefetchable window whatsoever:
> >
> >=C2=A0=C2=A0 0000:08:08.0: 90000000000-908001fffff [size=3D32770M]=C2=A0=
=C2=A0=C2=A0 <- winner
> >=C2=A0=C2=A0 0000:09:00.0: 90000000000-908001fffff [size=3D32770M]
> >=C2=A0=C2=A0 0000:0a:00.0: 90000000000-908001fffff [size=3D32770M]
> >=C2=A0=C2=A0 0000:08:10.0: [disabled]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-=
 loser
> >=C2=A0=C2=A0 0000:0c:00.0: [disabled]
> >=C2=A0=C2=A0 0000:0d:00.0: [disabled]
> >=C2=A0=C2=A0 0000:06:00.0: 90000000000-910003fffff [size=3D65540M]=C2=A0=
=C2=A0=C2=A0 <- shared parent
> >
> > And /sys/bus/pci/devices/0000:0e:00.0/resource:
> >
> >=C2=A0=C2=A0 0x0000000000000000 0x0000000000000000 0x0000000000000000=C2=
=A0=C2=A0 BAR0 unassigned
> >=C2=A0=C2=A0 0x0000000000000000 0x0000000000000000 0x0000000000000000
> >=C2=A0=C2=A0 0x0000000000000000 0x0000000000000000 0x0000000000000000=C2=
=A0=C2=A0 BAR2 unassigned
> >=C2=A0=C2=A0 0x0000000000000000 0x0000000000000000 0x0000000000000000
> >=C2=A0=C2=A0 0x0000000000006000 0x00000000000060ff 0x0000000000040101
> >=C2=A0=C2=A0 0x0000000074600000 0x000000007467ffff 0x0000000000040200=C2=
=A0=C2=A0 BAR5 assigned
> >
> >
> > Observation
> > -----------
> >
> > Observed, and I think not in dispute:
> >
> >=C2=A0=C2=A0 - the sizing pass produced a parent window exactly equal to=
 the sum of
> >=C2=A0=C2=A0=C2=A0=C2=A0 the two child window sizes (0x800200000 * 2 =3D=
 0x1000400000);
> >=C2=A0=C2=A0 - the assignment pass refused to place the second child at
> >=C2=A0=C2=A0=C2=A0=C2=A0 0x90800200000, which is 2 MiB-aligned and would=
 have fit exactly;
> >=C2=A0=C2=A0 - therefore assignment enforced an alignment that sizing di=
d not budget
> >=C2=A0=C2=A0=C2=A0=C2=A0 for.
> >
> > Where in the code: pbus_size_mem() sums the child bridge windows
> > without regard to the alignment the assignment pass will enforce on
> > them. The analysis, a small model that reproduces every number above,
> > and a one-line fix that has been A/B tested on this machine are in
> > "Root cause" and "Proposed fix" below, before the list of gaps.
> >
> > The shortfall is structural rather than specific to 32 GB. For N=3D2
> > siblings each needing (A + eps) at alignment A, the required span is
> > 2A + (A + eps) =3D 3A + eps, while the sum is 2A + 2eps. I have confirm=
ed
> > this at the other end of the range: after one failed 32 GiB attempt,
> > writing the ReBAR index back to 256 MiB and re-enumerating fails in
> > exactly the same way, because the firmware's original 770 MiB windows
> > (~3A + eps for A =3D 256 MiB) are gone and the kernel re-sizes the pare=
nt
> > to 2A + 2 eps:
> >
> >=C2=A0=C2=A0 pci 0000:06:00.0: bridge window [mem 0x90000000000-0x900203=
fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (512 MiB + 4 MiB)
> >=C2=A0=C2=A0 pci 0000:08:08.0: bridge window [mem 0x90000000000-0x900101=
fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0 pci 0000:08:10.0: bridge window [mem size 0x10200000 64bit =
pref]: can't assign;
> no space
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 0 [mem size 0x10000000 64bit pref]: c=
an't assign; no space
> >=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: c=
an't assign; no space
> >
> > So on 7.0 there is no in-place recovery once the kernel has re-sized th=
e
> > window: the only layouts that ever work are the ones the firmware left
> > behind. 16 GB and 8 GB remain untested but I would not expect them to
> > differ.
> >
> >
> > Downstream impact: this is not a soft failure
> > ---------------------------------------------
> >
> > The BAR-less die is not merely unusable. Because BAR5 is still assigned=
,
> > amdgpu probes it, its register reads return garbage, and
> > RCC_IOV_FUNC_IDENTIFIER comes back with bit 0 set. The driver concludes
> > the device is an SR-IOV *virtual function*:
> >
> >=C2=A0=C2=A0 amdgpu 0000:0b:00.0: register mmio base: 0x74400000=C2=A0=
=C2=A0=C2=A0=C2=A0 <- healthy die
> >=C2=A0=C2=A0 amdgpu 0000:0e:00.0: register mmio base: 0x74600000
> >=C2=A0=C2=A0 amdgpu 0000:0e:00.0: MCBP is enabled=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <- only set when
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgp=
u_sriov_vf()
> >
> > It then calls amdgpu_virt_request_full_gpu() ->
> > xgpu_ai_request_full_gpu_access() and waits forever for a hypervisor
> > mailbox that does not exist:
> >
> >=C2=A0=C2=A0 amdgpu 0000:0e:00.0: trn=3D2 ACK should not assert! wait ag=
ain !
> >=C2=A0=C2=A0 (repeating roughly 2490 times per 5 seconds, indefinitely)
> >
> >=C2=A0=C2=A0 xgpu_ai_mailbox_trans_msg+0x1a9/0x1f0 [amdgpu]
> >=C2=A0=C2=A0 xgpu_ai_send_access_requests+0x21/0xe0 [amdgpu]
> >=C2=A0=C2=A0 xgpu_ai_request_full_gpu_access+0x1a/0x30 [amdgpu]
> >=C2=A0=C2=A0 amdgpu_virt_request_full_gpu+0x2a/0x70 [amdgpu]
> >=C2=A0=C2=A0 amdgpu_device_ip_early_init.constprop.0+0x173/0x780 [amdgpu=
]
> >=C2=A0=C2=A0 amdgpu_device_init+0x83d/0x1180 [amdgpu]
> >=C2=A0=C2=A0 amdgpu_driver_load_kms+0x1a/0xd0 [amdgpu]
> >=C2=A0=C2=A0 amdgpu_pci_probe+0x1df/0x590 [amdgpu]
> >
> > modprobe wedges in uninterruptible D state holding the device mutex,
> > blocks the AER IRQ thread, and never returns:
> >
> >=C2=A0=C2=A0 INFO: task irq/34-aerdrv:1554 blocked for more than 122 sec=
onds.
> >=C2=A0=C2=A0 INFO: task irq/34-aerdrv:1554 is blocked on a mutex likely =
owned by
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task modprobe:1583.
> >
> > SIGKILL does not touch it; systemd's TimeoutStartSec fires and the unit
> > goes to "failed" while the task stays in the cgroup. The machine needs =
a
> > reboot. The remaining two dies are never probed at all.
> >
> > So the practical outcome of the sizing bug with a plain "modprobe amdgp=
u"
> > is: 1 of 4 GPUs usable (the healthy die of the first card; its BAR-less
> > sibling wedges the probe and the second card is never reached), no XGMI
> > hive (kfd reports a single-node hive), and an unkillable task on every
> > boot. Keeping the BAR-less dies away from the driver with
> > driver_override, which resize-amdgpu-bars now does, gets 2 of 4 dies an=
d
> > a 2-node hive; that is the "2/4 dies" figure under "Proposed fix" below=
=2E
> > Whether amdgpu should be more defensive about probing a device with
> > an unassigned BAR0 is a separate question for amd-gfx, and I've cc'd th=
em,
> > but the PCI-side undersizing is the trigger.
> >
> >
> > Reproduction
> > ------------
> >
> > With the four dies at their default 256 MB BAR0 (this is what
> > resize-amdgpu-bars does at boot, done by hand):
> >
> >=C2=A0=C2=A0 1. Set BAR0 to 32 GB on all four dies (ReBAR control regist=
er at
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capability offset 0x200, control at 0x208=
, size index in bits 8-13,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 15 =3D 2^35):
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setpci -s 0000:0b:00.0 0x208.=
l=3D00000f40
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (likewise for 0e:00.0, 1b:00.=
0, 1e:00.0)
> >
> >=C2=A0=C2=A0 2. Force full re-enumeration so the kernel re-sizes every b=
ridge window
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from scratch:
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo 1 > /sys/bus/pci/devices=
/0000:06:00.0/remove
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo 1 > /sys/bus/pci/devices=
/0000:16:00.0/remove
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo 1 > /sys/bus/pci/rescan
> >
> >=C2=A0=C2=A0 3. dmesg shows the "can't assign; no space" trace above; 0e=
:00.0 and
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1e:00.0 have BAR0 and BAR2 unassigned, 0b=
:00.0 and 1b:00.0 are fine.
> >
> > Fully deterministic across many attempts: the first-enumerated die of
> > each card always wins.
> >
> >
> > Root cause
> > ----------
> >
> > Since 3958bf16e2fe, pbus_size_mem() sizes a bridge window as
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 size +=3D max(r_size, align);=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* per child */
> >=C2=A0=C2=A0=C2=A0=C2=A0 size0 =3D ALIGN(size, win_align);=C2=A0=C2=A0=
=C2=A0 /* win_align =3D 1 MB */
> >
> > with calculate_head_align() making only the window *start* satisfy the
> > largest child alignment. The tight fit is gap-free only if, in the
> > descending-alignment assignment order, every child's size is a multiple
> > of the alignments of the children placed after it. That holds for BARs
> > (size =3D=3D alignment) but not for bridge windows: their size is the s=
um of
> > what is below them, while their alignment (IORESOURCE_STARTALIGN) is th=
at
> > of the largest BAR below them.
> >
> > Here each sub-bridge window holds BAR0 (32 GiB) + BAR2 (2 MiB doorbell)=
,
> > so it is sized 32 GiB + 2 MiB with 32 GiB alignment. The root port sums
> > two of them: 64 GiB + 4 MiB. Assignment then places the first child at
> > offset 0 (ends at 32 GiB + 2 MiB) and must put the second at the next
> > 32 GiB boundary, i.e. 64 GiB .. 96 GiB + 2 MiB. Needed 96 GiB + 2 MiB,
> > sized 64 GiB + 4 MiB -> "can't assign; no space" for the second die.
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:06:00.0: bridge window [mem 0x90000000=
000-0x910003fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:08:08.0: bridge window [mem 0x90000000=
000-0x908001fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 0 [mem 0x90000000000-0x90=
7ffffffff 64bit pref]: assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 2 [mem 0x90800000000-0x90=
8001fffff 64bit pref]: assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 6=
4bit pref]: can't assign; no
> space
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64=
bit pref]: can't assign; no
> space
> >
> > The same arithmetic at the default 256 MiB BAR0 gives 512 MiB + 4 MiB
> > sized vs 768 MiB + 2 MiB needed, which is why even reverting the BAR
> > size does not recover (the firmware's original windows were larger).
> >
> > Up to v6.17, calculate_memsize() rounded each bridge window up to its o=
wn
> > min_align (ALIGN(size, min_align); the old calculate_mem_align() gave
> > 16 GiB here), so each sub-bridge window was 48 GiB and the root port
> > 96 GiB, and siblings packed by accident. A small model of both versions
> > of pbus_size_mem() reproduces every number seen on this machine
> > (48G/96G on 6.8-6.17; 32770M/65540M and 258M/516M on 7.0).
> >
> > This is the tail-side sibling of the head-side under-estimation Guenter
> > Roeck raised on 2026-03-05 for the same series (4M@4M + 3M@1M + 1M@1M
> > needing 9 MiB in an 8 MiB window), which 8cb081667377 addressed for the
> > head alignment bookkeeping only.
> >
> > Proposed fix
> > ------------
> >
> > Pad a child up to its alignment when its size is not a multiple of it:
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size +=3D max(r_size, a=
lign);
> >=C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size +=3D ALIGN(r_size,=
 align);
> >
> > This is a no-op for BARs, so the v7.0 tight fit for leaf resources is
> > kept; for bridge windows it restores the pre-v7.0 parent sizing. It
> > over-estimates by up to one alignment unit (128 GiB here rather than th=
e
> > exact 96 GiB + 2 MiB); an exact version would have to walk the children
> > in assignment order and simulate the offsets. The diff follows below th=
e
> > "---" line at the end of this mail; the full patch with changelog and
> > Signed-off-by is ready and I will send it as a separate [PATCH] if that
> > is preferred.
> >
> > Tested on the same machine, same script, same sequence (2026-09-02):
> >
> >=C2=A0=C2=A0 v7.0.12 unpatched (control): identical to 7.0.0-30. Root-po=
rt window
> >=C2=A0=C2=A0=C2=A0=C2=A0 0x90000000000-0x900203fffff (512 MiB + 4 MiB at=
 the 256 MiB baseline
> >=C2=A0=C2=A0=C2=A0=C2=A0 the kernel falls back to), "can't assign; no sp=
ace" on 0e:00.0 and
> >=C2=A0=C2=A0=C2=A0=C2=A0 1e:00.0, 2/4 dies, 2-node XGMI hive.
> >=C2=A0=C2=A0 v7.0.12 + patch: 4/4 dies with 32 GiB BAR0, 4-node XGMI hiv=
e, from a
> >=C2=A0=C2=A0=C2=A0=C2=A0 cold boot and again from a warm reboot. Window =
layout for card 1:
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:06:00.0: bridge window [me=
m 0x90000000000-0x91fffffffff 64bit pref]:
> assigned=C2=A0=C2=A0 (128 GiB)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:07:00.0: bridge window [me=
m 0x90000000000-0x91fffffffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:08:08.0: bridge window [me=
m 0x90000000000-0x90fffffffff 64bit pref]:
> assigned=C2=A0=C2=A0 (64 GiB)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:09:00.0: bridge window [me=
m 0x90000000000-0x90fffffffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0a:00.0: bridge window [me=
m 0x90000000000-0x908001fffff 64bit pref]:
> assigned=C2=A0=C2=A0 (32 GiB + 2 MiB)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 0 [mem 0x9000=
0000000-0x907ffffffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 2 [mem 0x9080=
0000000-0x908001fffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:08:10.0: bridge window [me=
m 0x91000000000-0x91fffffffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 0 [mem 0x9100=
0000000-0x917ffffffff 64bit pref]:
> assigned
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0e:00.0: BAR 2 [mem 0x9180=
0000000-0x918001fffff 64bit pref]:
> assigned
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 The padding is applied once, where 09:00.0 sums=
 its 32 GiB + 2 MiB
> >=C2=A0=C2=A0=C2=A0=C2=A0 child (alignment 32 GiB) to 64 GiB; the levels =
above are plain sums
> >=C2=A0=C2=A0=C2=A0=C2=A0 of already-aligned children. Net cost 128 GiB p=
er card instead of
> >=C2=A0=C2=A0=C2=A0=C2=A0 the exact 96 GiB + 2 MiB, out of 1 TiB availabl=
e.
> >
> >
> > Why the repro does not use the sysfs resource0_resize interface
> > ----------------------------------------------------------------
> >
> > The repro above pokes the ReBAR control register with setpci and then
> > forces a rescan instead of using the sanctioned interface
> > (echo 15 > .../resource0_resize). That is deliberate: the sanctioned
> > interface cannot grow a die that sits behind the card's own PCIe switch=
,
> > on any kernel, and that is the reason resize-amdgpu-bars exists at all.
> > It was the first thing I tried, and I re-measured it on 7.0.12 for this
> > report so the failure is on record with the kernel's own lines.
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 Measured (7.0.12 vanilla, unit masked, amdgpu b=
lacklisted, so all
> >=C2=A0=C2=A0=C2=A0=C2=A0 four dies sat at the firmware 256 MB and nothin=
g was bound; the
> >=C2=A0=C2=A0=C2=A0=C2=A0 sibling die's BARs stay assigned whether or not=
 a driver is bound):
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # echo 15 > /sys/bus/pci/devices/00=
00:0b:00.0/resource0_resize
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write error: No space left on devic=
e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (-ENOSP=
C)
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 0 [mem 0x9ffe=
0000000-0x9ffefffffff 64bit pref]:
> releasing
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:0a:00.0: bridge windo=
w [mem 0x9ffe0000000-0x9fff01fffff 64bit
> pref]: releasing
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:09:00.0: bridge windo=
w [mem 0x9ffe0000000-0x9fff01fffff 64bit
> pref]: releasing
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:08:08.0: bridge windo=
w [mem 0x9ffe0000000-0x9fff01fffff 64bit
> pref]: releasing
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:07:00.0: bridge windo=
w [mem 0x9ffc0000000-0x9fff01fffff 64bit
> pref]: was not released (still contains assigned resources)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:06:00.0: bridge windo=
w [mem 0x9ffc0000000-0x9fff01fffff 64bit
> pref]: was not released (still contains assigned resources)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcieport 0000:08:08.0: bridge windo=
w [mem size 0x800200000 64bit pref]: can't
> assign; no space
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 0 [mem size 0=
x800000000 64bit pref]: can't assign; no
> space
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci 0000:0b:00.0: BAR 0 [mem 0x9ffe=
0000000-0x9ffefffffff 64bit pref]: old
> value restored
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 Parent window (06:00.0 and 07:00.0, shared by b=
oth dies) before and
> >=C2=A0=C2=A0=C2=A0=C2=A0 after: 0x9ffc0000000-0x9fff01fffff, 770 MB, unc=
hanged. Writing 8 back
> >=C2=A0=C2=A0=C2=A0=C2=A0 returned 0 and every window came back byte-iden=
tical. The whole thing
> >=C2=A0=C2=A0=C2=A0=C2=A0 took under half a second and nothing hung.
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 So the sysfs path fails the same way for the us=
er (-ENOSPC, "old
> >=C2=A0=C2=A0=C2=A0=C2=A0 value restored", BAR stays 256 MB) but for a re=
ason one level below
> >=C2=A0=C2=A0=C2=A0=C2=A0 the sizing bug: the shared window on the two br=
idges above the switch
> >=C2=A0=C2=A0=C2=A0=C2=A0 is never released while the sibling die's BARs =
are assigned in it, so
> >=C2=A0=C2=A0=C2=A0=C2=A0 the three bridge windows on the way down have t=
o grow to 32 GB + 2 MB
> >=C2=A0=C2=A0=C2=A0=C2=A0 inside a 770 MB parent, and cannot. The in-plac=
e path never gets to
> >=C2=A0=C2=A0=C2=A0=C2=A0 re-size the shared window at all; it is limited=
 to what fits in the
> >=C2=A0=C2=A0=C2=A0=C2=A0 firmware layout. That is independent of this bu=
g (it would fail the
> >=C2=A0=C2=A0=C2=A0=C2=A0 same way on a fixed kernel and on 6.17), and it=
 is why my tool grows a
> >=C2=A0=C2=A0=C2=A0=C2=A0 dual-die module by removing the whole module an=
d rescanning from the
> >=C2=A0=C2=A0=C2=A0=C2=A0 root port instead. The sysfs write is not a wor=
karound here and does
> >=C2=A0=C2=A0=C2=A0=C2=A0 not exercise the sizing path this patch fixes; =
the setpci + rescan
> >=C2=A0=C2=A0=C2=A0=C2=A0 repro and amdgpu's own resize at probe (below) =
are the two routes that
> >=C2=A0=C2=A0=C2=A0=C2=A0 reach it, and both fail with "can't assign; no =
space" on unpatched 7.0.
> >
> >
> > What I have not tested
> > ----------------------
> >
> > I want to be straight about the gaps:
> >
> >=C2=A0=C2=A0 - I have not tested 16 GB or 8 GB BARs (see the structural =
argument
> >=C2=A0=C2=A0=C2=A0=C2=A0 above; 256 MB and 32 GB are the two data points=
).
> >
> >=C2=A0=C2=A0 - amdgpu's own resize at probe time (amdgpu_device_resize_f=
b_bar ->
> >=C2=A0=C2=A0=C2=A0=C2=A0 pci_resize_resource) hits the same wall on 7.0.=
 From an earlier boot
> >=C2=A0=C2=A0=C2=A0=C2=A0 where amdgpu was allowed to autoload with the d=
ies still at 256 MB:
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu 0000:1b:00.0: BAR 2 [mem 0xb=
fff0000000-0xbfff01fffff 64bit pref]: old
> value restored
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu 0000:1b:00.0: BAR 0 [mem 0xb=
ffe0000000-0xbffefffffff 64bit pref]: old
> value restored
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu 0000:1b:00.0: Not enough PCI=
 address space for a large BAR.
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu 0000:1b:00.0: [drm] Detected=
 VRAM RAM=3D32752M, BAR=3D256M
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0 That path fails closed (ReBAR index reverted, d=
river continues at
> >=C2=A0=C2=A0=C2=A0=C2=A0 256 MB), so it does not trigger the hang descri=
bed above, but it
> >=C2=A0=C2=A0=C2=A0=C2=A0 does not get a large BAR either.
> >
> >=C2=A0=C2=A0 - I have not bisected by booting: the commit was identified=
 by reading
> >=C2=A0=C2=A0=C2=A0=C2=A0 setup-bus.c across the versions and confirmed b=
y the A/B test of
> >=C2=A0=C2=A0=C2=A0=C2=A0 v7.0.12 with and without the one-line patch (se=
e "Proposed fix"). If
> >=C2=A0=C2=A0=C2=A0=C2=A0 a real bisection would still help I can run it.
> >
> > Happy to test patches, gather more traces, or run with any debug option=
s
> > that would help. The machine is otherwise idle and I can reboot it free=
ly.
> >
> >
> > Available on request (not attached; the largest is 1.1 MB):
> >=C2=A0=C2=A0 - full dmesg from the failing boot
> >=C2=A0=C2=A0 - lspci -vvnn and lspci -tvnn
> >=C2=A0=C2=A0 - the trimmed allocation trace for card 1
> >=C2=A0=C2=A0 - lspci -vv from the 6.17 boot (working layout)
> >=C2=A0=C2=A0 - the sizing model (pci-window-sim.py, 130 lines)
> >=C2=A0=C2=A0 - full dmesg from the v7.0.12 control boot and the v7.0.12 =
+ patch boot
> >=C2=A0=C2=A0 - lspci -vvnn from the v7.0.12 + patch boot
> >
> >
> > #regzbot introduced: 3958bf16e2fe
> >
> > ---
> >=C2=A0 drivers/pci/setup-bus.c | 12 +++++++++++-
> >=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1329,7 +1329,17 @@ static void pbus_size_mem(struct pci_bus *bus, s=
truct
> resource *b_res,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r_size =
=3D resource_size(r);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size +=3D max(r_size, a=
lign);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Resources are a=
ssigned in descending alignment
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * order, so a tig=
ht-fit sum is only gap-free if each
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is a multi=
ple of the alignments that follow.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * BARs always are=
 (size =3D=3D align); bridge windows
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are not (arbitr=
ary size, IORESOURCE_STARTALIGN to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * their largest B=
AR), and two 32G+2M windows aligned
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to 32G need 96G=
+2M of span, not 64G+4M. Pad such
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * resources up to=
 their alignment.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size +=3D ALIGN(r_size,=
 align);
>=20
> This is not required for case where there's just a single composite
> resource so it will add again the space wastage back I've tried hard to
> remove. And because of that wasted space, it will regress on some
> systems/scenarios so it's, while simple looking "solution", a non-starter=
=2E
>=20
> I didn't want to read the long explanation which contained just snippets
> but this likely is the same case Bjorn reported to me privately that
> relates to two (or more) composite resources (resources whose size do
> not align with the final align).
>=20
> I've been busy with dealing another set of resource problems caused by
> 9036bd0efcb6 but I was going to write the fix to this problem soon as
> well.
>=20
> The final head alignment is not calculated until later in pbus_size_mem()
> and may be different for case with optional resources. The correction to
> the window should be based on those real alignments, not on the resource'=
s
> own alignment, and only applied to the final size if there's more than on=
e
> composite resources in the first place.
>=20
> --
> =C2=A0i.
>=20
>=20
>=20
>=20
--8323328-92614102-1789993967=:1213--

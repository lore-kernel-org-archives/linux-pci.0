Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775C3D3D1B
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877028; cv=none; b=FSkcLjxBiqDL4mtM7UMGmU7YiqSDGjQ3frqsR3/ufiXFyZBxVw4AHj8KmXM0KBIKRBLkpd4qwEgtLhxLYA9HXZeqhQ2ih44WawTUCtOjwIeu2Y1hpWfHoTQcb/o30plTfT3ibZVNH6KY9B5kLSaq2pZlhO7WTUkmtFb9g72UEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877028; c=relaxed/simple;
	bh=B8Khx6Vw/ZGtGl7pwfHbN0sgYlhMejRKCulR7rGTqIw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rdm4pHBACAejxFEJvugSqRoEQ0kvEoPjzpY2uWzVR0tke0wBDx13zCn++hVJl2Pia/1Y0Zt0oLR5i3+xZ52YeElyjXtEPQ3HX728RiuI7AWBqa9G44L7PlzPQmJOCMey7dbbIswzFneROoY45gquZlS4zb06gioCHmkje38LPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xr9BCUMc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xr9BCUMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774877025; x=1806413025;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B8Khx6Vw/ZGtGl7pwfHbN0sgYlhMejRKCulR7rGTqIw=;
  b=Xr9BCUMcm69Q2/tseVV7mQaYmvf70d3PLapqXH0nN7tZuj2lJnr8ut4m
   nVM2h5qq8exjDe1dGKUg0TpnKLEcCx9zSrVcwpNR3AOAa80Wu3Z57+4hI
   lcN8egUnGRJObcawrzWHzotj4SKW8ecxtXAmqlXw/utEEOk9LSpI5FQA3
   NlYOdvgS82dEjWQC2CrYAs9EpM1+ok3y1jHRCQ/G0/Xn0+OPTvLweNnAb
   t85StjFVJFu0kWE+nJMoBENlfGCnDAWyETcc+eK30xW5sHTmZ3wSVgPfg
   sTAmsbzJYTjvv4Hu6zVuWDzmNCQPJaYY7hHguTov2KwMfJtrYtI9UeWNg
   g==;
X-CSE-ConnectionGUID: BNH4JYTIT4+vyrIZNVq46w==
X-CSE-MsgGUID: TBAHm0azQbCAYmcquf4pGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75046089"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75046089"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:23:45 -0700
X-CSE-ConnectionGUID: CKKqauxZSPGchAJyZVhHXw==
X-CSE-MsgGUID: uLwcZ9rdRv+rUN8vRdQR/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="223178958"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:23:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Mar 2026 16:23:40 +0300 (EEST)
To: Cristian Cocos <cristi@ieee.org>
cc: linux-pci@vger.kernel.org
Subject: Re: ReBAR over Thunderbolt
In-Reply-To: <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>
Message-ID: <2f6838fa-dd7f-848d-4788-8b04a23b5753@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>  <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com> <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-801996061-1774877020=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-801996061-1774877020=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Mar 2026, Cristian Cocos wrote:

> Here below is the log excerpt annotated with section headers as
> promised. Full raw log file to be provided upon request.
>=20
> =3D=3D=3D ReBAR Hotplug Resize Failure on Thunderbolt 4 =3D=3D=3D
> Hardware: AMD RX 9060 XT (Navi 44, PCI 1002:7590, 16 GB VRAM) in Razer
> Core X V2 eGPU
> Host: Framework Laptop 16 (AMD Ryzen 7 7840HS), TB4 via USB4 root port
> Kernel: linux-zen 6.19.8.zen1-1-zen (Arch)
> Driver: amdgpu (rebar=3D0 NOT set =E2=80=94 allowing resize attempt)
> Boot: eGPU disconnected at boot, then hotplugged after login
>=20
> PCI topology:
>   00:07.0 (root port) =E2=86=92 02:00.0 (TB switch) =E2=86=92 03:00.0 (DS=
 port)
>     =E2=86=92 04:00.0 (AMD switch) =E2=86=92 05:00.0 (AMD switch) =E2=86=
=92 06:00.0 (GPU)
>=20
> Note: When this GPU is connected at boot with BIOS "OS Native Resource
> Balance" disabled AND thunderbolt.host_reset=3D0 on the kernel cmdline,
> the firmware pre-assigns a full 16 GB BAR and the driver uses it
> without needing to resize. The hotplug path below shows where the
> kernel's runtime resize fails.
>=20
> =3D=3D=3D Relevant dmesg lines (BAR discovery, resize attempt, failure) =
=3D=3D=3D
>=20
> --- Initial BAR discovery during TB hotplug enumeration ---
> [  289.893050] pci 0000:06:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit
> pref]
> [  289.893057] pci 0000:06:00.0: BAR 2 [mem 0x00000000-0x001fffff 64bit
> pref]
> [  289.893062] pci 0000:06:00.0: BAR 4 [io  0x0000-0x00ff]
> [  289.893067] pci 0000:06:00.0: BAR 5 [mem 0x00000000-0x0007ffff]
>=20
> --- Bridge window assignment (root port allocates 4 GB prefetchable) --
> -
> [  289.895531] pci 0000:02:00.0: bridge window [mem 0x10000000-
> 0x204fffff 64bit pref] to [bus 03-2b] add_size 600000 add_align
> 10000000
> [  289.895535] pci 0000:02:00.0: bridge window [mem 0x00100000-
> 0x005fffff] to [bus 03-2b] add_size 600000 add_align 100000
> [  292.204937] pcieport 0000:00:07.0: bridge window [mem 0x6000000000-
> 0x60ffffffff 64bit pref]: was not released (still contains assigned
> resources)
>=20
> --- Initial BAR assignment (256 MB) ---
> [  289.895644] pci 0000:06:00.0: BAR 0 [mem 0x6000000000-0x600fffffff
> 64bit pref]: assigned
> [  289.895663] pci 0000:06:00.0: BAR 2 [mem 0x6010000000-0x60101fffff
> 64bit pref]: assigned
> [  289.895681] pci 0000:06:00.0: BAR 5 [mem 0x60000000-0x6007ffff]:
> assigned
>=20
> --- amdgpu driver loads, releases BARs for resize ---
> [  292.191384] amdgpu 0000:06:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [  292.204930] amdgpu 0000:06:00.0: BAR 0 [mem 0x6000000000-
> 0x600fffffff 64bit pref]: releasing
> [  292.204932] amdgpu 0000:06:00.0: BAR 2 [mem 0x6010000000-
> 0x60101fffff 64bit pref]: releasing
> [  292.204933] pcieport 0000:05:00.0: bridge window [mem 0x6000000000-
> 0x60101fffff 64bit pref]: releasing
> [  292.204934] pcieport 0000:04:00.0: bridge window [mem 0x6000000000-
> 0x60101fffff 64bit pref]: releasing
> [  292.204935] pcieport 0000:03:00.0: bridge window [mem 0x6000000000-
> 0x60101fffff 64bit pref]: releasing

> [  292.204936] pcieport 0000:02:00.0: bridge window [mem 0x6000000000-
> 0x60f04fffff 64bit pref]: was not released (still contains assigned
> resources)
> [  292.204937] pcieport 0000:00:07.0: bridge window [mem 0x6000000000-
> 0x60ffffffff 64bit pref]: was not released (still contains assigned
> resources)

Hi,

These 2 lines indicate where the reason likely lies. BAR resize attempted=
=20
to release these windows but there are some sibling resourcers that=20
prevent the resize from succeeding. I cannot see what those resources are=
=20
from these excerpts.

Basically, the resize walks upwards in the PCI hierarchy and tries to free=
=20
any bridge window it encounters in order to allow them to be sized freely=
=20
(enlarged). The device whose BAR is being resized has its resources=20
released prior to the resize commencing, but any other device under any of=
=20
those bridge windows are not and they pin their bridge windows in-place=20
(it won't be possible to release them in the general case as some of=20
those devices may be in use at this point).

It may be possible to workaround this problem by manually removing the=20
sibling devices that pin the relevant bridge windows, performing resize=20
through sysfs manually, and then rescanning (but with GPUs it may be=20
problematic if it's the primary GPU).

Providing a large enough pci=3Dhpmmioprefsize=3Dxx parameter might be able =
to=20
make the bridge windows big enough from boot (possibly combining it=20
with pci=3Drealloc may be required as well). But it could also make things=
=20
worse (as realloc algorithm lacks safeguards to detect when the resource=20
fit was worse than the original). And it could be you run out of iomem=20
space with large hpmmioprefsize as it's not targetted specifically to the=
=20
bridge window of interest.

--=20
 i.

> --- 16 GB resize request fails at every bridge level ---
> [  292.204953] pcieport 0000:03:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204954] pcieport 0000:03:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204955] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204956] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204956] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204957] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204958] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204958] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204959] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204960] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204961] pcieport 0000:03:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204962] pcieport 0000:03:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204962] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204963] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204964] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204964] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204965] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204965] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204966] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204967] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204968] pcieport 0000:04:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204969] pcieport 0000:04:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204973] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204974] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204976] pcieport 0000:04:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204976] pcieport 0000:04:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204977] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204978] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204979] pcieport 0000:05:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204980] pcieport 0000:05:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204980] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204981] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204982] pcieport 0000:05:00.0: bridge window [mem size
> 0x400200000 64bit pref]: can't assign; no space
> [  292.204982] pcieport 0000:05:00.0: bridge window [mem size
> 0x400200000 64bit pref]: failed to assign
> [  292.204983] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [  292.204984] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
> failed to assign
> [  292.204985] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
> pref]: can't assign; no space
> [  292.204986] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
> pref]: failed to assign
> [  292.204987] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
> pref]: can't assign; no space
> [  292.204987] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
> pref]: failed to assign
> [  292.204988] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
> pref]: can't assign; no space
> [  292.204989] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
> pref]: failed to assign
> [  292.204990] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
> pref]: can't assign; no space
> [  292.204990] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
> pref]: failed to assign
>=20
> --- Fallback: old 256 MB values restored ---
> [  292.205079] amdgpu 0000:06:00.0: BAR 2 [mem 0x6010000000-
> 0x60101fffff 64bit pref]: old value restored
> [  292.205095] amdgpu 0000:06:00.0: BAR 0 [mem 0x6000000000-
> 0x600fffffff 64bit pref]: old value restored
> [  292.205096] amdgpu 0000:06:00.0: amdgpu: Not enough PCI address
> space for a large BAR.
> [  292.205100] amdgpu 0000:06:00.0: amdgpu: VRAM: 16304M
> 0x0000008000000000 - 0x00000083FAFFFFFF (16304M used)
> [  292.205102] amdgpu 0000:06:00.0: amdgpu: GART: 512M
> 0x0000000000000000 - 0x000000001FFFFFFF
> [  292.205113] [drm] Detected VRAM RAM=3D16304M, BAR=3D256M
>=20
> =3D=3D=3D END =3D=3D=3D
>=20
> On Fri, 2026-03-27 at 12:15 +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 26 Mar 2026, Cristian Cocos wrote:
> >=20
> > > [This has been previously posted on the linux-hotplug list, though
> > > it
> > > has been suggested that I post it here as well.]
> > >=20
> > > The short story is that ReBAR does not work in eGPU hotplug(!)
> > > scenarios: hotplugged Thunderbolt eGPUs are forced onto a 256MB BAR
> > > regardless of the system's ReBAR capabilities, and this because
> > > during
> > > hotplug the Linux kernel does not consult the ReBAR capability. As
> > > eGPUs are becoming more and more popular, accommodating eGPU
> > > hotplug
> > > scenarios has become imperative.
> > >=20
> > > The longer story:
> > >=20
> > > The current Thunderbolt eGPU *hotplug* sequence of events is this:
> > > BAR
> > > 2's hardware register powers up at 256 MB =E2=80=94 the default size
> > > programmed
> > > into the BAR's address decoder by Intel at the factory. The PCIe
> > > Resizable BAR capability advertises support for up to 16 GB, but
> > > it's
> > > passive =E2=80=94 software must explicitly exercise it. When a Thunde=
rbolt
> > > eGPU
> > > is hotplugged at runtime, the kernel's PCI subsystem enumerates the
> > > new
> > > device, reads the BAR at its 256 MB default, sizes the bridge
> > > windows
> > > to match, and assigns addresses =E2=80=94 all before any driver loads=
=2E The
> > > ReBAR capability is never consulted(!) during this process.
> >=20
> > Hi,
> >=20
> > The intel GPU drivers do attempt to perform the resize at probe time,
> > though it's often not successful.
> >=20
> > You haven't indicated what kernel you run nor provided any logs, but
> > there=20
> > have been some improvements to this in general in the recent kernels.
> > And=20
> > then there's also this patch which relates to thunderbolt cases
> > (which was=20
> > only accepted yesterday):
> >=20
> > https://lore.kernel.org/linux-pci/20260219153951.68869-1-
> > ilpo.jarvinen@linux.intel.com
> >=20
> > > A workaround is available for cold-plug scenarios only, and is
> > > achieved by means of the **thunderbolt.host_reset=3D0** kernel
> > > parameter:
> > > this preserves the BIOS's PCIe tunnel and BAR assignments from POST
> > > (where the BIOS *does* exercise ReBAR). This delivers the full 16
> > > GB
> > > BAR but, as just mentioned, only works for cold-plug(!) scenarios =E2=
=80=94
> > > if
> > > the eGPU is power-cycled at runtime, the new tunnel gets the 256 MB
> > > default.
> > >=20
> > > The proper fix would be for the kernel's PCI hotplug resource
> > > assignment to *first* check for ReBAR capability during
> > > enumeration,
> > > resize the BAR to the largest supported size that fits within
> > > available
> > > bridge headroom, and *then* commit bridge windows and assign
> > > addresses.
> >=20
> > That's being worked on. But it's not as easy as you depict it as
> > kernel=20
> > needs to be also able to fallback to some intermediate size if the
> > largest=20
> > supported size fails.
> >=20
> > Thanks to how size calculations and assignment are done at different=20
> > phases of the algorithm, it's not as easy to fallback to something
> > else as=20
> > you indicate as the secondary failures would still persist from the=20
> > attempt with the largest window. So effectively, the entire sizing
> > has to=20
> > be recalculated.
> >=20
> > > This is essentially what the BIOS does during POST. It hasn't been
> > > implemented yet because eGPU-over-Thunderbolt-with-ReBAR is (was?)
> > > a
> > > niche use case.
> > >=20
> > > Seeing as eGPU-over-Thunderbolt is poised to become mainstream,
> > > this
> > > can no longer be considered a niche use case.
> >=20
> > We don't consider it unimportant usecase. It's just the resource
> > fitting=20
> > and assignment algorithm is very complex and hard to improve, because
> > something usually breaks when trying to improve it. Thus, the
> > progress is=20
> > slow and everything has to be done carefully (when things break badly
> > in=20
> > this area, system doesn't even come up so there's not much room for=20
> > error).
>=20
--8323328-801996061-1774877020=:968--

Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6A24B28
	for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733104; cv=none; b=iQ4gInm3DF3qrLQf5uoT/8rUD2uVFoiM7p/XqKcgwhkO7CvrS3V8z70QIdvbXePu+YxEPUCY1KL0pY9+rj+c/qxblcPSIta1pdmh3d5zLsABcJMo+t3O+yxnDfn2axiWao5ZyHAQAoCYla13FdpyBqe3xgjRKjqSvs4plo/NRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733104; c=relaxed/simple;
	bh=MW07pyMn+2Ch0uICuOzuoRmAsN91TMr/HdBDUaGhJsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6k2Msszh9yira6IHNtxMhBMIrluZQrZnZvlzXVKqMDj4Li50rd/iqyzjRE9aNM/hFpxvuIFgtwNIvMlHw+s+RjVOwrGh1XLOqkMxb5gfZF5quTcTU9vNPCQgbk8TB/T++beM6590T0QPZFOWqI+X3L+iH4vI/yhdHDCdihYg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=N0LI413H; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="N0LI413H"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b29c4e554so41540661cf.0
        for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774733100; x=1775337900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bX4bWeRTOSd/mDxqT/zSVESt9/PwqQk1W3TZJRvDES0=;
        b=N0LI413HL5kEnLPshtMcMHCnAfJee8jVpHx3XuHYCsw36Tf/xQlU7v288W9rk6H58I
         J+yrMQWX2u5rQJBlSOmiuMBX19fYQH2jwg50tczZWiG1W+DWbNgLgEGFUbGFj0E5sB1N
         kSLBZFPc0p7GJAjrQvUe0jkXvsMpt82v/0NhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774733100; x=1775337900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bX4bWeRTOSd/mDxqT/zSVESt9/PwqQk1W3TZJRvDES0=;
        b=QTmLIWdDlSxcq16rq5U/sehfhA0SdfXOzM8DL8vvcikrDBIoQ3tDrIXvw8F/d5Y6b/
         Etd/KtkjpDqPGPFwkkfb0WeX1L/un2fdYn94dHEppjSZQOPFsQaSpSyS1Hz0EjOjHORY
         WG0jK0HWwkTYqSA2eUG0Sn/2gk90TsWVieh17GGmKqJoQrzshSOJia4TDAbwMRZAkpum
         mevsDGbd2Uhw6DoBoB+BiqwhWoM2zQP575MlQWpXR4Wn6TbS/4q96cuONkMrsQRvmZn7
         V2DJ3UQ/Ka2LfZFgEapuA7g02JqHn7nNjNJVlu91RouMsjN8Tef+TVfNa86gzFNN/QiN
         AWDA==
X-Gm-Message-State: AOJu0Ywiq4GiQgLgv+fumFLJgfAZOQgza7YUzX5HtdiHqH0+qy4XTGyJ
	f970sLBmV5NVxrZBJ7ot1VIaTpRwIWL9aLoou94J2bRogCVpHIT6Ik0C8fNVjS8diW7xP6FFqpn
	lMlYkKw==
X-Gm-Gg: ATEYQzw6rTuKotxlXyPK2fHRUBjA2DfewwTR++Yy8Y2aCrvTn48SbsOchwkfyKCF+Si
	K4ffIouiAmNZBgJb77fireIW47zOyVAJstqZK1VByqbK5k4tP6I24Z3aFgvGAvDKEYT2kW0DUij
	ZmZsew+oY6QZkVcx8/HRttZlEeKVFPIIIiynmnAQg2ehr6d4UTCZ1Zd5vMu0UWmvHQ4RBu3UElJ
	q0MA6jzkFLUu5oiU3933dGaysPMnXfUo2LNnIYN3VfJzydE6wTMxsc/yf1Zra7iSDjYNWvAXqsk
	F0dXdtX2xEOz1gCVgfCWyxJ9+xeCUAy9W13JlFjBSVwzohxlYrJ2lLbyBMu/eIL6UgrOiu+2myM
	me2CzWXgdM174lspMCvmXKl+2t7egl4SbvC/HgDg/c2PHQHMNxZf3TviXHmI+R/AgrI/SHQJh11
	sfQagJvgSk+G/edgdL5eq4Nbc=
X-Received: by 2002:ac8:5713:0:b0:50b:4dc9:3488 with SMTP id d75a77b69052e-50ba38c9751mr93564411cf.45.1774733099952;
        Sat, 28 Mar 2026 14:24:59 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67fefsm24731851cf.4.2026.03.28.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:24:59 -0700 (PDT)
Message-ID: <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>
Subject: Re: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Date: Sat, 28 Mar 2026 17:24:58 -0400
In-Reply-To: <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
	 <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Here below is the log excerpt annotated with section headers as
promised. Full raw log file to be provided upon request.

=3D=3D=3D ReBAR Hotplug Resize Failure on Thunderbolt 4 =3D=3D=3D
Hardware: AMD RX 9060 XT (Navi 44, PCI 1002:7590, 16 GB VRAM) in Razer
Core X V2 eGPU
Host: Framework Laptop 16 (AMD Ryzen 7 7840HS), TB4 via USB4 root port
Kernel: linux-zen 6.19.8.zen1-1-zen (Arch)
Driver: amdgpu (rebar=3D0 NOT set =E2=80=94 allowing resize attempt)
Boot: eGPU disconnected at boot, then hotplugged after login

PCI topology:
  00:07.0 (root port) =E2=86=92 02:00.0 (TB switch) =E2=86=92 03:00.0 (DS p=
ort)
    =E2=86=92 04:00.0 (AMD switch) =E2=86=92 05:00.0 (AMD switch) =E2=86=92=
 06:00.0 (GPU)

Note: When this GPU is connected at boot with BIOS "OS Native Resource
Balance" disabled AND thunderbolt.host_reset=3D0 on the kernel cmdline,
the firmware pre-assigns a full 16 GB BAR and the driver uses it
without needing to resize. The hotplug path below shows where the
kernel's runtime resize fails.

=3D=3D=3D Relevant dmesg lines (BAR discovery, resize attempt, failure) =3D=
=3D=3D

--- Initial BAR discovery during TB hotplug enumeration ---
[  289.893050] pci 0000:06:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit
pref]
[  289.893057] pci 0000:06:00.0: BAR 2 [mem 0x00000000-0x001fffff 64bit
pref]
[  289.893062] pci 0000:06:00.0: BAR 4 [io  0x0000-0x00ff]
[  289.893067] pci 0000:06:00.0: BAR 5 [mem 0x00000000-0x0007ffff]

--- Bridge window assignment (root port allocates 4 GB prefetchable) --
-
[  289.895531] pci 0000:02:00.0: bridge window [mem 0x10000000-
0x204fffff 64bit pref] to [bus 03-2b] add_size 600000 add_align
10000000
[  289.895535] pci 0000:02:00.0: bridge window [mem 0x00100000-
0x005fffff] to [bus 03-2b] add_size 600000 add_align 100000
[  292.204937] pcieport 0000:00:07.0: bridge window [mem 0x6000000000-
0x60ffffffff 64bit pref]: was not released (still contains assigned
resources)

--- Initial BAR assignment (256 MB) ---
[  289.895644] pci 0000:06:00.0: BAR 0 [mem 0x6000000000-0x600fffffff
64bit pref]: assigned
[  289.895663] pci 0000:06:00.0: BAR 2 [mem 0x6010000000-0x60101fffff
64bit pref]: assigned
[  289.895681] pci 0000:06:00.0: BAR 5 [mem 0x60000000-0x6007ffff]:
assigned

--- amdgpu driver loads, releases BARs for resize ---
[  292.191384] amdgpu 0000:06:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  292.204930] amdgpu 0000:06:00.0: BAR 0 [mem 0x6000000000-
0x600fffffff 64bit pref]: releasing
[  292.204932] amdgpu 0000:06:00.0: BAR 2 [mem 0x6010000000-
0x60101fffff 64bit pref]: releasing
[  292.204933] pcieport 0000:05:00.0: bridge window [mem 0x6000000000-
0x60101fffff 64bit pref]: releasing
[  292.204934] pcieport 0000:04:00.0: bridge window [mem 0x6000000000-
0x60101fffff 64bit pref]: releasing
[  292.204935] pcieport 0000:03:00.0: bridge window [mem 0x6000000000-
0x60101fffff 64bit pref]: releasing
[  292.204936] pcieport 0000:02:00.0: bridge window [mem 0x6000000000-
0x60f04fffff 64bit pref]: was not released (still contains assigned
resources)
[  292.204937] pcieport 0000:00:07.0: bridge window [mem 0x6000000000-
0x60ffffffff 64bit pref]: was not released (still contains assigned
resources)

--- 16 GB resize request fails at every bridge level ---
[  292.204953] pcieport 0000:03:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204954] pcieport 0000:03:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204955] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204956] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204956] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204957] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204958] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204958] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204959] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204960] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204961] pcieport 0000:03:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204962] pcieport 0000:03:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204962] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204963] pcieport 0000:03:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204964] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204964] pcieport 0000:03:01.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204965] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204965] pcieport 0000:03:02.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204966] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204967] pcieport 0000:03:03.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204968] pcieport 0000:04:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204969] pcieport 0000:04:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204973] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204974] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204976] pcieport 0000:04:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204976] pcieport 0000:04:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204977] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204978] pcieport 0000:04:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204979] pcieport 0000:05:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204980] pcieport 0000:05:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204980] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204981] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204982] pcieport 0000:05:00.0: bridge window [mem size
0x400200000 64bit pref]: can't assign; no space
[  292.204982] pcieport 0000:05:00.0: bridge window [mem size
0x400200000 64bit pref]: failed to assign
[  292.204983] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
can't assign; no space
[  292.204984] pcieport 0000:05:00.0: bridge window [io  size 0x1000]:
failed to assign
[  292.204985] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
pref]: can't assign; no space
[  292.204986] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
pref]: failed to assign
[  292.204987] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
pref]: can't assign; no space
[  292.204987] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
pref]: failed to assign
[  292.204988] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
pref]: can't assign; no space
[  292.204989] amdgpu 0000:06:00.0: BAR 0 [mem size 0x400000000 64bit
pref]: failed to assign
[  292.204990] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
pref]: can't assign; no space
[  292.204990] amdgpu 0000:06:00.0: BAR 2 [mem size 0x00200000 64bit
pref]: failed to assign

--- Fallback: old 256 MB values restored ---
[  292.205079] amdgpu 0000:06:00.0: BAR 2 [mem 0x6010000000-
0x60101fffff 64bit pref]: old value restored
[  292.205095] amdgpu 0000:06:00.0: BAR 0 [mem 0x6000000000-
0x600fffffff 64bit pref]: old value restored
[  292.205096] amdgpu 0000:06:00.0: amdgpu: Not enough PCI address
space for a large BAR.
[  292.205100] amdgpu 0000:06:00.0: amdgpu: VRAM: 16304M
0x0000008000000000 - 0x00000083FAFFFFFF (16304M used)
[  292.205102] amdgpu 0000:06:00.0: amdgpu: GART: 512M
0x0000000000000000 - 0x000000001FFFFFFF
[  292.205113] [drm] Detected VRAM RAM=3D16304M, BAR=3D256M

=3D=3D=3D END =3D=3D=3D

On Fri, 2026-03-27 at 12:15 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 26 Mar 2026, Cristian Cocos wrote:
>=20
> > [This has been previously posted on the linux-hotplug list, though
> > it
> > has been suggested that I post it here as well.]
> >=20
> > The short story is that ReBAR does not work in eGPU hotplug(!)
> > scenarios: hotplugged Thunderbolt eGPUs are forced onto a 256MB BAR
> > regardless of the system's ReBAR capabilities, and this because
> > during
> > hotplug the Linux kernel does not consult the ReBAR capability. As
> > eGPUs are becoming more and more popular, accommodating eGPU
> > hotplug
> > scenarios has become imperative.
> >=20
> > The longer story:
> >=20
> > The current Thunderbolt eGPU *hotplug* sequence of events is this:
> > BAR
> > 2's hardware register powers up at 256 MB =E2=80=94 the default size
> > programmed
> > into the BAR's address decoder by Intel at the factory. The PCIe
> > Resizable BAR capability advertises support for up to 16 GB, but
> > it's
> > passive =E2=80=94 software must explicitly exercise it. When a Thunderb=
olt
> > eGPU
> > is hotplugged at runtime, the kernel's PCI subsystem enumerates the
> > new
> > device, reads the BAR at its 256 MB default, sizes the bridge
> > windows
> > to match, and assigns addresses =E2=80=94 all before any driver loads. =
The
> > ReBAR capability is never consulted(!) during this process.
>=20
> Hi,
>=20
> The intel GPU drivers do attempt to perform the resize at probe time,
> though it's often not successful.
>=20
> You haven't indicated what kernel you run nor provided any logs, but
> there=20
> have been some improvements to this in general in the recent kernels.
> And=20
> then there's also this patch which relates to thunderbolt cases
> (which was=20
> only accepted yesterday):
>=20
> https://lore.kernel.org/linux-pci/20260219153951.68869-1-
> ilpo.jarvinen@linux.intel.com
>=20
> > A workaround is available for cold-plug scenarios only, and is
> > achieved by means of the **thunderbolt.host_reset=3D0** kernel
> > parameter:
> > this preserves the BIOS's PCIe tunnel and BAR assignments from POST
> > (where the BIOS *does* exercise ReBAR). This delivers the full 16
> > GB
> > BAR but, as just mentioned, only works for cold-plug(!) scenarios =E2=
=80=94
> > if
> > the eGPU is power-cycled at runtime, the new tunnel gets the 256 MB
> > default.
> >=20
> > The proper fix would be for the kernel's PCI hotplug resource
> > assignment to *first* check for ReBAR capability during
> > enumeration,
> > resize the BAR to the largest supported size that fits within
> > available
> > bridge headroom, and *then* commit bridge windows and assign
> > addresses.
>=20
> That's being worked on. But it's not as easy as you depict it as
> kernel=20
> needs to be also able to fallback to some intermediate size if the
> largest=20
> supported size fails.
>=20
> Thanks to how size calculations and assignment are done at different=20
> phases of the algorithm, it's not as easy to fallback to something
> else as=20
> you indicate as the secondary failures would still persist from the=20
> attempt with the largest window. So effectively, the entire sizing
> has to=20
> be recalculated.
>=20
> > This is essentially what the BIOS does during POST. It hasn't been
> > implemented yet because eGPU-over-Thunderbolt-with-ReBAR is (was?)
> > a
> > niche use case.
> >=20
> > Seeing as eGPU-over-Thunderbolt is poised to become mainstream,
> > this
> > can no longer be considered a niche use case.
>=20
> We don't consider it unimportant usecase. It's just the resource
> fitting=20
> and assignment algorithm is very complex and hard to improve, because
> something usually breaks when trying to improve it. Thus, the
> progress is=20
> slow and everything has to be done carefully (when things break badly
> in=20
> this area, system doesn't even come up so there's not much room for=20
> error).

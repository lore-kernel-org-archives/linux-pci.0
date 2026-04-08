Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844A35AC18
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626355; cv=pass; b=RCYQ42lmK4qAWtNNQV6IVXs35icJzi5KuYczNYpbJKfhEPSqZHGSdcy6Yap2Bmv2wOr3BGo+IqR6VO3/TNxF9v0Y8pfFFqETfKZDSAiE4wHZioSVYHtHtO9GIsSk+4dlpWbl0rmOqmjfJepXG53bMXg1o3WHw3gKwGfII5OTINU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626355; c=relaxed/simple;
	bh=sLfaX2hgX+idAzh51tXozUyLLhH1yCiPE4YxGcsWrMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ShqujaXyZZ/VfJwV6Gvzzy5Ihj+JbTI33kl77F8B9MSw6HYodOjqhzq+kWOE3QYrwivrpYAt0Q+c/rb7ejipwq1AITExH2E59Avff6Wkj1v5s2pVgldRxIPZmTx4mdTEirfWb+eZZieMzbJeKS1cKjFExN1n17SAvLmG/sGUNXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=zSWA/ynO; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="zSWA/ynO"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d7c12e48eso6121381cf.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 22:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775626353; cv=none;
        d=google.com; s=arc-20240605;
        b=TbyG4+e7v/pS6DlgJTOBlcsFn3rsKmzOu5C0PNMwMA8Ei1NHVmBtP0URqCGEY9vDtZ
         rCnxS2KrGQubo8MiPDh6WGUZHIDc/zxdQhfK+8vmp+sGYPqH6u4kXyWcL3Dty3xINlqu
         MiHL+03lYbXZnD17ixZoCzl5ZSuWulM1udgHO6+mrnJX5r2znJgx8EHwvKIecOIKubaq
         3/nHY3bG/1PSuOTqJhnUY+TOlzX10TUGIot424oVlEejfot/NGU+ZdECwJYgagF4mmEn
         2yZvOKlqQmb+06Ipzvtlx4nBRbx2JvH723eceaw1WxIiW/zl1UVOd0UqLYDcoaTULSQD
         U5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Pyx8+IObwARdlsUUeV2kpREDkLjdUir7NOSjCU9PyHY=;
        fh=KZ7p//v/5JuZ6ARtwismLZ/dsvuf+E17/zrgm0s1Aaw=;
        b=eP91WD+jOCtTnW+NGdUz4X1VlUhznd+dxR/Xhbcs6dKOd20bdhLuDN4crqxBxVjNJ/
         7ftYqPYl4281q9fGRDOrURJMhudtrz5DdQeEwcvfGTe25OoqdXktn3Fud/1hTVzVauwF
         aUnquzRdalvI+GID8WmrLIBHsfZORpMKwJhrQ5meJZaAnmaLmNztLjzheRIaM/qoIkGQ
         gInMQAAwz3TMvZtsflxQNZuDWVeMmMhmf+9lRZN45xjozarvFCy7EQnEuO6XE08dqT22
         glrQv16qbF9l5lpYux5czFn7FBkX0X/XTMnyBlTpNnSjbrT0RXj86tsAFNDLSInjJOZC
         WK2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775626353; x=1776231153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyx8+IObwARdlsUUeV2kpREDkLjdUir7NOSjCU9PyHY=;
        b=zSWA/ynOH38JPo2unJb06QMfxQ390LxdDABDhHEyPd96HAlJ3QTfDpe8zFCjRV1B2m
         IfD41OVXyk4eh9h83nX8V3Z/AMfnwrGQ1VFnLoQWbfQC5EZ9OXojuTofc71qP+1wXG4n
         1rxgQmPpZPIw9oJtGwdoU0NNiE/esinWCKsGud+wzfXsEqrxh4dm6dlqElFCeiVCFZrw
         3K0wIJpU0Xcusf7Ee7Jhl/cUR0szJ+RYUpOknt05EdV6UqxbKXeRJ419zznqZYOIRYVV
         21tgcWE5aSRg9BT7peyD4aIvWBhcmbVEhjkQ6KeDr85hj1t/5jkQ7FtZuaYaNI79VGpT
         MNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775626353; x=1776231153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyx8+IObwARdlsUUeV2kpREDkLjdUir7NOSjCU9PyHY=;
        b=S9Y/a4RNEnt8GLqjbl7gCVY7hFSoe4Xf0JXju1vlACKt3m+D4PZgHLrZy9M2cRB4GF
         2k30j2dj3SeS+fo5W6U+C3/N9TJG8V0WAdQeZB+GngeoJx31us4KgjPDHS+pkFgMxQYO
         A/OJXjmj39BLFDHCAz4gDdMboZoidM6yODqj18nRt+gWHIXrORMGMlalBWbD8+BBR9JX
         IoRH+pFRjxkTq3WdGVcBgAT+N48mFQFKGH+si1jgG60iBdQHXh0HHljHMSweK9bhm1Gp
         swURn2UQ0pA5T5Xo/APImaUxsrA3fsov+HzHy68BAkI0SD2SLTIFAp2Wn392dp+m6Dwz
         GM5g==
X-Gm-Message-State: AOJu0YwsvYWJDxmS9kSAhD0zqNqRzdsrCQrhQVbgSg0u5wYBHWU3MJ8C
	Jp+1C70isORVFHgGD3ofM6chWsmfw4bcSdNcHHVUVL8P5RW/It8G3lD+rbjluqeEIP+2ripygIK
	SkunIQXhGZZjE/55zbAV9KZQtRsLZlboVgCqKa4LzHn2x1GtJUP5MYCY9Ig==
X-Gm-Gg: AeBDietyqxxhs+1975TxvFHXAj7KRZ768iCqCDoV5hEoIdc1SNIF5cM6D2YL2iMSa2x
	8mas36+RaIcPJar+UvAU/fkSs8hFRFszynZ7GHp1NLSUR7K2/27Jzq8cssl17640zjuI3YxfHyg
	mqDsUIlmwgrDKnjAIVesE4vWeCd5ga6FfUZA2RGT7KK7X465R6iiDFzXK1zetpVHv1dHV1w4kA4
	XICGWVyocmiyvDOCQ7lujZOf+SgGeT3cNnDpkSbVhoYIhs3hkiKSVYC6S4pTjDf1v7+tMu9QjKx
	OsDhf8v8Q3Ge6lt0XaczcQ2PKUlx6/+FWUS8NMw=
X-Received: by 2002:a05:622a:835b:b0:506:baf9:5dd9 with SMTP id
 d75a77b69052e-50d4fab3562mr240087451cf.17.1775626352855; Tue, 07 Apr 2026
 22:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geramy Loveless <gloveless@jqluv.com>
Date: Tue, 7 Apr 2026 22:32:22 -0700
X-Gm-Features: AQROBzBMvi6tjW5BnVfdSCn_J9hAcZx1yY2WwRSZvQnNExetUN47QwU5tc57s5c
Message-ID: <CAGpo2me5irs2znVr+dnbtNPsNPiDBqKtKSn3r6D6K5-WWEPj0g@mail.gmail.com>
Subject: USB4v2 BAR resizing problems - hotplug gpu via razor tb5 dock - Intel
 Barlow Ridge
To: linux-usb@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am hoping someone here can help me; I'm currently having some issues
with a Razor thunderbolt 5 / USB4v2 Dock connected to a Halo Strix or
AMD Ryzen AI 395+ Max machine.
Specifically a Minisforum MS-S1 with a Host controller: Intel
8086:5780 =E2=80=94 Barlow Ridge Host 80G (rev 84) and the Dock hub: Intel
8086:5786 =E2=80=94 Barlow Ridge Hub 80G (rev 85) These are the JHL9580 (ho=
st)
and JHL9586 (hub) =E2=80=94 Intel's Barlow Ridge TB5 80Gbps silicon.
The specific problem I'm having, which I think is the largest issue
besides power management causing havoc which i can fix with kernel
parameters but the one I cannot "fix" granted not kernel params are
not a fix is that on thunderbolt driver it will not expand its bar
size to the parent size.
so when setting hpmmiopresize to 64G it gets split between the two
usb4v2 ports giving me 32G on each port and then the memory space is
not aligned so when amdgpu tries to resize it cant. I would think the
ideal situation at least in my head and not being a linux kernel
expert is that the thunderbolt driver should request the pcie device
max memory size and then create the bar at the correct sizes or at the
least let me resize it which might be a difficult and bad path to let
the "user" resize it.

Current kernel image is: 6.18.7-061807-generic

Custom Parameters:
 pcie_port_pm=3Doff pcie_aspm=3Doff
pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0

This was required to get the kernel to stop powering down the
thunderbolt link on the amd gfx1201 device because it goes into a low
power state when there is no display connected.
For my application thats okay, i'm using it for compute based workloads any=
ways.

Thank you for taking a look at this here are some log snippets have a great=
 day!

Here is my amdgpu issue with full logs
https://gitlab.freedesktop.org/drm/amd/-/work_items/4978#note_3339645

Here are more recent logs after running the kernel parameters.

System: MinisForum MS-S1 (AMD Ryzen AI 395+ Max / Strix Halo) + Razer
Core X V2 via Intel Barlow Ridge TB5 (JHL9580/JHL9586)
GPU: AMD Radeon AI PRO R9700 [1002:7551] (RDNA 4 / gfx1201, 32GB GDDR6)
Kernel: 6.18.7 (Ubuntu mainline)
Cmdline: pcie_port_pm=3Doff pcie_aspm=3Doff
pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0

--- Boot-time TB5 bridge layout (host-side, before tunnel) ---
pci 0000:65:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream P=
ort
pci 0000:65:00.0: PCI bridge to [bus 66-bc]
pci 0000:65:00.0:   bridge window [mem 0x8880000000-0x98800fffff 64bit pref=
]
pci 0000:66:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:66:01.0: PCI bridge to [bus 68-91]
pci 0000:66:01.0:   bridge window [mem 0x9080000000-0x987fffffff 64bit pref=
]
pci 0000:66:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:66:03.0: PCI bridge to [bus 93-bc]
pci 0000:66:03.0:   bridge window [mem 0x8880000000-0x907fffffff 64bit pref=
]

--- Dock hot-plug enumeration (after TB tunnel up + PCI rescan) ---
pci 0000:93:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream P=
ort
pci 0000:93:00.0: PCI bridge to [bus 00]
pci 0000:93:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:93:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:94:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:94:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]

--- Kernel resource allocation: cannot fit rebar + hotplug reserves ---
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:01.0 bridging to [bus 98-a4]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:02.0 bridging to [bus a5-b1]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:03.0 bridging to [bus b2-bc]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x3018000000 required for 0000:93:00.0 bridging to [bus 94-bc]
pci 0000:93:00.0: bridge window [mem 0x04000000-0x1fffffff 64bit pref]
to [bus 94-bc] requires relaxed alignment rules
pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
can't assign; no space
pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
failed to assign
pci 0000:93:00.0: bridge window [mem 0x8880000000-0x889bffffff 64bit
pref]: assigned

--- GPU BAR enumeration ---
pci 0000:97:00.0: [1002:7551] type 00 class 0x030000 PCIe Legacy Endpoint
pci 0000:97:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:97:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x4 link at 0000:66:03.0 (capable of 504.112 Gb/s with 32.0
GT/s PCIe x16 link)
pci 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assigne=
d
pci 0000:97:00.0: BAR 4 [io  size 0x0100]: can't assign; no space

--- amdgpu rebar attempt and failure ---
amdgpu 0000:97:00.0: amdgpu: PCIE atomic ops is not supported
amdgpu 0000:97:00.0: BAR 2 [mem 0x8890000000-0x88901fffff 64bit pref]: rele=
asing
amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: rele=
asing
amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't
assign; no space
amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to ass=
ign
amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't
assign; no space
amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: failed to assi=
gn
amdgpu 0000:97:00.0: amdgpu: Not enough PCI address space for a large BAR.
amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assi=
gned
amdgpu 0000:97:00.0: amdgpu: VRAM: 32624M 0x0000008000000000 -
0x00000087F6FFFFFF (32624M used)

System: MinisForum MS-S1 (AMD Ryzen AI 395+ Max / Strix Halo) + Razer
Core X V2 via Intel Barlow Ridge TB5 (JHL9580/JHL9586)
GPU: AMD Radeon AI PRO R9700 [1002:7551] (RDNA 4 / gfx1201, 32GB GDDR6)
Kernel: 6.18.7 (Ubuntu mainline)
Cmdline: pcie_port_pm=3Doff pcie_aspm=3Doff
pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0

--- Boot-time TB5 bridge layout (host-side, before tunnel) ---
pci 0000:65:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream P=
ort
pci 0000:65:00.0: PCI bridge to [bus 66-bc]
pci 0000:65:00.0:   bridge window [mem 0x8880000000-0x98800fffff 64bit pref=
]
pci 0000:66:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:66:01.0: PCI bridge to [bus 68-91]
pci 0000:66:01.0:   bridge window [mem 0x9080000000-0x987fffffff 64bit pref=
]
pci 0000:66:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:66:03.0: PCI bridge to [bus 93-bc]
pci 0000:66:03.0:   bridge window [mem 0x8880000000-0x907fffffff 64bit pref=
]

--- Dock hot-plug enumeration (after TB tunnel up + PCI rescan) ---
pci 0000:93:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream P=
ort
pci 0000:93:00.0: PCI bridge to [bus 00]
pci 0000:93:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:93:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:94:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Downstream=
 Port
pci 0000:94:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]

--- Kernel resource allocation: cannot fit rebar + hotplug reserves ---
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:01.0 bridging to [bus 98-a4]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:02.0 bridging to [bus a5-b1]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x1000000000 required for 0000:94:03.0 bridging to [bus b2-bc]
pcieport 0000:66:03.0: Assigned bridge window [mem
0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
0x3018000000 required for 0000:93:00.0 bridging to [bus 94-bc]
pci 0000:93:00.0: bridge window [mem 0x04000000-0x1fffffff 64bit pref]
to [bus 94-bc] requires relaxed alignment rules
pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
can't assign; no space
pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
failed to assign
pci 0000:93:00.0: bridge window [mem 0x8880000000-0x889bffffff 64bit
pref]: assigned

--- GPU BAR enumeration ---
pci 0000:97:00.0: [1002:7551] type 00 class 0x030000 PCIe Legacy Endpoint
pci 0000:97:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:97:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x4 link at 0000:66:03.0 (capable of 504.112 Gb/s with 32.0
GT/s PCIe x16 link)
pci 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assigne=
d
pci 0000:97:00.0: BAR 4 [io  size 0x0100]: can't assign; no space

--- amdgpu rebar attempt and failure ---
amdgpu 0000:97:00.0: amdgpu: PCIE atomic ops is not supported
amdgpu 0000:97:00.0: BAR 2 [mem 0x8890000000-0x88901fffff 64bit pref]: rele=
asing
amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: rele=
asing
amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't
assign; no space
amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to ass=
ign
amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't
assign; no space
amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: failed to assi=
gn
amdgpu 0000:97:00.0: amdgpu: Not enough PCI address space for a large BAR.
amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assi=
gned
amdgpu 0000:97:00.0: amdgpu: VRAM: 32624M 0x0000008000000000 -
0x00000087F6FFFFFF (32624M used)



Geramy L. Loveless

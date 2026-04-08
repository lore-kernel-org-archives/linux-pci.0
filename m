Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EB386439;
	Wed,  8 Apr 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639410; cv=none; b=moQSfHgaVsNVaaEozKJCXzPNdZk8Cz/9eHgpb0ohZrpwUgWgN1VIJAsL2eQwNhO/iLU5jAzjoEM5aA5cUfMpOHjdsj5x2Cu5V2lEUCSyAQSvmOUWMfRAjUKvXVp+WTgN23YumWchSW0ET+IsHgjeJYjefyxXefNAH83NyBr4CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639410; c=relaxed/simple;
	bh=mgqsKIijnNfvo8PHokRwHgRIHCboUir2zS4sodlO/XQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uKEzy8mH3TwTOHtgEUIdSjLfgC0cW9IbeS3Uv8HfOpyJDpVXVW2upTio6QEbuUHKpgawnunWMRgWiZGnhAi68w3rsB8Tzc3zCGr5rXpCmdsU6CyS2NFL4DrtrH7OsgLvRDmZazsCI/AGflVDXyFAqTPuq5tudwXly1U9bjUazSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqsutOSy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqsutOSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775639409; x=1807175409;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mgqsKIijnNfvo8PHokRwHgRIHCboUir2zS4sodlO/XQ=;
  b=aqsutOSyZBknhq2G8ZxEwdAP7WKP56XWxV9oX/PdA6H4rIG6cf8ILz3m
   V0n6/sQIJWDzsb/UGzX38AR0k+/Rgqfhiu4Onh/iPxSXUoFnUEfWORcs2
   vEPkL0iLOSgOyVq4fklR3ugNstXH5WbLPqHXY7K+pYVe8pjE5cVrqv+HS
   kGRcC2XoWux2Slu0dA16HOqATWyE3T9IDqxd6lAGD7r7+xymrldOaJ9Th
   ShFk0Wz21rBo0M119XLPq+FW+/lKeqrBi+aXivrjTDHzNiXbbsvAKWLWK
   97a9eeXiGgUm3JD5d8cxUCJFKKSWXe3/uuLoxgbfir5A+YkkPeA1ZJdpI
   w==;
X-CSE-ConnectionGUID: hzQXZ/HZRCSP8r0XktYzXw==
X-CSE-MsgGUID: yROy30pwQNOkQ6PMsebpbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75786853"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="75786853"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 02:10:05 -0700
X-CSE-ConnectionGUID: cjI2RzguQEunjHn0KDFfVg==
X-CSE-MsgGUID: Pmdsa222TEOMKJ/dgIjOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251566197"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.45])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 02:10:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Apr 2026 12:09:57 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: USB4v2 BAR resizing problems - hotplug gpu via razor tb5 dock
 - Intel Barlow Ridge
In-Reply-To: <CAGpo2me5irs2znVr+dnbtNPsNPiDBqKtKSn3r6D6K5-WWEPj0g@mail.gmail.com>
Message-ID: <b105c586-2178-5eb4-1d7f-fbb9b5e00002@linux.intel.com>
References: <CAGpo2me5irs2znVr+dnbtNPsNPiDBqKtKSn3r6D6K5-WWEPj0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-595154277-1775639397=:971"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-595154277-1775639397=:971
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Apr 2026, Geramy Loveless wrote:

> I am hoping someone here can help me; I'm currently having some issues
> with a Razor thunderbolt 5 / USB4v2 Dock connected to a Halo Strix or
> AMD Ryzen AI 395+ Max machine.
> Specifically a Minisforum MS-S1 with a Host controller: Intel
> 8086:5780 =E2=80=94 Barlow Ridge Host 80G (rev 84) and the Dock hub: Inte=
l
> 8086:5786 =E2=80=94 Barlow Ridge Hub 80G (rev 85) These are the JHL9580 (=
host)
> and JHL9586 (hub) =E2=80=94 Intel's Barlow Ridge TB5 80Gbps silicon.
> The specific problem I'm having, which I think is the largest issue
> besides power management causing havoc which i can fix with kernel
> parameters but the one I cannot "fix" granted not kernel params are
> not a fix is that on thunderbolt driver it will not expand its bar
> size to the parent size.
> so when setting hpmmiopresize to 64G it gets split between the two
> usb4v2 ports giving me 32G on each port and then the memory space is
> not aligned so when amdgpu tries to resize it cant. I would think the
> ideal situation at least in my head and not being a linux kernel
> expert is that the thunderbolt driver should request the pcie device
> max memory size and then create the bar at the correct sizes or at the
> least let me resize it which might be a difficult and bad path to let
> the "user" resize it.
>=20
> Current kernel image is: 6.18.7-061807-generic

Hi,

There have been significant improvements to the kernel's resource fitting=
=20
strategy since that kernel, some of the most recent improvements are not=20
yet even in Linus' tree but only in pci/resource branch slated for 7.1.

There's one fix in particular related to how hotplug memory distribution=20
is handled that might be relevant here but I cannot say for sure because=20
it only print a log line with dynamic debugging enabled=20
(CONFIG_DYNAMIC_DEBUG=3Dy + dyndbg=3D"file drivers/pci/*.c +p" on kernel=20
command line).

> Custom Parameters:
>  pcie_port_pm=3Doff pcie_aspm=3Doff
> pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0

The effect of these size parameterd may get nullified because of that bug
I mentioned.

> This was required to get the kernel to stop powering down the
> thunderbolt link on the amd gfx1201 device because it goes into a low
> power state when there is no display connected.
> For my application thats okay, i'm using it for compute based workloads a=
nyways.
>=20
> Thank you for taking a look at this here are some log snippets have a gre=
at day!

> Here is my amdgpu issue with full logs
> https://gitlab.freedesktop.org/drm/amd/-/work_items/4978#note_3339645

This is not a full log but starts in the middle.

You should pass log_buf_len=3D16M to kernel command line capture it from=20
start.

It would also help if you capture /proc/iomem dump.

> Here are more recent logs after running the kernel parameters.
>=20
> System: MinisForum MS-S1 (AMD Ryzen AI 395+ Max / Strix Halo) + Razer
> Core X V2 via Intel Barlow Ridge TB5 (JHL9580/JHL9586)
> GPU: AMD Radeon AI PRO R9700 [1002:7551] (RDNA 4 / gfx1201, 32GB GDDR6)
> Kernel: 6.18.7 (Ubuntu mainline)
> Cmdline: pcie_port_pm=3Doff pcie_aspm=3Doff
> pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0
>=20
> --- Boot-time TB5 bridge layout (host-side, before tunnel) ---
> pci 0000:65:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream=
 Port
> pci 0000:65:00.0: PCI bridge to [bus 66-bc]
> pci 0000:65:00.0:   bridge window [mem 0x8880000000-0x98800fffff 64bit pr=
ef]
> pci 0000:66:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:66:01.0: PCI bridge to [bus 68-91]
> pci 0000:66:01.0:   bridge window [mem 0x9080000000-0x987fffffff 64bit pr=
ef]
> pci 0000:66:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:66:03.0: PCI bridge to [bus 93-bc]
> pci 0000:66:03.0:   bridge window [mem 0x8880000000-0x907fffffff 64bit pr=
ef]
>=20
> --- Dock hot-plug enumeration (after TB tunnel up + PCI rescan) ---
> pci 0000:93:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream=
 Port
> pci 0000:93:00.0: PCI bridge to [bus 00]
> pci 0000:93:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:93:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:94:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:94:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>=20
> --- Kernel resource allocation: cannot fit rebar + hotplug reserves ---
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:01.0 bridging to [bus 98-a4]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:02.0 bridging to [bus a5-b1]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:03.0 bridging to [bus b2-bc]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x3018000000 required for 0000:93:00.0 bridging to [bus 94-bc]
> pci 0000:93:00.0: bridge window [mem 0x04000000-0x1fffffff 64bit pref]
> to [bus 94-bc] requires relaxed alignment rules
> pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
> can't assign; no space
> pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
> failed to assign
> pci 0000:93:00.0: bridge window [mem 0x8880000000-0x889bffffff 64bit
> pref]: assigned
>=20
> --- GPU BAR enumeration ---
> pci 0000:97:00.0: [1002:7551] type 00 class 0x030000 PCIe Legacy Endpoint
> pci 0000:97:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
> pci 0000:97:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5
> GT/s PCIe x4 link at 0000:66:03.0 (capable of 504.112 Gb/s with 32.0
> GT/s PCIe x16 link)
> pci 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assig=
ned
> pci 0000:97:00.0: BAR 4 [io  size 0x0100]: can't assign; no space
>=20
> --- amdgpu rebar attempt and failure ---
> amdgpu 0000:97:00.0: amdgpu: PCIE atomic ops is not supported
> amdgpu 0000:97:00.0: BAR 2 [mem 0x8890000000-0x88901fffff 64bit pref]: re=
leasing
> amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: re=
leasing

Here you filtered the explanation which immediately follows:

[   58.188911] pcieport 0000:96:00.0: bridge window [mem 0x8880000000-0x889=
7ffffff 64bit pref]: releasing
[   58.188913] pcieport 0000:95:00.0: bridge window [mem 0x8880000000-0x889=
7ffffff 64bit pref]: releasing
[   58.188913] pcieport 0000:94:00.0: bridge window [mem 0x8880000000-0x889=
7ffffff 64bit pref]: releasing
[   58.188914] pcieport 0000:93:00.0: bridge window [mem 0x8880000000-0x889=
bffffff 64bit pref]: was not released (still contains assigned resources)
[   58.188915] pcieport 0000:66:03.0: bridge window [mem 0x8880000000-0x907=
fffffff 64bit pref]: was not released (still contains assigned resources)
[   58.188916] pcieport 0000:65:00.0: bridge window [mem 0x8880000000-0x988=
00fffff 64bit pref]: was not released (still contains assigned resources)
[   58.188916] pcieport 0000:00:03.2: bridge window [mem 0x8880000000-0x988=
00fffff 64bit pref]: was not released (still contains assigned resources)

The last 4 lines tell those upstream bridge windows are pinned by other=20
(sibling) resources (effectively, it means it's too late to resize them at=
=20
this point). When attempting BAR resize, kernel release only the resource=
=20
of the device and then attemptes to release all bridge windows upstream=20
of the device to allow them to be changed (enlarged). If there are sibling=
=20
devices, their resources will prevent the shared bridge window from being=
=20
released, effectively preventing enlarging the bridge window.

The resize might succeedeed, if you manually remove those sibling devices=
=20
first, and then attempt the resize through sysfs (and rescan the bring=20
back the removed devices).

I cannot say for sure what the pinning devices/resources are as your log=20
is partial but you can check them from /proc/iomem yourself.

--=20
 i.

> amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't
> assign; no space
> amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to a=
ssign
> amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't
> assign; no space
> amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: failed to as=
sign
> amdgpu 0000:97:00.0: amdgpu: Not enough PCI address space for a large BAR=
=2E
> amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: as=
signed
> amdgpu 0000:97:00.0: amdgpu: VRAM: 32624M 0x0000008000000000 -
> 0x00000087F6FFFFFF (32624M used)
>=20
> System: MinisForum MS-S1 (AMD Ryzen AI 395+ Max / Strix Halo) + Razer
> Core X V2 via Intel Barlow Ridge TB5 (JHL9580/JHL9586)
> GPU: AMD Radeon AI PRO R9700 [1002:7551] (RDNA 4 / gfx1201, 32GB GDDR6)
> Kernel: 6.18.7 (Ubuntu mainline)
> Cmdline: pcie_port_pm=3Doff pcie_aspm=3Doff
> pci=3Dhpmemsize=3D2G,realloc,hpmmioprefsize=3D64G amdgpu.dc=3D0
>=20
> --- Boot-time TB5 bridge layout (host-side, before tunnel) ---
> pci 0000:65:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream=
 Port
> pci 0000:65:00.0: PCI bridge to [bus 66-bc]
> pci 0000:65:00.0:   bridge window [mem 0x8880000000-0x98800fffff 64bit pr=
ef]
> pci 0000:66:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:66:01.0: PCI bridge to [bus 68-91]
> pci 0000:66:01.0:   bridge window [mem 0x9080000000-0x987fffffff 64bit pr=
ef]
> pci 0000:66:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:66:03.0: PCI bridge to [bus 93-bc]
> pci 0000:66:03.0:   bridge window [mem 0x8880000000-0x907fffffff 64bit pr=
ef]
>=20
> --- Dock hot-plug enumeration (after TB tunnel up + PCI rescan) ---
> pci 0000:93:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream=
 Port
> pci 0000:93:00.0: PCI bridge to [bus 00]
> pci 0000:93:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:93:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:94:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Downstre=
am Port
> pci 0000:94:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>=20
> --- Kernel resource allocation: cannot fit rebar + hotplug reserves ---
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:01.0 bridging to [bus 98-a4]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:02.0 bridging to [bus a5-b1]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x1000000000 required for 0000:94:03.0 bridging to [bus b2-bc]
> pcieport 0000:66:03.0: Assigned bridge window [mem
> 0x8880000000-0x907fffffff 64bit pref] to [bus 93-bc] cannot fit
> 0x3018000000 required for 0000:93:00.0 bridging to [bus 94-bc]
> pci 0000:93:00.0: bridge window [mem 0x04000000-0x1fffffff 64bit pref]
> to [bus 94-bc] requires relaxed alignment rules
> pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
> can't assign; no space
> pci 0000:93:00.0: bridge window [mem size 0x3018000000 64bit pref]:
> failed to assign
> pci 0000:93:00.0: bridge window [mem 0x8880000000-0x889bffffff 64bit
> pref]: assigned
>=20
> --- GPU BAR enumeration ---
> pci 0000:97:00.0: [1002:7551] type 00 class 0x030000 PCIe Legacy Endpoint
> pci 0000:97:00.0: BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
> pci 0000:97:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5
> GT/s PCIe x4 link at 0000:66:03.0 (capable of 504.112 Gb/s with 32.0
> GT/s PCIe x16 link)
> pci 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: assig=
ned
> pci 0000:97:00.0: BAR 4 [io  size 0x0100]: can't assign; no space
>=20
> --- amdgpu rebar attempt and failure ---
> amdgpu 0000:97:00.0: amdgpu: PCIE atomic ops is not supported
> amdgpu 0000:97:00.0: BAR 2 [mem 0x8890000000-0x88901fffff 64bit pref]: re=
leasing
> amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: re=
leasing
> amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't
> assign; no space
> amdgpu 0000:97:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to a=
ssign
> amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't
> assign; no space
> amdgpu 0000:97:00.0: BAR 2 [mem size 0x00200000 64bit pref]: failed to as=
sign
> amdgpu 0000:97:00.0: amdgpu: Not enough PCI address space for a large BAR=
=2E
> amdgpu 0000:97:00.0: BAR 0 [mem 0x8880000000-0x888fffffff 64bit pref]: as=
signed
> amdgpu 0000:97:00.0: amdgpu: VRAM: 32624M 0x0000008000000000 -
> 0x00000087F6FFFFFF (32624M used)
>=20
>=20
>=20
> Geramy L. Loveless
>=20
--8323328-595154277-1775639397=:971--

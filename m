Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741926C385
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197515; cv=none; b=m1GF1LWqS9/2HTXCa6FDK7PkkPgwyRlcYPIzkvVisK76k5QWBD4GrqA1xvb+7iYHXHnonKK0TgOwKrlwTraB9ecf/m3gmer30zAlVC21owoCL/cTj3L2vHIokHYkrBKbtCVQY19ifxlE60jXgIqPK6/hinuxaNZIzcjgyFmI+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197515; c=relaxed/simple;
	bh=KBnEWa1YadfZ/d1xPbDYxvVX9zPZyDFi5jvxkbLph3s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IwqltbcUvdJ6EGHsDdvd+tW/OV/H3zUH6W6ybrtt+4lHIi9Gccl8Td6jcVq/jaGkzKsoYopKSJ4+z/SlYOJl1aNv4215W7d2V641KZ1DfmkHBCX9BvbrN2ZbefKfDyfgYf+ByaX2qTwsHa4stobXljM8sNMj2be0ONkF5pnFjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miK+311N; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miK+311N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791197513; x=1822733513;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KBnEWa1YadfZ/d1xPbDYxvVX9zPZyDFi5jvxkbLph3s=;
  b=miK+311NwZb/idaTV0617bgQwQVNFgXGfS/xcfMvDvsp6CSJghlch8dM
   0eX3GqGQWn5mstoWEwHeok9iDOfmfOg3uH8gC0E0hVbTiA9Qx+b7AiVyb
   l88oEI87Ljx4AR+eDabs2JQZ1ISDfKC8ds2fFHEyjYaU4XTo/177Dw0jk
   /Ue/IAA3BX3lJK1kv+wh3wu+4ZZybbRElZ4YppecO/Zogxt5wNfE5ktI+
   OpHwfvdrbxhRjJml5nM7cd2bm6pKYB6h7LNUm4VtLwbFaYnoTipVlNFBL
   izK1TkP+OBpxcJHCpQSGKhsa6GMm5VAr+hPEddJnMEcjn9625bpnSna79
   w==;
X-CSE-ConnectionGUID: SgobZdHFQ1el70P4JoV8gQ==
X-CSE-MsgGUID: t2W1zxFJQSWHZFUGpCs5ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102026892"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="102026892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:51:53 -0700
X-CSE-ConnectionGUID: eYEp8PIIRFeuYTouOf+Fiw==
X-CSE-MsgGUID: R7RhjlW/SNqXoMGF9f3oIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="280057448"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:51:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 13:51:45 +0300 (EEST)
To: John Doen <johndoen1965@gmail.com>
cc: linux-pci@vger.kernel.org, nbritton@exabit.io, bhelgaas@google.com, 
    regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Subject: Re: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
In-Reply-To: <CAPddu3kdTYPn51R05349V=KozM80+EL044fjDosteXvW9mOaQQ@mail.gmail.com>
Message-ID: <e0619af8-c100-8b4a-86bb-f7252cf540b1@linux.intel.com>
References: <CAPddu3kdTYPn51R05349V=KozM80+EL044fjDosteXvW9mOaQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 4 Oct 2026, John Doen wrote:

>  This is a follow-up to:
> https://mail-archive.com/amd-gfx@lists.freedesktop.org/msg152555.html
> 
> Hi,
> 
> I appear to have another instance of this multi-composite-resource
> bridge-window undersizing regression, this time with two discrete NVIDIA
> GPUs behind AMD chipset PCIe switches.
> 
> The allocation arithmetic looks equivalent to the original report, but I
> have not yet tested Ilpo's newer patch series. Please treat this as an
> additional likely instance rather than confirmation that the proposed
> series fixes this machine.
> 
> The failure was reproduced on Ubuntu 26.04 with its 7.0.0-31-generic
> kernel. The same hardware allocated correctly with Ubuntu's
> 6.17.0-42-generic kernel.
> 
> Summary
> =======
> 
> On Linux 7.0, forcing bridge resource reassignment gives the shared parent
> window only the plain sum of two composite child windows. The second child
> cannot start immediately after the first because both child windows inherit
> the alignment of their largest BAR.
> 
> The later sibling bridge, 0000:0b:08.0, consequently receives neither its
> prefetchable nor non-prefetchable window. The NVIDIA GPU at 0000:11:00.0
> then has BAR0, BAR1, BAR3, its ROM, and its audio-function BAR unassigned.
> 
> The NVIDIA driver subsequently reports:
> 
>     NVRM: This PCI I/O region assigned to your NVIDIA device is invalid:
>     NVRM: BAR0 is 0M @ 0x0 (PCI:0000:11:00.0)
>     nvidia 0000:11:00.0: probe with driver nvidia failed with error -1
> 
> The BAR allocation failure occurs before the NVIDIA driver probes, so this
> does not appear to originate in the NVIDIA driver.
> 
> System
> ======
> 
> Distribution:
> 
>     Ubuntu 26.04.1 LTS (Resolute)
> 
> Failing kernel:
> 
>     linux-image-7.0.0-31-generic 7.0.0-31.31
> 
> The failing dmesg identifies it as:
> 
>     Linux version 7.0.0-31-generic
>     #31-Ubuntu SMP PREEMPT_DYNAMIC
>     Ubuntu 7.0.0-31.31-generic 7.0.14
> 
> Known-good kernel:
> 
>     linux-image-6.17.0-42-generic 6.17.0-42.42+1
> 
> CPU:
> 
>     AMD Ryzen 9 9950X3D
>     x86_64
>     48-bit physical address space
> 
> Motherboard/current DMI information:
> 
>     Board vendor:   Micro-Star International Co., Ltd.
>     Board name:     PRO X870E-P WIFI (MS-7E70)
>     Board version:  2.0
>     BIOS vendor:    American Megatrends International, LLC.
>     BIOS version:   2.A52
>     BIOS date:      06/29/2026
> 
> I did not save a separate DMI dump in the failing-boot artifact, so the BIOS
> information above is from the current machine. I believe it is unchanged
> from the failing test, but cannot prove that solely from the saved dmesg.
> 
> GPU configuration at the time of the failing 7.0 capture:
> 
>     0000:01:00.0  NVIDIA GeForce RTX 5090 [10de:2b85]
>     0000:0d:00.0  NVIDIA GeForce RTX 3090 [10de:2204]
>     0000:11:00.0  NVIDIA GeForce RTX 3090 [10de:2204]
> 
> The RTX 5090 is attached directly under a separate root port. The two
> RTX 3090s are sibling endpoints behind the affected chipset/switch path.
> 
> The machine now also contains an RTX 3060 behind 0000:0b:07.0. That GPU
> was added after the failing 7.0 capture and is not part of the comparison
> or arithmetic below. The current four-GPU configuration works on 6.17.
> 
> Relevant topology during the failing test
> =========================================
> 
>     0000:00:02.1  AMD GPP root port [1022:14db]
>       `-- 0000:03:00.0  AMD 600 Series switch upstream [1022:43f4]
>            `-- 0000:04:08.0  AMD 600 Series switch downstream [1022:43f5]
>                 `-- 0000:0a:00.0  AMD 600 Series switch upstream [1022:43f4]
>                      `-- 0000:0b
>                           |-- 0000:0b:04.0 [bus 0d]
>                           |    |-- 0000:0d:00.0 RTX 3090 [10de:2204]
>                           |    `-- 0000:0d:00.1 NVIDIA HDA [10de:1aef]
>                           |-- 0000:0b:05.0 [bus 0e] -- Realtek RTL8126
>                           |-- 0000:0b:06.0 [bus 0f] -- Qualcomm WCN785x
>                           |-- 0000:0b:08.0 [bus 11]
>                           |    |-- 0000:11:00.0 RTX 3090 [10de:2204]
>                           |    `-- 0000:11:00.1 NVIDIA HDA [10de:1aef]
>                           |-- 0000:0b:0c.0 [bus 12] -- AMD USB
>                           `-- 0000:0b:0d.0 [bus 13] -- AMD SATA
> 
> Failing test command line
> =========================
> 
> The saved 7.0 boot used:
> 
>     BOOT_IMAGE=/vmlinuz-7.0.0-31-generic
>     root=/dev/mapper/ubuntu--vg-ubuntu--lv
>     ro
>     crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M
>     pci=realloc=on
>     pci=resource_alignment=0000:00:02.1;0000:03:00.0;0000:04:08.0;0000:0a:00.0;0000:0b:04.0;0000:0b:08.0
> 
> The resource_alignment list was used to force reassignment of the affected
> bridge path.
> 
> This is an important limitation of my existing comparison: the failing 7.0
> capture used the targeted resource_alignment list, while the successful
> 6.17 boot used pci=realloc=on without that list. The 6.17 kernel still had
> to reassign this hierarchy because the firmware-provided non-prefetchable
> window conflicted with AMDIF031:00.
> 
> Prefetchable-window failure
> ===========================
> 
> Each RTX 3090 has:
> 
>     BAR1: 0x800000000 = 32 GiB, prefetchable
>     BAR3: 0x02000000  = 32 MiB, prefetchable
> 
> Therefore each downstream bridge needs a composite prefetchable window of:
> 
>     0x802000000 = 32 GiB + 32 MiB
> 
> The composite child window inherits 32 GiB alignment from BAR1.
> 
> On the failing 7.0 boot, the parent at 0000:0a:00.0 was assigned:
> 
>     0000:0a:00.0:
>       [mem 0x1000000000-0x2003ffffff 64bit pref]
> 
> Its size is:
> 
>     0x1004000000 = 64 GiB + 64 MiB
> 
> This is exactly the plain sum of two 32 GiB + 32 MiB child windows.
> 
> The first child was assigned successfully:
> 
>     0000:0b:04.0:
>       [mem 0x1000000000-0x1801ffffff 64bit pref]
> 
> This consumes 32 GiB + 32 MiB. Its exclusive end is 0x1802000000.
> 
> Because the second child also requires 32 GiB alignment, it cannot start at
> 0x1802000000. Its next legal start is 0x2000000000. Placing another
> 0x802000000-byte child there requires an exclusive end of 0x2802000000.
> 
> Thus the required parent span is:
> 
>     0x1000000000-0x2801ffffff
>     size 0x1802000000 = 96 GiB + 32 MiB
> 
> But Linux 7.0 allocated only:
> 
>     size 0x1004000000 = 64 GiB + 64 MiB
> 
> The shortfall is:
> 
>     0x7fe000000 = 32 GiB - 32 MiB
> 
> The kernel then reports:
> 
>     pci 0000:0b:08.0: bridge window
>       [mem size 0x802000000 64bit pref]: can't assign; no space
>     pci 0000:0b:08.0: bridge window
>       [mem size 0x802000000 64bit pref]: failed to assign
> 
> This appears to be the same arithmetic as the original Vega20 report,
> except that my composite windows contain a 32 GiB NVIDIA BAR1 plus a
> 32 MiB BAR3 rather than a 32 GiB AMD BAR plus a 2 MiB doorbell BAR.
> 
> On 6.17, the same hierarchy received:
> 
>     0000:0a:00.0:
>       [mem 0xd000000000-0xe801ffffff 64bit pref]
> 
> That window is 0x1802000000 bytes, exactly 96 GiB + 32 MiB.
> 
> Both children then fit:
> 
>     0000:0b:08.0:
>       [mem 0xd000000000-0xd801ffffff 64bit pref]
> 
>     0000:0b:04.0:
>       [mem 0xe000000000-0xe801ffffff 64bit pref]
> 
> Both RTX 3090 BAR1 and BAR3 resources were assigned.
> 
> Non-prefetchable-window failure
> ===============================
> 
> The same boot also shows an analogous failure for the ordinary memory
> window.
> 
> Each RTX 3090 branch contains approximately:
> 
>     GPU BAR0:        16 MiB
>     GPU ROM:        512 KiB
>     HDA BAR0:        16 KiB
> 
> With bridge-window granularity, each child requests a 17 MiB ordinary
> memory window. Its alignment is 16 MiB because of GPU BAR0.
> 
> Linux 7.0 assigned the nested parent at 0000:0a:00.0:
> 
>     [mem 0xf2000000-0xf46fffff]
> 
> This is 39 MiB. The ordinary-memory child requirements below that parent
> are 17 + 1 + 2 + 17 + 1 + 1 = 39 MiB, again the plain sum.
> 
> The two 17 MiB GPU child windows alone cannot be packed into 34 MiB because
> each requires a 16 MiB-aligned start. If the first begins at offset zero,
> it ends at 17 MiB. The second cannot begin until offset 32 MiB and ends at
> 49 MiB. The smaller resources may fill some of the intervening gap, but
> they do not make the 39 MiB parent large enough.
> 
> The first GPU child succeeds:
> 
>     pci 0000:0b:04.0: bridge window
>       [mem 0xf2000000-0xf30fffff]: assigned
> 
> The second fails:
> 
>     pci 0000:0b:08.0: bridge window
>       [mem size 0x01100000]: can't assign; no space
>     pci 0000:0b:08.0: bridge window
>       [mem size 0x01100000]: failed to assign
> 
> On 6.17, reassignment produced:
> 
>     0000:00:02.1:
>       [mem 0xf2000000-0xf59fffff]              size 58 MiB
>     0000:0a:00.0:
>       [mem 0xf2000000-0xf57fffff]              size 56 MiB
>     0000:0b:04.0:
>       [mem 0xf2000000-0xf37fffff]              size 24 MiB
>     0000:0b:08.0:
>       [mem 0xf3800000-0xf4ffffff]              size 24 MiB
> 
> Both GPU BAR0 resources were then assigned.
> 
> Endpoint result on Linux 7.0
> ============================
> 
> Once 0000:0b:08.0 loses both bridge windows, allocation failure cascades to
> the endpoint. BAR0, BAR1, BAR3, the ROM, and the audio BAR all report
> "can't assign; no space". The resulting sysfs resources for GPU BAR0,
> BAR1, and BAR3 are all zero.
> 
> NVIDIA then refuses to probe the device because BAR0 is zero. Only the RTX
> 5090 and the first RTX 3090 were usable.
> 
> Known-good result
> =================
> 
> With 6.17.0-42 and:
> 
>     pci=realloc=on module_blacklist=nouveau
> 
> all relevant bridge windows and all physical BAR0, BAR1, and BAR3 resources
> were assigned.
> 
> The system currently boots 6.17.0-42 and directly enumerates all four of
> its current NVIDIA GPUs: RTX 5090, RTX 3090, RTX 3060, and RTX 3090.
> 
> Relationship to 3958bf16e2fe
> =============================
> 
> The observed behavior seems consistent with the tail-side
> multi-composite-resource problem described in this thread:
> 
>   * pbus_size_mem() sizes the parent as the plain sum of child sizes;
>   * each composite child is larger than, and not an exact multiple of, its
>     effective alignment;
>   * assignment then inserts alignment padding between sibling children;
>   * the parent did not budget for that padding;
>   * 6.17 allocates a large enough parent while 7.0 does not.
> 
> The one-line max(r_size, align) -> ALIGN(r_size, align) change appears as if
> it would cover this particular fixed topology, but I understand from the
> discussion that it is not an acceptable general fix because it restores
> unnecessary over-allocation and can regress systems with constrained
> address space.
> 
> I have not verified the exact Ubuntu source against commit 3958bf16e2fe,
> and I have not yet booted a kernel containing the newer proposed general
> solution. Therefore I cannot yet prove the regression attribution by an
> A/B test of the proposed patch.
> 
> Questions
> =========
> 
> 1. Does this look like the same multiple-composite-resource sizing
>    regression to you?

Hi,

I don't want to spend my time on reading long explanations (which often 
are output of AI anyway so of questionable quality and trustworthiness).

But two GPUs look a case where'd likely get scenarions my patch series is 
fixing. The series doesn't fix just the composite sizing calculation but 
also improves resource placement logic which is very much relevant in GPU 
scenarios.

> 2. Would this NVIDIA/AMD-X870E topology be useful as another test case for
>    the newer series?
> 
> 3. If so, which exact branch or patch-series revision should I test?

Either use mainline or base on the latest stable, either is fine in this 
case as things don't move that fast with PCI resource handling.

I've zero love for Ubuntu kernels because I once discovered their 
versioning is misleading claiming kernel version x but is based 
a commit < upstream version x (seemed to be based on some late x-rcY).
No idea why they do that but I suppose it could be corporate pressure 
(Ubuntu's release deadline comes before upstream version x is released) or 
some other unhealthy practice.

> 4. Is the intended solution expected to account for tail padding only when
>    multiple composite children are present, using the final calculated
>    alignment rather than unconditionally rounding every child to its own
>    alignment?

Yes.

Why are you even asking this when above long description text clearly told 
you supposedly understood why unconditional rounding is a bad idea?

Tail padding only applies to a case where there is 3+ composite resources.

2 composites case does only fill the gap between remainders with empty 
space.

> 5. Once accepted upstream, is this fix expected to be marked for stable
>    backport to 7.0.y? Ubuntu 26.04 uses the 7.0 kernel series.

Stable backport decisions are made by stable maintainers or more likely
their auto select scripts. There was time when I tried to get some 
important PCI fix included to stable but they didn't seem to end up taking 
it.

I've stopped caring that much myself but I think anyone could ask 
something to be included into stable, not just me so if you find something 
is useful, you should try to justify it for the stable maintainers yourself.

> I have the complete failing 7.0 dmesg, complete successful 6.17 dmesg,
> focused sysfs resource dumps, and current lspci output available. I can
> provide sanitized copies or collect any additional read-only information
> requested.
> 
> I can also test a candidate kernel, but this is a production multi-GPU
> machine and I need to preserve the known-good 6.17 boot entry. Any test
> would therefore be a one-time boot with a local-console and cold-power
> recovery path rather than immediately replacing the default kernel.
> 
> Thanks,
> JD
> 

-- 
 i.


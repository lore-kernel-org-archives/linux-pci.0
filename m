Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DB3A901D;
	Tue, 29 Sep 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684239; cv=none; b=YOcfx1ZhoPoL2a20IUigbwfow/SlO3h7Os4DEFvslvTHSFpeB0Jngoo3ibv1vgLfo5JsTIZ8RE2qEtL0Z4t7i12ensPCCD4a5GV5uvl4XUo3bbeOdO6zpuqZD+E0NryfIQFgS/UCxMryrKb0/mk3T9pJFfcX8DQuoyk5ban3+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684239; c=relaxed/simple;
	bh=EDWxlHWhi14wfZEdiyiEfOrL9X3cmIqaThULEkRzX/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RIefNljB+vPt2wARP3EDmI0gWiKKm1J/eOcNW1U2wsGZMzoeBvjH7BFdfQ8OWMNMiZo2mY38AlchLrc+2zV+9UECeUj85m8YTyx5dXYHJf1GUVerJ1Guv4tybS4R6uFmb+vHPSeuMVlButE7wB0ndX4a/tWa14faYaZECJ/2D5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDifMsqw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDifMsqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790684237; x=1822220237;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EDWxlHWhi14wfZEdiyiEfOrL9X3cmIqaThULEkRzX/w=;
  b=HDifMsqw9Uhwm6QcSqNMi6foe+a1ddqvhzol7TJSSCTuCPIrrlbJ1332
   TEmxE306R4dLQ+1REVoEMdHs3+FPGxtE/NhKrKr1SuhU0yDn2AN1FnCDF
   v5Wfa+DSvGQhj+8tmsCSnDmWbtDrDsDchXIxqbZHx3vantTL9dX+nsAcN
   07Jy0PER5TUpUtY5vf8s395YQ5SqVYhXLRGSdoDK/dOXhQQaqghLS5Pzi
   7VdthbthNsfnjWm11CmMnJ/oxFqf/fXC/RTG4wBfQc0Wu3tZfmB4Fvv5G
   Awmy5fVjot2c65V1Jf8iq6S5tfLh4YcJfvuucK/5zxdMynVmvS9xIvA0Q
   A==;
X-CSE-ConnectionGUID: gySVDcILRda0MtyOAyYgkw==
X-CSE-MsgGUID: 0RkutFRYS3+q8VaoRvqDDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90620537"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90620537"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 05:17:17 -0700
X-CSE-ConnectionGUID: yEE3TPHxQjiCsX13kWT4FA==
X-CSE-MsgGUID: uu9gYkMxTnGitAtNjRttFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="273140732"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 05:17:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Sep 2026 15:17:09 +0300 (EEST)
To: Mika Westerberg <mika.westerberg@linux.intel.com>
cc: =?ISO-2022-JP?Q?=1B$BD=3B0f86LP=1B=28J?= <monogokoro2026@gmail.com>, 
    linux-pci@vger.kernel.org, bhelgaas@google.com, linux-usb@vger.kernel.org, 
    westeri@kernel.org, andreas.noever@gmail.com, YehezkelShB@gmail.com
Subject: Re: PCI: Resizable BAR never considered for Thunderbolt/USB4 hotplugged
 eGPUs
In-Reply-To: <20260911090800.GZ106095@black.igk.intel.com>
Message-ID: <992676e6-6769-d72d-9ef6-94c1ba758992@linux.intel.com>
References: <CAFpUU0sqt2VzdGGUcx3fkLyyDSynOhNgAraT7-gL53oBq1aMfw@mail.gmail.com> <20260911090800.GZ106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1710482085-1790682627=:1173"
Content-ID: <2f68f70f-f1c0-388b-e6af-714d18487bb7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1710482085-1790682627=:1173
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <3f0f78f9-8401-8bb5-c730-ee51b2f989e1@linux.intel.com>

On Fri, 11 Sep 2026, Mika Westerberg wrote:
> On Fri, Sep 11, 2026 at 05:58:26PM +0900, 鳥井原茂 wrote:
> > 
> > I am reporting a case where a Thunderbolt/USB4-attached eGPU is
> > enumerated and links
> > correctly but can never be used for compute, because its BAR stays at
> > the power-on
> > default of 256MB and the Resizable BAR capability is never exercised.
> > 
> > I am not sure whether this is considered a known limitation or a bug
> > worth fixing, and
> > I would like to ask before assuming either. I have the hardware and am
> > happy to test
> > patches.
> > 
> > Environment
> > -----------
> >   Host:      ThinkPad X1 Carbon Gen 13 (21NS0000JP), Lunar Lake
> >              BIOS N4BET77W (1.47), 2026-06-30
> 
> I don't know if we support REBAR or how well in PCIe side, Ilpo probably
> knows that. Typically there is just certain amount of resources allocated
> for each PCIe root port that gets tunneled so the way to do this is to
> increase that in the BIOS. Having said that most of the vendors don't
> actually allow it to be changed.
> 
> >   Kernel:    7.0.0-31 (Ubuntu 26.04.1)
> >   Enclosure: AOOSTAR AG03, connected over USB4 (not OCuLink)
> >   GPU:       Intel Arc B580 (Battlemage, 12GB), driver xe
> > 
> > What happens
> > ------------
> > The card enumerates, binds to xe, and its edge connector trains at
> > 16GT/s x4, which is
> > the expected ceiling for a USB4 PCIe tunnel. The link is healthy.
> > 
> > BAR2 stays at 256 MiB. The card advertises Resizable BAR support for
> > 256MB..16GB:
> > 
> >   # cat /sys/bus/pci/devices/0000:24:00.0/resource2_resize
> >   0000000000007f00
> > 
> > Level Zero (intel-compute-runtime 26.31.39395.13) prints
> > 
> >   WARNING: Resizable BAR not detected for device 0000:24:00.0
> > 
> > and then drops the device from enumeration entirely, so it never
> > appears to any compute
> > API. The integrated Arc 140V is enumerated normally.
> > 
> > Why the BAR cannot be grown after the fact
> > ------------------------------------------
> > Attempting the resize by hand fails for every size down to 512MB:
> > 
> >   # echo 0000:24:00.0 > /sys/bus/pci/drivers/xe/unbind
> >   # echo 14 > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> > 16GB -> fails
> >   # echo 9  > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> > 512MB -> fails
> > 
> > BAR2 is placed at 0x2010000000, which is only 256MB-aligned, so a
> > larger size cannot be
> > aligned to the bridge base. The prefetchable window of the Thunderbolt root port
> > (0000:00:07.0) is only a few hundred MB and comes from firmware:

The usual result.

> >   PCI: Using host bridge windows from ACPI; if necessary, use
> > "pci=nocrs" and report a bug
> > 
> > I measured 711 MiB and 448 MiB for that window across two boots.
> > 
> > Things that do not help
> > -----------------------
> >   pci=realloc                  no effect on already-populated bridges

This was my discovery as well which blocked my Resizable BAR aware 
resource sizing from doing anything. I did some work to solve it but then 
got regressions from the earlier resource work to address so I've not had 
time to look into this for a while.

Solving this is among the last few blockers for the resizable BAR-aware 
resource sizing (sans the yet to be discovered bugs in the resizable 
BAR-aware code itself).

> >   pci=hpmmioprefsize=32G       makes it worse: the Thunderbolt
> > downstream port the GPU
> >                                sits behind gets no window at all, and
> > the whole card
> >                                disappears from the bus:
> > 
> >     pci 0000:22:00.0: BAR 0 [mem 0x00800000-0x00ffffff 64bit pref]: assigned
> >     pcieport 0000:21:00.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref]:
> >         can't claim; no compatible bridge window
> > 
> >   pci=nocrs                    the machine does not boot: the NVMe
> > holding the rootfs
> >                                fails to get resources and probe returns -ENOMEM
> >     nvme 0000:04:00.0: probe with driver nvme failed with error -12
> > 
> >   thunderbolt.host_reset=0     no effect here, and I believe the
> > reason is that the
> >                                firmware never enumerates the tunnel at
> > POST. The eGPU
> >                                first appears 63 seconds after kernel
> > boot (16:05:11 boot,
> >                                16:06:14 first sighting of the card),
> > i.e. purely as an
> >                                OS-side hotplug event. There is nothing
> > from POST to
> >                                preserve.
> > 
> > The BIOS has no relevant setup option: under Config > Thunderbolt 4
> > there is only
> > "PCIe Tunneling" (on/off). No Resizable BAR, no Above 4G Decoding, no
> > BIOS Assist Mode.
> > I have filed a separate request with the vendor about that.
> 
> BIOS assist mode is a workaround for early Windows systems that did not
> support native PCIe hotplug. It should not be used in any modern systems
> and I doubt it's not even capable of what you are doing.
> 
> > What I think the underlying issue is
> > ------------------------------------
> > On hotplug, the PCI core reads the BAR at its power-on size, sizes the
> > bridge windows to
> > match and assigns addresses, all before any driver binds -- and the
> > ReBAR capability is
> > not consulted at any point in that path. By the time a driver could
> > ask for a larger BAR,
> > the surrounding windows are already committed and too small to grow into.
> > 
> > This looks like exactly what "PCI: Allow BAR movement during boot and hotplug"
> > (Sergei Miroshnichenko, v9, Dec 2020, 26 patches) was written to solve
> > -- the cover letter
> > explicitly lists Resizable BARs as a use case. As far as I can tell it
> > never landed:
> > 
> >   # grep -c -e rescan_prepare -e rescan_done -e bar_fixed -e
> > movable_bars /proc/kallsyms
> >   0
> > 
> > Questions
> > ---------
> > 1. Is ReBAR-over-Thunderbolt-hotplug considered a known limitation, or
> > is this worth
> >    treating as a bug?
> 
> I would say here that it's not even related to the underlying transport,
> could be something else than TB too, as long as PCIe goes inside.

It's a known problem, but fixing it without introducing regressions is not 
easy. The solution must be able to fallback gracefully to smaller sizes 
as needed. Without that, a regression that will surely come up soonish 
would just lead reverting the improvment.

> > 2. Is there any current plan to consult the ReBAR capability during
> > hotplug resource
> >    assignment?

Yes, infact patches already exist to consired ReBAR during resource 
fitting, but they just don't run as is when a bridge is already assigned
so more work is still needed once I get the most recent set of regressions 
out of the way first.

> > 3. What is the status of the movable-BARs series? Is it abandoned,
> > superseded, or waiting
> >    on something?

I've no plans on basing anything on that work.

> > 4. Is there a kernel parameter or sysfs path I have missed that would
> > let the BAR grow
> >    after enumeration?

In some cases, removing siblings that pin any of the upstream bridge 
windows in place prior to executing the resize may allow the entire window 
to move elsewhere.

There's even a patch from Geramy Loveless that would do this automatically 
for empty siblings [1] which is definitely worth a try. It does not work 
universally, however, so YMMV (I don't see your /proc/iomem anywhere so I 
cannot tell whether it likely works in your case).

Somebody was against Geramy's patch as it didn't (and kind of doesn't 
even want to) ensure the unused siblings would be guaranteed to be 
allocated at least some space after the resize (any unused hotplug 
reservation is "optional" so it would be a major change to alter that 
differentiation to address that review comment).

But if that patch works for you, sending your Tested-by tag to its thread 
might actually be helpful.

[1] https://lore.kernel.org/linux-pci/20260428225146.3104063-1-gloveless@jqluv.com/

-- 
 i.
--8323328-1710482085-1790682627=:1173--

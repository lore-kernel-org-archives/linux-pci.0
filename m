Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D946AF10;
	Fri, 11 Sep 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117687; cv=none; b=a4E4C127jvqLRfjimNfCzS3KrkAC3dCmGTI5R5CgGHI2YjopscId+83yTpdr0jdfmmzHMoN38G21zwW0Z481vlKe636fTLhLCJZhv812MbtQu/ctWqkoHBeKT4CsfG3Fe4cOl8Pilp5hdfxVhHJiylXLLzMun021OTa5uCeCLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117687; c=relaxed/simple;
	bh=Nq+0XxKCrXn5WLqfuWpGxYMd0O5Yj5XT9x3UG5j3PVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir6cVtGG0VvwqhFwCzIzBDfWvIvfFW1X9b/vP51E/tUD+U7cnX38UlqZ86XpAsZ6jDcE9slPwxi1JSmoIEO15Y3soG14rQ0Lk8J9eu1LHhN/mIAI9uV9am0g0SpVmFS60BBoE0SZGUJhdIRnkbTf1yEIwWbODi1pkqupRl/A2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPoGY0OR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPoGY0OR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789117684; x=1820653684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nq+0XxKCrXn5WLqfuWpGxYMd0O5Yj5XT9x3UG5j3PVo=;
  b=HPoGY0ORKYSz/nx+YiXllW2VVCslYFPe0aBKwLoNxZoTI/jpDJncf9at
   6j0YLHKXWS1uBnnifMZaCWMX/R7FW5KQrR5ks9QiehYHVVrwlEf39wSWa
   dV/rrwkFOKzzBETrTqMck81HpItOb+r/JV3F49j1fHFyfH8vfCZSVaDHE
   /f8+UMID6JAtUg3dsZpVq6lqxvjXiyx1rwJrr9ZEP7cvJGyUeC54EM/V8
   mLCnLGNG0+b4uvADI+57O79XU/N4QOUhseZ+Ee7NVIPfM6cmWO3AxRlm4
   KgdumAZpwY6Arr09BL1geSyB1MREgjVxX55yWLNVucd+MrMU36WDmWSVL
   w==;
X-CSE-ConnectionGUID: OSaVkWBCQ56TiHQlc2Cwrg==
X-CSE-MsgGUID: AEPfirj1SX6r/t31SetAYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89343762"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89343762"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:08:04 -0700
X-CSE-ConnectionGUID: BE6AxQUvQFmN9VptZTb/Jg==
X-CSE-MsgGUID: 2FljSvmARM6m36WFBP2LWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="275392685"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Sep 2026 02:08:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4CA1399; Fri, 11 Sep 2026 11:08:00 +0200 (CEST)
Date: Fri, 11 Sep 2026 11:08:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?6bOl5LqV5Y6f6IyC?= <monogokoro2026@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, linux-usb@vger.kernel.org,
	westeri@kernel.org, andreas.noever@gmail.com, YehezkelShB@gmail.com
Subject: Re: PCI: Resizable BAR never considered for Thunderbolt/USB4
 hotplugged eGPUs
Message-ID: <20260911090800.GZ106095@black.igk.intel.com>
References: <CAFpUU0sqt2VzdGGUcx3fkLyyDSynOhNgAraT7-gL53oBq1aMfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFpUU0sqt2VzdGGUcx3fkLyyDSynOhNgAraT7-gL53oBq1aMfw@mail.gmail.com>

Hi,

On Fri, Sep 11, 2026 at 05:58:26PM +0900, 鳥井原茂 wrote:
> Hi,
> 
> I am reporting a case where a Thunderbolt/USB4-attached eGPU is
> enumerated and links
> correctly but can never be used for compute, because its BAR stays at
> the power-on
> default of 256MB and the Resizable BAR capability is never exercised.
> 
> I am not sure whether this is considered a known limitation or a bug
> worth fixing, and
> I would like to ask before assuming either. I have the hardware and am
> happy to test
> patches.
> 
> Environment
> -----------
>   Host:      ThinkPad X1 Carbon Gen 13 (21NS0000JP), Lunar Lake
>              BIOS N4BET77W (1.47), 2026-06-30

I don't know if we support REBAR or how well in PCIe side, Ilpo probably
knows that. Typically there is just certain amount of resources allocated
for each PCIe root port that gets tunneled so the way to do this is to
increase that in the BIOS. Having said that most of the vendors don't
actually allow it to be changed.

>   Kernel:    7.0.0-31 (Ubuntu 26.04.1)
>   Enclosure: AOOSTAR AG03, connected over USB4 (not OCuLink)
>   GPU:       Intel Arc B580 (Battlemage, 12GB), driver xe
> 
> What happens
> ------------
> The card enumerates, binds to xe, and its edge connector trains at
> 16GT/s x4, which is
> the expected ceiling for a USB4 PCIe tunnel. The link is healthy.
> 
> BAR2 stays at 256 MiB. The card advertises Resizable BAR support for
> 256MB..16GB:
> 
>   # cat /sys/bus/pci/devices/0000:24:00.0/resource2_resize
>   0000000000007f00
> 
> Level Zero (intel-compute-runtime 26.31.39395.13) prints
> 
>   WARNING: Resizable BAR not detected for device 0000:24:00.0
> 
> and then drops the device from enumeration entirely, so it never
> appears to any compute
> API. The integrated Arc 140V is enumerated normally.
> 
> Why the BAR cannot be grown after the fact
> ------------------------------------------
> Attempting the resize by hand fails for every size down to 512MB:
> 
>   # echo 0000:24:00.0 > /sys/bus/pci/drivers/xe/unbind
>   # echo 14 > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> 16GB -> fails
>   # echo 9  > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> 512MB -> fails
> 
> BAR2 is placed at 0x2010000000, which is only 256MB-aligned, so a
> larger size cannot be
> aligned to the bridge base. The prefetchable window of the Thunderbolt root port
> (0000:00:07.0) is only a few hundred MB and comes from firmware:
> 
>   PCI: Using host bridge windows from ACPI; if necessary, use
> "pci=nocrs" and report a bug
> 
> I measured 711 MiB and 448 MiB for that window across two boots.
> 
> Things that do not help
> -----------------------
>   pci=realloc                  no effect on already-populated bridges
> 
>   pci=hpmmioprefsize=32G       makes it worse: the Thunderbolt
> downstream port the GPU
>                                sits behind gets no window at all, and
> the whole card
>                                disappears from the bus:
> 
>     pci 0000:22:00.0: BAR 0 [mem 0x00800000-0x00ffffff 64bit pref]: assigned
>     pcieport 0000:21:00.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref]:
>         can't claim; no compatible bridge window
> 
>   pci=nocrs                    the machine does not boot: the NVMe
> holding the rootfs
>                                fails to get resources and probe returns -ENOMEM
>     nvme 0000:04:00.0: probe with driver nvme failed with error -12
> 
>   thunderbolt.host_reset=0     no effect here, and I believe the
> reason is that the
>                                firmware never enumerates the tunnel at
> POST. The eGPU
>                                first appears 63 seconds after kernel
> boot (16:05:11 boot,
>                                16:06:14 first sighting of the card),
> i.e. purely as an
>                                OS-side hotplug event. There is nothing
> from POST to
>                                preserve.
> 
> The BIOS has no relevant setup option: under Config > Thunderbolt 4
> there is only
> "PCIe Tunneling" (on/off). No Resizable BAR, no Above 4G Decoding, no
> BIOS Assist Mode.
> I have filed a separate request with the vendor about that.

BIOS assist mode is a workaround for early Windows systems that did not
support native PCIe hotplug. It should not be used in any modern systems
and I doubt it's not even capable of what you are doing.

> What I think the underlying issue is
> ------------------------------------
> On hotplug, the PCI core reads the BAR at its power-on size, sizes the
> bridge windows to
> match and assigns addresses, all before any driver binds -- and the
> ReBAR capability is
> not consulted at any point in that path. By the time a driver could
> ask for a larger BAR,
> the surrounding windows are already committed and too small to grow into.
> 
> This looks like exactly what "PCI: Allow BAR movement during boot and hotplug"
> (Sergei Miroshnichenko, v9, Dec 2020, 26 patches) was written to solve
> -- the cover letter
> explicitly lists Resizable BARs as a use case. As far as I can tell it
> never landed:
> 
>   # grep -c -e rescan_prepare -e rescan_done -e bar_fixed -e
> movable_bars /proc/kallsyms
>   0
> 
> Questions
> ---------
> 1. Is ReBAR-over-Thunderbolt-hotplug considered a known limitation, or
> is this worth
>    treating as a bug?

I would say here that it's not even related to the underlying transport,
could be something else than TB too, as long as PCIe goes inside.

> 2. Is there any current plan to consult the ReBAR capability during
> hotplug resource
>    assignment?
> 3. What is the status of the movable-BARs series? Is it abandoned,
> superseded, or waiting
>    on something?
> 4. Is there a kernel parameter or sysfs path I have missed that would
> let the BAR grow
>    after enumeration?
> 
> Thanks, s-tory.

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B107198A17;
	Tue,  7 Apr 2026 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540517; cv=none; b=ZH0dlsF7ajL3XNpC0p9qbxjp/bPpIDw1dhpIY0Kn5zBsJ1+1QzF7q1kvNjm9/GPA8lkj9ZwZllUsg5Zya8KqCS5/TVwv8B2rGTEZQ7enomofg1i7IEyPXTOIbgroAZqnTPIa6QzL/pGjOiptXGEqIc7eu6RqIRvhJL81V4AUCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540517; c=relaxed/simple;
	bh=QBNqn7DqPN6bH4V+rhCTGIvoTW/Q6i+xfn6srh4kWSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO3hzKH2WdJCcTNNvxWlQ/U4ez8GPdyZwvyFzlnea+uHOQNNstRdqFLoQuBXR0v312MUDljY9Tcv0ehx+WhdPRqxdQm0GEQeRr6wFMkMmpfzVYX7cijkHcyC/Lr7fr3FbpWdtJn4FaT8imWn87mTRTTANHssFn/j6OkOrT/AdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPlDd/wt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPlDd/wt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775540515; x=1807076515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QBNqn7DqPN6bH4V+rhCTGIvoTW/Q6i+xfn6srh4kWSs=;
  b=FPlDd/wtYpf82oVKX9DczPnxF0yqz0jmQnYD2SQRwq0iPlxYHmB13bwb
   xe9KgR0w/CE7W7GW/Of9IXZN/5Dqir1WTSI6WEtNUY7hDX0+bUUbDs9Y9
   gpmCvxSCZ9rviWaH4gDlgUf+grOdyBs7XpT0CNC0gV2ApWsj9grHX99su
   9az3h7Rqf2QLSsOCVdSqllmtTz0J0K8wXesmnbc492nJL4+m2Vpbc+t5C
   ZvNeRg9qBug3qtsSRWz/vXIJGt+gsHfhUjCP4G5NinKDPSmzjUx+59LlJ
   I1FEvbIg/VK701d1bG7JokRCib1nbrFCVJ7ic5zfoceDaPWjAZlSQxKDf
   w==;
X-CSE-ConnectionGUID: 0UIydvNgTnidWkThi2v0OA==
X-CSE-MsgGUID: RdLp+IHiREmLUHDudwI07A==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76684881"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76684881"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 22:41:55 -0700
X-CSE-ConnectionGUID: uTY+sCtjS1mbAZzEd8n77A==
X-CSE-MsgGUID: t+lVLBpARgq1I5LzoBQxnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223764674"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 06 Apr 2026 22:41:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A949595; Tue, 07 Apr 2026 07:41:51 +0200 (CEST)
Date: Tue, 7 Apr 2026 07:41:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Georg Klima <Georg.Klima@durst-group.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thunderbolt@lists.linux.dev" <thunderbolt@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"georg_klima@gmx.at" <georg_klima@gmx.at>,
	Rene Sapiens <rene.sapiens@linux.intel.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject: Re: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ
 warning and shutdown failure.
Message-ID: <20260407054151.GC3552@black.igk.intel.com>
References: <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
 <adIkaExcG-T5XACV@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adIkaExcG-T5XACV@wunner.de>

Hi,

On Sun, Apr 05, 2026 at 10:59:20AM +0200, Lukas Wunner wrote:
> [cc += Mika, Rene, Alan; start of thread is here:
> https://lore.kernel.org/all/AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM/
> ]
> 
> On Thu, Mar 26, 2026 at 04:09:05PM +0000, Georg Klima wrote:
> > I am reporting a reproducible shutdown issue involving Thunderbolt,
> > PCIe hotplug, and runtime PM on a Lenovo ThinkPad P16.
> > System fails to power off cleanly when PCIe ASPM is enabled.
> > After the kernel prints "Power off", it emits warnings and does not
> > complete shutdown.
> 
> The dmesg output shows that the problems start much earlier than
> on shutdown:  The discrete "Barlow Ridge" Thunderbolt controller
> is hot-removed at the 08:44:29 timestamp in a noisy fashion:
> 
> > Mar 26 08:44:28 fedora kernel: usb 3-3: reset full-speed USB device number 2 using xhci_hcd
> > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
> > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
> > Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> > Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for TX ring 0 is already enabled
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not ready at resume -19
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume error -19!
> > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: HC died; cleaning up
> > Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 at ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/1092
> 
> The controller is then re-discovered after the link goes back up.
> The actual shutdown doesn't seem to start until the 08:45:26 timestamp.
> 
> Going forward please use "dmesg" to collect kernel output, not journalctl,
> so that we get timestamps with usec granularity.
> 
> >   *   Hardware: Lenovo ThinkPad P16 (21RQ003BGE)
> >   *   BIOS: N4FET30W (1.11) 10/03/2025
> >   *   Kernel: 6.19.10-200.fc43.x86_64
> >   *   Distribution: Fedora 43
> >   *   Platform: Intel (Meteor Lake)
> >   *   Thunderbolt controller: 0000:8a:00.0
> 
> It looks like this isn't Meteor Lake but Arrow Lake-S:
> 
> 0000:80:1b.4 - Arrow Lake-S (800 Series) PCH Root Port #21
>   0000:88:00.0 - Barlow Ridge Upstream Port
>     0000:89:00.0 - Barlow Ridge Downstream Port to NHI
>       0000:8a:00.0 - Barlow Ridge NHI
> 

Looking at the dmesg there is hotplug enabled for the PCIe root port:

  Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot #25 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+

For Barlow Ridge it should be disabled. Lenovo may already have a BIOS fix
please check. They have done that for other models too.

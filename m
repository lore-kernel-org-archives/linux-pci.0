Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1317D2
	for <linux-pci@vger.kernel.org>; Sat,  7 Feb 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770428580; cv=none; b=QOk2o4h4F7UXLs0fn38nAuqOnzV2PCrQVy1xYyfsCNJBaxeHyS0zX3ur8eNaLjdHFVuvrk6Xrzzh6Q+/isauZDpd9P1HdTyoL5PFK9WSQynFIz4i0L+Jdsm851wbZcAkFn218fA8y/ltBh5w4EAo6pIIZ/lAwAGrqgaLlSLvXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770428580; c=relaxed/simple;
	bh=nM4TD51nEBf9Es1Jv5dwYF+TQVv1NWVTHW6DIlxuT+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBrZJolhePsKfDDfWaN9vOxHhtAr8xUVmP5UJLbYdC1Wdw+dUGVLpYm+3h/NTNnSuQmvGcxCtdOLrwqPbYrmHFZ2uoH646jN9VIpAVZ77BKMA6wNWKb4hqRfLi0Z5K5vlN458gtN2xAYvI6y1uWDpUgC3dUY15Xok0YxQjwUrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=ZmED/Hm3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="ZmED/Hm3"
Date: Fri, 6 Feb 2026 17:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1770428577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou9hbR74SGxtKKIfWKPL/WEcI3zRLMFpkLgLFcBQ8WM=;
	b=ZmED/Hm38wTLIm/E8KHam9U0IwOQNVFtLChId7yVGj8WkDm2ltfX3VnSLUMw89j1Z3P2mr
	LMBjoGKBzHJayj0w0wakuevLMgHz94hA+nhld9RhFKuxIdWNIGrqaaAxtVdcRfrdHIn25s
	JKD2Z191ui71GJQdCx66Bu3tMISz95uhwCRUwLBzFPuZaBT6Ma4g7mfX33pTFWWqbfgf6o
	xAIQ+6D+x4s1uYH6hXtL8V7sRz8nEKGDHrUxQ6DE9kLeWnCmgFf1ciaUVE+SARiCYavYQr
	MKNgxi425jS399C0Gd1iS7qCQ9uDBXDubIw8mV2sBZePSkoZYSia2bQTc6rTEQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: "DECUI@microsoft.com" <DECUI@microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"jakeo@microsoft.com" <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Message-ID: <aYaYnMYik3SC45bb@templeofstupid.com>
References: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

Hi Matthew and Michael,

On Fri, Jan 23, 2026 at 06:39:24AM +0000, Michael Kelley wrote:
> From: Matthew Ruffell <matthew.ruffell@canonical.com> Sent: Thursday, January 22, 2026 9:39 PM
> > > > There's a parameter to the kexec() command that governs whether it uses the
> > > > kexec_file_load() system call or the kexec_load() system call.
> > > > I wonder if that parameter makes a difference in the problem described for this
> > > > patch.
> > 
> > Yes, it does indeed make a difference. I have been debugging this the past few
> > days, and my colleague Melissa noticed that the problem reproduces when secure
> > boot is disabled, but it does not reproduce when secure boot is enabled.
> > Additionally, it reproduces on jammy, but not noble. It turns out that
> > kexec-tools on jammy defaults to kexec_load() when secure boot is disabled,
> > and when enabled, it instead uses kexec_file_load(). On noble, it defaults to
> > first trying kexec_file_load() before falling back to kexec_load(), so the
> > issue does not reproduce.
> 
> This is good info, and definitely a clue. So to be clear, the problem repros
> only when kexec_load() is used. With kexec_file_load(), it does not repro. Is that
> right? I saw a similar distinction when working on commit 304386373007,
> though in the opposite direction!

Just to muddy the waters here, I have a team on the Noble 6.8 kernel
train that's running into this issue on Standard_D#pds_v6 with secure
boot disabled. I've validated via strace(8) that kexec(8) is calling
kexec_file_load(2), but in this case the problem Dexuan describes in the
cover letter occurs but affects NIC attachment instead of the NVMe
storage device. (e.g. pci_hyperv attach of the NIC reports the
pass-through error instead of successfully attaching).


> > > > >  	/*
> > > > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > > > -	 * space.
> > > > > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > > > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > > > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > > > > +	 * zero in the kdump kernel.
> > > > >  	 */
> > > > > -	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > > > +	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> > > > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > > --
> > 
> > Thank you for the patch Dexuan.
> > 
> > This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
> > booting V6 instance types on Azure with Gen 2 images.
> 
> Are you seeing the problem on x86/64 or arm64 instances in Azure?
> "V6 instance types" could be either, I think, but I'm guessing you
> are on x86/64.
> 
> And just to confirm: are you seeing the problem with the
> Hyper-V DRM driver, or the Hyper-V FB driver? This patch mentions
> the DRM driver, so I assume that's the problematic config.

It's been arm64 and not x86 for the case I've seen.  They're currently
running with the hyperv_drm driver, but they've also tried swapping to
the fb driver without any change in results.

> > Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

All of the above said, I also tested Dexuan's fix on these instances and
found that with the patch applied kdump did work again.

Tested-by: Krister Johansen <johansen@templeofstupid.com>

-K

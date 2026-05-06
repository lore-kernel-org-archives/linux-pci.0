Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C63612E7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071144; cv=none; b=vEgBuSdOt6dSWl6ahkr2GSdpfoTkDiXIy4BKqxNNYU0RrnvIrqfDXULkEBZeJtsdwDi63ZEhvm3wS++KDc54rkXMhtSKgsCph1xNiTRjgfR+if54wWfXNwGrx1/wFpqwLlyU+P0gC3DaNQr/fGj0YFHOtye1OIm658BDPzsGU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071144; c=relaxed/simple;
	bh=DNFrMkD57FFYIl9NNNFf1ULJWcFODC/yZy07/DDUr7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYxD85+s98KYG0En8g1HaxMbSwyLZbNCI8Bqm7Wq9UP+kTScqW0AeyXp9I9XVXfRbOIBvLezt3uxnMRLnQXYqPsWCdhKAj+A/vZgphuvc2OUcfOfiQM9SbhmK5i/niavRC2kYdhvWjlyT88pKt3Swh/n7Qwkona7BRVBW616Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apyTeJEc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apyTeJEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778071142; x=1809607142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DNFrMkD57FFYIl9NNNFf1ULJWcFODC/yZy07/DDUr7Y=;
  b=apyTeJEcJcjf4FQjR2QGiRbM2VMF1ElAk4IHD9vQWgT4MNqugXOL7/QF
   S9Vp01Wxhd8yae44W5hVCe+AnjZ+DjEF8nZDXc/LqVAI1G+upbJ0hl2tH
   t05BvPLIuefKqR7xnK3vmASg0+3yc2+BpFkjcGz/LF7w09xnMLwCRQkKV
   9L7yX4yhtaU9I2NL2J9aID20r59TNEP5P0TGEWYOAGv0M6cq17PEnlPFZ
   mROMRvbzA3VzFFZKKC3iYFE4vKbHZv0r8vtJJuM5xX6twezV5IiRWRXcI
   s93cfYAPdCZn2CpQ2Gp9JVG6+lR+xWb/ExyVKgYgrKk+4adNUFGKdqKuO
   Q==;
X-CSE-ConnectionGUID: k3Gz6x9ERCCmGH3hebaYFg==
X-CSE-MsgGUID: QvB1/uFaQHSqrxrOEsdWbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66529024"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="66529024"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:39:01 -0700
X-CSE-ConnectionGUID: o8npl72ZTr+9XpWtqIN3ag==
X-CSE-MsgGUID: go5BB1GJQZKsB2ChZKD6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236240739"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 06 May 2026 05:38:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 636E495; Wed, 06 May 2026 14:38:58 +0200 (CEST)
Date: Wed, 6 May 2026 14:38:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: stuck-tamer-growl@duck.com, Sanath S <Sanath.S@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"bjorn@helgaas.com" <bjorn@helgaas.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after
 ASPM common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
Message-ID: <20260506123858.GL6785@black.igk.intel.com>
References: <20260504184325.GA656008@bhelgaas>
 <AB2EBCFC-663F-48A1-9C11-2DFB7C844B19.1@smtp-inbound1.duck.com>
 <F2774784-D1E3-46C2-8A6A-CC8932884D5F.1@smtp-inbound1.duck.com>
 <8ad6c6c8-48e4-b276-e639-ae9362cc7eff@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad6c6c8-48e4-b276-e639-ae9362cc7eff@linux.intel.com>

Hi,

On Wed, May 06, 2026 at 03:26:43PM +0300, Ilpo Järvinen wrote:
> On Wed, 6 May 2026, stuck-tamer-growl@duck.com wrote:
> 
> > Bjorn and All,
> > 
> > Attached 
> > 
> > pristine.dmesg.txt and pristine.lspci-vv.txt                                                                  
> > cmdline "quiet splash", same kernel/hardware as the report.                                                                    
> >                                                                                                                                         
> > Many thanks!
> > 
> > Peter / stuck-tamer-growl
> > 
> > 
> > 
> > On Monday, May 4th, 2026 at 2:43 PM, Bjorn Helgaas <helgaas_at_kernel.org_stuck-tamer-growl@duck.com> wrote:
> > 
> > > [+bcc reporter]
> > > 
> > > On Mon, May 04, 2026 at 01:29:28PM -0500, Bjorn Helgaas wrote:
> > > > ---------- Forwarded message ---------
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=221457
> > > > ...
> > > > SUMMARY
> > > >
> > > > Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
> > > > Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
> > > > common-clock reconfigure on the host root port, the downstream bridges go
> > > > through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
> > > > MB.
> > > 
> > > stuck-tamer-growl: Thanks for the report.  Would you mind collect the
> > > complete dmesg log and the output of "sudo lspci -vv" and posting them
> > > here (or in the bugzilla if you prefer)?
> 
> Hi,
> 
> To me it looks the ASPM/CCC is a red herring (or another problem unrelated 
> to the ReBAR size issue).
> 
> What happens here is the entire PCIe topology is reset:
> 
> [    1.121434] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Down
> [    1.121439] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card not present
> [    5.804638] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card present
> [    5.804643] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Up
> 
> I recalled Mika Westerberg mentioned some time back Thunderbolt is 
> starting to reset things on boot so this might be related to that.
> 
> As the hotplug tears down everything on PCI side, there's nothing to hold 
> the ReBAR size information across as far as PCI core is concerned.
> 
> Thunderbolt reset on boot was (probably) introduced by this commit:
> 
> 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
> 
> 
> I don't know if the nvidia out-of-tree driver does attempt BAR resize on 
> its own (some in-kernel GPU driver do on their own outside of PCI core's 
> resource fitting algorithm). At least there's no indication in the log 
> that would point to even a resize attempt happening.
> 
> 
> My resizable BAR aware resource fitting would eventually solve this but 
> it's not yet ready. I'm currently trying to fix pci=realloc not detecting 
> need to resize anything if the current ReBAR size fits just fine.

One temporary workaround until your code is ready is passing
"thunderbolt.host_reset=0" in the command line. That will skip the reset.

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934C480DF3
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078682; cv=none; b=PIbxzj7z/hUlZGZmpENPbyCsdF+zZizwdJZj4bjj1Un0BIYVl2CWdrDAI6cg1HQS7Gof5hicgv81LVPIHRg5zGEoq7LBZmhLvFunY7sXf2nTVxRaUWndYzfB8w9y3GnQ31KE5GrAnZPbJXiiGMOaRdW9UA4z37ikAgg9vF7m6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078682; c=relaxed/simple;
	bh=VHLh6icOD/qGij2EywTZFOUhHJOnoS9XpqYMhB1oo2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl4UshZ7jdhQHqRrnJi7bbSHWlmU8oZ/76WyYHuc8M64uwEVHNyu5R8Y61A6uncax20kqHnRmf+9OiGslWKGcKcSawpMEsKoaUS6m9PSwC+XhP02YmgkTOrGT/YHD5UJBs0AjEfJOmoPWkRxqEPbYjZDIBB0i5nIYc8gU/QELao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKG53BQp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKG53BQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778078679; x=1809614679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VHLh6icOD/qGij2EywTZFOUhHJOnoS9XpqYMhB1oo2M=;
  b=XKG53BQpXha24Fr+72oDJdHHRqjdPeDePSNQ3o2+PjG9JdugvWVPuUeG
   POoXsKKGx0JDercnK7DGXDIwalii8f3HLSK9uIc6mr7BwJF22cGKDXIQ9
   O/FibvBJ6p2TklvuN6/gNPnYQ1Y8R9meJEXfH65F0mjt4uGwIZa2cK63k
   gfYpuXNl8qhLD3UEThVruN0ZTFtOZf80tTcuegTjdAMu2qElg82Kvstii
   OsxYpZNyFu2FC+F5j60xRPj+6z5htODQHHlq6YvUs2TwtH/U0wDfEX8gH
   6V2dwYYxD0fgS7AysWUAXzuomPlBwAqSvj/6AFIpCyp6tIJjcVZRSHWq2
   A==;
X-CSE-ConnectionGUID: ATQFjJW9QgiCIECzxJi98A==
X-CSE-MsgGUID: UcoZnxiDSGeMBb4tCdj0wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78160494"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78160494"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:44:38 -0700
X-CSE-ConnectionGUID: 8D5+bhj2TPuX0nZsH/sMuw==
X-CSE-MsgGUID: ccWxtvIfRsKQkE7MAU1fQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231787511"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 06 May 2026 07:44:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 38B6C95; Wed, 06 May 2026 16:44:35 +0200 (CEST)
Date: Wed, 6 May 2026 16:44:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	stuck-tamer-growl@duck.com, Sanath S <Sanath.S@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"bjorn@helgaas.com" <bjorn@helgaas.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after
 ASPM common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
Message-ID: <20260506144435.GM6785@black.igk.intel.com>
References: <20260504184325.GA656008@bhelgaas>
 <AB2EBCFC-663F-48A1-9C11-2DFB7C844B19.1@smtp-inbound1.duck.com>
 <F2774784-D1E3-46C2-8A6A-CC8932884D5F.1@smtp-inbound1.duck.com>
 <8ad6c6c8-48e4-b276-e639-ae9362cc7eff@linux.intel.com>
 <20260506123858.GL6785@black.igk.intel.com>
 <6651652a-cab6-4791-a883-2e7de8a009f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6651652a-cab6-4791-a883-2e7de8a009f5@amd.com>

Hi,

On Wed, May 06, 2026 at 08:07:26AM -0500, Mario Limonciello wrote:
> 
> 
> On 5/6/26 07:38, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, May 06, 2026 at 03:26:43PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 6 May 2026, stuck-tamer-growl@duck.com wrote:
> > > 
> > > > Bjorn and All,
> > > > 
> > > > Attached
> > > > 
> > > > pristine.dmesg.txt and pristine.lspci-vv.txt
> > > > cmdline "quiet splash", same kernel/hardware as the report.
> > > > Many thanks!
> > > > 
> > > > Peter / stuck-tamer-growl
> > > > 
> > > > 
> > > > 
> > > > On Monday, May 4th, 2026 at 2:43 PM, Bjorn Helgaas <helgaas_at_kernel.org_stuck-tamer-growl@duck.com> wrote:
> > > > 
> > > > > [+bcc reporter]
> > > > > 
> > > > > On Mon, May 04, 2026 at 01:29:28PM -0500, Bjorn Helgaas wrote:
> > > > > > ---------- Forwarded message ---------
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=221457
> > > > > > ...
> > > > > > SUMMARY
> > > > > > 
> > > > > > Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
> > > > > > Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
> > > > > > common-clock reconfigure on the host root port, the downstream bridges go
> > > > > > through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
> > > > > > MB.
> > > > > 
> > > > > stuck-tamer-growl: Thanks for the report.  Would you mind collect the
> > > > > complete dmesg log and the output of "sudo lspci -vv" and posting them
> > > > > here (or in the bugzilla if you prefer)?
> > > 
> > > Hi,
> > > 
> > > To me it looks the ASPM/CCC is a red herring (or another problem unrelated
> > > to the ReBAR size issue).
> > > 
> > > What happens here is the entire PCIe topology is reset:
> > > 
> > > [    1.121434] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Down
> > > [    1.121439] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card not present
> > > [    5.804638] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card present
> > > [    5.804643] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Up
> > > 
> > > I recalled Mika Westerberg mentioned some time back Thunderbolt is
> > > starting to reset things on boot so this might be related to that.
> > > 
> > > As the hotplug tears down everything on PCI side, there's nothing to hold
> > > the ReBAR size information across as far as PCI core is concerned.
> > > 
> > > Thunderbolt reset on boot was (probably) introduced by this commit:
> > > 
> > > 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
> > > 
> > > 
> > > I don't know if the nvidia out-of-tree driver does attempt BAR resize on
> > > its own (some in-kernel GPU driver do on their own outside of PCI core's
> > > resource fitting algorithm). At least there's no indication in the log
> > > that would point to even a resize attempt happening.
> > > 
> > > 
> > > My resizable BAR aware resource fitting would eventually solve this but
> > > it's not yet ready. I'm currently trying to fix pci=realloc not detecting
> > > need to resize anything if the current ReBAR size fits just fine.
> > 
> > One temporary workaround until your code is ready is passing
> > "thunderbolt.host_reset=0" in the command line. That will skip the reset.
> 
> A few background things of that host reset:
> 
> 1. BIOS won't reserve enough MMIO resources for downstream device in PCIe
> tunnel to be able to hotplug.  If Linux inherits assignments you get in a
> bad situation.
> 
> For example:
> Boot with a dock connected and no downstream storage.
> Try to hotplug downstream storage.
> Downstream storage doesn't work in Linux.
> 
> Boot with dock connected and downstream storage connected.
> Downstream storage does work in Linux.
> 
> 2. Windows does the same thing.

The other thing is that this is essentially same as plugging in a device
after the system has booted up. Linux should be able to reserve resources
for its needs.

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45243CEE7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070412; cv=none; b=goVTYQKr+IPGLFUQIYuB7OWEX8bdF0nDi7wMLHHTq7b7vEFPXzYS1furb3QTmLJHbeCo0v/jJ6TA22fD7O6kYw5yUAVveb3pfkJXxWxe3EQ+PjiAqE8myVLSy17EFt46UjTgHWTpZFSLeASi3ZfB195lYGiOnnh1MWymxY9tvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070412; c=relaxed/simple;
	bh=ikT94KsWrOMd3eUjic2p5g+1U/hWXVVWvYgJTg15GFU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JopdQspuMNgO6jGypiUZ1gwAQZ/LyEqduy13O0ZkX2QAIRpf47D+73zLi4L55kYZKp5XvMJmxIbzunmdP8W3ZsWwroBwPWCSv5JtC00l7jDux3c5vU6T9DIGpAAMrTDAnKLvdFYjI3V4Ln5rT+GjtOvdh7R/yjCYxDrZFeO1CvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uezzlt+0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uezzlt+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778070411; x=1809606411;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ikT94KsWrOMd3eUjic2p5g+1U/hWXVVWvYgJTg15GFU=;
  b=Uezzlt+0ZT2UOrlslGHALK4DwllMKcWPqYQLuD66jrZIw5DVZF/6Eeuy
   WJKbADl/3JDGoecuWMHAzsVObLz1dn803T0uXsoG05lShLlkBVqDjM2ki
   1EDOalYR25QI1Ra36hI1WyrI+0jBXFkCE70UK9aTNH9DjJqrQx24bmepv
   lpDz2JfzHvR4CzC/o4cEwp3X3dDU/EYYnXKtxQ7M+1jZ/IbLPaZvHPMNF
   dxoL/hBwgJjNKfa+Rp29vmBfj2FJBRwI1GMVmpG9hXTBonnVq/zilFVXf
   b14rdqbmX0PTLjCxhGZvarxsBaWWRwyQ8XJfQWKaHjBuTCQL7r3sQoa1E
   A==;
X-CSE-ConnectionGUID: cPTHMRqKR0GgZ6AAMRE5xw==
X-CSE-MsgGUID: wNGTQOC6SMG3T9+dmriuBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82867214"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82867214"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:26:50 -0700
X-CSE-ConnectionGUID: CpBiOoVFTSawM2FXWEjWlg==
X-CSE-MsgGUID: cyLV2ZE7QCKG8KgoPaLafA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240113562"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.231])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:26:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 May 2026 15:26:43 +0300 (EEST)
To: stuck-tamer-growl@duck.com, Sanath S <Sanath.S@amd.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Bjorn Helgaas <helgaas@kernel.org>
cc: "bjorn@helgaas.com" <bjorn@helgaas.com>, 
    Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after
 ASPM common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
In-Reply-To: <F2774784-D1E3-46C2-8A6A-CC8932884D5F.1@smtp-inbound1.duck.com>
Message-ID: <8ad6c6c8-48e4-b276-e639-ae9362cc7eff@linux.intel.com>
References: <20260504184325.GA656008@bhelgaas> <AB2EBCFC-663F-48A1-9C11-2DFB7C844B19.1@smtp-inbound1.duck.com> <F2774784-D1E3-46C2-8A6A-CC8932884D5F.1@smtp-inbound1.duck.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 May 2026, stuck-tamer-growl@duck.com wrote:

> Bjorn and All,
> 
> Attached 
> 
> pristine.dmesg.txt and pristine.lspci-vv.txt                                                                  
> cmdline "quiet splash", same kernel/hardware as the report.                                                                    
>                                                                                                                                         
> Many thanks!
> 
> Peter / stuck-tamer-growl
> 
> 
> 
> On Monday, May 4th, 2026 at 2:43 PM, Bjorn Helgaas <helgaas_at_kernel.org_stuck-tamer-growl@duck.com> wrote:
> 
> > [+bcc reporter]
> > 
> > On Mon, May 04, 2026 at 01:29:28PM -0500, Bjorn Helgaas wrote:
> > > ---------- Forwarded message ---------
> > > https://bugzilla.kernel.org/show_bug.cgi?id=221457
> > > ...
> > > SUMMARY
> > >
> > > Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
> > > Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
> > > common-clock reconfigure on the host root port, the downstream bridges go
> > > through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
> > > MB.
> > 
> > stuck-tamer-growl: Thanks for the report.  Would you mind collect the
> > complete dmesg log and the output of "sudo lspci -vv" and posting them
> > here (or in the bugzilla if you prefer)?

Hi,

To me it looks the ASPM/CCC is a red herring (or another problem unrelated 
to the ReBAR size issue).

What happens here is the entire PCIe topology is reset:

[    1.121434] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Down
[    1.121439] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card not present
[    5.804638] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card present
[    5.804643] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Up

I recalled Mika Westerberg mentioned some time back Thunderbolt is 
starting to reset things on boot so this might be related to that.

As the hotplug tears down everything on PCI side, there's nothing to hold 
the ReBAR size information across as far as PCI core is concerned.

Thunderbolt reset on boot was (probably) introduced by this commit:

59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")


I don't know if the nvidia out-of-tree driver does attempt BAR resize on 
its own (some in-kernel GPU driver do on their own outside of PCI core's 
resource fitting algorithm). At least there's no indication in the log 
that would point to even a resize attempt happening.


My resizable BAR aware resource fitting would eventually solve this but 
it's not yet ready. I'm currently trying to fix pci=realloc not detecting 
need to resize anything if the current ReBAR size fits just fine.


-- 
 i.


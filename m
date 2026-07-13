Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1D352004
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966500; cv=none; b=cNsA3wcBbeX5w6MxCKhNeKcdO64kHuRLRgj47btu9sU0vK8eZngDxJJFXIT8zVMjNH+rK8n8DhaCltzCnpEDkgrURwYAo8vhgqXtKDhfbcDaX/1DOQwgwQLVjAzqoAT1EhwbsSHLT1dGJbcmqSie6IOdfNwr8yexIUCBD5kGckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966500; c=relaxed/simple;
	bh=SbeIco7HOJae6hGdmvZ1gQh1xyiQWGZqEfoPTYOmNRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idohPsEYR4jinwOC/Yu+hx0/JQpYQSeKyz+PesCqZBnNLS9MZ2EssBT47U6PEQDUGTxk1ptXeVFH3J+V+aUSgBjbSYaI1HUJREfojWOTzS1SLsl0TkSbYm4E3UYS51ufVkKss6EmIo/d54ujok5uR1wN967wOGstjeXc6aOmI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3UNRtnT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3UNRtnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783966498; x=1815502498;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbeIco7HOJae6hGdmvZ1gQh1xyiQWGZqEfoPTYOmNRs=;
  b=J3UNRtnT+Cd2d7kaJJ3cKX6Y31uq+RTYb8IgMroPydC7SfpHXKykO47O
   vn08GFPCu1Mrplx7Qyf/mVW+VMw3LjwQp9RLOiQ2Z9xGTvf80+1aYdbFF
   1C7aRL+BHiAsWSSQUfZV4xdm59KwcQZgk82AHlE1SLQ1+MmgdUDI3uccv
   VWHo96fxoZAHzaIqNgqBf3X/Jc+p/VfqV7tHlQatYuD4LioMmgJSAFx/Z
   8NkE6PU5dm/mtA1ohAoc2xITQN2ibevjD0K59Ym9FJlhRS809ceHg7N7u
   QQ+9CsGhn+YKJRwCorUP7DmEBEmANgoIhBdECpI+HHf5X6km+vuNC3bvw
   w==;
X-CSE-ConnectionGUID: sBNbwBYLTIm/hD3IErSrFw==
X-CSE-MsgGUID: y8nnujpcRP2LYL8HwrrV4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84676804"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84676804"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:14:58 -0700
X-CSE-ConnectionGUID: HcIiZQPaQJC/vFa3zn7mzg==
X-CSE-MsgGUID: Mc1Is1cLQRadSHoUWUtHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257573316"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:14:57 -0700
Date: Mon, 13 Jul 2026 11:14:57 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nirmal Patel <nirmal.patel@intel.com>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, lpieralisi@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Only assign OSC features in bare metal OS.
Message-ID: <20260713111457.00006fa8@linux.intel.com>
In-Reply-To: <alOIyYDz_RhsqT8v@ashevche-desk.local>
References: <20260710200558.499434-1-nirmal.patel@intel.com>
	<alOIyYDz_RhsqT8v@ashevche-desk.local>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 15:30:01 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jul 10, 2026 at 08:05:58PM +0000, Nirmal Patel wrote:
> > Copy valid OSC flags from root bridge only when OS can provide
> > correct values. In virtual machine, all of the control features are
> > disabled as hypervisor will not passthrough root bridge information
> > to VM.  
> 
> ...
> 
> > v2 : Added descriptive boolean and removed period from commit
> > message.  
> 
> It's still in the $Subject. You probably misinterpreted the
> comment(s).
My bad, i removed (_). Let me correct. Is (_OSC) in subject okay?
> 
> ...
> 
> > +	/* Non-zero offset means guest/direct assign view. */
> > +	vmd_in_guest = offset[0] || offset[1];  
> 
> + Blank line?
Ack.
> 
> >  	/*
> >  	 * Currently MSI remapping must be enabled in guest
> > passthrough mode
> >  	 * due to some missing interrupt remapping plumbing. This
> > is probably
> >  	 * acceptable because the guest is usually CPU-limited and
> > MSI
> >  	 * remapping doesn't become a performance bottleneck.
> >  	 */
> > -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > -	    offset[0] || offset[1]) {
> > +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > vmd_in_guest) { ret = vmd_alloc_irqs(vmd);
> >  		if (ret)
> >  			return ret;  
> 
> ...
> 
> > -
> > vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > -
> > to_pci_host_bridge(vmd->bus->bridge));
> > +	/* Don't copy OSC control flags in VM, it disables
> > features.*/  
> 
> Missing space before */.
Ack.
> 
> > +	if (!vmd_in_guest)
> > +
> > vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > +
> > to_pci_host_bridge(vmd->bus->bridge));  
> 


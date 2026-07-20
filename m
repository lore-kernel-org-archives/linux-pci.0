Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD23A452E
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582481; cv=none; b=SgXv2Tbx8SsIX3ktle1jndmrLAkv7CzWFIbsnkrHtpeRy3JJgAwtAH7YxB7CzVO0CMERLS1UCI8Oce7Cm3H+Lnz/xmZMIMmM6sixHa91GpU/DWwupAp+ihb4iQBj4Pv0eVCs0vRFoByC2UsgGWKnOTIGLi98YRmMFv+hkpXTHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582481; c=relaxed/simple;
	bh=EHWlo0+SvCACCEeRoDUefqiivwqs/BTblLwtgMpcuYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFJSQFW7AZmRoYKd0cMuYrlP9lRL7dukSDX9BuRfVe3DTrqKJrbC5eSkxChOfZWZClg0I+dq4QSjug8Igs0RrjCVblLv1JDVmWBrNi5QDNLfgLzcfiZ3Gk+yACdUBzH25Xfo1xkfykIKUPVjBnIJbNTBjHV/TviaE22TnWVPRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWWPWERO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWWPWERO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784582479; x=1816118479;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHWlo0+SvCACCEeRoDUefqiivwqs/BTblLwtgMpcuYg=;
  b=jWWPWEROOghv/QB+wHYCQlLiHfFPeJWb5evYXu4r9rI61CWjcMtc89G7
   F5iABgUlZiI1/Bc6+9TcrJzZrwuyI7xcvetk/NUaBKvkZ9V63likAyhvP
   iu0YqEhXSh+k2rMGqG8pCLxT3L6xQmedAMXIeCPgjIGexeKk9VGcIa//U
   Wl+hm8k6uVxFH/6czI3uNuBhI74qrUOI6lXCQQSPbrHaVSkxMxArQYBHs
   YocIAPpFUGBW7awIfv25Cf1N4fzFIq++e0zg3d4GKVxkry2Ab9WZ6E3PG
   mH0TAxr4lRpjh8GAOMK8mMcWGp1cbF1wGyDXmAx3D5JDYdUdXKRSVbOlw
   A==;
X-CSE-ConnectionGUID: s0Jbc3g9Q9+e3ZXUDsk5Lw==
X-CSE-MsgGUID: 6Ha5FYCeSiW5/zICteQSnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="107962614"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="107962614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:21:19 -0700
X-CSE-ConnectionGUID: 0UyM16n9R5GxnmmSB9rF0A==
X-CSE-MsgGUID: lawZKg3HQduXj/TLAaF3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256377060"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:21:19 -0700
Date: Mon, 20 Jul 2026 14:21:18 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: nirmal.patel@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 lpieralisi@kernel.org
Subject: Re: [PATCH v7] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260720142118.00000309@linux.intel.com>
In-Reply-To: <20260720183555.GA354351@bhelgaas>
References: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
	<20260720183555.GA354351@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 13:35:55 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Jun 29, 2026 at 04:50:25PM +0000, Nirmal Patel wrote:
> > Newer VMD  with device ID 0x28c1 has unique settings compared to its
> > predecessor where BIOS enumerates the entire VMD device tree and
> > assigns respective configurations.
> > 
> > VMD configuration BAR0 carries over from GNR legacy VMD as the
> > mechanism to access the configuration space of the devices owned by
> > VMD. The size of this window is fixed at 256 MB, where each
> > function consumes 4 KB and every bus consumes 1 MB.
> > 
> > The shadow and scratchpad registers have been relocated from the VMD
> > configuration space to the VMD MMIO space in VMD BAR4/BAR5,
> > otherwise refers to as MEMBAR2 or MSI-X bar.
> > 
> > VMD MSI-X remapping enable/disable is no longer supported.
> > 
> > All the VMD driver code needs to do is to obtain bus hide range
> > along with shadow register values set by BIOS and perform a bus
> > scan.
> > 
> > The commit also involves small refactoring of vmd_enable_domain
> > function. ...  
> 
> > +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> > +					unsigned long features,
> > +					resource_size_t
> > *membar2_offset,
> > +					resource_size_t *offset1,
> > +					resource_size_t *offset2)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Shadow registers may exist in certain VMD device ids
> > which allow
> > +	 * guests to correctly assign host physical addresses to
> > the root ports
> > +	 * and child devices. These registers will either return
> > the host value
> > +	 * or 0, depending on an enable bit in the VMD device.
> > +	 *
> > +	 * For certain VMD devices (i.e. 0x28C1), BIOS places
> > device info
> > +	 * in BAR4 shadow registers to determine the base bus
> > number and memory
> > +	 * offsets.
> > +	 */
> > +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> > +		*membar2_offset = MEMBAR2_OFFSET_28C1;
> > +		ret = vmd_get_bus_info_from_bar4(vmd, offset1,
> > offset2);  
> 
> Is it guaranteed that for device 0x28C1, BIOS will *always* do the
> enumeration?  Sounds like a rev-lock between this device and the BIOS,
> i.e., this device can't be used at all with an old BIOS that doesn't
> know how to do that enumeration?

It is guaranteed for BIOS enumeration for 28c1. They have changed the
hardware to such that with new changes, there is no backward
compatibility. i.e. 28c0 bios can't work with 28c1 and vice versa.

> 
> > @@ -1114,6 +1228,10 @@ static const struct pci_device_id vmd_ids[]
> > = { .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> > +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C1),
> > +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> > +				VMD_FEAT_CAN_BYPASS_MSI_REMAP |
> > +				VMD_FEAT_USE_BIOS_INFO,},
> >  	{PCI_VDEVICE(INTEL, 0x467f),
> >  		.driver_data = VMD_FEATS_CLIENT,},
> >  	{PCI_VDEVICE(INTEL, 0x4c3d),  


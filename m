Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C537EFEC
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725613; cv=none; b=joowniT9eNEyX9vBPdstHKrNMjATOvxYlnJzC997MfwxTo/7dRTyHhzYEq0CdVDBu8X9NmkVYaaiXh+94VxWHzjHKFNQf4VKFP7o6cFvzYjlhvwoRLVvVHVUY8ziQrbSZGBqm1TvLYFckTFUXdTClVigvP5FAIHIoVyN2TF6OV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725613; c=relaxed/simple;
	bh=fKFyAGN8OemXEvnaUNwgZzMf/n97+47ltunxYZGhrqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2NI/ZbkrwvUSCRG6cYAytlfNO6gUCmKnMgzslmpU7L623gYD0MBAyWd1aRH/usq9Fh5v5OLWntm2Q74nREZKdO0mS8R3txNCpawgIi63nw5pNzTpNxFHMdDMYOqbG6dnDZ4Or/8AXDpD3ADQleKEvTpeE+qPsjsEzuzksQ8b3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiOcug7S; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiOcug7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773725612; x=1805261612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKFyAGN8OemXEvnaUNwgZzMf/n97+47ltunxYZGhrqk=;
  b=DiOcug7S1svY23998K0I1WajHkRHMhqcibwXPjbfLbCFlTVER6r/YNVj
   MM+9oZ1Vduq6nlvlp0yZYD/HsE0ZMTFtdbDQAaVs7G6APpAwirYScSEJU
   QX6pjVKRKzpAtcCCAF2ABpbY0/Mza+eLt6Cfp2/1Cct0elu4FC/ndLOze
   kC+jhg/BXJmqH7P0tJm4mLml3NKJH6U4ilnVGsKRMYFIiAC0dYp6Ykg3d
   tknnNcKG+PV+Ovf/t8D4zGQjW5Rcrt7BYD07eoZT5Q76heK8GsirOsT9h
   8VVE+bgyPsgVQbOYtcMZtGAUCcGQe81N3ZqkwzFoQ4dqGstqA/0xd6iwA
   w==;
X-CSE-ConnectionGUID: znqsgwTKSvqDAOh/vHK0kA==
X-CSE-MsgGUID: CeNhzL6gQsS5eIlBen3L5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78603175"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78603175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 22:33:31 -0700
X-CSE-ConnectionGUID: 8aPpMn70TA+wL9mWeuwwWA==
X-CSE-MsgGUID: hEmZPi+LRpGhCdaeyBnxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221174941"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 22:33:28 -0700
Date: Tue, 17 Mar 2026 13:13:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, aik@amd.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <abji3A72ogqdRiGc@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <20260313133658.GD1586734@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313133658.GD1586734@nvidia.com>

On Fri, Mar 13, 2026 at 10:36:58AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 13, 2026 at 06:23:51PM +0800, Xu Yilun wrote:
> 
> > My understanding is, it is the obfuscated host start pfn of this range,
> > if this range has offset to the BAR start, this field should also be
> > offsetted.
> 
> The OS must get an idea of the bar layout out of the report, so there
> have to be restrictions on how it is formed otherwise it is
> unparsible. IMHO the PCI spec created this very general mechanism but

Yeah, now I think I've fully understood the problem. The essential thing
is some of the MMIO ranges could be hidden from the report, at least the
MSIX/PBA ranges must be hidden if not locked/private. This makes guest
hard to find the bar layout out of the report.

> the CPU CC specs need to constrain it to be usable by an OS.
> 
> > >  		range_off = tsm_offset & (pci_resource_len(pdev, bar) - 1);
> > > 
> > > So that we correctly handle if the interface report is reporting a range
> > > within a bar. The only requirement here is bar address should be aligned
> > > to its size and mmio_reporting_offset should not add offsets in that range.

This is the solution on CPU CC side, which requires the TSM to choose a
mmio_reporting_offset aligned to the MAX BAR size so that the
obfuscation won't blur the bar offset info. This is a trade off, the
larger the bar_size, the weaker the obfuscation. Is there a worst case,
that a device has a large bar in high address and a small bar in low
address, the small bar address has no intersection with the
mmio_reporting_offset. Then the obfuscated address ends up being amusing
0xabcd012345000, which clearly leaks the mmio_reporting_offset and the
physical BAR address...


And I've no idea why unlocked MSIX/PBA must be hidden? How about other
non-TEE ranges, must be hidden or mustn't? Is there a possibility we
enforce DSM to present all ranges, then the layout is clear to OS?

> 
> Right.
> 
> Jason

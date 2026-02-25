Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3732695F;
	Wed, 25 Feb 2026 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012608; cv=none; b=Chk2/luI+9/liZWlP+pNDsry4n0RoVoZrIrY+aIf6umjFUrt+7hhwGQW5n1b+2SfMQN0xx69o8wB6RI3DcoeIHIgfKG0HORG3AtVTJUdGIAABDKTjB078hxBFVzDDSPGavsBVwCJDl0TeQEYd5cewaGgG+2lWHoUcEPRrjomqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012608; c=relaxed/simple;
	bh=kENOrTkGkaholJ86orOv0qmhnNqpppTmX5csgJyKJPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERjqkVz4islJt/MVyDi80yQ0QRWWlYb8SrRvFiqbIGH7GS+9hJqwPhyDDUv/SeDQ3YnciRriq1zhWHfzjTVPmOJrYlhHHAp1c3lb0gxq/StoXYQ+RaJKHkOIJaeXJszyLvutpIhL0+b6ebfYsKJ5hqbAojdc6+Zorfhx3E1KgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzmMGjDA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzmMGjDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772012607; x=1803548607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kENOrTkGkaholJ86orOv0qmhnNqpppTmX5csgJyKJPI=;
  b=jzmMGjDAwUc+mJANk+NA9JXNXKit5CP+aikXceW4vsAh95NnZRmLCSdA
   X1KP2ouvI4O99DhiwEjPKo483o7URCH7tEnkxRbD939TaTSc1+I9wfQdL
   aROYXwW1rkFn42HFlQJIJ3oQtaBzsQkndFoTq0LeV+0dhgmv4CeLa5gUW
   K0R4oXj6pIvDS+NYpHgPSK1G9A7D8sk13MT02YSJ09VNL3dh/eEuhvuDB
   ys55eAGUsgxWZc1sqT+C6TQKBVdVF4PEG2+coU6Btdh/JDeTipRpdhE0R
   btj76qYGBtzr2O/V5caFyE6E7Kqr4VmyHAVfiNslJ3HyUiiMyCIQ/3DJU
   g==;
X-CSE-ConnectionGUID: 9i3Kga8fTN+mxJEIHPnVJw==
X-CSE-MsgGUID: HzTw3/pfQGegdCvwBEqRRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72952689"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72952689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:43:26 -0800
X-CSE-ConnectionGUID: n6g1UJDNSRaFOGF+/MipEQ==
X-CSE-MsgGUID: bZFgmHYrQuGFYVM5wB4ToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="253942723"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:43:24 -0800
Date: Wed, 25 Feb 2026 11:43:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
Message-ID: <aZ7EOa8NEMKAlGA_@smile.fi.intel.com>
References: <20260223184017.688212-1-dmatlack@google.com>
 <aZy6cge_a9a7O03g@smile.fi.intel.com>
 <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com>
 <aZ3fCdkCIAW-Q4-k@smile.fi.intel.com>
 <CALzav=eCZf_N=J9pfO8=-8k9TvCbT7m-=ByCL2jZYni=Kaeopw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eCZf_N=J9pfO8=-8k9TvCbT7m-=ByCL2jZYni=Kaeopw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 09:41:30AM -0800, David Matlack wrote:
> On Tue, Feb 24, 2026 at 9:25 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 24, 2026 at 09:19:05AM -0800, David Matlack wrote:
> > > On Mon, Feb 23, 2026 at 12:37 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:

...

> > > > > Fix this by disabling ATS via quirk during "early" fixups instead of
> > > > > "final" fixups.
> > > >
> > > > Hmm... Sounds to me like a premature disablement, but I leave it the experts.
> > >
> > > What do you mean by "premature disablement"?
> >
> > On early stage instead of final stage.
> 
> Is your concern that applying the quirk at early stage won't be
> effective because ATS will be enabled after early fixups are applied?

My concern that applying this quirk too early may affect something else.
But I'm not an expert in the PCI mysterious ways, I just share my feelings.

> To prevent that the patch adds a no_ats bit that blocks ATS enablement
> after early fixups.
> 
> If not that, I guess I am wondering what is your concern from a
> functional level.
> 
> > > > What I think about the case, that IOMMU should be probably fixed to avoid such
> > > > situation for all level of quirks. Can it be feasible?
> > >
> > > What do you mean by the "IOMMU should be fixed"? Are you saying the
> > > IOMMU should be prepared to handle quirks disabling features on
> > > devices after the IOMMU driver is notified about a device?
> >
> > Something like this, yes. At least the commit message is unclear why
> > "This fixes at least one bug in the Intel IOMMU driver..." not in IOMMU
> > driver code.
> 
> Gotcha. It felt wrong to have the IOMMU driver be notified about a
> device with ATS enabled and then have ATS later disabled. It seem like
> it would add complexity to the IOMMU drivers to handle such a case,
> and would be much simpler to have ATS in its final state when the
> IOMMU driver is notified about the device being created.

Can this be elaborated in the commit message? Then a reviewer will not
have questions like me.

> But maybe Lu Baolu and David Woodhouse (Intel IOMMU maintainers) can
> comment if they prefer to handle this in the Intel IOMMU driver.

I agree that his input may be valuable in this discussion.

-- 
With Best Regards,
Andy Shevchenko



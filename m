Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BB2D5C8E;
	Fri, 16 Oct 2026 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152143; cv=none; b=aDq6xR2HdZIivsI/GFylJrAQ3KchryM+0Ekv7wrzTvDACTaBhuOAjcSPMj5KZj73eqsi2s9cDVPcHYApsPRmP8aadU0LbwPyHsviBOWN+IbvE68jE1pSBoPmfydPYqRHIQJxfYxPuoieeEhMchlqtoSrcbSonjQLAUDudZhe2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152143; c=relaxed/simple;
	bh=2YG3k7N1X38H5sXvrgps9p+vMXJSHS9aHjR1BucBmKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo2RxmNDKscKBsOZQ9Z/ORHg6L4navQYT6E0u//2BzG5pJRjo/aQgoz6ylmzHiWgRZIVAo6IF86k1M5sdezIR2lwVyVfPFaHexDrxs+yUYnzBGdc3br/F3+zp3zn5ZeigVBQ39xx12EEGCjf8RdQec6V1zqFEppKA0B4OrL+G/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHAgS+yW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHAgS+yW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792152142; x=1823688142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YG3k7N1X38H5sXvrgps9p+vMXJSHS9aHjR1BucBmKk=;
  b=mHAgS+yWT5tE2MO5q8fD9OSLqvv7m/rvyd23KFhmDgKBhaRELNJrYqkX
   93VSVEng9HmEq2+4lo0X+X0EfCI4kbLzns0/sk3vxCAnxCc17wjmqQgsA
   0hgvAofuU6BOkw2ilcQuh1nzpPSeayJ+dxePRoLh0TDx8HXTQKEgppatl
   Yb5B+3zxmIGiHaBITn3OP2tIVoZZ66Y19v8QdvTmEhS0GW/G+Km0nUvle
   ti8n+qde3RBzKgXTfhsppHIvQ9kqKppjaEVUQkAqfojPzNmv34GqJo4mY
   W5266v2vyyahuhPKa0zs5u3Xgd+Ve/UAfxVCWdUIswXTmsUAHSqZMqvla
   g==;
X-CSE-ConnectionGUID: ITiQa9HhSuCnXC5bi4Vs5w==
X-CSE-MsgGUID: Pc+bYGelTAaPyG2bGeVZoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="929469"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="929469"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 05:02:21 -0700
X-CSE-ConnectionGUID: pThTZQvkRnyij68vVsx+Ew==
X-CSE-MsgGUID: Hx0W6NieRSqo/qKFwsRFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3766634"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 05:02:17 -0700
Date: Fri, 16 Oct 2026 19:57:57 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	jgg@nvidia.com, aneesh.kumar@kernel.org, aik@amd.com,
	iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
	bhelgaas@google.com, smadhavan@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
Message-ID: <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
 <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>

> > +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> > +{
> > +	int i;
> > +
> > +	device_lock_assert(&pdev->dev);
> > +	if (pdev->dev.driver)
> > +		return -EBUSY;
> > +
> > +	for (i = 0; i < mmio->nr; i++) {
> > +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> > +		int j;
> > +
> > +		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
> > +			break;
> > +
> > +		/* Only require the caller to set the range, init remainder */
> > +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
> > +					     pci_name(pdev), IORESOURCE_MEM,
> > +					     IORES_DESC_ENCRYPTED);
> > +
> > +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> > +			if (resource_contains(pci_resource_n(pdev, j), res))
> > +				break;
> > +
> > +		/* Request is outside of device MMIO */
> > +		if (j >= PCI_NUM_RESOURCES)
> > +			break;
> > +
> > +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
> > +			break;
> > +	}
> > +
> > +	if (i >= mmio->nr)
> > +		return 0;
> 
> Shouldn't this check be if (i == mmio->nr -1 ) i.e all descriptors have been
> initialized, given the for loop condition i can ever be at most mmio->nr - 1
> i.e the actual index of a descriptor?

The original if (i >= mmio->nr) check is correct. Valid i is at most mmio->nr -1,
but you need an invalid i to finish the loop.

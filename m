Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A984756CD;
	Fri, 16 Oct 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154519; cv=none; b=t9j8iEevvGHhhNOTlpayl03XOQkVHHYWekSjAZVsKCLM5vlVyyrfvSl5fHQr2fWe6pPkzXfp2KGggApmXIEaEhMUYBG5OSg/WSuC1cpkjNQblzMzHuspcfRjEe9+uGb4lEp3bxPUvAXOnCeYZu20kdhETwcUVIgtVhEwQpt4gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154519; c=relaxed/simple;
	bh=MYSIpFvZdutTNiVc4nGJ1MbklCWI8SOgBacqCfUFRFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPiht9cmcIki5XZEUyd2D10ta+TkD6nBVa9OpqzrUF1K366WIUK720a0UHedLuvaAj+yaMOAt/EplQZg+bFqDtrEY8MUG11CRiVebq/TM425sg8lNzjxQm/qMIL9NtZc7BeylrURj/uFUxrr9yeVPDVTvlPuwdLu7nWklyjhr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDW4cx8Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDW4cx8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792154518; x=1823690518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MYSIpFvZdutTNiVc4nGJ1MbklCWI8SOgBacqCfUFRFs=;
  b=aDW4cx8QO2bE+/yOaY3mZfEptBobRnv1X2eBWVwj/sgnb8MMU/8NAAO8
   NZ13o3UUPQ+z8//bDmbAyB0caFjSx6Lrzd/gil0oACNmj6GvpQuMimR5y
   5Wa2p35tj+lSf8SErdbZXjFevjbyK6Qv+wUQ2eZeh3FJYQDrLuz3lU2DV
   oA2wUn9uhgu1juIDnrbZxe1YG+vRJFSLG0iao+8DXe8eP1HPZIC8iJMfN
   ZjwlK4pTZSAyRQAsPbjSNlqefVKA0EsCDVAQznKdt5JegrCZTlNFNU7Z+
   rjjYkTq2YMEYwB2hhPy7kd4FzbSW2eGZDp2VEH6K8v4Ck4TvVB1CiSszo
   w==;
X-CSE-ConnectionGUID: gvC7adpUQzi8cOjGxHnxiA==
X-CSE-MsgGUID: wTWJl6yCSX6Wt7NwrsbbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="822767"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="822767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 05:41:57 -0700
X-CSE-ConnectionGUID: Olk29TqXRjukeJA4GFc0Xg==
X-CSE-MsgGUID: iwDhjZBGRyqpNUptz/rEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1839966"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 16 Oct 2026 05:41:54 -0700
Date: Fri, 16 Oct 2026 20:37:34 +0800
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
Message-ID: <atIajk/T/xb3NMK+@yilunxu-OptiPlex-7050>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
 <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
 <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
 <230ba855-0a7a-4187-aee4-ac551c1cac76@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230ba855-0a7a-4187-aee4-ac551c1cac76@suse.com>

On Fri, Oct 16, 2026 at 03:35:28PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.10.26 г. 14:57 ч., Xu Yilun wrote:
> > > > +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	device_lock_assert(&pdev->dev);
> > > > +	if (pdev->dev.driver)
> > > > +		return -EBUSY;
> > > > +
> > > > +	for (i = 0; i < mmio->nr; i++) {
> > > > +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> > > > +		int j;
> > > > +
> > > > +		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
> > > > +			break;
> > > > +
> > > > +		/* Only require the caller to set the range, init remainder */
> > > > +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
> > > > +					     pci_name(pdev), IORESOURCE_MEM,
> > > > +					     IORES_DESC_ENCRYPTED);
> > > > +
> > > > +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> > > > +			if (resource_contains(pci_resource_n(pdev, j), res))
> > > > +				break;
> > > > +
> > > > +		/* Request is outside of device MMIO */
> > > > +		if (j >= PCI_NUM_RESOURCES)
> > > > +			break;
> > > > +
> > > > +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	if (i >= mmio->nr)
> > > > +		return 0;
> > > 
> > > Shouldn't this check be if (i == mmio->nr -1 ) i.e all descriptors have been
> > > initialized, given the for loop condition i can ever be at most mmio->nr - 1
> > > i.e the actual index of a descriptor?
> > 
> > The original if (i >= mmio->nr) check is correct. Valid i is at most mmio->nr -1,
> > but you need an invalid i to finish the loop.
> 
> 
> Shouldn't the check strictly check for i  == mmio->nr the loop terminating
> condition, which means "we've initialized ALL mmio resources" otherwise
> perform the cleanup, that '>' can never be true.
> 
>  While not wrong per-se having a strict check would be far clearer, no?

I agree, if (i  == mmio->nr) is clearer.

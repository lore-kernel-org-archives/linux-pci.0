Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C07214812;
	Thu, 17 Sep 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603646; cv=none; b=Vzk4YdHhEH4uEeLf1gZamGuoY5zrkR6aZf8m6NMDGsLHzdVFnjAN5K4UmsoXi5CEWCV5ZFKBHAMH7e25/7SATLeLXtvapV8mkfQt54bKpyYBSqfvb8wq65JSSqbi4ttM8nzV3ZBDx0eWou19qEaK+YBwVH/J2wbVJJSTRYcrH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603646; c=relaxed/simple;
	bh=Q6qTyOSAVqzgx4rJNxm+9/hjkyz2JYfoGFgR2fGVxEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OUdeoKegCJAwvUmLisdbdqaJOGhxyn/8H/J3nhHeQBUdsuU0XS8bOlsdWM1nQ8aGvw8+RRbQnZsJ1TsqDp5Y/Zdz399GpFJpMhQqZmH0C/jHR62zc3hux0LBiwBwaVVjtBLx0VpJ0vOf0uV8JlpOi/7SYZbGO8x1g7CGU0gkJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjbTsEtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjbTsEtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5DF1F000FF;
	Thu, 17 Sep 2026 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603644;
	bh=+yFcjzj37ujFduHmXiBvfG9JBS833j3YXgLJ04CFxHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UjbTsEtVaPtsiaZUuZNq+T2sPIquKhVFlF6WCE1Nit+LYL5byUhUnUswsWKHVH8wK
	 7qMsN9mQuJsHdDVnrFzUsqc9srPE2TyNRfy5sfQGHZd2IhIXBj2X/t95jvsRKjbxes
	 lW4C1s7A5Nc0siyJhxlMktOEclBcFv0GC8ZCkpoYvvrYb+6YZUqa5gzAF92LNEhiWG
	 fbkCpan3pHHSqNMPeNzv/+c7N/vuVGzf8tIrVMWvAFsKjZw1wSbvxtDjUqQoHSjPIh
	 af2nNUqh3M0izEpdLd5+JAe9EJ8BchGBTY8vR4TP4CD1d2d1+4+nNv6FNem2o7XMVr
	 6IuBrI0whhNvw==
Date: Wed, 16 Sep 2026 19:07:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260917000723.GA992337@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
> ...

> +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> +					    struct pci_dev *dev)
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> -		return;
> +		return -EINVAL;
> +	}
> +
> +	if (!dev_ser->refcount) {
> +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> +		return -EINVAL;
>  	}
>  
> +	if (--dev_ser->refcount)
> +		return 0;

I guess this is a nit: I was looking for a dev_ser->refcount++ in this
patch to correspond with this decrement.  I *guess* the
"dev_ser->refcount = 1" in pci_liveupdate_preserve_device() starts
that, and the "dev->liveupdate.outgoing->refcount++" there is an
increment of the same refcount?  The connections there don't seem
quite obvious to me.

But I guess "dev_ser->refcount = 1" was added by a different patch, so
probably *not* the same?

>  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>  	outgoing->ser->nr_devices--;
>  	memset(dev_ser, 0, sizeof(*dev_ser));
>  	dev->liveupdate.outgoing = NULL;
> +	return 0;
> +}

> @@ -385,13 +418,23 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  	}
>  
>  	if (dev->liveupdate.outgoing) {
> -		pci_warn(dev, "Device is already preserved\n");
> -		return -EBUSY;
> -	}
> +		if (!dev->liveupdate.outgoing->refcount) {
> +			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> +			return -EINVAL;
> +		}
>  
> -	if (!pci_is_root_bus(dev->bus)) {
> -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> -		return -EINVAL;
> +		/*
> +		 * Endpoint devices should not be preserved more than once.
> +		 * Bridges are preserved once for every downstream device that
> +		 * is preserved.
> +		 */
> +		if (!dev->subordinate) {
> +			pci_warn(dev, "Device is already preserved\n");
> +			return -EBUSY;
> +		}
> +
> +		dev->liveupdate.outgoing->refcount++;
> +		return 0;
>  	}
>  
>  	dev_ser = pci_flb_alloc_dev_ser(outgoing);

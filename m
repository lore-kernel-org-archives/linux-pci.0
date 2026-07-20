Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585241DEF8;
	Mon, 20 Jul 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553708; cv=none; b=GDB6IsdjUM5Qubwhtd9rL4bMxYerW9cZcaODFM4DBR0w1UuX+Kkd2N0L76cnzOIoeCaZAdQHJ/yA+dpFm/iQNVGc7xIC2l3OddXrrltsizgeGb9njHRx5sgsqht85s/uURl2eK8motT5BvZuiGZA/gPf2CcSEGsp4o3IAuhA7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553708; c=relaxed/simple;
	bh=7qEOOjI2PDJPJ/qEWE3gxtYhnRJRwbdUyG270bI4+dE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RNUi2rjKVsvlsUCp+45apBn8fczJxTF2bMVfohppQV+akDQj+635SX1wVtas3CdR3fSfNMmmm39SZTdT798cubgDMO3Jnrl3/xt9Syq19eERHe69h+W+3YLqQzDv85ifX7YBdeltwjQfI/7WBXP4Gc/q/rZkCIUl5OTfWF+FZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N39nCFjf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N39nCFjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784553706; x=1816089706;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7qEOOjI2PDJPJ/qEWE3gxtYhnRJRwbdUyG270bI4+dE=;
  b=N39nCFjfHlTc1GE+WWzCECycURsMROgBCaklxhEVE/eujzQCS3FoY+Kj
   6fwCFZ3lNzz8k5Fc3k+w68fdviWMOVxUb03XCQ4ag/nA7D/Nj3AVjYc8x
   UZmJcODdO1frzi632yasMdgn0VzpIkuNNthBSr0buqJ1MnoiN9OLe6EKN
   Vo899MW3s9DYu4BVGqouy0Rm95oUBNtKALQH60hsNbrlZEdrQHpsMJ7ci
   iMFSO1oq0H2m/DJvh/753j1+Mf9B9VpO1veCYwdRCOt/Owpq/PSFwbTlb
   IBYO53B09AcTgIoRSpzh7pbBPFMsuBj1TQn4YI2NWc9C95Ul03sgHJZNw
   g==;
X-CSE-ConnectionGUID: O4N9KAorT+eQ30WKF9XwVw==
X-CSE-MsgGUID: sBGAsODhR6CGsd4dyTPQfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85082870"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85082870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 06:21:46 -0700
X-CSE-ConnectionGUID: X3GYMe4iTAa2P/2h8WNSqg==
X-CSE-MsgGUID: rBpj0s2hRQiAJCzrRuHTZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="256278476"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 06:21:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jul 2026 16:21:40 +0300 (EEST)
To: Anthony Pighin <anthony.pighin@nokia.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Don't report fully optional resources as assignment
 failures
In-Reply-To: <20260717180029.1829888-1-anthony.pighin@nokia.com>
Message-ID: <0d249665-2d76-7609-f78b-71ec1a94b507@linux.intel.com>
References: <20260717180029.1829888-1-anthony.pighin@nokia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Jul 2026, Anthony Pighin wrote:

> A hotplug bridge may request a window with required size 0 plus
> add_size headroom.  For example, the PCI core speculatively requests
> a non-prefetchable MMIO reserve for a hotplug bridge even when no
> downstream BAR currently requires that space.
> 
> reassign_resources_sorted() temporarily grows an unassigned resource
> from its required size to the required size plus add_size.  If
> pci_assign_resource() fails, the failure is ignored because the
> additional space is optional, but the resource is left unassigned at
> the enlarged size.
> 
> Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync") and commit 2499f5348431 ("PCI: Rework optional
> resource handling"), the __assign_resources_sorted() out path
> unconditionally adds every remaining unassigned resource to fail_head.
> The headroom-enlarged window is therefore reported as though a required
> resource failed.
> 
> pci_assign_unassigned_bridge_resources() interprets the non-empty
> fail_head as grounds for another assignment round and releases bridge
> windows with whole_subtree.  On a system whose < 4GB root-bus MMIO
> aperture was already fully allocated, hotplugging an endpoint that
> required only a 64-bit prefetchable BAR produced:
> 
>   pcieport 0000:00:03.3: bridge window [mem size 0x00000000] add_size 200000
>   pcieport 0000:00:03.3: bridge window [mem size 0x00200000]: failed to assign
>   PCI: No. 2 try to assign unassigned res
>   pcieport 0000:00:01.3: bridge window [mem 0xe6800000-0xe68fffff]: releasing
>   igb 0000:02:00.0 mgmt: PCIe link lost
> 
> The endpoint's required prefetchable BAR had already been assigned; only
> the non-prefetchable hotplug reserve had failed.  Releasing the sibling
> bridge window removed MMIO from the active igb device.
> 
> Save the required size before attempting the optional allocation and
> restore it when that allocation fails.  A fully optional bridge window
> is then left at size 0.  In the __assign_resources_sorted() out path,
> only report unassigned resources that have non-zero size and are not
> otherwise optional.  A zero-sized resource has no required part and
> does not represent a required failure.
>
> This leaves the speculative reserve unassigned without triggering
> another assignment round.  Required resource failures continue to be
> reported and retried as before.
> 
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
> ---
>  drivers/pci/setup-bus.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..c16f0a5f9456 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -450,12 +450,19 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
>  		add_size = add_res->add_size;
>  		align = add_res->min_align;
>  		if (!resource_assigned(res)) {
> -			resource_set_range(res, align,
> -					   resource_size(res) + add_size);
> +			resource_size_t req_size = resource_size(res);
> +
> +			resource_set_range(res, align, req_size + add_size);
>  			if (pci_assign_resource(dev, idx)) {
>  				pci_dbg(dev,
>  					"%s %pR: ignoring failure in optional allocation\n",
>  					res_name, res);
> +				/*
> +				 * Restore the required size so a fully optional
> +				 * resource is left zero-sized and not later
> +				 * mistaken for a required failure.
> +				 */
> +				resource_set_range(res, align, req_size);

This part seems valid, the resource should not be left into enlarged 
state if the assignment fails.

>  			}
>  		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
>  			res->flags |= add_res->flags &
> @@ -743,7 +750,13 @@ static void __assign_resources_sorted(struct list_head *head,
>  		if (resource_assigned(res))
>  			continue;
>  
> -		if (fail_head) {
> +		/*
> +		 * Report only required failures.  Skip optional and
> +		 * zero-sized resources; reporting them would trigger
> +		 * another release/retry round.
> +		 */
> +		if (fail_head && resource_size(res) &&
> +		    !pci_resource_is_optional(dev, pci_resource_num(dev, res))) {

This, however, will break some cases I think.

We first want to try fitting also optional resources, if those optional 
resources never go into fail_head, there won't be new pass and not enough 
upstream bridge windows will be released so the algorithm won't really end 
up even trying to fit the optional resources after this change if FW left 
some bridge window too small.

Only after that has been tried, it should try to fallback into fitting 
only required resources.

So, I think some other solution should be created to solve your issue.
I don't even know what that issue is since you don't show what happens 
with the extra pass after release and why it fails.

-- 
 i.


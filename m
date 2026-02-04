Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE20B665;
	Wed,  4 Feb 2026 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770248012; cv=none; b=NPONQETmW5O3rdKWTuFdO6H+vDfnzGl0ZpjRx+HjTvPns6NxMe6+OG43iGT3kCJTPMVwId2mb87s8PIYMlI3yi0B4zvIe2UF+eF7txgfuhvVHcZpafz1vrjECrXoRkWHm/ntSs5lGs+ZLfPy4RDwr3LeF4kTn701Y+6PSLlbYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770248012; c=relaxed/simple;
	bh=7RVE6LPpaYNX/NcZNtijcrH+6VNmpkiJ02OZxGxkzwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k2le24ERxw/VSEHCo5fK2vRED3OlDbMfihsL3OCZ+7GI+eptcnnW39cexozqC+2xVkdAeB3lNEKJKJf68Mfzp6qiDUyVdLNhWAg/NFVjtEo1L1HwU79rLFZZumZiEUZDeW1mdQCwosVNHjRHxxPZCbMM7CxMW48hSG+mTROuYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1FQq5qS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1FQq5qS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA5C4CEF7;
	Wed,  4 Feb 2026 23:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770248012;
	bh=7RVE6LPpaYNX/NcZNtijcrH+6VNmpkiJ02OZxGxkzwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C1FQq5qSrF6DE3dIAeFDUAKMb11ujUCueCcbQvmkuwxQw5k0cmxSl2wQzi2JkF7F1
	 SitYUdv8waMEC/4Qz6FLH023MTlWrqNgE8KdptLcwtMVBrEliQnrfuvhSao92frx7n
	 ZKH++pn+BCSElZmwqUpHUB+e7i9ipLGO2nRCtFl+UiaCCUz0Dm48lvbv8IIe9oQqDR
	 +bPsuNybl4ARdwi9/tUubv08mcYRk4bcDkHTOAVnFltGJwr6ET0DsRTjgxMDwW+kLf
	 75aAkEAN5bB3rjXRmThneCdyrgBQvw8MOnngedTfPvffmFaylImunXGTUGFOQXX8P6
	 PUGY8grvI7lMg==
Date: Wed, 4 Feb 2026 17:33:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3 1/4] PCI: Enable ACS only after configuring IOMMU for
 OF platforms
Message-ID: <20260204233330.GA22347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>

On Fri, Jan 02, 2026 at 09:04:47PM +0530, Manivannan Sadhasivam wrote:
> For enabling ACS without the cmdline params, the platform drivers are
> expected to call pci_request_acs() API which sets a static flag,
> 'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
> in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
> this call stack:
> 
> -> pci_device_add()
> 	-> pci_init_capabilities()
> 		-> pci_acs_init()
> 			/* check for pci_acs_enable */
> 			-> pci_enable_acs()
> 
> For the OF platforms, pci_request_acs() is called during
> of_iommu_configure() during device_add(), as per this call stack:
> 
> -> device_add()
> 	-> iommu_bus_notifier()
> 		-> iommu_probe_device()
> 			-> pci_dma_configure()
> 				-> of_dma_configure()
> 					-> of_iommu_configure()
> 						/* set pci_acs_enable */
> 						-> pci_request_acs()
> 
> As seen from both call stacks, pci_enable_acs() is called way before the
> invocation of pci_request_acs() for the OF platforms. This means,
> pci_enable_acs() will not enable ACS for the first device that gets
> enumerated, which is usally the Root Port device. But since the static
> flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
> ACS capable devices enumerated later.
> 
> To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
> only from pci_dma_configure() after calling of_dma_configure(). This makes
> sure that pci_enable_acs() only gets called after the IOMMU framework has
> called pci_request_acs(). The ACS enablement flow now looks like:
> 
> -> pci_device_add()
> 	-> pci_init_capabilities()
> 		/* Just store the ACS cap */
> 		-> pci_acs_init()
> 	-> device_add()
> 		...
> 		-> pci_dma_configure()
> 			-> of_dma_configure()
> 				-> pci_request_acs()
> 			-> pci_enable_acs()
> 
> For the ACPI platforms, pci_request_acs() is called during ACPI
> initialization time itself, independent of the IOMMU framework.

I don't think cmdline params are relevant, since I don't see any that
set pci_acs_enable or call pci_request_acs().

I propose a longer but combined call chain in the commit log to show
the old sequence vs the new one.  I do notice the double call of
pci_enable_acs() (along with dev->bus->dma_configure()), which all
looks odd, but maybe it will be rationalized someday:

    PCI: Enable ACS after configuring IOMMU for OF platforms
    
    Platform, ACPI, or IOMMU drivers call pci_request_acs(), which sets
    'pci_acs_enable' to request that ACS be enabled for any devices enumerated
    in the future.
    
    OF platforms called pci_enable_acs() for the first device before
    of_iommu_configure() called pci_request_acs(), so ACS was never enabled for
    that device (typically a Root Port).
    
    Call pci_enable_acs() later, from pci_dma_configure(), after
    of_dma_configure() has had a chance to call pci_request_acs().
    
    Here's the call path, showing the move of pci_enable_acs() from
    pci_acs_init() to pci_dma_configure(), where it always happens after
    pci_request_acs():
    
        pci_device_add
          pci_init_capabilities
            pci_acs_init
     -        pci_enable_acs
     -          if (pci_acs_enable)                <-- previous test
     -            ...
          device_add
            bus_notify(BUS_NOTIFY_ADD_DEVICE)
              iommu_bus_notifier
                iommu_probe_device
                  iommu_init_device
                    dev->bus->dma_configure
                      pci_dma_configure            # pci_bus_type.dma_configure
                        of_dma_configure
                          of_iommu_configure
                            pci_request_acs
                              pci_acs_enable = 1   <-- set
     +                  pci_enable_acs
     +                    if (pci_acs_enable)      <-- new test
     +                      ...
            bus_probe_device
              device_initial_probe
                ...
                  really_probe
                    dev->bus->dma_configure
                      pci_dma_configure            # pci_bus_type.dma_configure
                        ...
                          pci_enable_acs
    
    Note that we will now call pci_enable_acs() twice for every device, first
    from the iommu_probe_device() path and again from the really_probe() path.
    Presumably that's not an issue since we also call dev->bus->dma_configure()
    twice.
    
    For the ACPI platforms, pci_request_acs() is called during ACPI
    initialization time itself, independent of the IOMMU framework.

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pci-driver.c | 8 ++++++++
>  drivers/pci/pci.c        | 8 --------
>  drivers/pci/pci.h        | 1 +
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d596258..301a9418e38e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1650,6 +1650,14 @@ static int pci_dma_configure(struct device *dev)
>  		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
>  	}
>  
> +	/*
> +	 * Attempt to enable ACS regardless of capability because some Root
> +	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
> +	 * the standard ACS capability but still support ACS via those
> +	 * quirks.
> +	 */
> +	pci_enable_acs(to_pci_dev(dev));
> +
>  	pci_put_host_bridge_device(bridge);
>  
>  	/* @drv may not be valid when we're called from the IOMMU layer */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..2c3d0a2d6973 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3648,14 +3648,6 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  void pci_acs_init(struct pci_dev *dev)
>  {
>  	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -
> -	/*
> -	 * Attempt to enable ACS regardless of capability because some Root
> -	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
> -	 * the standard ACS capability but still support ACS via those
> -	 * quirks.
> -	 */
> -	pci_enable_acs(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e67014aa001..4592ede0ebcc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -939,6 +939,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  }
>  
>  void pci_acs_init(struct pci_dev *dev);
> +void pci_enable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
> 
> -- 
> 2.48.1
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BC31812E;
	Fri,  6 Feb 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369497; cv=none; b=rxIMTsloB2ZwooEqlOe6TYCG6crD6jGjVmMOAOitk4fIN6oT5LHJBZ+mTXcezN0eQOwqtq0o+q20o1wvRNH0vwkcw+ftJvulnPhES+LWDaZFntAGf7OS/Zx4/0bMtvov+D3JJtbErbEQyya7HH3Z3I5VT3veco2pvzinNEZ4O9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369497; c=relaxed/simple;
	bh=+YVOcz7293Y1pFm0YpuwuxUMFNEskj/gFmRuMKN0XBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHK0zAoVHsLCZrq7iywbZDuPRIcwUo2g21Ag+F1RTnHgPuzPFPvLWUeG9Og5zJztiMTqYeGpMbxl8gt1op2j9NEMcwHJJBke1hc6LErVNZCZOPqRZ24gDajdkz0yzvYvF3CuW2Mh/Lgro3D/4/HjpVj2cy/uwGidXmMcb1Dh5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFdy/1s2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFdy/1s2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7693CC116C6;
	Fri,  6 Feb 2026 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770369496;
	bh=+YVOcz7293Y1pFm0YpuwuxUMFNEskj/gFmRuMKN0XBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFdy/1s2G6pcrl9Syjo5XvWesv+Ca7LMWtjDAYT2qsuXyHDUUUsVALCOCQvzCh+mU
	 nAtvUvEsluBDgAeHfA7kRYZ+Mb41F+blVgeKlze5tyuSAzjfsYEv9nmGwAqDrbreVV
	 A5PwBjVxePTxEUeVCitB0rVznjMB20SW06JhlYNQ+W9gzuqTy6v3P9WpAep5cWA79Q
	 W3zpZcwUtC6/y6F/v5DnjZ6KFmcWvr6ex0OsHwbHm0zF6JM6lvk5cW/NneXCtKVrL9
	 XwoORZkNBclBtMh4e3HCDICcwjRWPuc8dCv1zQZDWsLwMYCWwiu2LqpoETrqJ44D49
	 o/2o4DZmm++3A==
Date: Fri, 6 Feb 2026 14:48:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 1/4] PCI: Enable ACS only after configuring IOMMU for
 OF platforms
Message-ID: <p6wq2kakzc53fdf47nmezlp2dccimblhc2ssb5hayll3epe7oe@jlgmjqyffkp4>
References: <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
 <20260204233330.GA22347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204233330.GA22347@bhelgaas>

On Wed, Feb 04, 2026 at 05:33:30PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 02, 2026 at 09:04:47PM +0530, Manivannan Sadhasivam wrote:
> > For enabling ACS without the cmdline params, the platform drivers are
> > expected to call pci_request_acs() API which sets a static flag,
> > 'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
> > in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
> > this call stack:
> > 
> > -> pci_device_add()
> > 	-> pci_init_capabilities()
> > 		-> pci_acs_init()
> > 			/* check for pci_acs_enable */
> > 			-> pci_enable_acs()
> > 
> > For the OF platforms, pci_request_acs() is called during
> > of_iommu_configure() during device_add(), as per this call stack:
> > 
> > -> device_add()
> > 	-> iommu_bus_notifier()
> > 		-> iommu_probe_device()
> > 			-> pci_dma_configure()
> > 				-> of_dma_configure()
> > 					-> of_iommu_configure()
> > 						/* set pci_acs_enable */
> > 						-> pci_request_acs()
> > 
> > As seen from both call stacks, pci_enable_acs() is called way before the
> > invocation of pci_request_acs() for the OF platforms. This means,
> > pci_enable_acs() will not enable ACS for the first device that gets
> > enumerated, which is usally the Root Port device. But since the static
> > flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
> > ACS capable devices enumerated later.
> > 
> > To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
> > only from pci_dma_configure() after calling of_dma_configure(). This makes
> > sure that pci_enable_acs() only gets called after the IOMMU framework has
> > called pci_request_acs(). The ACS enablement flow now looks like:
> > 
> > -> pci_device_add()
> > 	-> pci_init_capabilities()
> > 		/* Just store the ACS cap */
> > 		-> pci_acs_init()
> > 	-> device_add()
> > 		...
> > 		-> pci_dma_configure()
> > 			-> of_dma_configure()
> > 				-> pci_request_acs()
> > 			-> pci_enable_acs()
> > 
> > For the ACPI platforms, pci_request_acs() is called during ACPI
> > initialization time itself, independent of the IOMMU framework.
> 
> I don't think cmdline params are relevant, since I don't see any that
> set pci_acs_enable or call pci_request_acs().
> 
> I propose a longer but combined call chain in the commit log to show
> the old sequence vs the new one.  I do notice the double call of
> pci_enable_acs() (along with dev->bus->dma_configure()), which all
> looks odd, but maybe it will be rationalized someday:
> 

Yeah, there is no issue with calling pci_enable_acs() twice as of now, but I
don't have a better solution either.

>     PCI: Enable ACS after configuring IOMMU for OF platforms
>     
>     Platform, ACPI, or IOMMU drivers call pci_request_acs(), which sets
>     'pci_acs_enable' to request that ACS be enabled for any devices enumerated
>     in the future.
>     
>     OF platforms called pci_enable_acs() for the first device before
>     of_iommu_configure() called pci_request_acs(), so ACS was never enabled for
>     that device (typically a Root Port).
>     
>     Call pci_enable_acs() later, from pci_dma_configure(), after
>     of_dma_configure() has had a chance to call pci_request_acs().
>     
>     Here's the call path, showing the move of pci_enable_acs() from
>     pci_acs_init() to pci_dma_configure(), where it always happens after
>     pci_request_acs():
>     
>         pci_device_add
>           pci_init_capabilities
>             pci_acs_init
>      -        pci_enable_acs
>      -          if (pci_acs_enable)                <-- previous test
>      -            ...
>           device_add
>             bus_notify(BUS_NOTIFY_ADD_DEVICE)
>               iommu_bus_notifier
>                 iommu_probe_device
>                   iommu_init_device
>                     dev->bus->dma_configure
>                       pci_dma_configure            # pci_bus_type.dma_configure
>                         of_dma_configure
>                           of_iommu_configure
>                             pci_request_acs
>                               pci_acs_enable = 1   <-- set
>      +                  pci_enable_acs
>      +                    if (pci_acs_enable)      <-- new test
>      +                      ...
>             bus_probe_device
>               device_initial_probe
>                 ...
>                   really_probe
>                     dev->bus->dma_configure
>                       pci_dma_configure            # pci_bus_type.dma_configure
>                         ...
>                           pci_enable_acs
>     
>     Note that we will now call pci_enable_acs() twice for every device, first
>     from the iommu_probe_device() path and again from the really_probe() path.
>     Presumably that's not an issue since we also call dev->bus->dma_configure()
>     twice.
>     
>     For the ACPI platforms, pci_request_acs() is called during ACPI
>     initialization time itself, independent of the IOMMU framework.
> 

Thanks! Let me know if I need to respin or you want to ammend it while applying.
(It is not clear to me what is your plan here).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

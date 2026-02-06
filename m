Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AE26FD9B;
	Fri,  6 Feb 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392265; cv=none; b=oFVSgqsxWh1XDXTdUWkWPao1Ny/Dxnz5PlFUZvwD8gUmCP3Bj5VE1etNMflpm6T2c71VGmm052My1NRkWa2P5zRVwCkw2cXBHskAbhqUpdTOfYpeepwMZiETmq6eOmJNcCos6rMMD7Q/u/zDJjcBU8GxpnCfLOZyqSWUb+IyCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392265; c=relaxed/simple;
	bh=yBsPyWnhPX3UFsJOYcb6kzofkaYKj2uiUSHhWgGIrSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzxsRXDqzM3BsemvHLNIQqSjU0m6BvL9kmZ3h6jSHCY1/vH3R8RtGtx7EqIQ431bSbRt2UR/UOm7Ap/fy6vMY8IDUoHnCQWF4Wt1cF6L+kje0RLcV5GtAk77sOrX7vYpqAZFm2VYwJ+j9d+NEVldD9CkTLR029rvGGN0i8cUhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCAB6339;
	Fri,  6 Feb 2026 07:37:37 -0800 (PST)
Received: from [10.57.54.83] (unknown [10.57.54.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F219F3F778;
	Fri,  6 Feb 2026 07:37:40 -0800 (PST)
Message-ID: <3e1da927-d0ed-4f2f-8856-8b9605097cfa@arm.com>
Date: Fri, 6 Feb 2026 15:37:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] PCI: Enable ACS only after configuring IOMMU for
 OF platforms
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
 Xingang Wang <wangxingang5@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
 <20260204233330.GA22347@bhelgaas>
 <p6wq2kakzc53fdf47nmezlp2dccimblhc2ssb5hayll3epe7oe@jlgmjqyffkp4>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <p6wq2kakzc53fdf47nmezlp2dccimblhc2ssb5hayll3epe7oe@jlgmjqyffkp4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-06 9:18 am, Manivannan Sadhasivam wrote:
> On Wed, Feb 04, 2026 at 05:33:30PM -0600, Bjorn Helgaas wrote:
>> On Fri, Jan 02, 2026 at 09:04:47PM +0530, Manivannan Sadhasivam wrote:
>>> For enabling ACS without the cmdline params, the platform drivers are
>>> expected to call pci_request_acs() API which sets a static flag,
>>> 'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
>>> in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
>>> this call stack:
>>>
>>> -> pci_device_add()
>>> 	-> pci_init_capabilities()
>>> 		-> pci_acs_init()
>>> 			/* check for pci_acs_enable */
>>> 			-> pci_enable_acs()
>>>
>>> For the OF platforms, pci_request_acs() is called during
>>> of_iommu_configure() during device_add(), as per this call stack:
>>>
>>> -> device_add()
>>> 	-> iommu_bus_notifier()
>>> 		-> iommu_probe_device()
>>> 			-> pci_dma_configure()
>>> 				-> of_dma_configure()
>>> 					-> of_iommu_configure()
>>> 						/* set pci_acs_enable */
>>> 						-> pci_request_acs()
>>>
>>> As seen from both call stacks, pci_enable_acs() is called way before the
>>> invocation of pci_request_acs() for the OF platforms. This means,
>>> pci_enable_acs() will not enable ACS for the first device that gets
>>> enumerated, which is usally the Root Port device. But since the static
>>> flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
>>> ACS capable devices enumerated later.
>>>
>>> To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
>>> only from pci_dma_configure() after calling of_dma_configure(). This makes
>>> sure that pci_enable_acs() only gets called after the IOMMU framework has
>>> called pci_request_acs(). The ACS enablement flow now looks like:
>>>
>>> -> pci_device_add()
>>> 	-> pci_init_capabilities()
>>> 		/* Just store the ACS cap */
>>> 		-> pci_acs_init()
>>> 	-> device_add()
>>> 		...
>>> 		-> pci_dma_configure()
>>> 			-> of_dma_configure()
>>> 				-> pci_request_acs()
>>> 			-> pci_enable_acs()
>>>
>>> For the ACPI platforms, pci_request_acs() is called during ACPI
>>> initialization time itself, independent of the IOMMU framework.
>>
>> I don't think cmdline params are relevant, since I don't see any that
>> set pci_acs_enable or call pci_request_acs().
>>
>> I propose a longer but combined call chain in the commit log to show
>> the old sequence vs the new one.  I do notice the double call of
>> pci_enable_acs() (along with dev->bus->dma_configure()), which all
>> looks odd, but maybe it will be rationalized someday:
>>
> 
> Yeah, there is no issue with calling pci_enable_acs() twice as of now, but I
> don't have a better solution either.

Indeed the second one is due to go away - the current state of running 
all of bus->dma_configure twice is the precursor to splitting it up so 
the iommu_configure() bits run at device_add() time (or the equivalent 
if the IOMMU registers later), while the rest of the dma_configure() 
bits (including deferral if we're still waiting for an IOMMU driver) 
stay at driver bind. The snag is that there are some dodgy platform 
drivers abusing the previous behaviour that I'm not sure what to do with.

However I suppose with some careful refactoring it shouldn't strictly be 
necessary to change everything all at once, so if and when I get the 
chance to pick that project up again I could potentially finish the new 
design for PCI and other buses while kicking platform down the road...

Thanks,
Robin.

>>      PCI: Enable ACS after configuring IOMMU for OF platforms
>>      
>>      Platform, ACPI, or IOMMU drivers call pci_request_acs(), which sets
>>      'pci_acs_enable' to request that ACS be enabled for any devices enumerated
>>      in the future.
>>      
>>      OF platforms called pci_enable_acs() for the first device before
>>      of_iommu_configure() called pci_request_acs(), so ACS was never enabled for
>>      that device (typically a Root Port).
>>      
>>      Call pci_enable_acs() later, from pci_dma_configure(), after
>>      of_dma_configure() has had a chance to call pci_request_acs().
>>      
>>      Here's the call path, showing the move of pci_enable_acs() from
>>      pci_acs_init() to pci_dma_configure(), where it always happens after
>>      pci_request_acs():
>>      
>>          pci_device_add
>>            pci_init_capabilities
>>              pci_acs_init
>>       -        pci_enable_acs
>>       -          if (pci_acs_enable)                <-- previous test
>>       -            ...
>>            device_add
>>              bus_notify(BUS_NOTIFY_ADD_DEVICE)
>>                iommu_bus_notifier
>>                  iommu_probe_device
>>                    iommu_init_device
>>                      dev->bus->dma_configure
>>                        pci_dma_configure            # pci_bus_type.dma_configure
>>                          of_dma_configure
>>                            of_iommu_configure
>>                              pci_request_acs
>>                                pci_acs_enable = 1   <-- set
>>       +                  pci_enable_acs
>>       +                    if (pci_acs_enable)      <-- new test
>>       +                      ...
>>              bus_probe_device
>>                device_initial_probe
>>                  ...
>>                    really_probe
>>                      dev->bus->dma_configure
>>                        pci_dma_configure            # pci_bus_type.dma_configure
>>                          ...
>>                            pci_enable_acs
>>      
>>      Note that we will now call pci_enable_acs() twice for every device, first
>>      from the iommu_probe_device() path and again from the really_probe() path.
>>      Presumably that's not an issue since we also call dev->bus->dma_configure()
>>      twice.
>>      
>>      For the ACPI platforms, pci_request_acs() is called during ACPI
>>      initialization time itself, independent of the IOMMU framework.
>>
> 
> Thanks! Let me know if I need to respin or you want to ammend it while applying.
> (It is not clear to me what is your plan here).
> 
> - Mani
> 


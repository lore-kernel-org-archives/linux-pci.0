Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85C34D911;
	Fri, 20 Feb 2026 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598759; cv=none; b=seF0FmQ9g19dY+szxuwdOlRlckR9MM9239/ouTO66AikX1BrYR4iDUrAOIeLE0nW7vqRfZwRlY3WoTSiVYgQYdhDCpkC1bmwcFbxlt5B975ehdM4QJX/Ig1Z+1gijL/uyUX9pw+KXh03Y/g5SQrjXaadLIlqXBNmaKextiFHoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598759; c=relaxed/simple;
	bh=yRZxUtegdpNdrUNI41pSLi9+EsvVjIWvmtl+5DmnZ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT5auQkAEIXdsPKEMYu2dvyOl8fR16vq3tXGZB94R0naU+1X0DmnL4lOZjZAH6xGYwk4X17V3i/r1zKLimkNTlEBzqbqF55dKqp8KygdahoFApXQBdIXb0unUQgQV+CJoDFAybGVgW7tivbBt+3mQWCl/l37csXStIon6CZ1jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E4A339;
	Fri, 20 Feb 2026 06:45:49 -0800 (PST)
Received: from [10.57.58.244] (unknown [10.57.58.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AE33F62B;
	Fri, 20 Feb 2026 06:45:52 -0800 (PST)
Message-ID: <c7cd42ff-f95a-4aaf-ab79-5af476bca894@arm.com>
Date: Fri, 20 Feb 2026 14:45:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, dan.j.williams@intel.com,
 "Tian, Kevin" <kevin.tian@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia> <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com> <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com> <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com> <20260220125044.GK723117@nvidia.com>
 <6a842339-3f0a-48db-830a-326add917519@arm.com>
 <20260220135124.GA1894399@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260220135124.GA1894399@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-20 1:51 pm, Jason Gunthorpe wrote:
> On Fri, Feb 20, 2026 at 01:22:49PM +0000, Robin Murphy wrote:
> 
>> But is that an issue? Until the device has a driver, surely it shouldn't be
>> expected to send interrupts at all, much less depend on them being received
>> and understood by Linux? The MSI cookie is only populated once a driver
>> actually requests some MSI vectors (since it doesn't know what ITS
>> address(es) may or may not need mapping), so an empty DMA domain is still no
>> better than a true blocking domain in this regard anyway.
> 
> Oh, the issue is the driver_managed_dma flag.
> 
> In this mode we do bind a driver but the iommu callbacks at driver
> bind are not called anymore because that flag says the driver itself
> will call them later.
> 
> Things like PCI port driver that never issue DMA at all will set the
> flag and never make any calls, while still expecting interrupts to
> work.
> 
> This is why the other option is to rework this somewhat so these
> drivers still make call in to the iommu and can get an interrupt
> setup.

Or perhaps we handle BUS_NOTIFY_BIND_DRIVER to manage the switch from 
BLOCKED to (empty) DMA independently from whether the driver 
subsequently claims the DMA domain or not? That said, I wouldn't have 
any particular objection to generalising iommu_use_default_domain() into 
something like iommu_prepare_default_domain(bool managed) either.

> All of this is only for multi-device groups where we want to ignore
> some bad grouping with VFIO on old HW without sufficient ACS. Thinking
> about it some more I suspect this entire concept has been broken from
> day 1 in VFIO on ARM. If the iommu_group has two members, port driver
> and a VFIO device then:
> 
>   The port driver will start first, install the ITS page in the DMA
>   domain, VFIO will start second an switch the domain to BLOCKED, then
>   to PAGING, and the ITS mapping used by the port driver will be lost.
> 
> And nobody will notice this has happened because the interrupts in the
> port driver are only used for RAS IIRC so the net effect is your
> system doesn't print AERs anymore.

Indeed VFIO's MSI cookie doesn't inherit any existing mappings from the 
DMA domain, and that wouldn't work anyway since the IOVAs would almost 
certainly be different. So we'd have to somehow free any existing AER 
interrupts before the domain switch, then fully re-request and reprogram 
them afterwards, in both DMA->UNMANAGED and UNMANAGED->DMA directions. 
Oof...

Thanks,
Robin.

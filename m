Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68832E724;
	Fri, 20 Feb 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593777; cv=none; b=kgokVHV6OGuhBmqD9cEHl5KSzUPk51VTtM/AyCOoaJiILHcip54ZhfTJjFRRNyrLK764idrO9iDs+XbfWidt+I4oSzLPY5WKb98rsHvlDd84VYZDPdbOT8AIKNM0ICZyZ8aJy6go0zLiy+wTBKGdCwFMv3sLHg+vaoJxFvlK5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593777; c=relaxed/simple;
	bh=x+Urs4+La2N/SIM42LqA4H1exjjU/7eBuLLJCX9+FLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOUKW9+0qxaTG7/RCV/+C7YRx6ZQJAUba0dP3LAs6F4z6mAyJNGX3+ropbZesP1UjgA+rY+meSFfdQWt+kh9DDWXYgsVJnj1euzR4N9fmzStQupgBQgM+yEx5zMytYVKOE7r0B9SEmKGTAQBNC5tKZRJaY6kV4h/yozVE1ZOAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D345A339;
	Fri, 20 Feb 2026 05:22:49 -0800 (PST)
Received: from [10.57.58.244] (unknown [10.57.58.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B9E3F7D8;
	Fri, 20 Feb 2026 05:22:52 -0800 (PST)
Message-ID: <6a842339-3f0a-48db-830a-326add917519@arm.com>
Date: Fri, 20 Feb 2026 13:22:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
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
References: <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia> <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia> <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com> <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com> <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com> <20260220125044.GK723117@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260220125044.GK723117@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-20 12:50 pm, Jason Gunthorpe wrote:
> On Thu, Feb 19, 2026 at 08:52:56PM -0800, Nicolin Chen wrote:
>>> What is missing is to bring back the IDENTITY performance optimization
>>> in a secure way.
>>
>> I might have got it wrong (from the last part below).
>> https://lore.kernel.org/linux-iommu/20260127150440.GF1134360@nvidia.com/.
>>
>> You mean to disable ATS on IDENTITY domains?
> 
> The objective of this security step is to keep ATS blocked and
> IDENTITY domains disabled until the userspace has "accepted" the
> device by binding a driver to it.
> 
> The off the cuff suggestion was to just park the device BLOCKED until
> a driver is bound. This disables ATS and blocks translation.
> 
> That doesn't work on ARM because of the MSI issue.

But is that an issue? Until the device has a driver, surely it shouldn't 
be expected to send interrupts at all, much less depend on them being 
received and understood by Linux? The MSI cookie is only populated once 
a driver actually requests some MSI vectors (since it doesn't know what 
ITS address(es) may or may not need mapping), so an empty DMA domain is 
still no better than a true blocking domain in this regard anyway.

Thanks,
Robin.

> The next suggestion is to park the device in a real DMA domain with an
> actual page table and DMA API hooked up. Now interrupts will work and
> the domain is empty so there is no translation. The issue here is the
> domain doesn't block ATS. We could fix this with some "disable ATS"
> domain flag.
> 
> In either case when the driver is bound and requests that the DMA API
> start working if the user requested IDENTITY then it has to be
> switched away from the parked domain to IDENTITY.
> 
> A final thought would be to change around the driver managed DMA
> mechanism a bit to allow drivers to indicate they use IRQs but not
> DMA, then the bind step could switch from a BLOCKED domain to an empty
> DMA API domain to allow MSI to work.
> 
> Jason


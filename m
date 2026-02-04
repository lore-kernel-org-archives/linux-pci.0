Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157F326941;
	Wed,  4 Feb 2026 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207508; cv=none; b=csy3gzCHffNxhFA35nLZsSTQ30z4mH6sg6hyYy7L54gtbR47FLB2tlrcHto0HwwSfZBlXTAzB9FE8kBekTEFEUuFom0SW4/z7he5WOA9C01LHAfWUINUIIIbp3DdPKl3+rTbIWF7gqVv06dgjBlgLLhHwjMJ0ojJ6mQ8ROPSSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207508; c=relaxed/simple;
	bh=2EmQWlKPfSbZSqw4sPW4djB/xIL+OO9IYjzcA6B0KdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WM9vqWStlZ7BIF8G9oWuC/EZwGmiA6N/dfhY8KYqQzTl5qQvdyZUO9LQIsphjF3/zLJPlbNblxyaOCsHit5w/f/6KyI1ox0TPLrMwff+0ItcNh28n+o/p0VK8143JJQnt8Go5u1G30iVnMkXq5O/azG5fzNU80F7v0DTun5IcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4FC1497;
	Wed,  4 Feb 2026 04:18:20 -0800 (PST)
Received: from [10.57.54.211] (unknown [10.57.54.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C4093F632;
	Wed,  4 Feb 2026 04:18:24 -0800 (PST)
Message-ID: <69b9a009-55bb-4330-b64a-99b20bd9abef@arm.com>
Date: Wed, 4 Feb 2026 12:18:15 +0000
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
References: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com> <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com> <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
 <20260203231607.GE3931454@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260203231607.GE3931454@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-03 11:16 pm, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 06:59:35PM +0000, Robin Murphy wrote:
>> Realistically this combination cannot exist bare-metal, since if the device
>> requires to send ATS TT's to access an RMR then the SMMU would have to be
>> enabled pre-boot, so then the RMR means we cannot ever disable it to
>> reconfigure, so we'd be stuffed from the start...
> 
> This thread has gotten mixed up..
> 
> First this series as it is has nothing to do with RMRs.

I know, but you brought up require_direct so I figured it was worth 
clarifying that should not in fact impact ATS decisions, since the 
combination a device requiring ATS while *also* requiring an RMR would 
be essentially impossible to support given the SMMU architecture, thus 
we can reasonably assume nobody will do such a thing (or at least do it 
with any expectation of it ever working).

> What the latter part is discussing is a future series to implement
> what I think MS calls "boot DMA security". Meaning we don't get into a
> position of allowing a device access to OS memory, even through ATS
> translated requests, until after userspace has approved the device.

Pre-boot protection is in the same boat, as things currently stand - an 
OS could either preserve security (by using GBPA to keep traffic blocked 
while reconfiguring the rest of the SMMU), *or* have ongoing DMA for a 
splash screen or whatever; it cannot realistically have both.

> This is something that should combine with Dynamic Root of Trust for
> Measurement, as DRTM is much less useful if DMA can mutate the OS code
> after the DTRM returns.
> 
> It is also meaningful for systems with encrypted PCI where the OS can
> measure the PCI device before permitting it access to anything.
> 
> So... When we do implement this new security mode, what should it do
> if FW attempts to attack the kernel with these nonsensical RMR
> configurations? With DRTM we explicitly don't trust the FW for
> security anymore, so it is a problem.
> 
> I strongly suspect the answer is that RMR has to be ignored in this
> more secure mode.

Yes, I think the only valid case for having an RMR and expecting it to 
work in combination with these other things is if the device has some 
firmware or preloaded configuration in memory which it will still need 
to access at that address once an OS driver starts using it, but does 
not need to access *during* the boot-time handover. Thus it seems fair 
to still honour the reserved regions upon attaching to a default domain, 
but not worry too much about being in a transient blocking state in the 
interim if it's unavoidable for other reasons (at worst maybe just log a 
warning that we're doing so).

>> However I think there would be no point exposing the ATS details to
>> the VM to begin with. It's the host's decision to trust the device
>> to play in the translated PA space and system cache coherency
>> protocol, and no guest would be allowed to mess with those aspects
>> either way, so there seems no obvious good reason for them to know
>> at all.
> 
> If the vSMMU is presented then the guest must be aware of the ATS
> because only the guest can generate the ATC invalidations for changes
> in the S1.

Only if you assume DVM or some other mechanism for the guest to issue S1 
invalidations directly to the hardware - with an emulated CMDQ we can do 
whatever we like.

And in fact, I think we actually *have* to if the host has enabled ATS 
itself, since we cannot assume that a guest is going to choose to use 
it, thus we cannot rely on the guest issuing ATCIs in order to get the 
correct behaviour it expects unless and until we've seen it set EATS 
appropriately in all the corresponding vSTEs. So we would have to forbid 
DVM, and only allow other direct mechanisms that can be dynamically 
enabled for as long as the guest configuration matches... Fun.

Thanks,
Robin.

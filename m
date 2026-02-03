Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4E1AAE17;
	Tue,  3 Feb 2026 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145183; cv=none; b=kt/HZOZhf/TPw2LMrMr/fF9/NfKrzaXugYfHTWiEimGwztaod7ub8CHJAi+b1FewqmJc4ViTKQrUcFcqYVWklGtK91FeC+i4GKWX4mliDhjwtWImeMMO5pB6L16ZzX/LwWj3ScDOUkgOhBTqVGj/xTWJLgPPAFh5gb+NqjeLPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145183; c=relaxed/simple;
	bh=eynsS563cUJlUeBqeW9PPkN0jim1fbDAw/Vl3UDHxyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHbyeq6osLUKegI+uYAGHUEAAy3o0FIef5ZtQ6m9nsnblWAGq10a0EzWhGynkp6wvwvVZWMo2aGL7verZlW7DzNQIqBMcaOGwyYOH1+S+aXt86ijqLigk6o0Z/8fUES/CeJVUzmzT3h4gmhkZP4onctHt63++dtHAq9G0lmf/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD768339;
	Tue,  3 Feb 2026 10:59:34 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68253F632;
	Tue,  3 Feb 2026 10:59:37 -0800 (PST)
Message-ID: <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
Date: Tue, 3 Feb 2026 18:59:35 +0000
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
References: <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com> <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com> <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260203175540.GC3931454@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-03 5:55 pm, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
>> Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
>> allowed in general if require_direct=true. I assume this case can be
>> an exception since there's no point in allowing a device that has no
>> driver yet to access any reserved region?

No, the point of RMRs in general is that the device can be assumed to 
already be accessing them, and that access must be preserved, regardless 
of whether an OS driver may or may not take over the device later. In 
fact RMRs with the "Remapping Permitted" flag are only strictly needed 
*until* an OS driver has taken control over whatever it was that 
firmware left them doing.

> If require_direct is set then we have to disable this mechanism..
> 
> I'm not sure exactly what to do about this as the require_direct comes
> from the hypervisor in a CC VM and we probably don't want to give the
> hypervisor this kind of escape hatch.
> 
> Perhaps we need to lock off to failure on CC VMs if this ever
> happens..
> 
> But baremetal should just keep working how it always worked in this
> case..

Realistically this combination cannot exist bare-metal, since if the 
device requires to send ATS TT's to access an RMR then the SMMU would 
have to be enabled pre-boot, so then the RMR means we cannot ever 
disable it to reconfigure, so we'd be stuffed from the start...

Even though it's potentially a little more plausible in a VM where the 
underlying S2 would satisfy ATS, for much the same reason it's still 
going to look highly suspect from the VM's point of view to be presented 
with a device whose apparent ability to perform ATS traffic through a 
supposedly-disabled S1 SMMU must not be disrupted. However I think there 
would be no point exposing the ATS details to the VM to begin with. It's 
the host's decision to trust the device to play in the translated PA 
space and system cache coherency protocol, and no guest would be allowed 
to mess with those aspects either way, so there seems no obvious good 
reason for them to know at all.

Thanks,
Robin.

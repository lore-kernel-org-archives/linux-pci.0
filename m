Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E22AEF5;
	Mon, 26 Jan 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453354; cv=none; b=EXBgKhsaJ4j1Xx7jRG8RXQWO5BM2AkIcRsyNUiwpmNNbHla3Bc67v2HfgfAXn2x8eP07pVFh+d41tQ9t+EDobEb32dL1z9VVfdEa8m6VsxAN1MpI+2fwhxY1RhVKFXprmwxHu4I/UT2TmYVtKWN5ppvEHVc8SWxm8EL/gU5z7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453354; c=relaxed/simple;
	bh=BjevpJtv6JdMvGyZ4+3HDmYp0JsItGorquKWgvQc8uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMHNMp7HKE/A9ihlhFTEQ6cPyynaM7jg6yVxwZYYDRfaDDXpWuOtAXG9BmSw6IXk3TyGBJLScAi1T/nvXRAup+cpAZPS7IqIEQ4Ji+aMZ5Z5zzd/p6JrIICuK3J1/8ZOALSoxtl9OhmMw3UkOjG+Mzw7OIhdwt7gLJjUjHY3lSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62AD3339;
	Mon, 26 Jan 2026 10:49:05 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9EA63F73F;
	Mon, 26 Jan 2026 10:49:09 -0800 (PST)
Message-ID: <0a60797a-fbb9-4a83-adc6-ad62baf5915b@arm.com>
Date: Mon, 26 Jan 2026 18:49:07 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
To: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, bhelgaas@google.com, joro@8bytes.org,
 praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck> <20260126172020.GP1134360@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260126172020.GP1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-26 5:20 pm, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 12:39:50PM +0000, Will Deacon wrote:
>>> +	ret = arm_smmu_alloc_cd_tables(master);
>>> +	if (ret)
>>> +		return ret;
>>
>> Were do you allocate the second level entry for ssid 0 if we're using
>> 2-level cd tables?
> 
> I don't think we need to. The entire design here has a non-valid CD entry
> for SSID 0.
> 
> The spec is really weird here, on one hand it explicitly says that with
> S1DSS the CD entry is ignored.
> 
> On the other hand, you are also required to have a CD table pointer of
> at least size one for some reason.

Because it is not possible to enable 0 SubStreams, since that wouldn't 
make any sense, hence S1CDMax also acts as the "enable SubStreams" 
control (assuming SSIDSIZE > 0 and it does anything at all - note that 
strictly we cannot assume this bypass trick is *always* possible, since 
an SMMU is permitted to support ATS without supporting SubStreams).

> So, I think a CD table pointer to a fully invalid L1 table of at least
> size 1 should be OK?
> 
> Or stated another way, why would ie be OK to have a 1 level table with
> an non-valid CD table entry for SSID0 but not OK to have a 2 level
> table that returns non-valid at the first walk?

S1ContextPtr itself is reachable since S1 is enabled, so it cannot point 
to nonsense. But the S1DSS==Bypass behaviour does state:

"Note: Such a transaction does not fetch a CD, and therefore does not 
report F_CD_FETCH, C_BAD_CD or a stage 2 Translation-related fault with 
CLASS == CD."

So if we're not intending to actually allow traffic on the SubStream(s), 
then it should be fine to use either a 1-level table of invalid CDs, or 
a 2-level format with an empty L1CD table to gracefully terminate any 
config prefetches.

Thanks,
Robin.

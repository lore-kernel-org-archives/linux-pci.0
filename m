Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC064355036;
	Tue, 27 Jan 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520368; cv=none; b=OM6cFMXYJTgcxdkmFsBcvCXyYDw+XmgukYnRcsK5HQA2EW2alUwhtxQS42mzya1OM8fjU7jCYJxpS3prBnI3d6JC6Pt1QGpdW6VGrMFv1hbRstsSnr/ZoAXfOeNEPYrfGWS3wizLNytizrgKujzGjO2BYWWDar9zdDwK5e9a/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520368; c=relaxed/simple;
	bh=dHLLCoOksVEiX5+cGAAgXnOR7Mo3CHmYyJCj6LhfSv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgzEJeEp/vOHW1WQTgUdwY6vqY5a784DpBtBKfc+dL2eTbYADJ+LGnhvrGTaRMlAnnJTKyi+SDGvn8w6LuWIAl+NDTT7Gxdwj9PVhXIPlj/IT2fpmM/3RN6zISjHiKqlXD/JzijKa5CwFmuYhJHCaFoqsQ+zUTpZxrTRbFjNgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6B9D1595;
	Tue, 27 Jan 2026 05:25:59 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF3C3F632;
	Tue, 27 Jan 2026 05:26:04 -0800 (PST)
Message-ID: <f08595ff-f36e-45cc-8ea2-dc678f59c7d9@arm.com>
Date: Tue, 27 Jan 2026 13:26:02 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, bhelgaas@google.com, joro@8bytes.org,
 praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck> <20260126172020.GP1134360@nvidia.com>
 <0a60797a-fbb9-4a83-adc6-ad62baf5915b@arm.com>
 <20260126190935.GV1134360@nvidia.com> <aXi5W-7b2odQQtqy@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aXi5W-7b2odQQtqy@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-27 1:10 pm, Will Deacon wrote:
> On Mon, Jan 26, 2026 at 03:09:35PM -0400, Jason Gunthorpe wrote:
>> On Mon, Jan 26, 2026 at 06:49:07PM +0000, Robin Murphy wrote:
>>> (assuming SSIDSIZE > 0 and it does anything at all - note that strictly we
>>> cannot assume this bypass trick is *always* possible, since an SMMU is
>>> permitted to support ATS without supporting SubStreams).
>>
>> Yes, I think Nicolin has captured those conditions in computing
>> it... We don't have a logic to disable bypass in that case though.
>>
>>>> So, I think a CD table pointer to a fully invalid L1 table of at least
>>>> size 1 should be OK?
>>>>
>>>> Or stated another way, why would ie be OK to have a 1 level table with
>>>> an non-valid CD table entry for SSID0 but not OK to have a 2 level
>>>> table that returns non-valid at the first walk?
>>>
>>> S1ContextPtr itself is reachable since S1 is enabled, so it cannot point to
>>> nonsense. But the S1DSS==Bypass behaviour does state:
>>
>>> "Note: Such a transaction does not fetch a CD, and therefore does not report
>>> F_CD_FETCH, C_BAD_CD or a stage 2 Translation-related fault with CLASS ==
>>> CD."
>>
>> Yes
>>
>> However, taken together:
>>   * S1CDMax is set to substream 0 only
>>   * S1DSS is set such that "does not fetch a CD" for SSID = 0
>>   * SSID >0 doesn't fetch CDs because of S1CDMax
>>
>> Then it seems to be saying that it will never use S1ContextPtr? ie it
>> is IGNORED?
> 
> Right, I think the critical question is whether that setting of S1DSS
> (0b01) means that STE.S1ContextPtr is considered "invalid". The spec
> doesn't call this out explicitly but the "translation procedure charts"
> seem to indicate that it doesn't use the CD for anything...
> 
> It would be good to get some clarification from Arm about this
> particular case.

No, STE.S1ContextPtr itself is "valid" since S1 is enabled. No CD fetch 
will occur for no-SubStreamID transactions that are bypassed by S1DSS, 
but the SMMU is permitted to attempt to speculatively fetch CDs for the 
enabled SubStreamID(s). Those fetches do not have to reach a valid CD if 
the SubStream is not actually in use, much like we don't have to fully 
populate a 2-level Stream table for StreamID ranges we don't care about 
either.

Don't confuse S1DSS==1 (bypass) with the S1DSS==2 behaviour we use in 
other cases - the latter is "Use CD 0 for no-SubstreamID traffic" which 
makes SubStreamID 0 invalid to use. However in the bypass case (and also 
S1DSS==0 where no-SubstreamID traffic is blocked entirely), SubStreamID 
0 remains perfectly valid and usable (we just still won't ever use it in 
Linux due to the middle case).

Thanks,
Robin.

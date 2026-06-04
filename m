Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12639385D93;
	Thu,  4 Jun 2026 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540255; cv=none; b=Uu4X2F5fsTbW39l7PpeUa4mqgjfBvZbzfvjuGEonDlxN3S1URKT3rpj+zeymwVvISS7L+aah4RSsWpKEax8IfXZm6jg4ablOlUQR+MMg7/+MPxnPLSAfUbUMEISqz2+Zz9K6E1H/Kzrl9cAj9PWwGyFkt+Iy+ANSJbN9mJWR6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540255; c=relaxed/simple;
	bh=GrPBaqz4vJW6+l3zDtgP/2CO7SuG3mrR9GDbr1wFqMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQ1oqcCI43sYg5GVsTRmrpUZItNuizu3sVoVnGuDT/xQynD1ZEV+OGBWUErpfoLFsHQ6muGxqqDi8neyKfSUdwoJ23Bx3hNiNHcKymf/7hoIlWK/nQuPJqgqnklfa8rjxgUq4dVJOoXLVuGEybHxbJfml9JZ/hv9BDY917ck/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=episOf1X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="episOf1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540253; x=1812076253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GrPBaqz4vJW6+l3zDtgP/2CO7SuG3mrR9GDbr1wFqMs=;
  b=episOf1XVbRT2JG7yqcjc6XVQGbADHtVPzKrkP/h/rm6cNFwgNYsx6RI
   HABMdIei5pIqU8Hn4pkB10HqSTPkxh0ZKSw8F14L+0Uipu+XTL03fowBZ
   +cgHcpum9bMOFl/z35rz10gdEF1F5iiiSXN4Z6XZKQwmiPuAkiPQ8+1Zr
   HO4XBlZuQiiw4QR35OukT+ObhRjMvllBSuUe8xH7ZSMpoI42Ufhds1qKl
   qG7gK4o16MdO6AR2poIJw5/IIHjWN3x72dBWKDmxgddJyPaqyH8LMSh5M
   JSi9tQiIhjspUZllDs1N+3RELv8CAF4dWrwljGd8jrCasq0YAq9BmW4mL
   g==;
X-CSE-ConnectionGUID: 3dyUBJqcRvahstrJNaUrOg==
X-CSE-MsgGUID: x00w/M4zTKi+NTNGu4+7+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045334"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045334"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:30:53 -0700
X-CSE-ConnectionGUID: aH5hQDTLTVyD5bBUEvs16A==
X-CSE-MsgGUID: 4BwfoSKKSvaArjJVkD5/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241910640"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:30:50 -0700
Message-ID: <505c8f52-2526-4d78-bdff-1bf67f49129d@linux.intel.com>
Date: Thu, 4 Jun 2026 10:29:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
To: Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
 <aiAr_YZqVwijXyQ5@google.com> <20260603145903.GC1170766@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260603145903.GC1170766@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 22:59, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2026 at 01:28:29PM +0000, Pranjal Shrivastava wrote:
>> On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
>>>> From: Pranjal Shrivastava<praan@google.com>
>>>> Sent: Monday, June 1, 2026 10:37 PM
>>>>
>>>> Clear the iommu->priv to NULL while returning an error from probe_device.
>>>>
>>>> Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
>>>> handling")
>>>> Signed-off-by: Pranjal Shrivastava<praan@google.com>
>>> probably add a note that UAF is theoretical at this point.
>>>
>>> iommu_init_device() calls dev_iommu_free() right after @probe_device()
>>> fails...
>> Ack. This is just to prevent a UAF against future refactors. I saw the
>> intel & amd iommu drivers doing it and felt this is missing from smmuv3
> That is just pointless dead code, the core code immediately frees the
> memory this is NULLing
> 
> static int iommu_init_device(struct device *dev)
> {
> [..]
> err_free:
> 	dev->iommu->iommu_dev = NULL;
> 	dev_iommu_free(dev);
> 	return ret;
> 
> I would remove it from the other drivers not addd it here..

You are right. I ever mistakenly thought that release_device would be
called in the error path, as I noticed the following:

err_release:
         if (ops->release_device)
                 ops->release_device(dev);

That actually is not executed when probe_device() fails, so there is no
UAF issue here. Anyway, it would be better to add a comment line in the
driver to prevent any future misunderstandings.

Thanks,
baolu

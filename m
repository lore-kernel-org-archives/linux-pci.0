Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988177;
	b=1EgX1Bt/QegY9g9DoOxsWirn0Rzmwzp+a0hhGwBGup02NlFBA2hjqcoEuWy1cdB1h3dz
	 0lSe5ey6wK950FzkU+Vw9GmD4kIAeg4ER/lvKhkIWPguHf31NRZuv0zPDWasA2SdC+xlD
	 ecwi95RSGRqPyCFvRa3kLfabRwss8ca7E3XmKWRCaA/rpht5G2q9sI15XsimKs8m/HxZY
	 e4s4VDUpDV1Q/JbKlyqzisb7+uxRvcmRV7/gBGMYSiFEq7X9+qwfU8kqWAv6CAlQH3JcH
	 QBOk1fH7lke+LTOEFDJYOks8dx2UeibTFDxgAgt/WqsbeFIYlK1MY8JcyAdL+cBMx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988177;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ESPCsoEPtuCXM1f1Dh5TyCaDd7FuNNWEbBXa4uabGnQ=;
	b=F2mKpRLf2l0GNx6Afu32q0uDHwVmhccfZhiD9PSZYkzmLSKpedE160Jp3yMv1ji1kI4s
	 ntVT9Wjv+MQSdOrFV3yxmPwdU0boXlP95fPUcARBA+vUIkYrzbCn8ejXkfjFwcDISNC/4
	 8SbvKMWGz/cXcjXiK+G9Jsbx5VzrklHVPkUNGpP8B8z2jm635cnKj4PsEO/ogtdjpSANy
	 2+69Mks3qXKYxeCrqdoZNpLvAHEnS1yaBFQgVghY+lHlK5Oqw0sSPFs226Nr0ypLWmp7T
	 ZE6HlhD1txYDw/AOLrusvM1zjgMj0A2OMR2A3nXPpVWexcDXvQt/0s/B9ToXmKs165Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YAr8hA5N;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E605606A325;
	Wed, 18 Nov 2026 07:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E605606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YAr8hA5N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794988177; x=1826524177;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C3BJLvclQYCeUdc56oRM38yDtB84CMxhqig1w0q6W7I=;
  b=YAr8hA5Na1JuGU4kb/wRc5rJOxIDQYI2xWYbywKPePjN8MsnManET6ny
   kjF8XonC16IwfzgWOeL98YNuBNg5+EPruGc/6JERV90MKJrGOKpsehpJY
   4RYo+XbXL7MBoelalmn/2HEtwOdiwP0sjYUrW1WBfaCaMQzLGQx4s/HPY
   6Z0+/y+islLbiWeQFjeaJX47SCuNCVYMfF3so7VfnJwvunP+eAnHqIlZl
   teXnMpBvkR8t+cm/Vjj6oi7XLyORoIiX13I2o72Xiv8Z2NUlLzrG64uUF
   Su9SsEIGHSr277tmx6cNfq16KbxrWkE8Qniy1yJJD7MsdGcK1yfYcd5wX
   Q==;
X-CSE-ConnectionGUID: nFeTgua9TkiSDwqL1Xe19Q==
X-CSE-MsgGUID: 4iE46M8lQ5+9oUWHMjtt0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3679532"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3679532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:49:36 -0800
X-CSE-ConnectionGUID: ebXOhVNTRZ6lgBbDHIlbqA==
X-CSE-MsgGUID: sJzLRkfxSJCmG5AMr6tPag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9866875"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:49:32 -0800
Message-ID: <19551f22-84cd-4256-a24b-f26c61502368@linux.intel.com>
Date: Wed, 18 Nov 2026 15:49:30 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Danny Gonzalez <digonzal@google.com>, David Decotigny <decot@google.com>,
 Sheena Mohan <sheenamo@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20261117180122.GA427856@bhelgaas>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261117180122.GA427856@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 2:01 AM, Bjorn Helgaas wrote:
> [+cc Danny and others because this is related to ongoing work at
> https://lore.kernel.org/all/20261020181053.2646782-1-digonzal@google.com/]
> 
> On Sun, Apr 07, 2024 at 09:14:29AM +0800, Lu Baolu wrote:
>> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices") adds all devices probed by the iommu driver in a rbtree
>> indexed by the source ID of each device. It assumes that each device
>> has a unique source ID. This assumption is incorrect and the VT-d
>> spec doesn't state this requirement either.
>> ...
> 
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4299,9 +4299,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>        }
>>   
>>        dev_iommu_priv_set(dev, info);
>> -     ret = device_rbtree_insert(iommu, info);
>> -     if (ret)
>> -             goto free;
>> +     if (pdev && pci_ats_supported(pdev)) {
>> +             ret = device_rbtree_insert(iommu, info);
>> +             if (ret)
>> +                     goto free;
>> +     }
> 
> This change is upstream as 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in
> iommu probe path"), but I think there's a problem here.  Previously
> the rbtree insertion was unconditional, so the unconditional remove in
> the error path was correct.
> 
> After 89436f4f5412, the rbtree insertion is conditional.  If
> intel_pasid_alloc_table() fails, we try to remove it even though it
> may never have been inserted:

info->node is initialized with RB_CLEAR_NODE() before the insertion, and
the remove helper checks RB_EMPTY_NODE() before erasing. If insertion
was skipped, removal is a no-op, so this error path does not need
another state check.

> 
>>        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>                ret = intel_pasid_alloc_table(dev);
>                  if (ret) {
>                          dev_err(dev, "PASID table allocation failed\n");
>                          goto clear_rbtree;
>                  }
>      ...
>      clear_rbtree:
>          device_rbtree_remove(info);
>      free:
>          kfree(info);
> 
>> @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct device *dev)
>>        struct intel_iommu *iommu = info->iommu;
>>   
>>        mutex_lock(&iommu->iopf_lock);
>> -     device_rbtree_remove(info);
>> +     if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
>> +             device_rbtree_remove(info);
> 
> This is also somewhat problematic because it relies on the assumption
> that pci_ats_supported(X) always returns the same value it returned in
> intel_iommu_probe_device().  That may be true today, but I don't think
> you should rely on it.

Agreed. The release path should not re-evaluate pci_ats_supported().

> I think both issues could be solved if intel/iommu.c kept track of the
> rbtree insertion itself, e.g., with a bit in struct
> device_domain_info.

Sure. I will address this with a follow-up patch.

> 
>>        mutex_unlock(&iommu->iopf_lock);
>>   
>>        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>> -- 
>> 2.34.1
>>

Thanks,
baolu


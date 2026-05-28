Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE53176EE
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945601; cv=none; b=jAB2ONGkmsvUw/jqhelNhArRnPN/6JGiND/IGxNnInD58aoh9QBBcG6NjVOLHokLFb4vl8Oc70jhRXl974JJChZezFr+Jx+LlIWCQAHZ3/aUf1G7tZwNXst51K7My74xfJ+gpIBVSaoQZGcEpCXT5WZxxIQ97VaDXeH4nwV+agc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945601; c=relaxed/simple;
	bh=zx2FDTbvq6OMZ3PhozqCteWEsJXhyt6slhqDRxSe7Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmH7uXyKiPZFr84ANUcsWn7lD7t9Esa0/2FHNAVOOrhXQkfzWqSa1vjcsZbsLTR+AAvyNx0kanIm7ANXNPlXKTDj2dPur8lmyK+OZU2MhDvlW+SUs7Ki6522St5nO24NoxJVWmTI49cl8rNIfCpzYdHTCRLb/lDzc3EES1DC/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG+AQo9i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG+AQo9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779945599; x=1811481599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zx2FDTbvq6OMZ3PhozqCteWEsJXhyt6slhqDRxSe7Mw=;
  b=XG+AQo9i6o9u4JDf9knqhL8m4glAgptdToOVsjqeMViu6K31pWYGAVDy
   YcL/FxPjSSglOXWmtSLtBx1PHddhED9u5YWxXTuivNQjlTrc+DstFhGTx
   l9mdbW6Pbmq0ylptHz27bL7miIck+b2IRgz/c37KIyaMY+yn1q1r4D3LU
   OnU+G8/8WbiDqH0hlv0vb4/FKaEyPVJoLPKRxfVzReJPVRjFosAb6YuZj
   K6RtzJ7VlpGNOFSVM3QS/Jq+oCr74DkcTiM4hRRDoealM2gcZ9eRPO2q0
   52y6CaI8AMoRjpi57+tjsZgBGJTrFEWG/Gb1Niv8Z7wKuA0qIIAR/ArCe
   A==;
X-CSE-ConnectionGUID: KvmCsT3EQ72fWLlVjbl6Hg==
X-CSE-MsgGUID: lcHaZVk9RyuGwJnsYc2Tkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84671956"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84671956"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 22:19:59 -0700
X-CSE-ConnectionGUID: KqVnZpWaTEmjR89Fptzcug==
X-CSE-MsgGUID: k9j7NrlDRV6slmhXb1r5IA==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 22:19:58 -0700
Message-ID: <17ab0d76-6df7-48f6-a7fd-387934f95c0f@linux.intel.com>
Date: Thu, 28 May 2026 13:19:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] iommu/vt-d: Fail probe on ATS configuration
 failure
To: sashiko-reviews@lists.linux.dev, Pranjal Shrivastava <praan@google.com>
Cc: linux-pci@vger.kernel.org
References: <20260525184347.4059549-5-praan@google.com>
 <20260525205628.CD4431F000E9@smtp.kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260525205628.CD4431F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 04:56, sashiko-bot@kernel.org wrote:
>> @@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>   
>>   	dev_iommu_priv_set(dev, info);
>>   	if (pdev && pci_ats_supported(pdev)) {
>> -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>> +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>> +		if (ret)
>> +			goto free;
>> +
>>   		ret = device_rbtree_insert(iommu, info);
>>   		if (ret)
>>   			goto free;
> [Severity: High]
> This is a pre-existing issue, but does unconditional removal of the rb-node
> on the error path cause tree corruption for non-ats devices?
> 
> If a device does not support ats, the info structure skips the
> device_rbtree_insert() call here, leaving info->node zero-initialized.
> 
> However, if a subsequent operation like intel_pasid_alloc_table() fails,
> the error path jumps to clear_rbtree:
> 
> intel_iommu_probe_device()
>      ...
>      clear_rbtree:
>              device_rbtree_remove(info);
>      free:
>              kfree(info);
> 
> Calling device_rbtree_remove() on this zero-initialized node causes the
> rb-tree logic to treat it as a root node with no parent, ultimately
> overwriting the actual tree root with null and corrupting the device_rbtree.

Perhaps we can fix it like this?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..849d06dfe1ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -157,7 +157,10 @@ static void device_rbtree_remove(struct 
device_domain_info *info)
         unsigned long flags;

         spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
-       rb_erase(&info->node, &iommu->device_rbtree);
+       if (!RB_EMPTY_NODE(&info->node)) {
+               rb_erase(&info->node, &iommu->device_rbtree);
+               RB_CLEAR_NODE(&info->node);
+       }
         spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
  }

@@ -3254,6 +3257,7 @@ static struct iommu_device 
*intel_iommu_probe_device(struct device *dev)

         info->dev = dev;
         info->iommu = iommu;
+       RB_CLEAR_NODE(&info->node);
         if (dev_is_pci(dev)) {
                 if (ecap_dev_iotlb_support(iommu->ecap) &&
                     pci_ats_supported(pdev) &&

Thanks,
baolu

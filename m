Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6D30BB8A;
	Fri, 24 Apr 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999364; cv=none; b=e03owPP1apypV69Er+K9gWsBstI7M5qLTts8/i8iSK5XBucLXwb+cFp0HQ+jj7Pqxinp4D+dBzltpbBMVRl7pUpnbfSmVbiwKnYyaimEipcF72rogctpmtDNRr4TKWJKeQ5xZSo1VVSut1I4h6FblDmXtcnce1+hEHMzh1vPVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999364; c=relaxed/simple;
	bh=pZDuDeaZoj7O1LubWx5vw5Buq2BjiWMeU3DeyutW5QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIsCPI1Wp59prRYPsBLIurw0tL9jogAME39QbImGa1ac6wbSsScCOdDrLAl2GHE+FQp1rHjvGp2TG2iLxGE1XgBcpd4Wpz7K7Slhr3AdlnDtqHChulOe+7jptposOn7yFDuLTWhlP3LcmPAhOXeDyNhwGUAznkDXdzUTo1VnIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBMDsUSr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBMDsUSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776999361; x=1808535361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pZDuDeaZoj7O1LubWx5vw5Buq2BjiWMeU3DeyutW5QQ=;
  b=XBMDsUSrm9Spf4Lktm/+oqgc8+ia1O/sUFwEL8+HYeHYi61T9H32mw80
   IjoUG3TlWihTQLzkDibTevdw3lY2o2b5yZSbjjIKUXivrdbCqazkWb1hL
   UWplpC2YwlYuAAK1kZ0L3q+WZZbSLTOJ42IjDWj3cFSzwQgRNwEOfqNzc
   ybs3iRBuhGM5mKea39N3/wq2Z07va7oy3r5nDEjBP/RcRT9Rhh2MKHQol
   CxgjWqOK1Hs8aGkBkOit/DAUfUvNUYXIA8emmieJ+oSFvq1m14PyPh2qK
   FkjvppJxSEcMPgBFF8BQdiTgBaEc2iJ4Q441Pco1/hF6pbTfQN+PzLTIX
   Q==;
X-CSE-ConnectionGUID: WVhTsdqSSoSIVsKM/h9aMw==
X-CSE-MsgGUID: KosSwxVwR2u5+ln7jTzC6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="65511067"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="65511067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:55:59 -0700
X-CSE-ConnectionGUID: uP9vfrh5TES/laj0y+LAEg==
X-CSE-MsgGUID: 2db0jdZfQsqaiY8zHzQvsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="237184547"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:55:55 -0700
Message-ID: <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
Date: Fri, 24 Apr 2026 10:53:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 07:28, Nicolin Chen wrote:
> To allow lockless iterations of the group->devices list in an ISR context
> that cannot hold the group->mutex, change the list to be RCU protected.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 768ac728b4cc3..d1be62a07904a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -84,18 +84,20 @@ struct group_device {
>   	 */
>   	bool blocked;
>   	unsigned int reset_depth;
> +	struct rcu_head rcu;
>   };
>   
>   /* Iterate over each struct group_device in a struct iommu_group */
>   #define for_each_group_device(group, pos) \
> -	list_for_each_entry(pos, &(group)->devices, list)
> +	list_for_each_entry_rcu(pos, &(group)->devices, list, \
> +				lockdep_is_held(&(group)->mutex))

for_each_group_device() is used in bus_iommu_probe() without holding
either the mutex or the rcu lock:

static int bus_iommu_probe(const struct bus_type *bus)
{
         struct iommu_group *group, *next;
         LIST_HEAD(group_list);
         int ret;

[-- cut for short --]
	    mutex_unlock(&group->mutex);
             /*
              * FIXME: Mis-locked because the ops->probe_finalize() 
call-back
              * of some IOMMU drivers calls arm_iommu_attach_device() which
              * in-turn might call back into IOMMU core code, where it tries
              * to take group->mutex, resulting in a deadlock.
              */
              for_each_group_device(group, gdev)
                         iommu_group_do_probe_finalize(gdev->dev);
         }

         return 0;
}

Will the change above trigger a lockdep splat due to this "mis-locked"
case?"

Thanks,
baolu

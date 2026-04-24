Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9533E7;
	Fri, 24 Apr 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776997912; cv=none; b=MECvJLn0fTZlbW5J9Wy4oisIba/F2iGweKKSOwZoJ/METqsPvwB54dm5dsM3s9sTJMEkl19dN9r+FfoOXldAC67pp2X0SxmJOJLTgfxdTxtEsiFqXGhj4I24Opa+p+SB+esUCGfgAJg4QSnOzC+WC9td17092uscxnb8e99tzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776997912; c=relaxed/simple;
	bh=LyMvA85aXO9l8odLPd+42Em6naKlmY2OXKuRaUPutyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G01PNv79SGuVjE7Bf3h6yYc6Q7u8ilJcQ3DirS4RKdQET+aS2N6hdMr4iW17ZvQC3XOyiw3aDsj711qQ3rLZTqW+K3K5IqsvSebbT8TnrfIVfgzaNnIHVhA00z9BrKBIkDLEhYmGCDvaHa2tTetuC2o+a3VXulgPs+FQe2G2xgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHfZlMf3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHfZlMf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776997911; x=1808533911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LyMvA85aXO9l8odLPd+42Em6naKlmY2OXKuRaUPutyE=;
  b=FHfZlMf3FcQj07cq4/7u7myPK3erOONYO9bWJUTgoN1XVdvJYmzsbyuu
   5tCmcg1gKIn7T1gpzUxetcSJJzJbSjcwQKl+WBjU3v25qCvUb8XPloC8L
   AA/p4yzjobOPbN6YcOA4VPlurSgBnrcrTQh/REe7Q1U1aPcBVA/wC/7Sf
   +Z+zzRqVCX8h485p5xFnbB+rCpal3NZrsGht+4c8jg9kZDhFTAjicoijA
   rR9dgpVEwkUNbdXLdFoCArvbW+WLbfA1eYzg0wkReLcXKzcv2O4dHTLf4
   +w80bPw9uzAMN6eUxswQKMWodYcZ/jBSwrkboEYNKPclSqO5awJ4UlA0Z
   w==;
X-CSE-ConnectionGUID: nm1iFSxMSu2iQX5M5GBR4g==
X-CSE-MsgGUID: YcP26u6qSW6bLeCl0ZDLyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88671342"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="88671342"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:31:51 -0700
X-CSE-ConnectionGUID: hSntE3wvRXCvwE4MXgt62Q==
X-CSE-MsgGUID: ZLZ+lQZtQqm4aQohybn0aw==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:31:46 -0700
Message-ID: <667647da-c8e3-483f-aa57-c3730194c8a5@linux.intel.com>
Date: Fri, 24 Apr 2026 10:29:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] iommu: Defer __iommu_group_free_device() to be
 outside group->mutex
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <3f5d229267d1f4d918641bc5b896f54b5c4b7782.1776381841.git.nicolinc@nvidia.com>
 <3570e178-f887-45c9-a251-e089915cfbd9@linux.intel.com>
 <aeo/BDwYM9yYHctI@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aeo/BDwYM9yYHctI@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 23:47, Nicolin Chen wrote:
> On Thu, Apr 23, 2026 at 03:55:02PM +0800, Baolu Lu wrote:
>> On 4/17/26 07:28, Nicolin Chen wrote:
>>> +static void __iommu_group_empty_assert_owner_cnt(struct iommu_group *group)
>>> +{
>>> +	lockdep_assert_held(&group->mutex);
>>> +	/*
>>> +	 * If the group has become empty then ownership must have been
>>> +	 * released, and the current domain must be set back to NULL or
>>> +	 * the default domain.
>>> +	 */
>>
>> Nit: this comment doesn't quite match the following code. The code
>> doesn't check "group->domain != NULL". Or perhaps in that case,
>> group->default_domain must be NULL?
> 
> This is the original patch from Jason:
> https://lore.kernel.org/r/4-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com
> 
> I kept the comments as-is, though It might be slightly confusing?
> 
> I think it means:
> If group->default_domain == NULL, it does check "set back to NULL".
> If group->default_domain != NULL, it then checks "default domain".
> 
> Maybe it could be "must be set back to the default domain (which
> itself can be NULL"?

This is clearer. As I understand it, when the last device leaves the
iommu_group, the group->domain should be one of the static system
domains, either the default domain or the blocking domain.

> 
>> Furthermore, if a device is currently quarantined, group->domain will be
>> the blocking_domain. If that quarantined device is then hot-removed and
>> happens to be the last device in the group, will this WARN_ON trigger
>> unnecessarily?
> 
> If a device is quarantined, its group->domain is retained to the
> previously attached domain. Its blocking state is logged in the
> gdev->blocked flag. So, I think it can pass the test.

Oh, my mistake. I thought group->domain would point to the blocking
domain when a device is quarantined. It's fine if group->domain remains
set to the previous domain.

> Thanks
> Nicolin

Thanks,
baolu

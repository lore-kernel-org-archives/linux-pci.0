Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F13446A3;
	Tue, 14 Jul 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007529; cv=none; b=ePYN1OeKluVvS0RcCdKmd1SRFrN1fsUuGz+WbUoYiG4EhSjgh8AvGOTnCDPBdmfr5WnqjbU8ntEjwydgN1EcJ6PUdIJIF227BOcSSrdNLNaxSE36oWhIuolAetlI6yLAOR05Q/IOHxxq5bYiY3knJHKU0XMvqFoXLO/RaAMcwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007529; c=relaxed/simple;
	bh=fmoxeHNad4ygdYeSccYkXkWFeEORD/OVZF5VZ9FQ+VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyyRdIQ4CeMATj1mumAZFTUxOijWngcUDdB5U8GsDbfoVgQahhOrHFkyJgwqd17wD2onujZvOPb0rhy9igj6lqdLttGU5p+5EqJn1v4rp9d/e3b3bq6r/6AdSxvXrK91T5r4EWNNPO9cp3ggf1o29hLUK2krEKNcXP0tNniRkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQue7NJy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQue7NJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784007526; x=1815543526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fmoxeHNad4ygdYeSccYkXkWFeEORD/OVZF5VZ9FQ+VY=;
  b=DQue7NJyCdMME7fNvX1cj3+SLY1kgFmpBStDLcKnKgcpE2vl83WpxrqR
   +/mtpgNskFuETXdNAw1JYz9umYUCwfobpkF/MZws9BPOTjOu4cXubWEGO
   Fz2Oc4N6nuclVbR7n/vshIW/FBr922tEwUS0A7XteW85VCopj8dyl40Qb
   nn2d2wT5JZWt7IRwUiYbXwwfBm6+F3Q8dook+XrapZ7gcFEcr7OiJaybu
   6OfOacfb+4EsMnVyKhlaFlFaNyyb5EBMrLuL54/+RmjzY1yjCEXB7tk08
   2n0hRkya+imPZVueR10punfQ/iZlIlmHTUMjoU9PPwijcwM2NAB6aOm/M
   g==;
X-CSE-ConnectionGUID: Wds0qBDNRo2vknM+AfexWg==
X-CSE-MsgGUID: G7GZ2AmwQuCgheO1Nr87DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95769604"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95769604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:38:43 -0700
X-CSE-ConnectionGUID: WzQa0jlfQW+1VqakYHExLQ==
X-CSE-MsgGUID: 8SLmmXFoTmqq4BRuqSX1aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="259331943"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:38:40 -0700
Message-ID: <4afb26f6-ab9c-424c-b23e-b639370b00fb@linux.intel.com>
Date: Tue, 14 Jul 2026 13:36:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
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
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
 <a24597bc-28ff-4b23-818c-f9126be3bbf9@linux.intel.com>
 <alUvPl/NtmqLMsoY@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <alUvPl/NtmqLMsoY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 02:32, Nicolin Chen wrote:
> On Mon, Jul 13, 2026 at 07:48:53PM +0800, Baolu Lu wrote:
>> On 7/3/2026 12:06 PM, Nicolin Chen wrote:
>>> @@ -762,6 +763,9 @@ static void __iommu_group_remove_device(struct device *dev)
>>>    		if (device->dev != dev)
>>>    			continue;
>>> +		/* Must drop the recovery_cnt when removing a blocked device */
>>> +		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
>>> +			group->recovery_cnt--;
>>
>> I feel that the change above is unrelated to the purpose of this patch.
>> It looks like an independent fix that belongs to a separate patch.
> 
> It's actually related; I had this in the commit message:
> "
> This introduces a new situation where a blocked device is being unplugged.
> Decrement the group->recovery_cnt accordingly.
> "

Okay, I see your point now. Previously, reset_prepare and reset_done
were always paired regardless of whether the reset succeeded or failed.

This patch changes that model. The DMA blocking state of a device will
not be released after a failed reset. Thus, it is now possible for a
device to be released by the IOMMU subsystem while its DMA remains
blocked waiting for a successful recovery reset.

> So, it was not needed prior to this patch: it wouldn't fix anything
> if applied before, and it would be a bit odd to apply/fix after.
> 
> It's a small three-line change, so I think folding it in is okay?

That makes sense then.

Thanks,
baolu

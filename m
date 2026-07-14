Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E91FFC59;
	Tue, 14 Jul 2026 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008118; cv=none; b=Nn6b5dkVjmJ3ono16K1IKg0M48g8AXoElrf9BZWJ4zlEhMlQNByp4SHzlT5Mf/f8m74lxhRxKPrU4WSy+whhHMaAHg//BwkofWAV0Xwi3Nbp2+EZI781geDPWP+0q0SbG/ZuptXi31hdGhfCG9C1RhC33quJGmvCXdiDODIejNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008118; c=relaxed/simple;
	bh=iaWPYz/PEYpLtc8hcV+XI7U4ojKHzqm3RCvrB1jQoY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhKelMqIP1JmGODeUNQnuWjczKnwPmJBdL6bYGw+A7ElKayDqTBO7wAJ9ouQBVKG21sEsMvzS0c0ypxR1kXMAK6bGRCC7qbCxvGuD//oF93ZtrOpyszQvg4eJ3DNqJzaVTi/gOFBgAIXOua4r/J/iP1hI6qR/Q3imQs/5F3VbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CL3zdTHX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CL3zdTHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784008117; x=1815544117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iaWPYz/PEYpLtc8hcV+XI7U4ojKHzqm3RCvrB1jQoY8=;
  b=CL3zdTHXWnj6a9tbPe4odchk12n9wPlTlcqnfIxZWzwglfLYG5Oegegi
   GGeAF58CLR/xl+PR+7MCUsPm/G9xKnWkUeDFRUozD6uytArM3od83C7Ee
   xekwiXbnOA9V3e1LHeHgQ6OHldN5QzqQ2kAxC4suT63370HTTWFNPbDnH
   03kPzosdOt+928BOTlVaRgo2d3LPVtOQ7Y0NXgZ8E1NjwL35C3n1RAdFt
   W6DKgjlrwB3HKgKVcGx6x7dETzCscNeDK3uAVPgNzC6ER2GvUTzRaGmb7
   j0/nyjn78MBlxNcFdS7PWDFpik0/hobxYBklaQLar1HjhzgGSKXWNIL4L
   g==;
X-CSE-ConnectionGUID: XH8RLDhESx2G3NYsPFe6kQ==
X-CSE-MsgGUID: FBldrkZRSEGpnRWl7OCwpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84741770"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84741770"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:48:37 -0700
X-CSE-ConnectionGUID: YVfgNPWqQ4qIPwEDh/lsyw==
X-CSE-MsgGUID: owHzFtAaSI+EfbxjhDEj4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280176911"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:48:33 -0700
Message-ID: <d119314e-613f-4077-b141-747e7d6f0501@linux.intel.com>
Date: Tue, 14 Jul 2026 13:46:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/18] iommu/arm-smmu-v3: Block ATS for a master upon
 an ATC invalidation timeout
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
 <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
 <9a85cccd-29ed-4c51-b9cb-140631966d20@linux.intel.com>
 <alUzeyRh5FnzMiQ4@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <alUzeyRh5FnzMiQ4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 02:50, Nicolin Chen wrote:
> On Mon, Jul 13, 2026 at 08:20:29PM +0800, Baolu Lu wrote:
>> My understanding of the sequence to quarantine a faulty ATS device is
>> to:
>>
>> 1. Identify the devices that encountered an ATC invalidation timeout
>>     failure.
>> 2. Have hardware block incoming DMA transfers and translation requests
>>     by clearing the corresponding bits in the device's context/
>>     translation table entries.
>> 3. Have software prevent the driver from submitting new invalidation
>>     requests or re-attaching a new domain to the device.
>>
>> If this understanding is correct, then while steps 1 and 2 are hardware-
>> and driver-specific, step 3 seems completely generic.
> 
> Step 3 is kinda driver-specific too for a few reasons:
> a. This is in the iommu_unmap() context; called right before that
>     function puts the kernel page. So, all the steps must be done
>     before kernel reclaims the page (potentially to a new ATS for
>     the same device whose ATC is stale).
> b. Invalidation can be an IRQ context. So, can't use group->mutex,
>     which a generic helper would likely need.
> c. Given (a) and (b), extra driver-level spinlocks are required:
>     streams_lock and master_domains_lock in this patch.

Yes, fair enough. The locking constraints here are tight, so keeping
this logic inside the iommu driver makes things simpler.

> d. Step 3 actually has two small steps: disable ATS at the driver
>     level; disable ATS entries in the invalidation array, either of
>     which are currently driver-specific.
> 
> Jason has a view of moving the arm_smmu_invs to the core. So, maybe
> step 3.2 (disabling it in the invalidation array) can be generic in
> the future.

Thanks,
baolu

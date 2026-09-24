Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26944825B0;
	Thu, 24 Sep 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271252; cv=none; b=h90nTcdax/yKHeti6gl9KB+GlOzPkjqwjtr5kKos5F1UmW1QEGa+1pnWRG3U35iEAZiky75bXQPmxX3jJ9MQaM5mzCyz5Pz8iRX2SusUo0YcqpWKDh5d4KZ0mLA7ldnMTAHSyE2HMjZvT+HBSoCwHlpkwJbAIEV0yrqSm/biJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271252; c=relaxed/simple;
	bh=2tysLwBWgTZ7MCrFdp3B11+1lpg/A+T5MpTOa0A3mO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PB9ZYPntFAZXrF5Y+L46EkHTvYZFKVEHvSNEB+YnunzJMahQr3TD1zr/aTRQESAYfxtMqzLnmmv4HSzKaO10/eF33E01fTJ4NsZ3uV1WCTQfwb7l2LSvchY4tAUxRfFBP0V/8lTdKOT9CB3ouO3awb9w40RfmMyn2ejoKvet8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUX1wo4x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUX1wo4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790271251; x=1821807251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2tysLwBWgTZ7MCrFdp3B11+1lpg/A+T5MpTOa0A3mO8=;
  b=kUX1wo4xuxhfp4Xvg8o+Kwf2QhBde/s3OXnlRMEDEEYEb1CYreL8Z4uL
   oomxwz2v3EDVrfLt0Zq5b/rcpQOvMTWmPuz5ejfSJ8IYCdTPS1ATbL/MQ
   xQTe8eilIGmnIumtCl75Grq+1OpLfm9Z3vsZtS7Ien8n0VVqmPj+OOJIk
   z3kjDNLLItPCMNz9kvYjybgIP87alvVRFY675eDfkdj7uMDtKobtK5pVD
   5nMFkctIQDwgXGJFuZkpxxcmk+MgjEI5Db4pwPLQ4fJqERk13uSJJ2wi4
   PUcXOssycDnh3M2kEMbATPTr8VQ17ClngsR4bF4DbLAPC5/mUDq0EN4V9
   Q==;
X-CSE-ConnectionGUID: o+2BN3spT76nvmiP3Q5AGg==
X-CSE-MsgGUID: U/+il+23RAOTIetUBR8wzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91159520"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="91159520"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:33:51 -0700
X-CSE-ConnectionGUID: vUmazGeKQrmcgZCCf6VuLA==
X-CSE-MsgGUID: 6KCNVVTrRkCHM1syjNTfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="282178478"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:33:48 -0700
Message-ID: <5e819088-e922-4efc-ada0-c2c237f599cb@intel.com>
Date: Thu, 24 Sep 2026 10:33:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/15] PCI/CXL: Reject reset with unsafe function
 scope
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-13-smadhavan@nvidia.com>
 <e63cb7a3-bcd7-4968-a5a6-12ffcd9bad50@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <e63cb7a3-bcd7-4968-a5a6-12ffcd9bad50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/26 2:41 PM, Cheatham, Benjamin wrote:
> On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
>> The per-device PCI reset interface must not reset sibling functions.
>> Reject cxl_reset and cxl_bus for multifunction devices and PFs with
>> enabled VFs.
>>
>> Reported-by: Alex Williamson <alwilliamson@nvidia.com>
> 
> I'm not sure Reported-by is the right tag, I would expect a Suggested-by instead. I think Reported-by
> is really more for bug fixes, but I could be wrong.

Yes Suggested-by is the right tag. 

DJ

> 
> Thanks,
> Ben
> 
>> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
>> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> ---
>>  drivers/cxl/core/resource.c | 3 +++
>>  drivers/pci/pci.c           | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index 85a554b6236c..249b1280f3d3 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -859,6 +859,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>>  		return -ENOTTY;
>>  
>> +	if (pdev->multifunction || pci_num_vf(pdev))
>> +		return -ENOTTY;
>> +
>>  	if (probe)
>>  		return 0;
>>  
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..fe611340f5ab 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>>  	if (!dvsec)
>>  		return -ENOTTY;
>>  
>> +	if (dev->multifunction || pci_num_vf(dev))
>> +		return -ENOTTY;
>> +
>>  	if (probe)
>>  		return 0;
>>  
> 


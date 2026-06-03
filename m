Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5338C427;
	Wed,  3 Jun 2026 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465371; cv=none; b=FwSAwI7frz3EvlDA8zeZKqS7kOlYd781Ebo8DOZzHnCdfQwGfqj6TB0PYrPXM8X+l1d9/TuSMt4gySqxnDnLvmtZy++IJ0nczbIQmmXxaj82Hb1BqYKPqusHfqCIofnN9WM3M0kdemKbo6VvdMWwvm/+CGZZWBuWWzl1er4FEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465371; c=relaxed/simple;
	bh=eHSfms8SDqQZDGz9Tir5qn1pgYT8YLXwTWyORdOsJaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuWmYbml3knHUkcU+hxHFXFx0B6vZ2qvLaf/5RD6+GIcqoUIUUcOZTZUaHLtEPcmdApBBpTMQNjgvFf+aVe8uJB865/uBnvinpD9ymxw9OYLXGOoFKDygWHwK0EOv6JrHUe5PEgTFjNuExUfDK10mQ5Wq7C+Lb4R/ZzXJ/TNscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqHjx/FN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqHjx/FN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780465360; x=1812001360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eHSfms8SDqQZDGz9Tir5qn1pgYT8YLXwTWyORdOsJaA=;
  b=aqHjx/FNtsgFbTSPj0ljgm3zV7rhuYceAdUyNY3IjfQ1dBENlPk444Jw
   ZDVfPqL5LivxUV4zNybSxZg3TgQEIQl3VxPFMSaAw0lhdJSv/hP18mb3b
   P9a6QOcjnDYtU7tSczV7V6Q30itmg5gVr4trOlukiWf+dyLCzMQYFi7g6
   N6XCbK8aZ4v4g3O/UT6398zVwBImlE4pBSRWLJfLf8PHk9F5uFKqy+b7o
   M4kNlhsVXa9fCTk1EXreNM3qz3tsEdAbzqFidAuQ5b14RqC5B1F9/svMH
   fXRqvRx5QpURYUXgKIhSY6HwwSQIXUwj4lIShExflR292rFFNDTta3IBh
   w==;
X-CSE-ConnectionGUID: SbQtfcATSb2qiJ12Dg2T6g==
X-CSE-MsgGUID: 7KhhzWFVQHqNN22zn/47XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81388904"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81388904"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:42:40 -0700
X-CSE-ConnectionGUID: IaHh4nJBR2a8FSCTiy9zzw==
X-CSE-MsgGUID: LcxjojRuSoiTvDqBxpCzWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241132053"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:42:37 -0700
Message-ID: <86b10a12-1d83-4c5b-969a-e0f9bed3f7ba@linux.intel.com>
Date: Wed, 3 Jun 2026 13:41:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration
 failure
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-6-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260601143644.2358771-6-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 22:36, Pranjal Shrivastava wrote:
> Update the Intel VT-d driver to handle ATS configuration and enablement
> more strictly. Specifically, update the device probe to fail if
> pci_prepare_ats() returns an error. This ensures that any ATS-capable
> master reaching the attach phase is guaranteed to have a valid config.
> 
> Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> fails. Since earlier checks in the probe phase preclude config-related
> failures, any failure during hardware enablement is considered a kernel
> bug.
> 
> Signed-off-by: Pranjal Shrivastava<praan@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

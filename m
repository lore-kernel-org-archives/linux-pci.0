Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AF282F2F;
	Fri, 24 Apr 2026 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998542; cv=none; b=WD7glV6wWk6PIlfrli3w0QsM63VpCp7gx6BTK6ckcy1RZSbOmwG/+S2+RqxAh0fZ9yj4FQARSjHcahspTkPY5dVw56WZpDdaqr4YXWy3FcMSOgipAnc/eUS4R9PEVcFgLIJNuJt2umZ8BMUDoC26Jv+sw/Tv0RKN2bPJJEtOgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998542; c=relaxed/simple;
	bh=+9A1KI036l8QOASwONExbQWXRXNXu7SxFYZQUHMm8XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrwCq1iS34EGzMZjQQw/jph+dIsF2W9MGv7thOmtBDRxz9z/EK8XGwwjBo59+oXepl+vFUL3WIRfp52C+KpOkkUIprJlz7MQXva4BIJUkpvPhhm4jaEMrz9rkCmEP2SmvHVFzdDSNFwenZa3/Yem0nsGv+m3AG9INYBx7pFEHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBQSj1Vm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBQSj1Vm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776998541; x=1808534541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+9A1KI036l8QOASwONExbQWXRXNXu7SxFYZQUHMm8XY=;
  b=RBQSj1VmaMyoqPQu00Zn+ZFRQjwM1DhWDyaYTZiQjiVpeXDtK9RZzMjj
   QZvJW3021Hy9QLpr1q61n0Gm/eaHqUrGcOCaB38bwiQ1rGR6JD7OpSqI0
   CrRLtgiiYZHiWRW5odxjY17dJ1/xFvN/r2dIEJ8pajMx1PEAEnONgFUH8
   y5skxtr8y64sCDDpKVxiJ5ClGvm0adbp8ESCnqdNXCbGrH8Zt1Z6GbrHJ
   QBH0RR77VhEz7uWIpM+uzSKadILBR5KVmhSwqc1bP/F7R7AW1EN889H06
   Ja9AtgO+ooW+WzyJQA4sB6FhjD5LNnKuBEdWrBj22pSihdo7zngCOPkla
   g==;
X-CSE-ConnectionGUID: coWbmI+nRGynllaFxrAMng==
X-CSE-MsgGUID: px0o+ROPRKe6qf1/6dkrYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77008145"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="77008145"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:42:20 -0700
X-CSE-ConnectionGUID: VdMpaQVoRzaH9GBKu8Y3EA==
X-CSE-MsgGUID: YwEWNUCRSDyF6AeeWJTrBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="226289829"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:42:16 -0700
Message-ID: <6460abc4-94d0-48a7-8cfe-978dad076cfd@linux.intel.com>
Date: Fri, 24 Apr 2026 10:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] iommu: Add reset_device_done callback for
 hardware fault recovery
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
 <c90693e75c0610da38103a683b558d5596bd843b.1776381841.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c90693e75c0610da38103a683b558d5596bd843b.1776381841.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 07:28, Nicolin Chen wrote:
> When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
> invalidation timeout), IOMMU drivers may quarantine the device by disabling
> specific hardware features or dropping translation capabilities.
> 
> To recover from these states, the IOMMU driver needs a reliable signal that
> the underlying physical hardware has been cleanly reset (e.g., via PCIe AER
> or a sysfs Function Level Reset) so as to lift the quarantine.
> 
> Introduce a reset_device_done callback in struct iommu_ops. Trigger it from
> the existing pci_dev_reset_iommu_done() path to notify the underlying IOMMU
> driver that the device's internal state has been sanitized.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  4 ++++
>   drivers/iommu/iommu.c | 12 ++++++++++++
>   2 files changed, 16 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

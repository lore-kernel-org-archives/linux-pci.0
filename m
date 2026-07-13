Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5D3CF207;
	Mon, 13 Jul 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943354; cv=none; b=uO4B4NbNk907qvG4Qum4cLW+z+TZB6yFzAbBKbM0H8nY+0Apxoif1tCL4C5q6ybpZvf2DfTsQww1dLjRmO+oy1hRPylhOlzmxF2hLKfKS4zVGvfLH84yYM70Jb3FTV5idb7/i/DqFM675wsfjVPu5cjhSYo+9J4wmcyTTbQ1sGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943354; c=relaxed/simple;
	bh=eWnSXz9Ty3uIb95SUsOqz5bA+W6Aati8Zka7C0DJr9A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNZQ8DWeyi/huq+1CxHkHMPTO+O4jyXF/rQG2qWx02lObFFb5f5VL1u/3TuMomWOdWTvwQhphpls+vZLlQ5bML8AhXFNFwwTFVULAhjqw2cykbyoqhZ8YQ09sfedAB1NZT6s1zgbn6YQIKIOTBjGv7ZKUzLgMcPTUT8f0qWTmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNuDUlKM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNuDUlKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783943347; x=1815479347;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eWnSXz9Ty3uIb95SUsOqz5bA+W6Aati8Zka7C0DJr9A=;
  b=DNuDUlKMoJUoi6/riI+CMs0kUqUuQC8tWoDy951Cbi6SlTYn+99E6h82
   NQTycpffjdAZPxbMWuKL6y+u2BLeETi5404a5EfZijSPRK3QdkiECPU3/
   MeYGrG5CQrYOu9wA70Q2dskelJ2mZkSgiVCMnEi0eenhuF+glts6hX+NX
   o12HM7GZgIG+UDRBTTeePQlSqKWK0Rjg9ZaHiF2IlNoDPjtwo3msTHKrv
   2wDbbchS3D4Tg2LV3OwhFpFwQGAfUf8OYxxnprVKaGz6jVlnQRfxOGQI9
   gFw0vrmKifT0Xpoynj/GHEHueq31GZ87aGUPXbWKFrTARiq6MKxDfebOM
   A==;
X-CSE-ConnectionGUID: bF00eiC3RS6w/T9GdrX2hA==
X-CSE-MsgGUID: cgDnZ260Q+OiX2FtcHWBiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95697223"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95697223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:49:01 -0700
X-CSE-ConnectionGUID: N6iz91DlRpqeoIxV+DT4Zg==
X-CSE-MsgGUID: ySaEXyB2T7mvKjfyUTuDwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259834074"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:48:56 -0700
Message-ID: <a24597bc-28ff-4b23-818c-f9126be3bbf9@linux.intel.com>
Date: Mon, 13 Jul 2026 19:48:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 05/18] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/2026 12:06 PM, Nicolin Chen wrote:
> IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
> errors (e.g., ATC invalidation timeout), indicating that the ATC cache may
> have stale entries that can corrupt the memory. In this case, IOMMU driver
> has no choice but to block the device's ATS function and wait for a device
> recovery.
> 
> The pci_dev_reset_iommu_done() called at the end of a reset function could
> serve as a reliable signal to the IOMMU subsystem that the physical device
> cache is completely clean. However, the function is called unconditionally
> even if the reset operation had actually failed, which would re-attach the
> faulty device back to a normal translation domain. And this will leave the
> system highly exposed, creating vulnerabilities for data corruption:
>      IOMMU blocks RID/ATS
>      pci_reset_function():
>          pci_dev_reset_iommu_prepare(); // Block RID/ATS
>          __reset(); // Failed (ATC is still stale)
>          pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)
> 
> Instead, pass in @reset_result to pci_dev_reset_iommu_done() from callers:
>      IOMMU blocks RID/ATS
>      pci_reset_function():
>          pci_dev_reset_iommu_prepare(); // Block RID/ATS
>          rc = __reset();
>          pci_dev_reset_iommu_done(rc); // Unblock or quarantine
> 
> On a successful reset, done() restores the device to its RID/PASID domains
> and decrements group->recovery_cnt. On failure, the device remains blocked,
> and concurrent domain attachment will be rejected until a successful reset.
> 
> Note: -ENOTTY is overloaded with different meanings by PCI reset functions.
> Some of them indicate "reset was not attempted", while others indicate "try
> the next reset method and the current method failed". IOMMU that must react
> these two outcomes separately has no choice but to keep the device blocked
> on -ENOTTY as well. Leave an inline FIXME and warning.
> 
> This introduces a new situation where a blocked device is being unplugged.
> Decrement the group->recovery_cnt accordingly.
> 
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h  |  5 ++--
>   drivers/iommu/iommu.c  | 62 ++++++++++++++++++++++++++++++++++++++++--
>   drivers/pci/pci-acpi.c |  2 +-
>   drivers/pci/pci.c      | 10 +++----
>   drivers/pci/quirks.c   |  2 +-
>   5 files changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d20aa6f6863ab..59ea7e601a2d7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1224,7 +1224,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
>   
>   /* PCI device reset functions */
>   int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
> -void pci_dev_reset_iommu_done(struct pci_dev *pdev);
> +void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1554,7 +1554,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> -static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> +static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
> +					    int reset_result)
>   {
>   }
>   #endif /* CONFIG_IOMMU_API */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 342e8a5ad628c..6e2e607de8d8f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -76,6 +76,7 @@ struct iommu_group {
>   enum gdev_blocked {
>   	BLOCKED_NO = 0, /* Not blocked */
>   	BLOCKED_RESETTING, /* PCI reset in flight */
> +	BLOCKED_RESET_FAILED, /* PCI reset failed */
>   };
>   
>   struct group_device {
> @@ -762,6 +763,9 @@ static void __iommu_group_remove_device(struct device *dev)
>   		if (device->dev != dev)
>   			continue;
>   
> +		/* Must drop the recovery_cnt when removing a blocked device */
> +		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
> +			group->recovery_cnt--;

I feel that the change above is unrelated to the purpose of this patch.
It looks like an independent fix that belongs to a separate patch.

Otherwise, this looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

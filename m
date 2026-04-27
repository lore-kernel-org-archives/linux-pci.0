Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812207083C;
	Mon, 27 Apr 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307858; cv=none; b=sJSmXtKA9tIZ7Y5kOP7uDqRQM5aiIMe5oXdz/NA7yU7K1O0bSI0b8+ZNolDe1TrgFYp+vxqukzPr+Uq5+WQhg7iBumU421CjjIpIrXfP47b63Ldw1Ds0ahGBz6S+11S3J+emts2vEqg3LTpFQcZKUU8CnIKgTSeEiB+WSVdeVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307858; c=relaxed/simple;
	bh=YIh4WeN8QUAy34rQE95nzKe8DABTjUVlxtRPaQcJnk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk+TSDi6s5QZBikgXT2BkwKBxhXaqDjZJ8N8OnE/UsuoA8eZlvKiZIWH0ph/PTJoedHGCh+hbnx15tlZL18U3abvWc5bxjygJOph6trwZePGxcVaQIINt31idGlOk7d+38ctz9+0nGIW2iL5CZqBMCfprwvbLeMmcoeWPfMM908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5k4jZRL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5k4jZRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777307856; x=1808843856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YIh4WeN8QUAy34rQE95nzKe8DABTjUVlxtRPaQcJnk4=;
  b=O5k4jZRLxsIY/8pNfZ79qgBRZjQQV7GWzrpBMeJfDgFSiYoyACf2cyoV
   LnSesCx5JLgV3KGPRkBhFBDWEsk2BaTfkXvhJ5xasiviYLXbXlk6TdE2Y
   5QrTkU9rAoq79buWbV1gFmMYH/8ICeVn2swh4pzQbzg7FhlhXwmiQedaG
   4m8Deam15tZemK9212ALjzeiVdkQPl+VpcalKa1lt2TdVscVjLiwYUakz
   XQzkySMT01Ui0oH/Mhxce68F+i8/h4LMsjmq1rUw6W5iUsat6teIwHsh7
   3kAzJCQ7hgECw53sRs5unzFiPrwiybt5py4Er/JOYSMwWd1tVpR14EzGM
   g==;
X-CSE-ConnectionGUID: nEAEmDe0QgulIc0wRb6rfA==
X-CSE-MsgGUID: 57bALsCqSMyxATz0k4XaIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77231917"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77231917"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:37:36 -0700
X-CSE-ConnectionGUID: n0jX+b1ESp2QJU2StdRyxA==
X-CSE-MsgGUID: m5gUBWOhT5Gq4mf82ZIymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="235438818"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.172]) ([10.125.108.172])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:37:34 -0700
Message-ID: <4389deb3-2c25-45ce-bbd5-ae36760d2619@intel.com>
Date: Mon, 27 Apr 2026 09:37:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com
Cc: joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
 kevin.tian@intel.com, miko.lenczewski@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, vsethi@nvidia.com,
 linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <7403163ebf59380f88c7503b3adf0dae07428df8.1777269009.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7403163ebf59380f88c7503b3adf0dae07428df8.1777269009.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/26 10:54 PM, Nicolin Chen wrote:
> When a device's default substream attaches to an identity domain, the SMMU
> driver currently sets the device's STE between two modes:
> 
>   Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
>   Mode 2: Cfg=bypass (EATS is ignored by HW)
> 
> When there is an active PASID (non-default substream), mode 1 is used. And
> when there is no PASID support or no active PASID, mode 2 is used.
> 
> The driver will also downgrade an STE from mode 1 to mode 2, when the last
> active substream becomes inactive.
> 
> However, there are PCIe devices that demand ATS to be always on. For these
> devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.
> 
> Change the driver accordingly:
>   - always use the mode 1
>   - never downgrade to mode 2
>   - allocate and retain a CD table (see note below)
> 
> Note that these devices might not support PASID, i.e. doing non-PASID ATS.
> In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
> a !0 value in order to keep the S1DSS field effective. Thus, when a master
> requires ats_always_on, set its s1cdmax to at least 1, meaning that the CD
> table will have a dummy entry (SSID=1) that will never be used.
> 
> Now for these devices, arm_smmu_cdtab_allocated() will always return true,
> v.s. false prior to this change. When its default substream is attached to
> an IDENTITY domain, its first CD is NULL in the table, which is a totally
> valid case. Thus, add "!master->ats_always_on" to the condition.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 ++++++++++++++++++---
>  2 files changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ef42df4753ec4..8c3600f4364c5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -943,6 +943,7 @@ struct arm_smmu_master {
>  	bool				ats_enabled : 1;
>  	bool				ste_ats_enabled : 1;
>  	bool				stall_enabled;
> +	bool				ats_always_on;
>  	unsigned int			ssid_bits;
>  	unsigned int			iopf_refcount;
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f03..d478f148cd34b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1742,8 +1742,11 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
>  	if (!arm_smmu_cdtab_allocated(&master->cd_table))
>  		return;
>  	cdptr = arm_smmu_get_cd_ptr(master, ssid);
> -	if (WARN_ON(!cdptr))
> +	if (!cdptr) {
> +		/* Only ats_always_on allows a NULL CD on default substream */
> +		WARN_ON(!master->ats_always_on || ssid);
>  		return;
> +	}
>  	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
>  }
>  
> @@ -1756,6 +1759,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
>  	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
>  
>  	cd_table->s1cdmax = master->ssid_bits;
> +
> +	/*
> +	 * When a device doesn't support PASID (non default SSID), ssid_bits is
> +	 * set to 0. This also sets S1CDMAX to 0, which disables the substreams
> +	 * and ignores the S1DSS field.
> +	 *
> +	 * On the other hand, if a device demands ATS to be always on even when
> +	 * its default substream is IOMMU bypassed, it has to use EATS that is
> +	 * only effective with an STE (CFG=S1translate, S1DSS=Bypass). For such
> +	 * use cases, S1CDMAX has to be !0, in order to make use of S1DSS/EATS.
> +	 *
> +	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
> +	 * CD table but it should never be used by an actual CD.
> +	 */
> +	if (master->ats_always_on)
> +		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
>  	max_contexts = 1 << cd_table->s1cdmax;
>  
>  	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
> @@ -3851,7 +3870,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  	 * When the last user of the CD table goes away downgrade the STE back
>  	 * to a non-cd_table one, by re-attaching its sid_domain.
>  	 */
> -	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (!master->ats_always_on &&
> +	    !arm_smmu_ssids_in_use(&master->cd_table)) {
>  		struct iommu_domain *sid_domain =
>  			iommu_driver_get_domain_for_dev(master->dev);
>  
> @@ -3875,6 +3895,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  		.old_domain = old_domain,
>  		.ssid = IOMMU_NO_PASID,
>  	};
> +	bool ats_always_on = master->ats_always_on &&
> +			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
>  
>  	/*
>  	 * Do not allow any ASID to be changed while are working on the STE,
> @@ -3886,7 +3908,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  	 * If the CD table is not in use we can use the provided STE, otherwise
>  	 * we use a cdtable STE with the provided S1DSS.
>  	 */
> -	if (arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
>  		/*
>  		 * If a CD table has to be present then we need to run with ATS
>  		 * on because we have to assume a PASID is using ATS. For
> @@ -4215,6 +4237,42 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  	kfree(master->build_invs);
>  }
>  
> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
> +	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
> +	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!arm_smmu_ats_supported(master))
> +		return 0;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pci_ats_always_on(pdev))
> +		goto out_prepare;
> +
> +	/*
> +	 * S1DSS is required for ATS to be always on for identity domain cases.
> +	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
> +	 */
> +	if (!s1p || !master->smmu->ssid_bits) {
> +		dev_info_once(master->dev,
> +			      "SMMU doesn't support ATS to be always on\n");
> +		goto out_prepare;
> +	}
> +
> +	master->ats_always_on = true;
> +
> +	ret = arm_smmu_alloc_cd_tables(master);
> +	if (ret)
> +		return ret;
> +
> +out_prepare:
> +	pci_prepare_ats(pdev, stu);
> +	return 0;
> +}
> +
>  static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  {
>  	int ret;
> @@ -4263,14 +4321,15 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled = true;
>  
> -	if (dev_is_pci(dev)) {
> -		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> -
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> -	}
> +	ret = arm_smmu_master_prepare_ats(master);
> +	if (ret)
> +		goto err_disable_pasid;
>  
>  	return &smmu->iommu;
>  
> +err_disable_pasid:
> +	arm_smmu_disable_pasid(master);
> +	arm_smmu_remove_master(master);
>  err_free_master:
>  	kfree(master);
>  	return ERR_PTR(ret);


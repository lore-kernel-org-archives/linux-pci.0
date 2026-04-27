Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CE3D649F;
	Mon, 27 Apr 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307505; cv=none; b=Fy2yyadcCQ2sF69QsIOtXKdHl9IGu3AIBxSGGV6uigbie8fR+sSjdY/OloZfn2utOLnQrLnzvjmdO7wRwv/QPQA1S5n73ChNGeaPxvrqQes/DDc6tbW/vrlkCpJKvus1826ReWKC+4PChfWfsEkFDRlJGSCsgxkjDoR4KJ6qmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307505; c=relaxed/simple;
	bh=RJ9UPp8EF7z1uvB7R2RYJWNX1kg1lSd61NxnC8m0o8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaPYNzkLA2tmZfEM4zxZ2iQ/JSV471ZYvBdKq79h/bkK8UzgINbKvDI1tMj9M+pTlCWuPNnopZuf0k0NoYkVX0v4MAoUksHsqKmi30Vp3ewhXkI+E0+RJslx6TGC9evuJjECBamwBkfbsVzDT7pc126K5QuGJL6jkX3ksFwLF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmNEH+Mq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmNEH+Mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777307503; x=1808843503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJ9UPp8EF7z1uvB7R2RYJWNX1kg1lSd61NxnC8m0o8k=;
  b=gmNEH+MqDbG/X5ny1aiUUqCwyVFlwMo3Dunc9S3oupiObq1DI/QlMfd0
   ZJmDIlhYAcNR+3CD32ppttLi1cSGb6ngdzBxp6r3NlssJtKyZe1w7ixV6
   1FbsjMtOPO0Gl+IQov9HV8tKT5AtAnPi5ZieQIUUiVOZgbaO9vep1n6T0
   Gudm3AqFAbMwzSZ6p1nl9qrTmBNKKrm8LxdWHQX5oXKr1Rfsx/r3eZjnI
   fuNwB/znuaFlnyK3/Yj66RdrGPVJIXvXczsG9SeBn/cVWXqGl1BHymH8I
   TUUj4Y1ktIp5jm5752DRQAmEUYh2rthi3xsvKT0nRmY3NayPTMO5EkF79
   w==;
X-CSE-ConnectionGUID: w3P6qVORSTONtAW0Xl/fRw==
X-CSE-MsgGUID: plAwMEBvRnCEr4TMCSetVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78093619"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78093619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:31:43 -0700
X-CSE-ConnectionGUID: LCC0RagbSjCpVrwYJkeKiQ==
X-CSE-MsgGUID: D8PgNkBgQgSIF6wwRjcL7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="271816236"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.172]) ([10.125.108.172])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:31:42 -0700
Message-ID: <2efed1ea-e373-41d0-bc37-4adac8378169@intel.com>
Date: Mon, 27 Apr 2026 09:31:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com
Cc: joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
 kevin.tian@intel.com, miko.lenczewski@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, vsethi@nvidia.com,
 linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/26 10:54 PM, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> given PASID on a device is attached to an I/O page table. This is working
> even when a device has no translation on its RID (i.e., the RID is IOMMU
> bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
> 
> For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
>  "To source requests on CXL.cache, devices need to get the Host Physical
>   Address (HPA) from the Host by means of an ATS request on CXL.io."
> 
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_always_on() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
> 
> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  include/linux/pci-ats.h       |  3 +++
>  include/uapi/linux/pci_regs.h |  1 +
>  drivers/pci/ats.c             | 43 +++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 75c6c86cf09dc..d14ba727d38b3 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);
> +bool pci_ats_always_on(struct pci_dev *dev);
>  #else /* CONFIG_PCI_ATS */
>  static inline bool pci_ats_supported(struct pci_dev *d)
>  { return false; }
> @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
>  { return -ENODEV; }
>  static inline int pci_ats_page_aligned(struct pci_dev *dev)
>  { return 0; }
> +static inline bool pci_ats_always_on(struct pci_dev *dev)
> +{ return false; }
>  #endif /* CONFIG_PCI_ATS */
>  
>  #ifdef CONFIG_PCI_PRI
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350d..6ac45be1008b8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9c..fc871858b65bc 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,49 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other words, CXL.cache devices cannot access host physical memory without
> + * ATS.
> + */
> +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> +{
> +	int offset;
> +	u16 cap;
> +
> +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!offset)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> +}
> +
> +/**
> + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires ATS for basic functional operation.
> + */
> +bool pci_ats_always_on(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_always_on(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_always_on);
> +
>  #ifdef CONFIG_PCI_PRI
>  void pci_pri_init(struct pci_dev *pdev)
>  {


Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A86378806;
	Tue, 24 Feb 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934143; cv=none; b=G4C/0PvlZOkmfSxhbznfbR/X790yLpb6JdKkES24scKYKaBvZ/0BXjIBcbszKibhYbi9/fN0QasOLVbeuufbTZEXW1mJzl7BAn3BbfpooetowDruC0iEDj7W8ldduVWGfqFEMZV30fY1xcd3avSr8561kzaYud0bZE8+xNrN4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934143; c=relaxed/simple;
	bh=6/HdsL8dsOZklNeeujbuOOCJPIicsKqiPMofmPR/9lU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzcbwkwEPbbLKy//MByFkityehWB2e+LyIH2s5/WayawCDqLuF7ksVy1N0RlisgG9OeGG8OLciTRWq15Z6b47piAKBf2UeF8cypxVAsq2qps8Cl/TaCKf3h5qTpF7BG0OUOYNX+pFqKqT0w0glAQEW3TLB0oFBAkOOM/fK7aR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKx431VmgzJ46jF;
	Tue, 24 Feb 2026 19:55:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B398640569;
	Tue, 24 Feb 2026 19:55:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 11:55:35 +0000
Date: Tue, 24 Feb 2026 11:55:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260224115534.00000ac7@huawei.com>
In-Reply-To: <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
	<ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Feb 2026 14:52:20 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> device requests a translation service from its associated IOMMU HW running
> on the channel of a given PASID. This is working even when a device has no
> translation on its RID (i.e., the RID is IOMMU bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
> 
> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> "To source requests on CXL.cache, devices need to get the Host Physical
> Address (HPA) from the Host by means of an ATS request on CXL.io."
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
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

+CC Linux-cxl

> ---
>  include/linux/pci-ats.h       |  3 +++
>  include/uapi/linux/pci_regs.h |  1 +
>  drivers/pci/ats.c             | 44 +++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
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
> index ec1c54b5a3101..ef061c0313ce6 100644
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
> index ec6c8dbdc5e9c..93060fdc0d3c0 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,50 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other world, CXL.cache devices cannot access physical memory without ATS.

Maybe tweak that to "host physical memory"

There are too many physical memories in CXL land...

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
> +	pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
> +	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
> +		return true;

Could just do

	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;

Unless the thinking is there may be other stuff that comes here.

> +
> +	return false;
> +}
> +
> +/**
> + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires non-PASID ATS function on an IOMMU
> + * bypassed configuration.
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


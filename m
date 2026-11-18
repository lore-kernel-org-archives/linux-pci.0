Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986439;
	b=4M/gisc7uOrhhJ6ePSFiYSGIidxpdJPSmrzo3Y5+fbpoaCHVWTzZVxUcnWD3sfYiLxCH
	 WvQUX4TuCX5SCZJLU2SauApoy8OP7BHlVtZuS/g4dWf3HYURRrW5rLUPGUrQ5wEPPyu3a
	 Nhz2sDhNANZv5vU0RW/v7PQ9gQWrsTeeMBg9k7Rv2+Pxv+5zSl7C0ukkIS/TbuUfiPTWJ
	 v9UUGhAkOzaq0Qu0eA7FAWK8qXZL0mdutPGNR3VLyA0au7Z0ErNyyp/bdwWeVuUq886Yj
	 vbLVjMfNjSo0IB+D4kQEuoaua0WBSXzEUBXu3vlVp3QjP3H/X8AAIWsu8l5f4jSIoaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986439;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aGwfspGlZydInl36JBBWlsrbZVsfQfMf2BFCiJS1BiA=;
	b=O2q6/xmY/4th3vCIMFcGOSX8HZB//KRv1uzlSvfHhCPrC7wgsKsxD2gokjCCMCvxrRSb
	 Vf1ek6kXiiEpDpuE/Dd1k41meDNoDN5YTwmbZibtoZvE7JC7LaHfSVlyBOg6Q3TnnQ2E4
	 fxpFMykz0xcw5J5f8TywHAHLTgRzNfJTcJhPoOTxwA8aJaJt5FQ24wGvbqq0R+hegoMOJ
	 vTCKCBikLlLAN/gTzVMSH3v4lbGY70jbK6mqGdHqcomoHJ2xC3T9n4PS7ldYB1CrbKuRi
	 +HlomaW8qoQjmBzuDduTRN13tL+xArm4oOLDuxesl24yi+ZNICVUGSE4vKuPCrwwn9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VIChq8sh;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B9606A325;
	Wed, 18 Nov 2026 07:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221B9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VIChq8sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794986439; x=1826522439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+2udD+I/B2oEnhd74DurfplmADbgc1YhIACKTb7a8dg=;
  b=VIChq8sh06N539lObd+t9jymvcO5L70F0mCkviOybsFRJ4did/45uFsj
   bCY9K1ihKD8H4VXBd1ShjokcXmMHZCaNd8PqaN2nQlLJubJ2WlJo9xshi
   Kh/FjiyxqXcRPdXvdg6uHBTO6sCRk0vypd7fd8q4gfvdf08Ofl5U02a9b
   z7l5vPgT3S1bstpCWwOitHpt0Bjh4cHRLB9dVgznE3+1ya8FKtyFYvAcO
   yiYr4Jbtz2S+84U0W/OWMQbBYvhqdqN0CRipP5M2H31FFPGffHXC7RKbl
   /1bgiZ8bOSPMJLxWQD8TOsIasofLlhLaZ7yK/TCG5rbIqdphAbqZZHovx
   w==;
X-CSE-ConnectionGUID: Vqk0UAB3QD+MJjVIbjAaYg==
X-CSE-MsgGUID: XvTuMYYDQ2OpY6uqn1PkNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3786036"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3786036"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:20:38 -0800
X-CSE-ConnectionGUID: P1j6hrGhTiiAhyx+IilPVg==
X-CSE-MsgGUID: 6OJJH8AFTDWd5J0HmgVxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11872150"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa011.fm.intel.com with ESMTP; 17 Nov 2026 23:20:31 -0800
Date: Wed, 18 Nov 2026 15:11:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 03/13] virt: coco: tsm: Complete PCI registration
 before publishing the device
Message-ID: <av1Pp0vDUisoErEo@yilunxu-OptiPlex-7050>
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-4-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116081935.85372-4-aneesh.kumar@kernel.org>

>  drivers/virt/coco/tsm-core.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 57db3f14cf46..181d6114086f 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -56,24 +56,6 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>  	return no_free_ptr(tsm_dev);
>  }
>  
> -static int __tsm_register(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
> -{
> -	int rc;
> -
> -	tsm_dev->pci_ops = pci_ops;
> -	rc = pci_tsm_register(tsm_dev);
> -	if (rc) {
> -		tsm_dev->pci_ops = NULL;
> -		dev_err(tsm_dev->dev.parent,
> -			"PCI/TSM registration failure: %d\n", rc);
> -		return rc;
> -	}
> -
> -	/* Notify TSM userspace that PCI/TSM operations are now possible */
> -	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> -	return 0;
> -}
> -
>  struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>  {
>  	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
> @@ -91,15 +73,24 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	rc = device_add(dev);
> -	if (rc)
> +	/* Complete PCI registration before exposing the TSM to class lookup. */
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);

Ah, sorry. I see you've open-coded it.

I think let's move all tsm_register() side change in this patch. That
saves much intermediate change.

> +	if (rc) {
> +		tsm_dev->pci_ops = NULL;

Besides this unnecessary nullification, others are good to me.

As mentioned, we've done several rounds of detailed reviews for this
early publishing problem. I think it's time to split Patch 1,2,3 out
for merging.

> +		dev_err(parent, "PCI/TSM registration failure: %d\n", rc);
>  		return ERR_PTR(rc);
> +	}
>  
> -	rc = __tsm_register(tsm_dev, pci_ops);
> +	rc = device_add(dev);
>  	if (rc) {
> -		device_del(dev);
> +		pci_tsm_unregister(tsm_dev);
>  		return ERR_PTR(rc);
>  	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible. */
> +	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> +
>  	return no_free_ptr(tsm_dev);
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
> -- 
> 2.43.0
> 

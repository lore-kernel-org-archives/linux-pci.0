Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D542669E
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577858; cv=none; b=SEEKAzgkOp0RLultEohNgmwCf7EyoCd33Bb0IRQZxsN4kmH8ZiFVSsVYo1xTnbluEqTYtmKDe3ydr3YxDHxGOiU2TvPnmVAivvXRQCKuhozT8b1gcr1yl/94q719WAlT75dFSd5nifwsF/S7QGTvFTSaPYqTxacsLzmBJ0JF1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577858; c=relaxed/simple;
	bh=1U6NyzXgzghwmgznfZeRYyFAcgGDs0fm45Rk9Z3dM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpvSAsiRNULdrUqhLFKPy55AId/rykdkNJPtb1ggXvwMtjdp0KOZh/oIb86TzZ2wp0kBBCrglycu3fswdFHjcLMZt0mMj+MhA6RKSn27XLVymSBKTuEC3AHR34BexHMrAYuJvekSmVGWjhFX24U5h//tHxUXiLu2/KCpKb4W44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mI8FzApD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mI8FzApD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6391b114so249305885a.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787577853; x=1788182653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Av++B0/o7UC1jj49c6nzmrH1j+NIAZ2vTywjWODYChQ=;
        b=mI8FzApDUeWVFfs178nDccxfzi47sSHOWyFdrYXi59CPKRfxpXq8YUOT8hJd1i0nen
         M6dLulGrCq9AhRjpS4kwt48ZKn9Rz0X/z1VeHYPmJl5sGSCsSVNTV/Llh3J2Zdr+zIFy
         8yBtIx553YMNpHWTu55P8UYLgfDh2ABOpw8kTgOQ4Ahh4xhZNn1XFy725MyGiyW+b1vW
         lCr0e0cfDssD6QxDaS4BCE0QSAcXi6hcqP7+AnighhxesFzE8sj7ztQStqiTq5vjvoM+
         IWIwZNz+hSBjInNK1r0+EOvhk71BZQ6CFj0upfDApZx4L8GGeFuDjDvuWsmGZdOMN2hJ
         UwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577853; x=1788182653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av++B0/o7UC1jj49c6nzmrH1j+NIAZ2vTywjWODYChQ=;
        b=Dfs/MW2hEcKc8/sQQzfRqcF95kKIxnKbk2raaYlaJso680rklzxQmKlNzMdWPw6jy3
         fTDirl06w0xz7NK3AtsflP3+7wd68hf1QTCodkKk8w8BXzArFwDNwLDL9JDQeWXGa1qg
         EvrtQALCKAitjzSfSryXm4y7liEGO+c91r1u4woCiXWe8TJnLQIToi48CzZcy5SEs6FA
         hXXXapwpVxyd0WVtlAqfaXuaiEpNQ6DdsDxoRvb6E2C4diFBsv/sgX/ptUUz37jvlCtA
         BIukczU5qtQlEBKfsk7oF9rYWkgtdIqZpklChlPsoYIpyexMvqJnUZxcBxYyZ7GErmiQ
         2eTg==
X-Forwarded-Encrypted: i=1; AHgh+RrfuT+cF4EBV/guYFankEV4wN+voQ9Mryk16d3QYOWYTgevoZGpPUZJEikqwDggqstpbZucttgTYNg=@vger.kernel.org
X-Gm-Message-State: AFuF++mAWErbGzHlfERLiPsvFo+NWh8KMwVPpwYZNJXgvqWxCSSIDcHt
	ADCvnhIr22cy4O+m5c5NbfBFFvgDEcLrU1AAQXUey5BkOEZXU8vX7guEVLawJtXLrV0=
X-Gm-Gg: AR+sD10HlyAv2a1/YuIC9p1dP3p2psH3/HBq2ZZ3+UvnHqGaHXiC9Hyy9rO6GWtNXYX
	BZXP9HQ3DNIWZQbFxW3IHCbV2c1CiCRTX/Tt3mwFGck+Si+UDNlfoJJYh4SFRzIRSnlHPbsEKvd
	5N/SA3vX2s0baQIsUPYgy0eDG3I8MkGerHno7ndscCJYVlawrE2JflZntibpsOu3m9AxXoZeCUR
	fOKzOFfDdbYe1b0HhFF3XuFQH99CdtdkjEmT7O/JjcPLNJyYkw4apDJrMhbFfs/YpVRmAzekZaW
	fhZIBX0TUUzimKh7gnxh7YcocDlT+DBQQwMMji3PeQ4I3bY6fkNDEYUNiY97pTf3gMVg+KbFCWA
	osJ3NHlBC7FRlPt4cKe49/x2OylLFZCuxXLHz68Q84JZfy8lT4GgAFZrvqaws/Ev/ymQ5NzKB+7
	VfGGRu1kwbTJc1U0r0arqkeKfvgK8WMurHqv1LLwJ6927GQr0QN11DR2+24fG8PmSgqhksN7Zt5
	hm9XwH3GS6Sk2mNakp3qIQTNK/wbtFE/sy8FEm6i90SaA==
X-Received: by 2002:a05:620a:1195:b0:92e:4799:a808 with SMTP id af79cd13be357-937395be432mr1945679685a.40.1787577852646;
        Mon, 24 Aug 2026 06:24:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749abe858sm495557985a.6.2026.08.24.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:24:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wyUen-0000000Cnw4-2s5a;
	Mon, 24 Aug 2026 10:24:09 -0300
Date: Mon, 24 Aug 2026 10:24:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260824132409.GC1449020@ziepe.ca>
References: <20260824085821.5422-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>

On Mon, Aug 24, 2026 at 08:58:21AM +0000, Vasant Hegde wrote:
> Certain AMD GPUs must always operate in IOMMU identity mode. This was
> previously enforced using a PASID check, which happened to work because
> these specific GPUs are PASID-capable. However, this approach incorrectly
> applies identity mode enforcement to all PASID-capable devices, not just
> the GPUs that require it.
> 
> This made sense in the past because the domain allocation API
> (iommu_ops->domain_alloc()) only received the domain type, so the
> driver had no way to inspect device capabilities and pick the most
> suitable page table format (v1 or v2). With the recent driver
> enhancement to use domain_alloc_paging_flags() for all paging
> domain allocations, the driver can now inspect the device and flags
> directly and choose the appropriate page table type per device.
> 
> Update amd_iommu_def_domain_type() to force identity mapping only for
> the specific GPUs that require it, via a new quirks_force_identity_mapping().
> 
> With this change, a system booting in DMA translation mode will now
> select:
>  * Guest (v2) page table for PASID-capable devices
>  * Host (v1) page table for non-PASID-capable devices
> 
> Also drop the amd_iommu_snp_en check, as SNP enforces paging domain,
> which doesn't work with the identity requirement of these GPUs.
> 
> Link: https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
> Link: https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>   - Dropped disabling ATS for "Radeon Pro WX 4100"
>   - Addressed review comments
> 
> @Jason,
>   Once this patch settles, I will send separate patch to drop
>   'untrusted' check inside amd_iommu_def_domain_type().
> 
>   Regarding SME check, I have retained SME chek inside
>   quirks_force_identity_mapping(). If everyone is fine to drop then I
>   will do follow up patch later.

Sure

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;

I still haven't seen an explanation why this make sense. This
patch says two conflicting things:

1) We need identity for the APU cases because they can't handle
   translation
2) We can't have identity for the SME case because it can't handle the
   high address bit, so use paging.

Surely #2 is also a per-GPU version thing and this address width issue
was fixed in newer chips?

But even so, if paging doesn't work why is it OK to use it for SME? If
paging does work then why do we quirk it away?

Jason


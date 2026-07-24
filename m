Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC2349CC1
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906132; cv=none; b=rgyalolSmK4qgmlVzmDtim5NdxXKu+FORUgAnUSuzaDJdPFJ4bz4nw/zU12cCRYgCRbel0s6iNYK99pq9B32qs2zJ5ulPH3FBy9dSGYCrPqYW5tcDefkEEPgEAeghFAaLmAoC18lNV+zyoQb1wYOBaplntjcEekl4Cw/Dh326XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906132; c=relaxed/simple;
	bh=QbMIzfT3pI/FCbKHeyTodh9O19gRKy/LqmADzHFm4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW5KZmqcmYHHd1OYenp2xVxOZSOu3CWOtSEO6kYvCRSba7MxMexiqQyo4V59w7klRMgy2C5gnxkXDMSmFMmh8QoCv6q55u89yALdF6Sg2hx5W5xBekstZgue9FXwqyqlrhTNFG0XkjyUrWY724RWd9wCKrFRlFE3y0P0MDimpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yf+bxnoE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yf+bxnoE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so6218185ad.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784906130; x=1785510930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHaoMw8Oj5RyClx0k/jfMkqxxF2MZw9lUe54lPVbmc0=;
        b=Yf+bxnoEtQPsO6gpiMSWmoAzGDz5boTh1AdsaeQ4GFY7p5498JXLhHztvPgqQT4qyf
         CohntmjEb5nTSLv3BkE1qN/PS/je5OjEHgQDsIEHpfiq+ubc+ojHOPR1m0NXtkOA+SXc
         0tpAyl1LKUlQu0GIuAhTouzu/sqctBG7wV0MB4kSgDKiAjjQCGQVAdhMOSKknitNeh6P
         aS+RKGzRMEsy49y0jqPOSyWIyuYKRi7nVGPQ6Dz1oQV3oyqRM6JUk/I6Vr6498bmY38Q
         s70cMFQMTvtrk0KpAurBIhUA5Iw6UsIC/xblktr+JJpYKmsODv4VDtC0ueciM9BrTBZH
         RwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906130; x=1785510930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHaoMw8Oj5RyClx0k/jfMkqxxF2MZw9lUe54lPVbmc0=;
        b=G9pbti0wQ/mT0A67y+d2Ky0bGup/6c6RoN9CS1GPGztCYgw6CV6jitYDSFjdIAD0WX
         PxDIevnS9H+JOBLwawe5dTTRU414gc7SURdp4pLYlg3WE7xa/p7pClD+RLa27Nu+SwXY
         DOYILXgiAgK6w3c5fu1Uh9/qm+UGxcFYE8RCZb6ImHZpIxy+3stWTi42uUShpkAN95Qy
         7So9jRwsjJKqdMTHRTirGnsZJNdxDr/jDAfqlObnQ5NrHuEy2e8LUuJpOikumRDydT33
         uT4stFL4RMii5QaLSm1wD83oem8rq3JYDleJSrpVx438DdJcZuBRbNThtkEukWBdGKHU
         qz9Q==
X-Forwarded-Encrypted: i=1; AHgh+RomZZ1gWj8U7Ali7oIK85bnS6nB+uDhabtaONDLBXNHfLaBx2peCBLn8brXCHhg7sTY7g7ul9PNRCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeBz1tvi7HAA2lRWVhhwGzsT5sfnBYnfDGkNeqflpeDjkBYNC
	F+Q8dYeQ1YmYvnFe+AUYCWvcEja/1j5mPyjbJRpMuLmhZsJcNuAGz4MuHNZkO7AWPGc=
X-Gm-Gg: AR+sD12HrrVF1W70MDV66kYxJcv6vPMBLw1Siu0ngH3p1MQmmXZqMizxCbY+bMpAbRG
	LP39LoDEELzOUfsIC0ljqxA3MZE+5zKRK8tEg5ewAx49x2m3d/Z5STUwak4i+XjQ9wcDMOUHiFf
	QWQTB42712jt2raupco0lJlAVhAQ8mVubqh2B1RfkyqXSU3ItnMbF5aHu+Ns6exjwSCaBlAWn7J
	bDkAGCH5nybOVpk7M7rtiBS0YURNyhtkcbf+UI5qScsIs0lVnaQsdJ2DyUpa7RTf0NGn6kiuc1E
	lrYHUt1HjnK113QzWg3hcd0/VKlC7zjH4fZlmAwNtLBB0HXdnTbgfUs7ezwDYvDCkuHAKvlnrst
	Bua2zbzrSPWJK+38FT41Km5jBccOxsdqwXG+blbpJt5uu1h9kzdZC
X-Received: by 2002:a17:90b:54d0:b0:38e:5717:9cc8 with SMTP id 98e67ed59e1d1-38ec6617deemr7146863a91.31.1784906130395;
        Fri, 24 Jul 2026 08:15:30 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130ce035sm27005956c88.13.2026.07.24.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:15:29 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHcW-000000002mg-3wXH;
	Fri, 24 Jul 2026 12:15:28 -0300
Date: Fri, 24 Jul 2026 12:15:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <amOBkJ4BaZ4qnkpc@ziepe.ca>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723061548.10187-3-vasant.hegde@amd.com>

On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	if (!dev_data)
>  		return 0;
>  
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
>  	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (to_pci_dev(dev)->untrusted)
>  		return IOMMU_DOMAIN_DMA;

The core code does this, it shouldn't be in a driver?

> -	/*
> -	 * Do not identity map IOMMUv2 capable devices when:
> -	 *  - memory encryption is active, because some of those devices
> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -	 *    and require remapping.
> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> -	 */
> -	if (pdev_pasid_supported(dev_data) &&
> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -	    !amd_iommu_snp_en) {
> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;

I think this can probably be dropped now? There is no intersection of
this old broken embedded GPU and a CPU that supports CC right?

> +
> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
> +		if (amd_iommu_snp_en)
> +			return 0;

Ditto?

Jason

Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26E3D9DCD
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086374; cv=none; b=AdDJjyaOE314CneJGi/sUpWi/mLcVrdVq9kSrBiOA0OlufesVMBy/+rbZTCCo9eaCWM4fFqdpWU/reOiekfMQhd4SZCLMiRrcAoqhuyK1e8nV/nuTZNHhVrETIdY7RNGf32vEib1RInw8ZhA93SDbGC1Fe1lNrygK8nSQjn3AFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086374; c=relaxed/simple;
	bh=PNYyEgoZtTQZAIb05vcE56UQchi78kODzvtdyqQGPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjL5FyzPGOyqILFMHjxiMEUxI5ETwcjXkAEYMohruq7wkBvDepJJrOMzskiU1BcyzUWQVSjFFKAebs1T3p2rRr4ssZxtNeOtVR0Rtkt3RbAmSJQD+4xDDN/N5ZwkcDI7KsFFFc5MxgFByoLvfEleGUr3lYl4Gu6X8unoQs2LzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vq4M7Lx2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vq4M7Lx2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso210145ad.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783086372; x=1783691172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEobmR+dTUalRHOtzAB6SzqkNWJ+47R827DKeMKcmBQ=;
        b=Vq4M7Lx2ytQUq/Z6BA0tBBqceo+HzPqOC+k+kj5s5kg89730h+yGr6gErUtxE+Bfoh
         Cz1a5J3UQRnE8GzGZnBSxU9YPxXAEhnYi6ksCVoqlEKHqojdTz7E7ZkuqhPzwPmXsuXf
         b3OWV+oygV5qT2h75tdXkdZYnneuoG5hRLb/8cdDKUIQlhjpq2nHcOJ42m1P8omup/jX
         9ronGufU/BINHYPhdOLEX3jH6Z3I4dEYMLBptTnxsOzoz8LBSOyJrBGpVUbkhgBWZ+a7
         RbD9asVz8ejilhm29sCXamgaw82tmFJ2JfyENf4psx1d1GOEMU1WKjR9sFnumEKeRbvW
         iSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086372; x=1783691172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEobmR+dTUalRHOtzAB6SzqkNWJ+47R827DKeMKcmBQ=;
        b=F6qT3QG6f/QVRUUnM1gMkOdj7naQXXJMpUP58fc5x7jh2oAUO/FhephZsqNyNlBCzF
         beStGUZALI7zGHqYXjqAkTIpPD3S8Rgu1YCcr2re0hlDRJ9XDp+fMrviK3Cutib6Kpjm
         XRTDpm2JR/ysYA+1MvqS2bAgVArcLPbZLHTQVn15gaId57CfiqG7O8GH0ncSZjBY071M
         girc0FbbuvBTBfFR7ap5YiaAKCr6iVTjSv98+oHsQ08tKMGWVfKdNcVOqhAmv7YxZLA/
         0XqTiyJLpXwDGQ5tpykvEg8McoO5rZPHMr4f/sZwWhosOiNzZ9SlgjVqyCa/0bsdtBIp
         4pWw==
X-Forwarded-Encrypted: i=1; AHgh+RqeovkzRAQIr+EAdzMuRAfplS7l1VYzjH+LjQkMbXt9XOddDhbQYqAHR9CM5wGxvX0Yspuxyh0DXu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6X9SPwmMQ2H5JnNB+9P4jsKUGAYnpIHG9TJJSeAubjUEi0v3
	/T+wou+9/HKwoR8e62waNj6apSgitlcStd3MOrf9VJbHrEX5g94+liYGSeXkiiLpJw==
X-Gm-Gg: AfdE7clX06BeD0SH0i52aI1mLnN5NIxZ7f5+3yVSIBRa82qqBbCumcBdcSCu6K/eipm
	LvQeU0Dmnk5MyN2Pn9u+CdBvLtYIRS4WQOJyxAb4HZh1O0UMPD028yQj2Kb7mUSVAYmCrKBZh3Q
	0GKD7ha8T9f0BabrUt5vFVgvwAhNqBZmOWkb7iwHGaS+KGIncXobbfSHvMzTqeMSH/4fA/vk82E
	aF+UFBkas9YybH3RI8xAWOfLG6HSC5tNCRXG8C/mqFFRsRNh8Y6FTvIEIyMDxNSBgvsfZ54DA/Z
	XunEOTvfI2iOPF6dK6RRXIR3gkFWo9otA9Dax/xUHh4bn1gRnT9yGd2BIJkudwi+rLQdUzOaa7h
	uJOrmttx90B9LZSauT+i1Hf0D3TvdiCS9bllHe119b2Z5fdS55yA8GRnGeVcBXYg1RQySp9kx+8
	9GcAz/OE76QJ2dNSTlaAEWZEBuOIRUHNVJqrvNDbcAJcf3Wus=
X-Received: by 2002:a17:902:fc86:b0:2ca:d873:3b41 with SMTP id d9443c01a7336-2cad87347damr1931895ad.19.1783086371317;
        Fri, 03 Jul 2026 06:46:11 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7894b20sm9826605ad.78.2026.07.03.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:46:10 -0700 (PDT)
Date: Fri, 3 Jul 2026 13:46:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v9 0/4] iommu: Standardize ATS robustness and state
 tracking
Message-ID: <ake9HIb60em50WaC@google.com>
References: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615235037.259909-1-praan@google.com>

On Mon, Jun 15, 2026 at 11:50:33PM +0000, Pranjal Shrivastava wrote:
> The primary motivation for this series is an ATS state mismatch observed
> under heavy load (via iova_stress). A failure in pci_enable_ats() leaves
> IOMMU drivers like arm-smmu-v3 with inconsistent state leading to PCI core
> warnings during device detach.
> 
> While David's recent work [1] addressed a discovery race for specific
> quirked devices by moving them to the HEADER phase, gaps remained
> regarding how Virtual Functions (VFs) inherit state from their Physical
> Functions (PFs). Specifically, pci_ats_supported() did not account for
> PF-level quirked status, and pci_prepare_ats() lacked STU validation for
> VFs.
> 
> Based on discussion with Jason and Baolu in v3/v5, it was decided that the
> IOMMU drivers should explicitly check pci_ats_supported() before calling
> pci_prepare_ats(). To enforce this, pci_prepare_ats() now noisily checks
> for support via WARN_ON(). Furthermore, the device probe should fail if
> pci_prepare_ats() fails. Since these early gates preclude software
> configuration errors, any remaining failure during pci_enable_ats() is
> treated as a kernel bug.
> 
> Following the discussion with the community, the driver-specific series
> have been posted separately:
> 
>  - Intel IOMMU fixes reported by Sashiko [2]
>  - Refactors for AMD IOMMU [3]
> 
> [1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
> [2] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/
> [3] https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/
> 
> [v9]
>  - Collected R-b tags from Bjorn, Jason, Nicolin & Sami
>  - Folded in the dev_err into the WARN for arm-smmu-v3
> 

[...]

> Pranjal Shrivastava (4):
>   PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
>   PCI/ATS: Validate STU for VFs in pci_prepare_ats()
>   iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
>   iommu/vt-d: Fail probe on ATS configuration failure
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 +++++++--
>  drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
>  drivers/pci/ats.c                           | 13 ++++++++++---
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 6666bde33b83cb4fc9b1f7ba6a3471479f76ce72

Hi Joerg / Will, 

Gentle ping on this, please LMK if anything else needs to be done for
this seris?

Thanks,
Praan

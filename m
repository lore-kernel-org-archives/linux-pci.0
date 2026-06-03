Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F253822A2
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477932; cv=none; b=UlLociOtnFnyANGtX0u0kr87hQ7wPOttuQ1lR4fwhwwhdcqyIw6Shb+MkyDAK9fLrPlZBR+wUKxFrxnTKKF/okW0bEVkGG85nvLjpBD1zpOk3i/h6j5JT9cHnFUNzTKiCWKu19NsyL4GdS5FfQZAVg1QQFzfM/q3KJy1kCpJdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477932; c=relaxed/simple;
	bh=aWJJYsImjMlpCgcuTspHg9B1jrZFFSK8m1eqcj4coS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ+deUS5LiX8/R6fpcIBAn/KjJMP8Vxotdo203ZGgT2Xib8N1NiygUhE74jVuqGFQXTakgyOtf5HjFETB6bkKBrvMvmsrwKtFeEjIIVqTyliSyiz5b7Q9kwg1mOrl8liwhi3k1ucGkfW2TcJ5gxuBPFfM6SNz237hHm8U/20zGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGOnzj3k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGOnzj3k"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so60195ad.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780477930; x=1781082730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SX4ayXZOGYaHHJyUgP6DHUBZW5VCIsd9Cb8QwmYDehQ=;
        b=eGOnzj3kx2Lwkl2tHOwPNnQ/DL2p/8MayUcd24YWde9VtvLX7Y8YuGNVN8FrVglj1q
         9kw0sueaBac8TP5usNa6cv+e8hJbz318In3GX4/fPZPNiGueIReIz/O1qCrBoPmoh43n
         10+5LBDgMuQIZFbxiLQfMiCE3/vtR2B7SMxebeivDop3aqZjYxapp5jLqHGAIyHLe8Zt
         wKiCfnitomuQwcGodciYHi8ssUHEsIal/N6U+myBYvkNS2bz+aaZjQ8QY735/ee/T6ql
         T7FxSacbxtDlrEyjZ7Mlx+Cf67Q4g9RUWHDIDPAMnXBzU1dwXniu9ESGLKLfPMBkt2kD
         IOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477930; x=1781082730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX4ayXZOGYaHHJyUgP6DHUBZW5VCIsd9Cb8QwmYDehQ=;
        b=rvDLZTqsjQVmZ4FBPJunQF6jSGwA14MhQzm9/DEDZ5wwkH5PPkFFpHeyqtja6QxsIV
         bFAon0QI5nT8yzUvtY2JaLBeVnODOTElPJueoXfbt6CYf0FrFiN6j311jIHomD4+9UVs
         KgPrt73q1Xcf01LZJM7VgtSowAPFxg8DyAcD4argoOGzlDMZSHVDv+p5dlGavvhxVLev
         b7ULheOKS9AsX3GFCPdBTlvg+qTQ8Bj+CAjedvR3tKz8oYn4szFtQkYdwMU84zsCNKgP
         q7wdJEjNy7ANMwP1ei7qtwWTBEMx+VHyioG/0vhf9+vq+2iqPNMUtPEN2YTJmyfT/2IT
         nVxg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZqGK+SxefVtqW7ErScmnoxRwauXc/HIo9QcpL/gxMxIVFvWjq8YaTZ9QpyLFKpNOPkoBYUGnVKI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybolKl8x7/fY0kHm7x6uMAe6fZOqZjPNU3e29MZUguUmdq48rZ
	iq/E2eu7TKrzfgqCwGoDoiqjfZbDUQEQ5U4Jx/c5ZVPUZ6jzAxH6PznOdXCWbNoy0A==
X-Gm-Gg: Acq92OFqdDPEuCpdign1e+92rnpYjptZc5RKdQjOybXTKNRE7exkIc9Rg59owXdfV04
	xrIh4BYodIF8wrLzjm2OlYjJGW2tiKIHBF5rOPb1Wf1zH0kICYZzYdaB9JWBQLnGRJ4OqlnCmRD
	2i8Ba6Hxm43n6xSwVqufgTx+cxIchUbin206dBbQx/pyf6U0N7G0+sksHiAIpVipVzut2Ry0OYZ
	jSBhQ4wndu+AhW3TaGu4TbNZBZsyZtsduzpwZ0kMmZlmwLpcAgduul3pHeUveBfODuVx3SKQQ61
	2u8Gre2UXLUs6TYdGDOaNIDpZ4NOjpneGbdnB8CqAvKQ4H3V5Bhh6PAbMOpnP8BllgKjarP90qF
	S0p4OQXhmtJmZvO2ox7ZUEZfGNxg+OboPkYpVH6Hp++x0isqNjzajDgQa6snwwpfDI/yKSGIZnU
	0184xUE5nptD3F8VHlN9mAoEDhdW5cWdwQ8As9ZBVMt3z1Cq3ELCCun0aRIpTa3nn1NgpbkaE=
X-Received: by 2002:a17:902:c405:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2c16fa720bamr937125ad.3.1780477929972;
        Wed, 03 Jun 2026 02:12:09 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm18571895ad.83.2026.06.03.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:12:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:12:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ah_v48zPNHoZb8D9@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-5-praan@google.com>
 <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>

On Wed, Jun 03, 2026 at 07:34:14AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Monday, June 1, 2026 10:37 PM
> > 
> > Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> > WARN_ON(). Since probe-time checks now preclude configuration errors
> > any failure during hardware enablement is considered a kernel bug.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 54c7f1ae3a84..dfb2b0d2d2a5 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct
> > arm_smmu_master *master)
> >  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> >  	 */
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > +
> > +	 /*
> > +	  * Since pci_prepare_ats() has already verified the HW capability
> > +	  * and programmed the STE, pci_enable_ats() should not fail here.
> > +	  */
> > +	if (WARN_ON(pci_enable_ats(pdev, stu)))
> >  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n",
> > stu);
> >  }
> > 
> 
> looks smmu driver doesn't check return value of pci_prepare_ats() too.

It does check the reval of pci_prepare_ats() now with the a recent 
patch [1] (merged in Joerg's tree) that adds a new 
"arm_smmu_master_prepare_ats" helper function.

Thanks,
Praan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=core&id=5ff98a0da6b48d8722eac0080e4185c417925d05

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869222424C
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329683; cv=none; b=ksvoqwt+VwQHEcG1Hj8yxLCtWj5EIw7R5b1qgvBC6OKJSfqPeHqmFq7+2MmChQEnBpOPrZToUIxoGYCfnF1uf/RSa3GB0tliT2gRgiifJIo+n8BjCw7m7LKTJf8dLzuZbKSX/0n0MIXlCzeyiMjevOzkMTat+4xUzCXjX+dGtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329683; c=relaxed/simple;
	bh=tqyb8j/dV7maTDE6A53XUG/pllUilNmVuiuRAuhvyMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpA2K2nf28LiaZ+0l2gtCknR6crr/7zJpkkYZT4u1bQowKasZirrZV3BCMcuBeThSfRskFR6uQnKSPMZDcK5o3ztLcT5wZcPG8Ti4zZpWJsOVm2DxVBao7L7DokaFzz5hKB933v4Fgr7XWtkx2UWdbQepQoOlbXkfFpqbEnMyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cqi9N+6a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cqi9N+6a"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2d865383so1635ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780329681; x=1780934481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqeyGtP1BtIlNo5CtVdhbiR2kLYidnVAzCET6d04Mv0=;
        b=Cqi9N+6avluY5dEvx5Gf8w19onbLMA5OnMDva2dVjH64VDKdEJfUvK2ULga6EhOBN+
         f4mQAeTWVS4l72z4fh4VwHuE4PACbHwqBGNZtFFNQQY++cZX5/On3idM/7Oo+IpvK0lA
         lHkxwR26e6ppP1a/7lR4zN6ehLbZLpZoA0AaBL0nm0envpjyyhI6K/JSE4C0ccXCSsbg
         bwD1oYn9WHh4WeWtFzWKDX820tmMNnwCxwlFYnfffX9A+9E3Dv7rxCCDX//goTPxoIsH
         MqIewedlB1Pzy1GWlG0G+SO5/y/CcFtfb8Pkd+rElLmp0rnl+OWfji3aeJ5UGL/0V6XU
         +3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329681; x=1780934481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqeyGtP1BtIlNo5CtVdhbiR2kLYidnVAzCET6d04Mv0=;
        b=AEJo6ftEbSwVXM12OpDTWvZR8JOhVD00JJjYlXW8HsMt+Seu8pDdQA+KF9W50LBmca
         xAg18QSxOrLZ3yR2R93hFYSb+vcESpCKOZeYBHs9DnBgczo+ysCTC4Y6XmWZLyv/Eun2
         L9mLxnhDsywRnive0wgClNrdTMSw6n49SbZWQg2nZ9ufMeiShUGkJnBc79orvYB6Qd56
         IXw4EdsW8+3QVChY11ZQfhQ3TWRoHwqJ44tzQK7kW3OfRH0fxtzOZh3jF3gnHui+tqzu
         X5va55YCVshoC54Vdkbfg3qxowPW8HYZPC0OU9TY7ztJeDCATKJmvB4N0Z5jDst/SJEq
         /k1A==
X-Gm-Message-State: AOJu0YyfMnL3Cy21JXDAxmSGmTZJU2Q/9c2CrrIYdGBZ2qKfTqE8O2rT
	V73t9KR2KHoI5RT0Jl7Ou+NSkmOWDQZt51/m1z74u+RUPTj9r010C9H6i+s8xCq0fg==
X-Gm-Gg: Acq92OEYxpQCV27gAzKYnkdZZCHBs7fcfEC+B+JGcdmJLj1lFMlijm85/OX4Lj6KC3l
	2/+isR0doHUiKZVJvVYhDSQw7CzkffEHaHVRdaMBQjeFqxC/O/d3TY2Wzni+UAWcmv6a6LaXFn0
	FmpOFLu57URUq/tBIsYEPdTSLDc93T/il5hpktS64RoJdG+hNDzYaK0bO3gplVgRtzxnARIPE8U
	zTcoN2EBkMq8/ku15Tfm5sCLx3YjoSGWDm95j0X9WD86bXRmK9T+ZW+IB2hByIh7BOKBMgBzw26
	aeHj7j2ZYvaL+RJ8eHQW1rnw6Rwm1hxFStIBBaTjakE8cadAKizfE6XTaAJI6toHuu0bvToPG9k
	sRd0GKcN/xTLWTL0QsZ5ZHe8X3aXpsbkGEPhz4pj207EjtO3gUFlppOZW6UIo7YhdhpvtnbSfPQ
	9/Qd6/W9Zyvc3p+FClyy+3c62budtRKH34KVBt7P2sx9imLRl+WkeKPHq1UmnVx41jEVh0xv4=
X-Received: by 2002:a17:902:ccc8:b0:2c0:b1b0:376e with SMTP id d9443c01a7336-2c0b1b0389emr3865105ad.8.1780329679954;
        Mon, 01 Jun 2026 09:01:19 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c9252bsm10773325b3a.39.2026.06.01.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:01:19 -0700 (PDT)
Date: Mon, 1 Jun 2026 16:01:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <ah2syZ_FmVusREQx@google.com>
References: <20260601143644.2358771-6-praan@google.com>
 <20260601153032.36C861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601153032.36C861F00893@smtp.kernel.org>

On Mon, Jun 01, 2026 at 03:30:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unconditional call to `device_rbtree_remove(info)` in the error path causes rbtree corruption for non-ATS devices.
> --
> 
> commit 73f5ec2d0aa9d509723e686b4cbf5b853c3a39c6
> Author: Pranjal Shrivastava <praan@google.com>
> 
>     iommu/vt-d: Fail probe on ATS configuration failure
>     
>     Update the Intel VT-d driver to handle ATS configuration and enablement
>     more strictly. Specifically, update the device probe to fail if
>     pci_prepare_ats() returns an error. This ensures that any ATS-capable
>     master reaching the attach phase is guaranteed to have a valid config.
> 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 4d0e65bc131d7..22308e4911e1f 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> [ ... ]
> > @@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> >  
> >  	dev_iommu_priv_set(dev, info);
> >  	if (pdev && pci_ats_supported(pdev)) {
> > -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		if (ret)
> > +			goto free;
> > +
> >  		ret = device_rbtree_insert(iommu, info);
> >  		if (ret)
> >  			goto free;
> 
> [Severity: High]
> This is a pre-existing issue, but does the error path in this function
> unconditionally call device_rbtree_remove() on failure, even for non-ATS
> devices?
> 
> If intel_pasid_alloc_table() fails later in intel_iommu_probe_device(), it
> jumps to clear_rbtree:
> 
>         if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>                 ret = intel_pasid_alloc_table(dev);
>                 if (ret) {
>                         dev_err(dev, "PASID table allocation failed\n");
>                         goto clear_rbtree;
>                 }
> 
> clear_rbtree unconditionally removes the info from the rbtree:
> 
> clear_rbtree:
>         device_rbtree_remove(info);
> 
> Since info->node is zero-initialized via kzalloc_obj(), calling rb_erase()
> on it for a non-ATS device (which was never inserted into the rbtree) causes
> the rbtree implementation to treat it as a root node and overwrite
> iommu->device_rbtree.rb_node with NULL.
> 
> This silently destroys the entire rbtree and detaches all previously
> registered ATS devices. Could we add a check to verify if the device was
> actually inserted before calling device_rbtree_remove(info)?

All of these have already been fixed in the Intel series:
https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/

Thanks,
Praan

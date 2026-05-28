Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E883B585F
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989825; cv=none; b=frUoTaCAsff25RPZ7xvsSio940NzCipDV39qOttF4qvayPH5qhwDPcBU7xGBfAU5/G4q0u6QsGPxVuDtqWEW9NtmjIrlGLjfQqvz9wZasfeRqklQfS0cG5K9Ga8ax+gm1IdSTIv3ZXEz/r5WTH24XVUW7IDq9An2m4xbqjV2CzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989825; c=relaxed/simple;
	bh=ODRFnjIkUAQww/q3dLtAxcGbYW1BaTBmjW2k6uhC1K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF9bQSqMcdB14EQWy0FsLDRwj/qxsUY/2GeNutEwvehDmaHOr8Ef9GpTIFEQ9Ls/VSEVw1MTZ3TiSdY69qfS2lRmJ1rcRsmSmfCdierq/SaRptWqyGXFuipq3y856lEqhMeEIMrrPAqihvO2qIQ4zzuLtktRKCiC4PjjqSQoPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/N8gN/q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/N8gN/q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso1555ad.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779989823; x=1780594623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk/MAQeMcth0WKh9OHkZ/HSNe18bg7+51E9FEIaNkro=;
        b=Y/N8gN/qqq+MlSfzfpYrrIFdpq5tjeUOpow073UPmeM6TSEvq4XZDmcYXNUeIRx/jh
         zcEiJkizKmPi0map1wNRy/Ettl+v11BLP07dMhxBeXmdLLVmFvRrpEp/HwSb4fKzIe5b
         09rYxoi5FtiWnpYellmHcbST98eqovweHf2rdI1ZqZIn12LxGfx7cK4Dks0Tbs83fQW6
         C4thYvMxemQVIXS6uhQg3jMZe9m0LwyBdKN9NObzcjmeqP/EMUok6UaL/T9xVU3guccu
         +VnBq/ELMPyqF9V3ZDlpm/aBIjtKzY2pZIpJghQru16VeG9RxWqF/A5FKwLTsS6S0ZUP
         Yiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779989823; x=1780594623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk/MAQeMcth0WKh9OHkZ/HSNe18bg7+51E9FEIaNkro=;
        b=r1w+G/GSDI954JKu3MUe/aIfvdTRt1vpZWa+eXqjSSAHuLjMKjouD5C0HfOHrcZhw8
         GL0LD2t/6TCmAmGTnM05ewY07ZpQW7J3AHgNVclTjMNmHouxz3dj/w6ujzmdl7CJGx6Z
         8F9SoKrJ0Ah6i7d0/3rQGGIVMmHRWgc/Xk+TzoRPFlroNps1ocJ2BqPxRaSGRiahMLih
         bxe+x/wvqwZk6luFL7pvIcsxCTvNIICXAEDdGPUSlYp1JQR/vQtrZ4xAdm/KCuCw5B81
         HfdcrRBkajcirC+EhG3CgfF+1rbiJtGMpUj+mvy3ATOZ5MB/O/vk6xUjXr+ZZ01Jx7j2
         ISrg==
X-Forwarded-Encrypted: i=1; AFNElJ/ONo1H3ZOTRFY6DWTymVqfSqmOSVB3XHS/u6sxx60Hr1gTyf3SxISWlcTkjigoz7EKWbkd4yjQHpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfqCA7PN4wGliUZUFekIWScddRURf9SwTIVemhlesdh1Y8kmP
	Z7tY8j9PuC2V8neI7cacIBmqE/RFU3hc4Ed3M1p83QuGMD6xHgJ7uI1NqHvRBMqyTg==
X-Gm-Gg: Acq92OHHWsCREeSlgx1MlHYlyXw2EBQjJst+TPwtqoztS1UQDoYHlJAEvfGTeVp6h8H
	J/6LjselsNojVe2yy9SEWetlC2jWCn+6Tpr5FrCMErk5tkqtp/kJxVw9EJ3YeEU+HKPIKXiyGrR
	XY7tIubuyQjfVDvowmeWsNjdpLtZa5qInFBel17zSAoIIeHPHnz6x4rBY6tG0kSwLMjR8wpPset
	g7e0DXcvhDqLUdCkCtdvaQl78VUmxpT2fakSwNuxu5rWnowdZ9qVg40USCdSQ4rdtTMkcCq/bTr
	WqCPZuCKeco4qexe/x4d0c1H12+iFGBfv9M2HD/6TmgOZTBbR9jcAxbbg36kdB2LZTQOXbH3q8U
	UMyyWgOPGDSd3bPFjgfDtG8ddbzNIeMeoqu0saD0dTqY6u746/n/3XQrm6/nqQP09+mgWHC1F/Z
	VnAP0KYuDirmcv6li5oVsIJ7HUs2BdpDkhNLtwayhe2CqOlhEHkd+wK/hckIdyTfZ+nJbV
X-Received: by 2002:a17:903:2b05:b0:2bf:749:55c with SMTP id d9443c01a7336-2bf1dea9685mr19605ad.21.1779989822247;
        Thu, 28 May 2026 10:37:02 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852056db34sm15614699a12.27.2026.05.28.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:37:01 -0700 (PDT)
Date: Thu, 28 May 2026 17:36:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <ahh9ORDm6EcQ7aKS@google.com>
References: <20260525184347.4059549-5-praan@google.com>
 <20260525205628.CD4431F000E9@smtp.kernel.org>
 <17ab0d76-6df7-48f6-a7fd-387934f95c0f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ab0d76-6df7-48f6-a7fd-387934f95c0f@linux.intel.com>

On Thu, May 28, 2026 at 01:19:13PM +0800, Baolu Lu wrote:
> On 5/26/26 04:56, sashiko-bot@kernel.org wrote:
> > > @@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> > >   	dev_iommu_priv_set(dev, info);
> > >   	if (pdev && pci_ats_supported(pdev)) {
> > > -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > > +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > > +		if (ret)
> > > +			goto free;
> > > +
> > >   		ret = device_rbtree_insert(iommu, info);
> > >   		if (ret)
> > >   			goto free;
> > [Severity: High]
> > This is a pre-existing issue, but does unconditional removal of the rb-node
> > on the error path cause tree corruption for non-ats devices?
> > 
> > If a device does not support ats, the info structure skips the
> > device_rbtree_insert() call here, leaving info->node zero-initialized.
> > 
> > However, if a subsequent operation like intel_pasid_alloc_table() fails,
> > the error path jumps to clear_rbtree:
> > 
> > intel_iommu_probe_device()
> >      ...
> >      clear_rbtree:
> >              device_rbtree_remove(info);
> >      free:
> >              kfree(info);
> > 
> > Calling device_rbtree_remove() on this zero-initialized node causes the
> > rb-tree logic to treat it as a root node with no parent, ultimately
> > overwriting the actual tree root with null and corrupting the device_rbtree.
> 
> Perhaps we can fix it like this?
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..849d06dfe1ae 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -157,7 +157,10 @@ static void device_rbtree_remove(struct
> device_domain_info *info)
>         unsigned long flags;
> 
>         spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> -       rb_erase(&info->node, &iommu->device_rbtree);
> +       if (!RB_EMPTY_NODE(&info->node)) {
> +               rb_erase(&info->node, &iommu->device_rbtree);
> +               RB_CLEAR_NODE(&info->node);
> +       }
>         spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
>  }
> 
> @@ -3254,6 +3257,7 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
> 
>         info->dev = dev;
>         info->iommu = iommu;
> +       RB_CLEAR_NODE(&info->node);
>         if (dev_is_pci(dev)) {
>                 if (ecap_dev_iotlb_support(iommu->ecap) &&
>                     pci_ats_supported(pdev) &&

Ack. Yes. I'll add it to the next version.

Thanks,
Praan

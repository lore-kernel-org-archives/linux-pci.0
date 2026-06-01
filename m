Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CE3D7D8F
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326347; cv=none; b=C9x5cdL2CTL+JNZEH+bpKi9Ez/vb1+V+BGfnH5gXxWNyC8zU9NijXm+izSvQi6HXVfY4IQiMqah/IYgr3eF/AhGAgIDEsfVH8t2uygrYaaUOn8H2MZCPyVOkennjraM/lBVZsLxfDugnmt4TjkQlzcB28EQcnOQxMS/RSe3lLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326347; c=relaxed/simple;
	bh=9x+cMbphP6dLbrW7AUFxUKgjFD1luiDCeRrJCZurggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ+javBmk5F0Xf1fPJ18TkiqteXaNjo9f4RzuxmUgOcDLaNyPEcc/1LIBgUmqwqkEUo5Ndz1R92PjK5juiz/Iuwd4kqAh26vlixRtJ9ZeJZVWR/XkPmHNOwkx0i3HfweILnSVBbkcthZQ2ku/cMEb974aGmXJMSKKHCP6v9/4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePrZBDiy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePrZBDiy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf22c18ad3so26645ad.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780326343; x=1780931143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGNrvQu3MsUANR6m8Aw6nTCtzJ6XjXkmgI7B+ElRctQ=;
        b=ePrZBDiynqw6EqBNpLpadU8O+dJnoKpPPr89PqS0mO6JTQesvQO8rjaTRCkR5TP4ea
         EvebEcF4nkhjpTowfnes8ot4Su64J/0lN1IEIIrQjXpqViSxYYZBhxKZ5HlPtINxFIEC
         DnuD5Z9jP8vuET5U2zYNMScVXXsYAv7uTbzAUCQWJOpDumBy/S7BmNTtsK1XMs0llZJ4
         jxvbICr4c/sVWbOd0Mlq/52ksWC1eJm0PMDmDS4YFcj8chdPMZXi5l5DPaBxpb8VD36d
         V6qUH/xKkfRMXNhGiTuDt0b+v09f51I8SyQ+oA+v8NegOHpTHU6SIKMGQo/wNQblunex
         DnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326343; x=1780931143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGNrvQu3MsUANR6m8Aw6nTCtzJ6XjXkmgI7B+ElRctQ=;
        b=f08hk5Iby2Qe3702p+LB8YcLVIvw/D2K9h0DIGlY8buMUZRVa0dqfq5RE4CDX7Hcdu
         U3v60SQSkV6fEyPWoAUVECl1RWi4Jxsq9YbuYYidfJQxZ0tYY1xM5E0PUjhFlE4VRz2T
         Vm3eDcQYUTMHK8FlshnVQmaH/TO+/eGZUqNnLw8eCrzWLPIHFEiAjez9x09JkhoN5P94
         papLrfktn+OpWNaNxnLyc/S3MSFwxerXgGkthn+WWAIWT0/b6x6TeKMLqFYbnOWUAcDp
         xljpTqTR0XoowsNydgxF1gWeD4gfKGhxwjZxkJf1NjG69iUS6l1xg31TqdmgThCwdSMA
         QYzQ==
X-Gm-Message-State: AOJu0Yy6Deit971N/2RxBJVtGkltui2GniZIT9GlxFtoSaU69ejg///P
	aEefP8ct5bFtnaX0gpQenUsAgFT9XLq+HP6F29sLrvJ60mrNLKXhS/7HEosNkAYUi1oaKHHLzqU
	SfaiyrA==
X-Gm-Gg: Acq92OFmKmqpCU30gv9n/2yDzIXgvVWzmkrblsWKXSqX+jHxYP24sWu2pCSlKFyDtIo
	XIaIzGj5FJBcFKDHcHAL6PevmxwpsRfwqToorWTJ6IH+yoHuwW9/XkpRJekoALMhZXnzvvVPQ/c
	qc+jbxMYG909rs7CWh8hL/7eFS/AiceVoIgMU7QvUywBJUOap28A15Ki1j+EBzjfmXci9/NnMCM
	fMgorIqBCyCe4TsbgwnNzoU9Sib69T9R4MiZ8PR1xd/lhkDiQw+/POD5pwxATpBQ15vF5NuILsh
	zwHDBWkR+B8Qz4lju8gABzsfe3GV8yv1CjZUsMRDEVbH5yPPHZbtg9T3ELn2EfpGr+2uuotHsMm
	Cnbl/UMIlO7mAKVj3athsh5wk9aWMZkffbSBQJbYz3+iMkjURCBqJwLXYtCO0TE30lqfK8rvgvi
	NW492H4Cw82hH2+uGlScL8BcGm9O59EX4NhN2m46URwyJpM98cGJTC85ux+1uYGiYPO6oSwgw=
X-Received: by 2002:a17:903:388d:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2bf97501295mr7147535ad.10.1780326342401;
        Mon, 01 Jun 2026 08:05:42 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c30646sm104919005ad.68.2026.06.01.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:05:41 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:05:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah2fwcxzdhx8N0FR@google.com>
References: <20260601134204.2150602-6-praan@google.com>
 <20260601150126.3E04E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601150126.3E04E1F00893@smtp.kernel.org>

On Mon, Jun 01, 2026 at 03:01:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The newly added WARN_ON(ret) in pdev_enable_cap_ats() can be spuriously triggered for SR-IOV Virtual Functions (VFs) if the Physical Function (PF) was not properly configured for ATS.
> --
> 
> commit 40ae1c6d486f021eadc253f746299ffa4ca11dff
> Author: Pranjal Shrivastava <praan@google.com>
> 
> iommu/amd: Fail probe on ATS configuration failure
> 
> This commit updates the AMD IOMMU driver to call pci_prepare_ats() during
> device probe, failing the probe if it returns an error. It also adds a
> WARN_ON() in pdev_enable_cap_ats() to catch failures from pci_enable_ats().
> 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 4ef6024c5a4ea..783f53cb85996 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -566,10 +566,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
> >  	if (amd_iommu_iotlb_sup &&
> >  	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
> >  		ret = pci_enable_ats(pdev, PAGE_SHIFT);
> > -		if (!ret) {
> > -			dev_data->ats_enabled = 1;
> > -			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
> > -		}
> > +
> > +		/*
> > +		 * pci_enable_ats() should not fail here because earlier
> > +		 * checks have already verified support & config.
> > +		 */
> > +		if (WARN_ON(ret))
> > +			return ret;
> 
> [Severity: High]
> Can this WARN_ON() trigger spuriously for SR-IOV Virtual Functions (VFs) if
> the Physical Function (PF) was not properly configured for ATS?
> 
> Looking at pci_prepare_ats(), it has a fast-path that returns 0 immediately
> for VFs without checking or configuring the PF's Smallest Translation Unit
> (STU):
> 
> int pci_prepare_ats(struct pci_dev *dev, int ps)
> {
>     ...
>     if (dev->is_virtfn)
>         return 0;
>     ...
> }
> 
> Later, when pdev_enable_cap_ats() calls pci_enable_ats() for the VF, the
> actual validation happens there:
> 
> int pci_enable_ats(struct pci_dev *dev, int ps)
> {
>     ...
>     if (pdev->ats_stu != ps)
>         return -EINVAL;
>     ...
> }
> 
> If the PF failed its IOMMU probe or was explicitly bypassed by the driver,
> its ats_stu would remain 0.
> 
> When VFs are subsequently probed, pci_prepare_ats() would blindly succeed,
> but pci_enable_ats() would fail with -EINVAL, triggering this new WARN_ON().
> 
> Could this lead to unnecessary bug reports or kernel crashes on systems
> configured with panic_on_warn?

No.. this error won't be hit because the path highlighted above is being
changed in the ATS series:

https://lore.kernel.org/all/20260601143644.2358771-3-praan@google.com/

Thanks,
Praan

Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456043F58E0
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566056; cv=none; b=BD4MwM5eUArkTcl6RHsgqp4MCBHmELKCp4e7kvt3YgGLKo4WaDZYVouI83LbhcRPUXaunTbtSMUd+j2NrDZcBe0RR2b8doE8tDC8AmIvu8gVJUK/FwpAo4EyIJU+06CxgRFyerbiutoCFnUSXk0RK65LUb5ETnSE6yR5/k4ks4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566056; c=relaxed/simple;
	bh=tiMiPtTKlfHRwgEibcz8vFhTykbZbs0vaWu8IsiI8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui8/TKlOqpt40CseDxc/8dlMAIVUwMaiaS7gkJ8LcnzjP5OcS/yQJgWW8PudZ/RInU1CFfbcwnIEHecYTemra0DC2W+gfMPTHGUle1g7El0mIZ7PI40AB20JccCC0Kex58u6+Wqsx5nC16lx5Ji3imtCpUu8TaYE9ZzYK/cIaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLOuEEZO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLOuEEZO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso137925ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787566054; x=1788170854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zbz0UezBRokFCxPAADPzNNnQ2q3uFS8kgDI9OKirCA=;
        b=nLOuEEZOI6xN3Fq3Nz6lpm2VhXw8uWs0WUQ7XYhsV/uJBv5gr5uxsM4NZnSlXh1lDN
         W8XjUSkxPh9GoW1D0g3gcqhQOX//xGr+HFuk0aKxHMhZ0wZ3eWX9Ut0JJ566+CDMYm7R
         UxbQyEEZ4eF7SzwDQPcYbFsLqcKdXQPM981glW/SS/g8/tnitwKseB3jFO6+arV6Xz7w
         AMzebyTJ51A27MNOwpCiPQiLvNJK3wtephpmpEQKO2dQdHPAfYqAzrbmM6ZbYw4V9N2M
         IQuJOqtRZ/I0JpBLIeAs3cfFZ9p5aBtW2EH9bfGpwQSN31vlESUYgDogtCKr++FmVB6Y
         mmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566054; x=1788170854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zbz0UezBRokFCxPAADPzNNnQ2q3uFS8kgDI9OKirCA=;
        b=Z+Glo/ryQkvco6Q0GZvMCX+HrUezHzha5SM4hXVjfsdvMgxFCWkUlzY08JcZMg63xN
         4MwuEgihiIjsIHo7zlczfsEJ0I3XejGm030fYySoLD8z4eJ7AM3q28uozQsxvZ6O7vbK
         aYgI3ep915R+/rOFIcDPwkm0gf4Jk5M66WmNTZC6Uqx4HCbtYqZNH0GwDK7Imay3zpt9
         ntRVVBb8Fu2onKbpdBSFPsHJU2yXSPtHwEIj7BmQfEFZ9+ntqkvIU4gmSKOU/NXebgtL
         3HAIw1xVO3OkqRsQb3AQpKvsNrnU+c9AZu44jl3QCpIGMy4KrFYZvM1kcSzWNMzGptHE
         ylow==
X-Forwarded-Encrypted: i=1; AHgh+RomHsdBVl77dsd8ueUglKJSUE9A54Dn/7gAjFV+CcG6oR/vi5voTNAmauDf8K1ndhNI+pVv0ydg7ZM=@vger.kernel.org
X-Gm-Message-State: AFuF++lZx2UCOXDeuLPmgauJje47p+t+XXUG0UTgfWdomyH+L9cShH3D
	26dYTRo2urDH1qCTeySfuYNvY2FptO25zAR2a7M979p8EqJ3GKJuqLJlpRc/huNI0w==
X-Gm-Gg: AR+sD12DX4LtcRdnVSxGI7QqCkMtOYoiIUfDGj97WRoBgGJjIE4QHOWKPrSUxBtBOza
	jAIuww2AiPIjHqS/I0svJZhAxa/EvXnd1WNcPco+xsY1qrLNIf31r47TPsRf6zizz401HG1VrV+
	KJQUOJQxw4qnpZWzF+pcE/tAYrZM/BbxeQ/2hIS5YSRNlNuhP4tMWPRUMmQ8+5ETG884aRT0Ehw
	C1UqEYq7o2kt93HgrRYQjgU5Rtf43Gl0uZyxCGN8Rv821EM3BBPO7N54wwy2zld3BTVlnkKbD6Z
	6MB2AQC+dmtjgSPbvj8B98KR5OgJaEf1OJgNBFtDuYX4Jz7wW8SVndzrvDaNapSJ2AAopyysnXp
	geAXRlFq+QZp6eOMGCnQaC4GRqGPEsVRBGEu9antx2gy4dI5/g4YnVdQdrju9Fu9QSGx4aY/3xz
	ouJvSz4NZLqNXPQ+GJTBwFTx48ka1CGmLyWMYReveRavSkj2WlE5jw7ZvmWM31EyqpDQc4rvLFQ
	vnGSaJtP2WxrtMsJ0VJ319mwg==
X-Received: by 2002:a17:902:ced1:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d673bdc43fmr8073435ad.11.1787566053791;
        Mon, 24 Aug 2026 03:07:33 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b065sm1758681b3a.32.2026.08.24.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:07:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:07:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <aowX3yLlstXoCfKa@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-2-praan@google.com>
 <ecb70415-05c9-40bd-8ddb-173267a7a30d@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb70415-05c9-40bd-8ddb-173267a7a30d@amd.com>

On Sat, Aug 22, 2026 at 06:34:42PM +0530, Vasant Hegde wrote:
> Pranjal,
> 
> 
> On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> > Restructure the device probe path to improve readability and prepare for
> > cleaner error handling. Refactor check_device() into iommu_lookup_device
> > to explicitly validate and return the amd_iommu ptr & devid. Refactor
> > iommu_init_device() to return the allocated dev_data. Consolidate all
> > PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> > iommu_init_device_caps().
> > 
> > Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 114 +++++++++++++++++++-------------------
> >  1 file changed, 56 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 4c31294fabc5..9b8ad131ba79 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> 
> 
> .../...
> 
> > -	amd_iommu_set_pci_msi_domain(dev, iommu);
> > +	iommu_init_device_caps(dev_data, dev, iommu);
> >  	iommu_dev = &iommu->iommu;
> >  
> > -	/*
> > -	 * If IOMMU and device supports PASID then it will contain max
> > -	 * supported PASIDs, else it will be zero.
> > -	 */
> > -	dev_data = dev_iommu_priv_get(dev);
> > -	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
> > -	    pdev_pasid_supported(dev_data)) {
> > -		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
> > -					     pci_max_pasids(to_pci_dev(dev)));
> > -	}
> > -
> 
> Can you add something like below comment so that we know why we are not calling
> iommu_ignore_device in error path.

Ack, I'll add a comment about this.

> 
> +        * When DMA translation is unavailable return error so the iommu core
> +        * won't attempt domain attach for this device. But interrupt-remap
> +        * is still supported. Hence do not ignore the device.
> 
> -Vasant
> 

Thanks,
Praan

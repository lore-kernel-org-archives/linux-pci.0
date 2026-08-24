Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41F3ED3BA
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566153; cv=none; b=Rs1D6Yh24w+bcn/xO4Eu5nMOuiEIEdeL8GWgBlPOVa3US07Q46XcDHVSO5WRFB4woivptqxQ1ACEKdhGIH/LzLOdyEehz4F8u1Z3jpX6/tQwW5peJp8r+DAOPfJydOCQHm9EmWo0woivuRiOsyREpgAHznOYfHhoVMf5WWkNhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566153; c=relaxed/simple;
	bh=jZ3eIBAHAm6NC6JweAvN1qywHq5vfH1TyeQwkHsYg8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH+B79hTfwKE3vNl/QiIZJu0g/pkaifHxD/ZVk11Jn+5Lg1p9pJ0ctkqxFmDDUh+x3l9HRJn8pe8i1vr4cIb9x+HtGq2zWtBBYJgR9HU5hfPXO8Z7l1GeQ30Or7I0LVrz8oEuG3MH1p1AadT68y/zIFedR3kct5XTX2lcODQQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/kgV8+l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/kgV8+l"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccdf36f63dso138045ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787566150; x=1788170950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gfNd3h+FFiDmANrEuut7wHc99xGFyUDuhgOjn5RQ48=;
        b=c/kgV8+lBoclnWZ6Aly3jWofSyg1+ECQPz+N9U6Hv6ZtK3psvS44VU+iU/8Y90HIgV
         6iQ3gcMaftqzaNX8oKmZ3qkopukzMUG/44ph7a/PL56Xi4yfUV47Q05RHjexEtg0g36u
         UyMNo1EYDSUVJWkK2frSsvvofSmZGs2CDcxy+voLLjxRwqeKSIbkpYyKNg4tIWBs4zo4
         06jE4HqDghlIwFGHz2UHo0lBkNTXaKpndAG98KqYi15h26hwdd1mM1baDBLrWUT3H3G4
         LRIvm/LAieN2imvaILlHl7HtGgwiMr3QWfP/gWaGU3FkZN82/P3iw+ZONx/KfE7Aj5pC
         n8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566150; x=1788170950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gfNd3h+FFiDmANrEuut7wHc99xGFyUDuhgOjn5RQ48=;
        b=WtHCCnHSUcoVOunCN3v1yGW9IAw+2Pmwu6JFT5IMy9Zv0JwXY94y9ExguIg8Uoy+f+
         G9RBUgs61nnaU4L3Ts8P11PRBw1DLeM10y4A934puTNQx+D9OtoVUiZhCAyKFIzEfiJ7
         x3N3tBkQWuK5iSL9xJLEIrnjMM93OQws1ebUNwXPM+9cuC9bQKGIWHuTqA4FyK+8T9vZ
         tlno0ZgN+B+j51hqAGtEkYsFXyKeirIPYdFZgIMsulDFX83UduUUqXjZAZ6om2gn/bWg
         YpinDu1vODRLK5kwG8eLqKsgVteX+Ah5u6WDf6CxMW3wLUA1lMiae8/INZfpV6Hyons9
         8vig==
X-Forwarded-Encrypted: i=1; AHgh+RqW2MqyMheGwj/xcZHws7lrLWefrVbkXOhjmnpYZsQ5XZrg+5B1z7RfRtAujI5JVtzQ+myfXzDSvKA=@vger.kernel.org
X-Gm-Message-State: AFuF++lMe/WZr5xwreMt6+8FZyDbK6RpJYAw9N56UkPqwCgOJTm56AZu
	9uagSozjLjHKS/PTgIj7YHrvywa5M17GcTbYLKYjhIde53s9noxygSxdWLkRP0GyKw==
X-Gm-Gg: AR+sD11osaW1WchdMVouoZM/YzVc6HMvQSwrZ3Bvv5wfhbjrc3zer1r5o+OHN5q9k1H
	sNJ/rVTQWxobjw7RCe6lLO8nFqPnBTC/AXeCEUlDEWwb4Oliw5UXONKP1+35d8EVKLmvwEkyTEv
	ZZ0DovuzVNoGClWRmEtUGenpFvIpPo1HAhLmyz9m+ZtMMtesXqPo2bwLcbf8KeAdSBCDXbtFQes
	izKXCucX24dEaKH2D1vNRnDTa0MG7FSaZHgXjz4n8mxPIXK/6mugQvzq5jLYqxh7PkFy6sG1V/e
	SvvY+26rakndfhiO4kM7XGmN/mE2/gjeMkjstNfWek2Tkk7gZBilH1h+b/l/7E71DLAkY2iY1gJ
	kgBZm98Rb2fWt6zsoKfqrXX417GW9FDg48wSEMpjO6sHDBHZols9mD165hn5O3AssmmQ2mQiD/m
	2gLlu6nCdpVnlj6mdPzFTrPE99YHuQbHsL5j4Ijfwfufj+zLR3edad9q9DJshpno/RkvkceR/xq
	OkzY508h2qOpJYTJ7cKhfHGIsr9Xs72o1NO
X-Received: by 2002:a17:903:2acd:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2d66fffe95fmr8900965ad.18.1787566149624;
        Mon, 24 Aug 2026 03:09:09 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm9398937a91.13.2026.08.24.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:09:09 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:09:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aowYPxhzGKMLIU10@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-3-praan@google.com>
 <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com>

On Sat, Aug 22, 2026 at 07:28:20PM +0530, Vasant Hegde wrote:
> 
>

[...]

> >  
> > -static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
> > -{
> > -	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> > -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> > -	int devid, sbdf;
> > -
> > -	sbdf = get_device_sbdf_id(dev);
> > -	if (sbdf < 0)
> > -		return;
> > -
> > -	devid = PCI_SBDF_TO_DEVID(sbdf);
> > -	pci_seg->rlookup_table[devid] = NULL;
> > -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > -
> > -	setup_aliases(iommu, dev);
> > -}
> >  
> >  
> >  /****************************************************************************
> > @@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
> >  		clear_dte_entry(iommu, dev_data);
> >  }
> >  
> > +/*
> > + * Invalidate a DTE by clearing the Valid bit first.
> > + * Note: Not to be used on a fully probed device with
> > + * live dev_data.
> > + */
> > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > +{
> > +	struct dev_table_entry new = {};
> > +
> > +	write_dte_lower128(ptr, &new);
> > +	write_dte_upper128(ptr, &new);
> > +}
> > +
> > +static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)
> 
> This will disable interrupt remapping support as well. May be we should rename
> this function.
> 

Ack, Sure. How about iommu_disable_device() ? 

> Otherwise patch looks good.
> 

Thanks,
Praan

Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041D3A4F26
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038535; cv=none; b=PTuJiK4sCP3RvYVDquRTHB2IUhQ/kh+Pek+Jc2BKkHiNFkv1ZhokrxkaFI/g93ooFb+3I9jHam3Nmy9/NloNSBOX8+KUtvBW4k69m7i3jkciikwzOBi0wolq0lzxbelJ2XCx76fv8XZXEogDrVx+boTy39Lza4yDu0i2JN6dLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038535; c=relaxed/simple;
	bh=3YRPDdkBYwuR8SskEPhXZydnjWk8w+KTKFKsHSALymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1A2pJM2jMdeQM30PZW87eXwAAJnzUQutSBfqNjywdbSY5s747ksbBC2XIwfn8eRfuCWKkcAKn/C5wtswzsHetIDY9HU4uW7d9P+yiO0IasbBXA6S/Gn/kFKcrmQQne7VOXGaaI7Tymfoqt39hqh0bZugJHqjJl6aBdPHn2t0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSyZHGVi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSyZHGVi"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf22c18ad3so1265ad.0
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038533; x=1780643333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6kkGTm8aDOuEQx+9gLd0hWMQBKtucSi5H8ZVEqct2s=;
        b=TSyZHGViJhjm82HcUNwWF5WyJj2jfysOqm4wfNPfzQW+26oV//yP6gmoYccdwUR69/
         WLrHbVttKmpZZeD3shsbNY9ZZhliYc0nhTpEdJl4Lu4JyvG3IrTDDctI7MaGXk3/Ur5K
         PNEIgV0LmB2wSe7cVROxAurD/DifEHD2SFKpOOCYXyLzqyqj15T3F/CfAeDQmzUOhhOh
         K1EAEeT4GDeeQI2/vNgp8XGUE+wx/vJQHSa1DxvYD1Fi8WRA4e4cUbOCPe6t75CRKr14
         1Xgm4cNnFHjt7ORwBX6KSQxKry3HP1ixAlCKUDfjVMyZKHkT/DxyORY65iX/cGDi6UsC
         1XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038533; x=1780643333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6kkGTm8aDOuEQx+9gLd0hWMQBKtucSi5H8ZVEqct2s=;
        b=P/29fy2qhg2OoKzwmZR7OreYmNm9lFka8TVXeZRZ0YoQfE8IxtEdqUM1gfqw+ecNxz
         xu9Cx4s77uwdSbPEv19OwVDD0dadC1yjAvNY64PRqffjB39yovhby2hBfRy3AgzRDduz
         oo1xCulUxMZi9xAdvLRwfTsdROBWHIaIFiDicrPYoRaqlQbwug9gaDjSXL/J0++u8J5L
         gcOqmDPfLGTfMpLAh328/Xm8pz3h/czOWRlQoKs8YjfkC5/5BhJjdEWp6IXg4fOltxHn
         9csb5RG400O/lcxLTstkZelMrUrAMPHlhl//xXOE++Us+gkwTDvM/YHEiN1RPZorSn60
         IidA==
X-Forwarded-Encrypted: i=1; AFNElJ/JorUnXZeNdZwmg9ML5WWuIASGMm56G7pmpRcFFwMRLQom9oauCbo8qyud/Dk5ceEre9kg4yCUMEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Lp4YYHxpqkJz5UnfSaCkEgcOufP6dAAFbQTthTyWxLBuobmp
	xrUB7E1fka8LLPLSl2551pG3gQL/Esd8BL/nG7Zv8jVhKatmAKM8ejOVynOJNijPVw==
X-Gm-Gg: Acq92OFTYZv09BWUY1DQOX/S7wqCCTxBFecLxHQlvokw8f9xrB+vpxyxmuiloCKZqeq
	hTytBvfGCOkDm/wK/frE+StzZq1pm5L7BNNCDGs0UTsdYyYArqzwtohSbTErzH41lj1F+I4S910
	U+YLh9AOkmo58K0x5b/q9qemleZwr7550m6yRM92T8gjmWeYfBgSDpLlWedT7yR0vA5d+1cqLtl
	8oWAn0hn0BybvAMt8NJokGZxeNNIGhOxnKHrg8LCWtS6pw9DgqXy5Hc4vQ/BWEvRK+oBoFfaBBa
	z6klJWPkNZ6m4B9bBniluR20VaTKymV5PTUfaV8rnVqYEeYwjXvQ0zUBaYprNxcH1kCCbrW+qgT
	P09gJEGlWU59gMNKnpzcDDoyzXcv+nvxj7Px/zWzVuSwAn12218y2OTlNI8ATbfoJ9PtLOHNKOs
	4N29WpEBaNGNg906g29sZRdjY5Rq0UCjGJQvXwa0GEGGnW24abrardwJzwZAvGrJduM3DD
X-Received: by 2002:a17:903:1a2f:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bf22ee7642mr1033685ad.17.1780038532683;
        Fri, 29 May 2026 00:08:52 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b67b8asm814623b3a.25.2026.05.29.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:08:52 -0700 (PDT)
Date: Fri, 29 May 2026 07:08:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v5 3/7] PCI/ATS: Decouple pci_ats_supported() from
 pci_prepare_ats()
Message-ID: <ahk7eomIcbZTkEAu@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-4-praan@google.com>
 <2693467a-eb86-4cb9-9161-db6042b0335d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2693467a-eb86-4cb9-9161-db6042b0335d@linux.intel.com>

On Fri, May 29, 2026 at 02:29:16PM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> > returns -EINVAL if the device does not support ATS. While this provides
> > a safety check, it conflates support detection with configuration.
> > 
> > Update pci_prepare_ats() to remove the internal support check. This
> > decouples support verification from the configuration phase, ensuring
> > that drivers can distinguish between a device that does not support ATS
> > and one that has a true configuration error (e.g. STU mismatch).
> > 
> > Update the function documentation to mandate that callers must verify
> > ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/pci/ats.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index 8057c24b0469..92c2a6bc2dcc 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
> >    * @ps: the IOMMU page shift
> >    *
> >    * This must be done by the IOMMU driver on the PF before any VFs are created to
> > - * ensure that the VF can have ATS enabled.
> > + * ensure that the VF can have ATS enabled. Callers must verify that ATS is
> > + * supported by the device (e.g. via pci_ats_supported()) before calling this
> > + * function.
> >    *
> >    * Returns 0 on success, or negative on failure.
> >    */
> > @@ -64,9 +66,6 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> >   {
> >   	u16 ctrl;
> > -	if (!pci_ats_supported(dev))
> > -		return -EINVAL;
> > -
> >   	if (WARN_ON(dev->ats_enabled))
> >   		return -EBUSY;
> 
> I am not sure that the removal above ensures that 'drivers can
> distinguish between a device that does not support ATS and one that has
> a true configuration error (e.g., STU mismatch)', especially considering
> that this helper already has a return value that explicitly conveys the
> failure reason.
> 
> Furthermore, if a caller misuses this API by calling it against a non-
> ATS device,

Ack. The idea was that all callers will check pci_ats_supported() before
calling pci_prepare_ats() but I guess I didn't consider callers abusing 
this for non-ATS cases.

> 
>         ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> 
> This causes the driver to attempt a write to an invalid or non-existent
> PCI configuration space address. Instead of removing the check from the
> function entirely, how about adding a WARN_ON() around it?
> 
> 	if (WARN_ON(!pci_ats_supported(dev)))
> 		return -EINVAL;

Ack. That makes sense. I'll post another version!

Thanks,
Praan

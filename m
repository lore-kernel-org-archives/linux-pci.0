Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9823F660B
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653558; cv=none; b=K/UemXMJ+pGSFrHRxgDYkBvRFk25oh9oRF9OF+kO4dqyM2XvLKhItTa70p33FISRhSlDY6SNsOBmkB3I4VGQiJSKgzhmryJDeqtU90xvMBkcQwo0Ry/3Aea2oTxD21UuOiS7l59Os0W3i3iDERlWHfI2oWVWOPJHtpu0wWF3pWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653558; c=relaxed/simple;
	bh=us+W/l34bjTqb6E5LUJYAddeXA9sIpUgX+mtnAqikO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaXJ5RyPsDgd8r9f0TuG8queocA8Ip3XSCNrMXKQ/6gkMMGGs9mS+EmuLW8MsBtpSm69gHttxFo7Y5n13cXww6VvcHmX/lTyNs0OFm38FOxke1ZAM8QnTLtbmfw2bPyRggcJhePWnktmQqO2vpVDDN2adX6dTSGxB46Vy/+b3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZeLN1ZXq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeLN1ZXq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso101035ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653556; x=1788258356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E0guju7I7mkEmUSt1DIdoTBJV8Ed/bpyGw6FfhSmD8Y=;
        b=ZeLN1ZXqZ+Stei7HHH8dI1Lo5/wACGdXeI7y0Nnn+Qe4vs0K7n+397s7Z7CPNWFJaY
         ztZvpz2vDS0/i1enuPU9e+l1yQspy1xiwg4nIlG5n7+w6Rl2j9LupOckslRzXe/IzwRt
         zHg4/feRy1QryypUiiFo+8II6ae9oe+fWD3ed9ZvGtU2M7N/lK3iMP8hA94741bZgiY6
         R9RDW4xzgWDmbi2BMb3H7pJ041TAmDUUdYEOUZnMVgwFcsR2AMjJnVMsVfqYgfkB/ukO
         eXv7nf+E9G/oOnQBUselY2aFpIVHw5Ky0D4I00Kc6AUHk3HDWyZPP2yeRR6xCz4Rsbqb
         3uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653556; x=1788258356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0guju7I7mkEmUSt1DIdoTBJV8Ed/bpyGw6FfhSmD8Y=;
        b=ZSJJtfCHm6NqMc3iFghXQQLGCMTJ6eUoKfvQ9pc/jFXg26VDtERiw76E+fRxCDkM/s
         w7aCZeWjijWiFK6HUuXpjg5i1f6nnZpos1lOkMfuvXRZN9ozGZGbEUK3c+rEENL0Rrkw
         tQtYHusa8em+brxHv7xbdPoprtIpn3k6xZdWD8oVpJx5/DYU+F1Lst2dTOTFcLOmuDGJ
         Ul2SvBDXViythEMZc+TQXHDhAJ8dJmpmcbq5vN+JICOMMTiR+Mn9rkNcQ455Z21al7jU
         usrXKwD5AiK5UO0yk+UdM5n+8NpRvmyPBwXMvJJhr70j/9Iten5SezpFSI7V9Z6VlNkQ
         nEEA==
X-Forwarded-Encrypted: i=1; AHgh+RoI0i78Mi7U6MaebqznJwmZZCsy/7Tn799u/CsnC/x2Y7sRwEma/pDilu4+2Won8RVWopXUpVN/8jE=@vger.kernel.org
X-Gm-Message-State: AFuF++lHnzjXTcbQN6+JtXVKE6qoJvIjX2YJNXSsVpYpCfLSksxLN5X2
	ZBlXMOzJasNY+Ky0VftE6LLLbKKSlYPMEzxOoJpdrZ7VFwqMxnmq2JYvg3kKdL9xhw==
X-Gm-Gg: AR+sD13fNSOGJeqM0JuiM+4iRefxV2X2z7Xds/z5wxARQbYSbNbFdVuKcHBC8wYU4ki
	ifC1iWRuRSCC67KBOgNaRhFM9hKPhKGumzmUR8lQAeKc4U/AKP9bDwvW61XJihbSM4oIa8Sc+er
	SbRaDDKxU0PqahtsnhG73rDrcVdDsxn9qOBpBXquXJGoGgDbc93WLqC7UyzRitfapnnAx3wnbnk
	w9BDe5VdH6HVXxTtlPE/RG5Tb6Hl6vg6mgYng/eg0FhQP53nuQ3tg/yNmFaheTja3fHhpa05OWM
	QmF24w6nfbNJPPKqg3vy5WF5KZBDGKj+DI7/k/zmlt9d1kL7JrQIJ4ANOnf83yUXGAts4Q0gBVP
	WU114cwxHUVXnfB64es4sbQ5WpVqRq8h73iEdNiQ1JdT7v/g5Ng9tUgCsx0Ay+g8eQTXDKm5SWM
	yxxEtD3S+btZocaVxP1HbwkIAQN0fXNbOPRgNGNxmr1cRyUbu4VBInk2VJFziKDMIrF4ihfYGFM
	6IEhKePF8v95gOdvW40Qu6ddA==
X-Received: by 2002:a17:902:f705:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2d6e05187ecmr6241535ad.6.1787653555477;
        Tue, 25 Aug 2026 03:25:55 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b243sm2791227b3a.31.2026.08.25.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:25:54 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:25:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <ao1trSkUzlko5E1T@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
 <a3279e43-5875-4165-8754-022a6cb2fb54@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3279e43-5875-4165-8754-022a6cb2fb54@amd.com>

On Tue, Aug 25, 2026 at 12:29:35PM +0530, Vasant Hegde wrote:
> 
> 
> On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> > Restructure the device probe path to improve readability and prepare for
> > cleaner error handling. Refactor check_device() into iommu_lookup_device
> > to explicitly validate and return the amd_iommu ptr & devid. Refactor
> > iommu_init_device() to return the allocated dev_data. Consolidate all
> > PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> > iommu_init_device_caps().
> > 
> > Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> One minor nit. Otherwise patch looks good.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> 
> 
> > ---
> >  drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++-------------------
> >  1 file changed, 60 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 4c31294fabc5..e1f9fbb63837 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> 
> 
> .../...
> 
> >  static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  {
> >  	struct iommu_device *iommu_dev;
> >  	struct amd_iommu *iommu;
> >  	struct iommu_dev_data *dev_data;
> >  	int ret;
> > +	u16 devid;
> >  
> > -	if (!check_device(dev))
> > -		return ERR_PTR(-ENODEV);
> > -
> > -	iommu = rlookup_amd_iommu(dev);
> > -	if (!iommu)
> > -		return ERR_PTR(-ENODEV);
> > -
> > -	/* Not registered yet? */
> > -	if (!iommu->iommu.ops)
> > +	if (!iommu_lookup_device(dev, &iommu, &devid))
> >  		return ERR_PTR(-ENODEV);
> >  
> >  	if (dev_iommu_priv_get(dev))
> >  		return &iommu->iommu;
> >  
> > -	ret = iommu_init_device(iommu, dev);
> > -	if (ret) {
> > +	dev_data = iommu_init_device(iommu, dev, devid);
> > +	if (IS_ERR(dev_data)) {
> > +		ret = PTR_ERR(dev_data);
> 
> Instead of this, you can change below iommu_Dev assignment directly.

Ack, I'll change iommu_dev assignment directly.

> 
> -Vasant
> 
> >  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
> >  		iommu_dev = ERR_PTR(ret);
> >  		iommu_ignore_device(iommu, dev);
> >  		goto out_err;
> >  	}
> >  

Thanks,
Praan

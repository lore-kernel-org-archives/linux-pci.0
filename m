Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190762D23BC
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741029; cv=none; b=mOyQS6wILIBN35o77AAklaU+9lYP8exqp3FP3X/ciBCXxUSkxM+2Sr60l+p/Q6o7hpVqBqobJx3vVz+nzwxeH1alnUgRiTS6BPfbVLwdtG5b0hc7Zta1BrBlOc3GQP/INRN8sySTBs4+CpR/h+qJ5A99L+U/10l6n2Dy/WzK6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741029; c=relaxed/simple;
	bh=fb1sV8f7GTFbilAJDWZVAHBiDupn0F6kRbrmdEB9hdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6scNpc0au5g9WczojpXgeB8yEiMkBg0JoKaEvOSjTOOODOfD9gGrGSK2hFIk9CeB/m/ZxVuZ9soQmWHMz5pXThMXUnNEDScBcdN18Hxr5ICTijRdYQvvDmkU2IHvEvFhco8pbxMPoU88+WG7IGlVVLYfGrO1x6kERMG+U56SRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPcx2Gs3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPcx2Gs3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba180a022dso35ad.1
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779741027; x=1780345827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhZgy3CvZVYPvW9umuB7DRocYTW3QJrl2ACJkt8tw8=;
        b=YPcx2Gs3jbxVj+EAtCphW4Qe8iHUZcoKj021a/NCNWc2GaeKBunnwZEq4xsgb/GnUH
         oDh/4+KuujIZyWjDqXeAKMyC/1txguRBZ78BdHpUuLNcesalUXNHjd76wos/DOEMuUDi
         nkVi/h6GyfbljNlIeUXj77ifYzMfXzrHutpbbWD6qzlyePaftRuwMoLmQjYeqilOqODk
         xrxta7QEUVgcViiQxSlRpPgNsxobtvM4H2ycbX0LiO9LzZKHBgN4SaWKpcGI8RtUzz/Q
         puu9faXAPVPBFZvTNmaGz0cT7eSegypfJY3CPaatR0/RH5f3F0vGPZ936zLRPAE2PJHc
         0nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779741027; x=1780345827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWhZgy3CvZVYPvW9umuB7DRocYTW3QJrl2ACJkt8tw8=;
        b=Nuu+uzoFof3bQS1hrMsjLDKWVI1WcEsR7tw2v3NVvGtswOHP4t35AOlpF/oRaesnpm
         vc3ys0ece2bDfl6VUJb/PHY0w52laiCStZ1hxnJJ7X5/N5ivSuxtE0EHipDwj47LXIKi
         iloepQU7NdCzVepjBZsyNseRrQcl2fsJN+rJ/hUvEgbhk46mj3YHqPtsht3wTVgIuKUW
         nNCWvL8XVVYOSP5wvPTokLGGR5jm4jayIOleiTZoF2+PHMmpeyfaSTIu2sz3wJMSDC+O
         q+pPxa85OhwIVT24BYYvM8qWqjhW0lhX7jydHMjOcnvdvruxdpAHVs1Bk0RO37N8XBPp
         V9QA==
X-Forwarded-Encrypted: i=1; AFNElJ88vkWvfb59tD5GT5S0T0UAXfODEFHRN4e2ZvaXdPyh5sILwWTGX8syjHtPC3t6Ls+ZpapEv2GWmpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kzQ4C/9DbOcOCxQJ34ao+VYvPqYHcZGav6MsybYdVgG3OfLe
	LvGxH59IznmFZEjKVi4J7NUueOwQRCssXgEU/eMqpT5Xhycm4RD3Ypv6YfK/Ehtwyw==
X-Gm-Gg: Acq92OFQTAz1ZBgZs24i2XUpv5h1v5LCkFW51SZh780wAPqUrc7BgxrSqk39QLzZeI2
	Xmo3z5ryLMZYYVJSH4S0wQbmc/dkdC/WM2z6+HvcfWei1bl0fZ1GihwTiuAHR94/WaVhXvjolrJ
	PvT/CSCQgON5IpnbG6y5/HnIl1yHwxHlr85pmRtijPT54EAXhfBASPBvODMYeuUIXtwGuE8B1SH
	G1NfWkvq6VYiJOuVE2e4i0h8crMtp9m3d8ISxUcFBwC8FdJxYierpLOzsta9aRcxZAw4n8Tlyyi
	Ss9VSytn2brWAxB8T27mrtW39PKfunR7J6GXqBtyHDGpVhohFeJmyLQNysR0yNnPHQ3JjJJ6PY9
	oyRG5Jjg/vONcKu0Tg5mwwlEzanlAv9XQa12/C/9CmGC3XJxScKaTZMljYTq2sDEYtGnWwyljM+
	7DnJW87kjgXVBRu85OQrG7eGvwoSKZ+8lZpQRI5vutoT7SlXGQRsofyAZKVkqXniUjzL6R
X-Received: by 2002:a17:903:1aeb:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bec11c2cc4mr3609585ad.17.1779741026873;
        Mon, 25 May 2026 13:30:26 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36adc0a6e94sm4597808a91.4.2026.05.25.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:30:26 -0700 (PDT)
Date: Mon, 25 May 2026 20:30:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
Message-ID: <ahSxWoWd5hFvKE_R@google.com>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-4-praan@google.com>
 <ahSrkOv+4QZWrcJq@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahSrkOv+4QZWrcJq@Asurada-Nvidia>

On Mon, May 25, 2026 at 01:05:36PM -0700, Nicolin Chen wrote:
> On Mon, May 25, 2026 at 06:43:45PM +0000, Pranjal Shrivastava wrote:
> > @@ -3065,8 +3065,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> >  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> >  	 */
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> > +
> > +	/*
> > +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> > +	 * and pci_prepare_ats() have already verified the hardware capability
> > +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> 
> Nits:
>  - WARN usually indicates a kernel bug already.
>  - pci_prepare_ats() covers pci_ats_supported().

Ack. For the pci_ats_supported.. since we're failing probe if
pci_prepare_ats() fails, the idea was to call prepare only if ATS was
supported [1] i.e. not penalise non-ATS callers of pci_prepare_ats. But
I agree.. maybe a better way would be to factor our pci_ats_supported().

> 
> 	/*
> 	 * As pci_prepare_ats() have already verified the hardware capability
> 	 * and programmed the STE, pci_enable_ats() should not fail here.
> 	 */
> 
> > @@ -4264,9 +4270,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >  		master->stall_enabled = true;
> >  
> >  	if (dev_is_pci(dev)) {
> > -		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> >  
> > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > +		if (pci_ats_supported(pdev)) {
> > +			unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > +			int ret;
> > +
> > +			ret = pci_prepare_ats(pdev, stu);
> > +			if (ret)
> > +				return ERR_PTR(ret);
> > +		}
> 
> Again, pci_prepare_ats() covers pci_ats_supported(). So, the check
> is redundant. Instead, it should check arm_smmu_ats_supported().
> 

Ack, I'll add a check with arm_smmu_ats_supported

> By the way, this would conflict into my series:
> https://lore.kernel.org/linux-iommu/18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com/
> 
> It would be nicer to have an arm_smmu_master_prepare_ats() so that
> both series would have a common ground; mine would be just adding
> some additional lines if your series goes in first.

Ahh yes, I was thinking about the conflict to (I'm yet to review the
series though). That makes sense, we could add 
arm_smmu_master_prepare_ats() for clarity

Thanks,
Praan

[1] https://lore.kernel.org/all/20260519145947.GK7702@ziepe.ca/

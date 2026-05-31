Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115235C180
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247618; cv=none; b=LiYkDAfKfZAWJM9+KReSpmwc+h/8xPcPKUu/bpJOI9ITgAjIfLZUlHIT0p1g72rNSg9lbdwngVIINJbGy0QlCrLtbIPaPAvzpzYMd8Ikmd9XT0mCE7s55K1T2mBy4TQpIIcrDCExO9YH3MKj7k8VoFPYkWCECHyVIt+z1ZOCmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247618; c=relaxed/simple;
	bh=7FI94Dq1nh1tq5EHXeCQHA7vvcz73nqzDPko5g+75sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSfEPKr3QEzG4iqEzzUJq+fa8Xil9MaL2THsMd+tJqAeibzIrxiKyRcDoWHi0UXyG3RYQmrxWtYbYVnF18g0udxOGTnIBbyR0PrC8EJ+G6Tz5UcM4ku7uC4XZlprqTTD2Kfu4MKmkk3BV2EmBUhR+HHqfeCQQ+3eRh2Bv1SGEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYct0lUw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYct0lUw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2d865383so85ad.1
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780247617; x=1780852417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtFz/hC3O8enmBfuHY94wDqD/sImgOOHpNXD3ZxO5m0=;
        b=BYct0lUw6HRol+VsG9VHV7ef/EEyGruMrFyTNFs9abSDHP24ZjrTsDAO5p8Y1jrMEF
         sSTXrtDsgpjADsZ6twhvCFZD9eggHbv1dAtAprUGUzdH141Cw3dcBdDIEd3IyZepRsvB
         zZe4qHubVIkU3GhYJUNTx3S2PQYnadtPsQ0R33jNUsjthTQluLXIK+1EZOFLVh2QSUg6
         yl7ji6lqKQGs41UdlN8oIjh/tY7+z3cFAgnVPhXIzDkM4gGvWITormaSIyKVgMLOa0mn
         oe/H3MnptLkh3ZMug5E+8IOFs3R9wQnB3Gr2DTZBeie+35CmCBL+teLE5WzhPt1bXdpr
         32tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247617; x=1780852417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtFz/hC3O8enmBfuHY94wDqD/sImgOOHpNXD3ZxO5m0=;
        b=DaVQJDrUCiH3e1iKaanJQYBut2XMbZwoI2KY9unOxtGYXrasq+r3mp5y1s0OXSd9j6
         E6xMALNJdq4iRGH2PtDo4Spb2VSMRYygXSIRGlXn6274NKyKjf14gQZr7HWcmZZvUD6O
         1+kwvOZhJoYra3TNfO5XnFHLcq3HOVSw1QySdZTpeAOjaBUZH0F6ELkV2sGg3PxqJSQF
         5SAHPUbACHIiHx8MHRb0U+x7UoMeLgpszHxRil1f93Irk/EWCHb3dvge7dIyLOZAVgcm
         8Zo8L0nfmLgLHTa8P1sIhC1ERA2zR7Rt6DsLDNvbng7YaQRVGETzpTj5surdIRf7I8bM
         Q62A==
X-Forwarded-Encrypted: i=1; AFNElJ8N3+XpAUuEj4WvIpGR4TJ9rTUoWEHY4YdLTX2gZyIQfh9kSU8h/9ktWm14Y/nk5yrCvrlcfYiWY90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtVSXPyTlaQnaFa0WenIEAMOxn5Ioxn9G3FtuOPDvU1RrP0j7
	7Je/bAg78zf2WEtuO3mrqh35yIr9EKjaibFPqpRqJlaGZgRmg/Nl6+nNhgkgr5RIjw==
X-Gm-Gg: Acq92OHw3LJgQsi6YXFOon+H/XYXLC7/wRYxsLSlhz3y46rF/c2bO3vXik4dgBYsUvh
	dKdm1K8/qvO4RCkac3sPRzZkq8KoTzohnDsaToILByy6HCjxKwptQuKCPcVglWCNli8eE7V7sOt
	IuRr0usRjhjpzm1Ctvgh/mz8AOFq8OXbI3+jOUSbvuYmY3ZXSDJrYcrJNKzie5N6gDTCbVxKm4C
	lmzCLSESLf0F9Tb5+MykrqbrfzFtjw5egGLIFeH74IAFJPCg2skCYDAQLV87l5PP8CuLke9+g1I
	io9oVK6r6GBTdnZsFIRsIIcbmY+t6yEFO+EuSizet2JGn4LlsUwLrjVb9Z8bqLJ+xAFeheVrUmn
	dBuSMpHjiqammVLQE8/0d2xiyeUcuDclhOJXBfR9EGjV4syGCFA8fPBoTenXZm/2qzlkB9VeWaw
	0G2WnhXE17mGfNo8uKEgsFDW4vT4iaH93/skx1uI55EjMHAGuu0GPNH8MeXXueh71Ple8SF4c=
X-Received: by 2002:a17:903:41c6:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2c07cb6c77dmr2512555ad.21.1780247616106;
        Sun, 31 May 2026 10:13:36 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01727sm84542255ad.53.2026.05.31.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:13:35 -0700 (PDT)
Date: Sun, 31 May 2026 17:13:28 +0000
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
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ahxsODjvubhUjJjG@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-5-praan@google.com>
 <ahoKeEmFhU8nWV3P@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoKeEmFhU8nWV3P@Asurada-Nvidia>

On Fri, May 29, 2026 at 02:51:52PM -0700, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 11:12:06AM +0000, Pranjal Shrivastava wrote:
> > The SMMUv3 driver currently has a two-phase commit in its ATS enablement
> > flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
> > enabled using arm_smmu_ats_supported() and accordingly increments
> > nr_ats_masters and merges ATS invalidations into the domain's invs array.
> > 
> > However, the actual hardware enablement via pci_enable_ats() happens
> > later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
> > the SMMU driver's ATS state tracking remains polluted, i.e., the driver
> > tracks ATS as enabled on a master that is not actually using it. This
> > leads to an incorrect nr_ats_masters and triggers a warning in the PCI
> > core during detach:
> > 
> >  1 [  127.925080] ------------[ cut here ]------------
> >  2 [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8
> >  3 ...
> >  4 [  128.068169] Call trace:
> >  5 [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
> >  6 [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
> >  7 [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
> > 
> > The issue was exposed under heavy load when running a VFIO-based DMA
> > map stress test (iova_stress).
> > 
> > Following the addition of the arm_smmu_master_prepare_ats() [1] helper during
> > device probe, failable ATS configuration (STU setup) is now handled early
> > during probe. This ensures that any master reaching the attach phase is
> > guaranteed to have a valid ATS configuration.
> > 
> > Update arm_smmu_enable_ats() to use the WARN() macro for any
> > subsequent enablement failures during the commit phase. Since probe
> > checks now preclude software configuration errors, any failure here is
> > considered a kernel bug.
> 
> The commit message feels like mixing a stale background and the
> real requirement (based on the latest code line). Could that DMA
> map stress test still trigger the WARN_ON in pci_disable_ats(),
> after having arm_smmu_master_prepare_ats()?
> 
> It'd be nicer if the writing can be simplified a bit.

Ack. I'll re-word and remove stale context.

> 
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> > +
> > +	/*
> > +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> > +	 * and pci_prepare_ats() have already verified the hardware capability
> > +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> > +	 */
> 
> The patch that removes pci_ats_supported() from pci_prepare_ats()
> is dropped in this v6. So, my previous comments may stay true and
> the two lines can be enough?
> 
>  	/*
>  	 * As pci_prepare_ats() have already verified the hardware capability
>  	 * and programmed the STE, pci_enable_ats() should not fail here.
>  	 */
> 
> > +	WARN(pci_enable_ats(pdev, stu),
> > +	     "Failed to enable ATS (STU %zu)\n", stu);

Ack. I'll update this.

> 
> https://sashiko.dev/#/patchset/20260529111208.387412-1-praan%40google.com
> Please check Sashiko review (for other patches in this series too).

Yup, already sent out a series [1] to address Sashiko findings
separately.

> 
> I think it'd be cleaner to just have:
> 
> -	if (pci_enable_ats(pdev, stu))
> +	if (WARN_ON(pci_enable_ats(pdev, stu)))

Sure.. I'll also maybe keep the dev_err log that we have, knowing STU
mismatch is slightly helpful.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/

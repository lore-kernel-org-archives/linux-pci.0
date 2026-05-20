Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1073ED121
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287400; cv=none; b=QYmQLPxw966lG1yBPm+zs+qnYt+Dq/mqD4L15aa99hmRRyUEFGLlmYl0lbkPxVytF/6Pp9nASSGvNeZukVtYkxyrOJY0UI8KrpmoWJ7ufn3AEeCRMTP0OqWGihUVLIa4YzOLqvgCgm1yTb3XaiLFqywXy/E4luLgU+ywYjejYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287400; c=relaxed/simple;
	bh=TG0NKcrLjqdyQdlw2c6URhaVJV8b27piDsMO4RVMv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOlzqkm9GwBzFc4O/pYUHz9nBjVmRb/bkAwZ5bQAloGUHjYgpGZfOuLAAJbJOUdlmVsIGQTQEOI1Gp/rIBqv9D8LFNH1hlFNwfoJvxhEb+fM8kLF3LvOXPsdOUh3Pgv4/R2/xhtl4DEKkGi65eoiywcWE0QrO+Mu5qTQ4NhFyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvaSDNmr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvaSDNmr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1015ad.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287399; x=1779892199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hupf40yvplKJ6StYekfgG7udqF3fGQFNogF6bADkx9E=;
        b=LvaSDNmrAaHpWAi+xwsngeImUnsb1pWPsH1n3s8U1rItkmFMjujCR3k9nSK3f6HZ4g
         12I5JFmNgNNm50ZqDzT2xfpM1JhSlK/g/PdXvHazm8pZoWg7i0WFYu2wcOxQ6rGb/gxr
         /bmAwrBVuqcz2zs4jBddBr9vcC5SJUbjc53u3eL4X07asgjpWXm6Y3YZ0LnhuiNfn8fR
         35miSeGjw8E0sHfkyuuKoDzDQ4OiCW+dkN0UtPj9s+RdfUNLdyR57QPXD/9+6lwSPOIU
         vF5Cl7vcQ4FZjb+/rDci99R1XHI6cafU8+PZ2Jye+kWKqOndOhPlkkSCGyKy1o0Pe+L6
         s21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287399; x=1779892199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hupf40yvplKJ6StYekfgG7udqF3fGQFNogF6bADkx9E=;
        b=GvQ1Q7tml2L9DKHBuS/pgfCtCSaivm4jIjhsL3CIU1Nxle5cygiKO3aaMTyJRU/Ef7
         snu0PebDjkEA9uU3zGwp0mBpEwVENs1PGzIqQqq3Th0KhK+Dw1qbvd4PW/S3dFD1YFcD
         0CqwvYn0xxVgC/evsP+rPkTEU/iHyfs7gqawwkLKG+X/PLN34yyzyqPhrQTe5VrEKZPs
         Y2+yG3Le6XxVk0nAfYFHl2VjHUK8qevLn4sJwVyVuwV+afD4r+OFSQt192SuAFePaPio
         Dfj37gSJ1hBDct0meIkx6bItcuBhGy7yj7ABjxXShtM1IOLgHv63jr/VlDCbwUoSRQkV
         HQrg==
X-Forwarded-Encrypted: i=1; AFNElJ9EU2oZVKgLKwJwnfbl9htXpFWwsVEOy+np2qg5ianmWwZniI+Cs2f9FkOX9cOYymKt1CSI/hk/rmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoodsKJecXwXzTnVcMDkglajXyPKyd0dBuFRZCJFK+att30jO+
	X8Ql6wuifUT551bRmQ+56k8jk/vI8GcXvadTkfJ4oPLZqz6zgDPDqfBZBYmxi8T4UA==
X-Gm-Gg: Acq92OGRlKOhpJ+ylmfrcwvfy5lC0qM5afh4KpBc2DgtAGC8s7BnZ+EpQC7e264pn1c
	lBQlYboFYE1JXvxfmDjQI6l+zIQpBmSQ2EgQkE9bYhE6WiOisVWQcCk0hYkQnm4+3gA88LljDUs
	0ckZe/X/UndhZXsp958Hav6b4RimxThvQJTlyXSUd1kqUuyI5j1iufEC7m6/o/DbXVLpLaEYcz9
	+7eQb/lkNqsGxN22pEgcCpFr7VlBdoFchG5xE49k1upB0uK+yARUCxf8lGMHCWcidSOaj+m71GO
	S56niUbuJBnPHYijJs5j5y+s9EhcFcL2Xbc7QXx8M/H9dcMCc9Cgo6wHKwFrgtonHO4KYs5IxNL
	7ozq9cWJPVEr8m3YBokQAoUfcS+O9q3gdtWPZpEGxg1BFVSicdz8W542Gh0xY4tDVdTcj4vzn9h
	0hpgCWjoG2NZEr8M+tZN6DRePaj/mA4Wjz6Ok1vge3QHDVtJ3IRPi39Kq/W1NC851J/Uxm
X-Received: by 2002:a17:902:d4c4:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2bdb32c2d37mr8481265ad.11.1779287398420;
        Wed, 20 May 2026 07:29:58 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb0csm206596705ad.17.2026.05.20.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:29:57 -0700 (PDT)
Date: Wed, 20 May 2026 14:29:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <ag3FX2rYHybhv7bZ@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <agy2uGGC6wXhG91Z@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agy2uGGC6wXhG91Z@google.com>

On Tue, May 19, 2026 at 08:01:55PM +0000, Samiullah Khawaja wrote:
> On Tue, May 19, 2026 at 11:59:47AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > > > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > > > >  	if (dev_is_pci(dev)) {
> > > > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > > > >
> > > > > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > > > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > > > > +			master->ats_prepared = true;
> > > > >  	}
> > > >
> > > > This should fail not keep going, it is a kernel bug if
> > > > pci_prepare_ats() fails.
> 
> I agree with this approach, as it captures the bug at right place and we
> can fix it. This maybe changes the simantics of prepare_ats(), but I
> agreed with this.
> > > 
> > > Are you suggesting it's a kernel bug if the STU doesn't match?
> > > IIUC, it can fail because of the following cases (including the PF STU):
> > > 
> > > 	if (!pci_ats_supported(dev))
> > > 		return -EINVAL;
> > 
> > It should not be called if ats is not supported, iommu driver bug.
> 
> So basically iommu drivers should call pci_ats_supported(dev) before
> calling prepare_ats() and probe fails if prepare_ats() fails.

Ack. I'll add those checks to Intel and AMD IOMMU too..
AFAICT, both of those too, don't fail an attach if pci_enable_ats fails
[1][2]. I'll add those in the next version as well.

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/iommu/amd/iommu.c#L2373
[2] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/iommu/intel/iommu.c#L3340



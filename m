Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944131E844
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202792; cv=none; b=IIO4AWjJPtZD+lagdZZlVVRhXi5PIJ9yhtaY0KnjLFlmVJJwhTQjs6nS/Hl3I8kWaCKia4eUZ2Z+rJ/BlQkb7HTxY0puq8hfYC8e9vaOxZ8TZJpbd0QkYTaympSedOXLisO35uczz3JUJ1Xg1unw7DoIZBPq6LjpiZ3zvT+am0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202792; c=relaxed/simple;
	bh=VKinmpkc0sPkaF+DR1uUp82//Kl1UNBgVB3kTHmnB1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4VZCuc27rj20QWnrqhty+t2S5sNGwWN0fDmF07lL4h9EL8YNSd63QGyW+hmGakoXc8p3JhuZHlI7KZIu2dQpDW4eR3DESTupbtLgitsTaI0nKVdDPni8gHVRJi76DJ2AxFkVJIg3Nob6onQizM8zOUcloASynkmrVXX8//YN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BfvNXeab; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BfvNXeab"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-512f750d4b2so45663761cf.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202789; x=1779807589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7hUyn5iO0H7X7Ga+pTWTO+vfWmix946/pxKMTlOtbo=;
        b=BfvNXeabM/fvLzWAA0f+/39FduwU024itNxmRumSodF/FR22r3XkNtnec3McZPWee9
         F+weoFoULmPk7prS4HjDw33oRET50f9dIKy+17Pnt8j15t5h10GS05gDl0xcUB7C/VPa
         CRLMbCgJiZqOiYuSheelfV7fU4R0VZ4UwioAwqwkLFoJY98t9QlOc+CmdNMIDdGZF0V+
         OXCIuBFYuoKbtl4gamYEf1A09Zv2geJHzK5LGmVQWTiMmwDQhCLAdeYZq+aLaH+HsMi9
         qYGCA+ODeU8sxAOvoyc8Uj3yGOJYf6YCp0BdOSVKMHhJ43NA35s3a7y2jyNrjmd/2eEJ
         nTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202789; x=1779807589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7hUyn5iO0H7X7Ga+pTWTO+vfWmix946/pxKMTlOtbo=;
        b=NLO1RyO75q/xDILyHdPjd3Nrc4BgTk/EaZcuz/sJp3uulon+BJVc1nVaFTNeab2i1e
         CXH60xvwbp4iGRMdTd5yJpOyPCcZU7c9gssfxVA24s98i6TC5CW0tyd6oGTUQuciMoix
         9sIKRKSlvlBGdfPZdcqodf4E7xXdtHfvwkXGK4Qu0Fu94LofpR2Gwxkmh3/0GQicn1vG
         mHVXIcsECtxxia7NJp/q62eFafzz22LACiIZhI7dbEfe2gYhQ875uorTjTUvxkiZM5Ow
         vO+LZtQ8/G3Jz+mWX06xesYRNsl1ayhoNeD2LVPYvtTbWYyryQ9Yk/qX8FNW1JNfXHd6
         ortQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dx6AJpN0H1rKp0yBCEOihhrMmY2ZJj/7VCJ55k0scf2+cdLXw8uzEM/GFwVyYGxgUQpGweTuoYos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG2SKKEK4CVNLJSU3kwZjuOjUD8tQGjm/AoeclQVcZTLKbY5l
	v1mdpNYW2sz2NkLiLUOyQStkt7CAajnmG+RFVGYHmSxE+u8UdCCimz9pr9RhPYTUBYM=
X-Gm-Gg: Acq92OEv/4Thqil7SIGXS7Y7HdS7ICxlGflYiBR2S7qxJZJCO3dWJh39V8nZAPnZIYL
	yoj72J2rYO/iBrQvYcZNVjL8HRavVV6SWomdi+6xCbdPegUAS3VK52RztOpe1BZKWX8CQpxfzkd
	4ufqe8GuJVjCJtRBd7ZWVRz5jZj9Nx+kfTi5FIHoNrHxseQDe0bCbbAoMse0kkmpufDK/gvPqob
	fWy8R/325r+0SjYSob0uWtPVzsGHlNkRs86jtjuL1oQ8QblAMaHLpgN8Z2dd+W0SReAZ1PkbqAb
	I0SxA+tphWo0zhYdz8xDFwF6SGR+H2bpDVMqstlogao3fTpZZPEZ6rSTeHZSRiZoVPCG3mgkbu7
	GD3vR62DNU1OS9boDNyKLKcFrv3+hYIl2MuQpTw6dpGv0yWo4sdoZzpnQoqWucbNKsveUK9yXaB
	WqVfvcSz97WkgluM9g7pfeJpxCMsmRckGidSzLVVjxLiDwjuyFzN2sIyEHCySn+JEDeYOm/rFrp
	3EZRP6AJFbqm+cA
X-Received: by 2002:a05:622a:a911:b0:510:138e:b83c with SMTP id d75a77b69052e-5165a2760e9mr223529131cf.33.1779202788595;
        Tue, 19 May 2026 07:59:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm174979741cf.3.2026.05.19.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:59:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLv9-0000000F9u3-2Y6V;
	Tue, 19 May 2026 11:59:47 -0300
Date: Tue, 19 May 2026 11:59:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260519145947.GK7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx5-jFkU2skyEos@google.com>

On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
> On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > >  	if (dev_is_pci(dev)) {
> > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > >  
> > > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > > +			master->ats_prepared = true;
> > >  	}
> > 
> > This should fail not keep going, it is a kernel bug if
> > pci_prepare_ats() fails.
> 
> Are you suggesting it's a kernel bug if the STU doesn't match?
> IIUC, it can fail because of the following cases (including the PF STU):
> 
> 	if (!pci_ats_supported(dev))
> 		return -EINVAL;

It should not be called if ats is not supported, iommu driver bug.

> 	if (WARN_ON(dev->ats_enabled))
> 		return -EBUSY;

It should not be called if ats is already enabled, iommu driver bug.

> 	if (ps < PCI_ATS_MIN_STU)
> 		return -EINVAL;

PAGE_SIZE is illegal somehow, build bug.
 
> 	if (dev->is_virtfn) {
> 		struct pci_dev *pdev = pci_physfn(dev);
> 
> 		if (pdev->ats_stu != ps)
> 			return -EINVAL;

The kernel failed to setup the PF, iommu driver bug.

> If ats isn't supported or if there's a STU mismatch, shuoldn't we just
> ensure that we don't try enabling ATS for that device?

No, the kernel is broken somehow.

> Returning an error here would fail the device probe.. which seems like a
> big hammer for devices that can't reliably use ATS.. 

It has nothing to do with devices, the kernel is broken if it fails.

> We have a special case in SMMUv3 where we pre-allocate stuff in prepare
> but actually enable ATS in attach_commit, which IMO neeeds to be gated 
> based on client device's ATS capabilities?

Yes, all of this should be gated by pci_ats_supported()

But also failing to enable should translate into a failed attach.

Jason

Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E711352C54
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220922; cv=none; b=OjLOoCZfBAAoYu8xCCcukLIeg+H95iTwE268HOKq5NpaFPvn+ld0K7ghjrSHEVufL/tQZhKlb+DRh1UwH66qTeKxVBLT5BGSAtudZP3G7VcufTdKGeQ+h84Lnpe3SM6EI1ooVJBvtRkZfqgZPziQ5rrPnUJJyM1G5KO+95OWAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220922; c=relaxed/simple;
	bh=jVbSLT4eZONXCbzPo5oDjs53UjPhjZF26rMvREPsuGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPoUBPti3Ba8BvjAB8nAyZv69ExkcgNHjESYInz8q5E0mq+I0tRPHPtic+0FsE3jXHFHu4Hm9rCu9CBzYaW8lDbVWzBfvHQ0L1q8usWYP2IJKJTP2s8ok5alYOwGG6AjXSdgWSn6jS8QVPgdZt546EHW+VngyCryENileYoTQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCzUhcds; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCzUhcds"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso3725ad.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779220921; x=1779825721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXDj/DTIeAGhrO/gWWaG2rh6poiOMsEC8DlUT/nKHTY=;
        b=kCzUhcds4Rv+z0P4wCDKDxNajCvMMuDpgHkZU/pjhiEAOHzHO0UXhkonggO1L982A1
         2rvMbhDyWNW+3fYb+mXVSK0ep/2PIh+loRcQ8JUZxj+TPKZgCBFTyBatd9Ef2VTCkCWq
         vYLbU558Ddzg4Vl/BTsPibmjEFESDMDAPX3kf3FfStIwXTME2JB5bUpsm8nSepNn6YMI
         Mfm9PdRiedDz2AiEH6PT2N0FOEzzb6YkK/axgTietK5mGR87Wn2NI5t1b8RuJu54LFCC
         iDbeWyZw1eza9kWshQP4zsV8L11e5dSy3aJe6z37+0Fa4ktiD0vz31mCTSefkgZHTNxg
         LPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220921; x=1779825721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXDj/DTIeAGhrO/gWWaG2rh6poiOMsEC8DlUT/nKHTY=;
        b=tRjUGIj2+i7mGuJlBPQB6izNgfZs7kM7j8iMaqa3JNPfBMaZ5GOtcNc5/hGYkVUF76
         Koo6ZcYs2Vq5+0bb15J1HEBESyf2tzn2gOnBI5Ne6z2qka4cjQeB+EBcLR4XRylcZalf
         aONfk3S9JgV/P1pkPzyUxUctfKEUv4AcqTQ2KS44O8IkAvZXCC62D5PLWjWq8mmmt9B3
         oovnE4bGqNCZoPlmPlE/QMXNNoWcD0uhLwtG8SeF9X6fZrlGLy4tBdR59gXYUPMbm3cR
         glbzzlfTqAZ/O8ezlQeQkIRuqnAddsE5HktkSiUCzffi9ta8zMyPZiivJW6gEFh8WLDD
         tq6w==
X-Forwarded-Encrypted: i=1; AFNElJ+sxGUANu4PU50vA8K6h0sO+FaOs9tH7piSbky08aSYd4BF9Lsap/ZaajoNEujTU89GWpYV3KLoF7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNu1qA0lph0IwRPJxyEQQ69SfoRukXE89ibpgbmxmwjuxJEpu2
	OgtMI506BYSS1KkcTQsNxNJxyE5V9QEr2zUJjZvYUeAm4SPduS4wdsEB1Izdpe7S1w==
X-Gm-Gg: Acq92OHOV4oqns3QdoFdbCNB5BhSRkTjZpzzl0pC4aJo5iM54o/A/3NtyZpXBsjFJ1/
	gABobR3jfcxN5N2951ViFlTURbmU0sK00z/LyLubs3aXakbhZkiu4wxhUSmWdeVTiCoLBv09njU
	azd2jiCBrMd3QLYDHntpyEe43k2FKZ5KfS/bhy0ysEXDjSGKMmN4fMduvmrfswEVCFJlaBffZTS
	/o/+d1PxXJMKRovUgPzQtKQbFBGtVkS8/a0ohYXXJ456AfS/jBjtc9CfDSqBBGT3hsTZryw+Dg2
	fxLrf3i6X7tf+p6BjVoyiRns59ARsSFaCDdH4BN6+p8ZRbxW5JYTdJyjHuuZ8Gp0Qlr05Fcr65O
	y38wXLjQ8I7rU2cs9UZPbRkiRc4CwjYPhqU18HpitjqSnVsx+ia0TCW+ylZ7bZJaQIsRwsOgQzI
	DpHcWdlF5sRsOhuDyglVKh6NCmSnYqdyYcnDiVxcu3d0JX/CA5KZ4baQ3IJRBEDf9+lv13VQRFc
	RNq8wI1
X-Received: by 2002:a17:902:f64e:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2bdb303b125mr3099215ad.3.1779220919888;
        Tue, 19 May 2026 13:01:59 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a820fsm15139452a91.10.2026.05.19.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:01:59 -0700 (PDT)
Date: Tue, 19 May 2026 20:01:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <agy2uGGC6wXhG91Z@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519145947.GK7702@ziepe.ca>

On Tue, May 19, 2026 at 11:59:47AM -0300, Jason Gunthorpe wrote:
>On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
>> On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
>> > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
>> > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>> > >  	if (dev_is_pci(dev)) {
>> > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
>> > >
>> > > -		pci_prepare_ats(to_pci_dev(dev), stu);
>> > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
>> > > +			master->ats_prepared = true;
>> > >  	}
>> >
>> > This should fail not keep going, it is a kernel bug if
>> > pci_prepare_ats() fails.

I agree with this approach, as it captures the bug at right place and we
can fix it. This maybe changes the simantics of prepare_ats(), but I
agreed with this.
>>
>> Are you suggesting it's a kernel bug if the STU doesn't match?
>> IIUC, it can fail because of the following cases (including the PF STU):
>>
>> 	if (!pci_ats_supported(dev))
>> 		return -EINVAL;
>
>It should not be called if ats is not supported, iommu driver bug.

So basically iommu drivers should call pci_ats_supported(dev) before
calling prepare_ats() and probe fails if prepare_ats() fails.
>
>> 	if (WARN_ON(dev->ats_enabled))
>> 		return -EBUSY;
>
>It should not be called if ats is already enabled, iommu driver bug.
>
>> 	if (ps < PCI_ATS_MIN_STU)
>> 		return -EINVAL;
>
>PAGE_SIZE is illegal somehow, build bug.
>
>> 	if (dev->is_virtfn) {
>> 		struct pci_dev *pdev = pci_physfn(dev);
>>
>> 		if (pdev->ats_stu != ps)
>> 			return -EINVAL;
>
>The kernel failed to setup the PF, iommu driver bug.
>
>> If ats isn't supported or if there's a STU mismatch, shuoldn't we just
>> ensure that we don't try enabling ATS for that device?
>
>No, the kernel is broken somehow.
>
>> Returning an error here would fail the device probe.. which seems like a
>> big hammer for devices that can't reliably use ATS..
>
>It has nothing to do with devices, the kernel is broken if it fails.
>
>> We have a special case in SMMUv3 where we pre-allocate stuff in prepare
>> but actually enable ATS in attach_commit, which IMO neeeds to be gated
>> based on client device's ATS capabilities?
>
>Yes, all of this should be gated by pci_ats_supported()
>
>But also failing to enable should translate into a failed attach.
>
>Jason

Sami

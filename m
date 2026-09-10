Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFC48EC96
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048043; cv=none; b=H7dYBUYSC+oOPtGUqOW4Ot6Xy5X0KTI4OUDv+cG8mbdqvEfSQ+3OHEelN+VuzY8EdE7Eyi/7MDBWbS/Q+2thOhIOLwS/gz7lCYTmhObFaWZ3q95Qoar+AmAsI57qrFYYFX7We5N+/E1Yf7HM89pEZu0KuzrI5y4uLCziI4Lnp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048043; c=relaxed/simple;
	bh=EAupyPyuOf7QDpZYE61msvaSyoWYmzVXc55xqZ5Wf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HelbvsdfLAT2UJZ5nySCU0L+eUdaG3S6wRDtdI8QKG5JVLy8iPb8NK1gfiS/F0R0YJGjYSCokNASRGHG8HqWXL9zGyjT1PKmP7ZCCjK7XqTcSBUDwEtXg/9+44FS/KGmuBqUfodsvI+176LOhO4lDGhe+RNtrVQGLTSkjGzSFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9l6kO6+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9l6kO6+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so74165ad.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789048041; x=1789652841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Er/jDsnNRoh+QmJEZXA5qaI6MvfZ+ynzviSkzMrOHk=;
        b=j9l6kO6+L+iQAPhxFveNuolq4A8YLIACWkXBoQYERG+zilDQzlFZ4ox3m8o1+ynozK
         g38rPhlQrPJhl4K6Tr4+LDXV0YzPLq5tzKtfIpjLH4ARl8TdIWR0GgtSlLm2HDN2sOqv
         R5ynpe1jJVnXpeRNXEIReTrO2KQL+SGF9XRv7/1dgfiwrouNQthIS7k5unVYRjduj8Gu
         jtSwcAtazV0yrSEt0bE8Y8iRkkLqBw0iI0mJ9vsZU7B7U/Cd+VxRpQQiqHCjPLOcIw+N
         SVsnP6d60IoMisfhQ6WFCCF4VZiyHNf4Tbcn9jqSjsIxXqC3DEgEOq2n9KayQaQuVSMD
         M4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048041; x=1789652841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Er/jDsnNRoh+QmJEZXA5qaI6MvfZ+ynzviSkzMrOHk=;
        b=GusJya+D7i6Cq0OPqUf1chBsC/picG1BBzjgZak7+AjKsiOJFn4F+hAwkmHOoQu//a
         U8TaCnfpg085CDm96wa26UT/k6VgnW/ns/dgQuNIQ3aUGaZQmYtUAXVRbV1MVokjMQAY
         /ZybBV0EtRfsliU2xB8QDLpAQZrbOtWCtJCe4gKCVNnrACUlEeo8RPRiXNd+W3gsrkvP
         SamXB7EIMf4RUddHaQ3iXxpimbhulwq1MODTS064rXejhvhLLkYW0gP/peBq5n9pFliE
         JZDGRleoHW5zo84Ko6nLlIaxqbNbAeXNPF0jjAfdvEiLRHwoD1K9NWNudOO/Z5FdXGLm
         uP7A==
X-Forwarded-Encrypted: i=1; AKwUvBxNtTX3nOJldNWyNcto9GBFvwtrg8fD/jX4xqZwSXdoLtj4tn/xBFAyaZSzNam6qUgqvrpAINndY5s=@vger.kernel.org
X-Gm-Message-State: AFuF++mMwWvwhDJyyDWjL1IKk9S4LCZ/sY7PdDzOpXlbW5ptAUFUQEis
	fY2Lzbk1qPYF6xbIm/dF5r8+fIw4UXQfJPZxaaLJ+SkFEODVY1EnUVAstDxiO5fPaw==
X-Gm-Gg: AYBFou1eLhePDqEzDCRXqJQfCiZESE/rzLKM1Vr1MdXVx+nSVE0dQ3/jIWY4EK2fHhK
	qRo8qPB1nNL9L7h2LmFfh6JF3cYIVZT376Y+sepvuLLjfDYuD5hYMD1BiESIowLDv9/UWIXD67C
	fr73QktTvBfLKXUKzlAU5LYPkRbR9mns1XqYVnFjoWaJwmUZFZF88cwYCKMjXupySlnDjtjpQ+m
	diOsq9f/BgDqVA3uwil7j3QepuSmT9jPQFYqBJUYbKCMMKrhxCqHzF9QbuyAHEX6YoUQcZ6YJbm
	pqWWI/bFxi43QL0IbtW2PkOYDLKB7NIvyE5LUro/WKzxMHoroIKdCYXzQUtkRpOo1pASe4r615a
	OfRJ9WcrVd0vPtVWrZ/aupeTdxjfYcLhXVBOY/PqTPIb8VhnOO7bd6rPdAmR5TIVsj9RXyobxmj
	soLU7XgxRuhaU49LiQcQ4YDGXytd8ak9sykbSklrKIVL4qSJ7i+DkvbBjvgJWoEdhCoVpMkpSGi
	Hly3CpQyQICbqKI+I92KGFkJH3f1X3CHcYofKUExjFKw1Q=
X-Received: by 2002:a17:903:4b46:b0:2d3:153d:acae with SMTP id d9443c01a7336-2dd109d9e59mr7015225ad.0.1789048040913;
        Thu, 10 Sep 2026 06:47:20 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483ea94sm89902865ad.9.2026.09.10.06.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:47:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:47:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aqK04hq575iwY5BR@google.com>
References: <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
 <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>

On Thu, Sep 10, 2026 at 05:25:25PM +0530, Vasant Hegde wrote:
> 
> 
> On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
> >> Jason,
> >>
> >>
> >> On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
> >>> On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
> >>>>> Having the driver boot up with all DTEs programmed to identity (eg
> >>>>> 0'd) and then try to fix them to blocking after the iommu probes
> >>>>> devices is security backwards.
> >>>>
> >>>> During boot, it only sets dte.v bit.
> >>>
> >>> First it clears it to fully 0, what does 0 do in HW?
> >>
> >> IF DTE is fully zero, then all requests are blocked for that devid.
> >>
> >>>
> >>> It doesn't make sense that you'd pass over the DTEs after
> >>> probing if the original 0'd DTE was actually blocking?
> >>
> >> During boot, it sets certain default values includ dte.v. It doesn't
> >> clear everything.
> > 
> > ?? It starts out with a 0 DTE table? There is no inherited DTE table
> > except for kdump.
> > 
> >> May be we should just remove ignore_device() completely? as
> >>   - normal boot, its not yet configured, so no DMA is allowed
> >>   - kdump boot, old DTE is still valid and let it continue?
> > 
> > Yes, that makes alot more sense to me.
> 
> Ack. @Pranjal, Can you fixup and send v4?
> 

Ack. I'll remove ignore_device entirely and drop patch 3 for v4.

> > 
> > But this comment is also wrong:
> 
> Yeah. One of the cleanup patch missed to update below comment.
> 
> > 
> >         /*
> >          * Order is important here to make sure any unity map requirements are
> >          * fulfilled. The unity mappings are created and written to the device
> >          * table during the iommu_init_pci() call.
> >          *
> >          * After that we call init_device_table_dma() to make sure any
> >          * uninitialized DTE will block DMA, and in the end we flush the caches
> >          * of all IOMMUs to make sure the changes to the device table are
> >          * active.
> >          */
> >         for_each_pci_segment(pci_seg)
> >                 init_device_table_dma(pci_seg);
> > 
> > The DTE starts out with blocking because it starts out as 0. This
> > isn't making the DTE blocking, it is doing something else. And it is
> > very suspicious and racey looking to me.
> 
> IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
> should set and flush the dte here. Let me dig the details.
> 

Should I also update the comment in this series? (It seems less relevant
to the ATS stuff)

Thanks,
Praan

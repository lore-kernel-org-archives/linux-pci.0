Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8A51474A
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548795; cv=none; b=E07OD+YAS+nhn5OCSDSMaX89rD9+6JOCM9FHzhUL4AK4eTeHxZ1M7l1S8qsvpgFLiWeefmH/HRj0uLf8aiqBy+SPm1UPAonlqYclHwp4GJwuPCvgms5udrUhF9EX2cXV7o6Npl2L/mBuOHY2co04anHNowC2Bz7vxwEGQKr6ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548795; c=relaxed/simple;
	bh=21Bh4RJxpeiCW82oSWerk5Qo5AfL15/5sh5ePR1ifY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu1QZP8MyarWp8+IAcoqodsTEMSZd11emX1kjlye1zbM0idmmYtElXgq2KZIiG+gUHMgtaHP9aU9YKV4jfYBkmhT9y2Nw9xJu/h633IUUIKIH1jVa15hyFrbOGAI8bewO8/eoEfJg1+F4LlwAJwE1k7nuVQIffXMIh4I/7a5zgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ODcRLImc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ODcRLImc"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-867a943b149so25269947b3.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788548787; x=1789153587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=ODcRLImcsIS5iVNl+ZahRycAduLdy9JKF4ZXLUxRp/0zaap7yPdhEQ55TLbSREotDR
         t2D2pU4eLgK9qUdmPunJpyqByPO9UY0gCm6KqjN5ljyHH5QRjXk940z3BI6OZbumZtJA
         8iwFPX/VNeXGrdgyIcxN+4E2w9Szh1dSdOmn3IHVWAzH+4lASnZGhj4Bp9jY/OxRq/se
         dkpCoRlQKHxFddxqxH69HJKK1KSfw59L0IvPUY5OGUQT7Ula/prBAY6qTZfaZSURxI6m
         z7UH4wK4/5jA7+nIIK5HYcSBdzF0eB4TvrCQJ8J+99z2ht0kLl9BKuqXXWQeetwrGUGl
         ENmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548787; x=1789153587;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=dbJ/Bdu3oZ+LUAzUwmepZbGxcOLImWlc434T+4FStBHsPlVFFRErn/A5wS1DPoHgvq
         QwgmJ4q45ZUU08jdtrnrXetT8DwNyt2xBRlZz+5IuPHEvZ4I0vwqtZn7PqmKB8Y0wNsD
         qKA2vf5Inzs1xdzRtbiGsisLDSMF0s2xo+19rTn9H10GwvP4GYrapPWUr9S2gOhzhxGf
         gaCDmVRmsGNbumIpDQjosFK0mcgUSwb0IiZ8Qj+v/AyZb4zqY74U9LRBrGt9tAv0SUFY
         hkgHkfSikgDwZS+u+ltHRuSjACyuJVbe0l9dyacpewUoajzsdh7ouISC+xYWzDJCUt00
         4GcA==
X-Forwarded-Encrypted: i=1; AKwUvByoXOzRHt7UKy43nD1OSHjcIRs2rfujVst/qEzo8iWsUFbVfboqI0obF4PrLl4ivjWezDNkSkY/lxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kFKvDK3G9dpih/4y/cM8m2hTWc4oCSZtfSJRnHuBrsLRFi4MiX
	Muz2bWaMhX+reTuh5Wz/ZKN+2DsLqWhuECpT1wOgSPErDL1jZb0viEFAa9KCEYEf2/w=
X-Gm-Gg: AYBFou3GYDiVjl8Ww9xTIr0Ok2DXyqj8/RI8OqCq/1Ohnw68AsM/zbrY/f9pyC42JqD
	UDCbGNejLW5gZzZ1EMhbiXRVoy38mwslqAaHnCt1A3qmYKfr5VVlQRxM9trm67wpO4JzlZlBzQj
	cYplH/RhoZoQptiIQ+W4jHnbkdaJ7q7G7Yr4xyHSjWojITS9zy0PL8Zr6/gYw+8uUTUR9T6lSge
	zpEwYlcJ4xCtlCopRF6vnUVlG4oT/52lu72agImiurF3k1MTn7SschohIL8cThCTZqrKUq5feNi
	Y6RYSOwlS3RxMa6DCq2OdoWcvQ4LmE/fMRZVsTfxivznyewuc9laKjmKmGx+mdl0rh5+zyYSOjQ
	En2vKU4nzWvgEUKY1++hwJelSrVsMQrNk3cKaDdx4EJYIUDNPJwGtPYI7Oo4XCt+ILW5jK1hbqS
	dyPHG+B7iDVzWcoEA2kzKlrAGuQ0WWAP7q5dyAWTLtL8d0vF2Wy0H0T/p+GIJTV4elYBqQ+u8gK
	rsnAw+LKDI/0oK5cEPYXHdOFSEVjiE6ZlE9aPtGB3MDMWtF+wQFfIg2OA==
X-Received: by 2002:a05:690e:2026:b0:66f:c284:4834 with SMTP id 956f58d0204a3-66fc2844e8amr819081d50.60.1788548787246;
        Fri, 04 Sep 2026 12:06:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406481b4sm27434626d6.17.2026.09.04.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:06:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x2ZF3-00000002uJq-3KUc;
	Fri, 04 Sep 2026 16:06:25 -0300
Date: Fri, 4 Sep 2026 16:06:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Alex Williamson <alex.williamson@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260904190625.GA667892@ziepe.ca>
References: <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
 <aoeffe1v--CgRK0a@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoeffe1v--CgRK0a@google.com>

On Fri, Aug 21, 2026 at 02:20:55AM +0000, Samiullah Khawaja wrote:
> On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
> > 
> > > > The blocking domain operation looks like it might be simplest to
> > > > implement in the IOMMU core.  We can set a flag for a default blocking
> > > > domain on the IOMMU group when we take_dma_ownership of the group.  Then
> > > > release_dma_ownership picks the blocking rather than default domain.
> > > >
> > > > This is then unwound in use_default_domain, called via dma_configure,
> > > > attaching the device to the default domain in probe of the next driver.
> > > > Therefore until probe by another driver, a device used by vfio would
> > > > remain in a blocking domain even while unused and unbound.
> > > 
> > > The devices are expected to be attached to the default_domain even when
> > > these are unbound and the use_default_domain assumes that, and it only
> > > checks the ownership and doesn't switch the domain to default_domain. I
> > > guess we should add a WARN in use_default_domain() if that is not true.
> > > I will probably send out a patch for that separately.
> > > 
> > > I think we can move the device back to default_domain after reset after
> > > unbind, maybe it can be done in pci_dma_cleanup() based on
> > > driver_managed_dma?
> > 
> > This blocking domain stuff sounds very similar to what Nicolin
> > implemented for the per-function ATS issue?
> 
> I see you are talking about this invalidation stuff:
> 
> https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/
> 
> But this was the case where the device is going to be reset and to
> prevent ATS issues, we attach it to blocking domain before doing the
> reset. But of course, with the PF reset here, it induces the same kind
> of ATS issues on the VFs.

Yes, we need to attach a blocking domain before we make the function
unable to respond to ATC invalidation. PF or VF reset both trigger
this condition.

> Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
> VFs to blocking domains before the PF is reset, will only resolve the
> ATS issues. But the software state is still out of sync with hardware
> state.

Sure, it doesn't fix everything, but it is something you'd need to do
to avoid problems in the iommu driver side..

Jason

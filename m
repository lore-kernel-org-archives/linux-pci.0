Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D62848AA
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604166; cv=none; b=mIN0FkGWFams9PNx2tW14TS+FJ+vZ86ledAVSi0AHaF1OhCI3hVf97/aPMqon5rW5ZH6utcei3idKPRVnW9zkwIRKP6719rtoTTng7E6UjhqqC2MCZN08QzZMVjXdRJrXsn1qJJMF0PuI6gNVhaWjpbMq4BbLOT1i0qLrBJRzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604166; c=relaxed/simple;
	bh=XY1DtExPK+vBehOtMz1hd26l+uA8hk3yO9vu4Vb4+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJa9y4oEwunKJEgT+zgXI2JsC1WNN1ZDtfbv0Mw6AMgpPmu+FOej8TA26fY2OBGxcZASfmKLC3vLeNBaiagMFuhe2w73SGd0PIdNCfK9hJBAHJ2TEk7EtnIX8hHxdqbgjVN/DwKbQNj61nsHGdFime1IshUlVw8FxggASOKYSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BXlLXUkC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BXlLXUkC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfad59921so6340961cf.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783604163; x=1784208963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wb9mS3uu6ir3/OS2ifAG+bggBvdExzW9AcfbPUafx3M=;
        b=BXlLXUkC4sdDJbyfhmQv0Th4/CJ4IwehpORNvNFb7QmatDc3fHKphAd0MFtnCmmPk1
         XNKIjdpOs/LUvM+X2/Cxd4pkAYtGevpZY5zR+4fE4PW2dqhEpmepLcrGUpdB+b/wBgSi
         qC9ehZD7jpUKdBBGxIL508rWOpzYUu7vJFjjuCIKIKMYAql9VUvbNdylvy5KrIX/KVP8
         8pqVHVLghfahHesVIA8w7QowcLkDCWF/d4pDjV+B73jxNIRMzyh9pR7ij2oc1WZQ2C8m
         YSvo6MITjEs2CnTEmxMAL/JXXJO9+xWItemN/v3M24oC5BPtjM6uuQ3cZbGGhOM9Hykw
         Odkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604163; x=1784208963;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wb9mS3uu6ir3/OS2ifAG+bggBvdExzW9AcfbPUafx3M=;
        b=qcG6EnSjBS0HBJUXPv0n++GSQOHro3170YQzlji67XyNe9XgZM4+bgrZEs1GpQQYhK
         0tbm7lb6ZSzI3G/3umT/zaWhYrEDQq8JE9tpCdORcWIgP9W4BWQYcCNf3pLP4aNBC9s8
         QK/ElzunGK3oUUzDh3VxGDGU4ycEQL4wmf3ypjCyM5XTKK5UmjMk3aBUkRI8VRZQ8SOf
         S2VV5zPYwC1xutRC5V+urCGHDjA+aIhjNZU1kiuHsKYnOfee0tbwAAYLYS03E1RSeOSb
         6JGTtVklbvlXevFbIsO6ic/4BDdaL8bhbmcisIssO4J0t6kul17pQhO6RzrDK7E+NX2e
         F70w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+dH9VwvJpntUqPMk9f+QawsVUZCDWKrHXTgYBcxQui8GTzcSSdrXIjbbzmz56JjL3VCqWhNDYm2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3c9WxVTD7y4Z9nYyQZ1HLTDdP75XaqFbudq4MWoZ35cfk+5G
	jx0ciFb92n5L2+MmqBZHpTxOvtSxyHSOb2zWT35fC1dncd0zu4MixBiJwFMuWAqFh0k=
X-Gm-Gg: AfdE7clHQXhbKhyRsHSU9seo+vTpLMUuu/Hp/tb/o6GqHBvE4pSqQIW3gAlB74UcgYH
	L6amUEzOx7mlKEEH1AmcpABoFmo4T8ruiCf/IQOQ2wxIw42wQ/u1J2MerSl8ozyM5mc6G1fQwZs
	jTPbdN25ri51YToqYhKyJBN1y7ZDeP22YnN0HRXiS2AaVrhdcyKbv68euS0vOX0U3FMWNxnWiKn
	Lx7kuYPZTIeQ+HxuRtqiamGfiEYOl8SNqZ5lYoFelSxqD4IZ8rDQNsukfWdYCDfpCYx4qdKuEtC
	rI7luUdvmDi4ycE0xfz06cmkJozFqRnLycEwKHulC+AiNHY2Qx+SEpp7MlzdMl9fJn6cpJngCuC
	wL2flIhp95Ev7cUwYuR37Cy6EO8HTWUfxo98Oe84+ZkLVtP563vEsOsbVzkvJ
X-Received: by 2002:a05:622a:2308:b0:51c:1a9b:fa0b with SMTP id d75a77b69052e-51c8b403c59mr77399961cf.10.1783604163246;
        Thu, 09 Jul 2026 06:36:03 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41f1ee58sm155910441cf.29.2026.07.09.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:36:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whov3-00000004tQU-3mqL;
	Thu, 09 Jul 2026 10:36:01 -0300
Date: Thu, 9 Jul 2026 10:36:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, ankita@nvidia.com,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260709133601.GJ118978@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
 <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
 <20260707124321.GF118978@ziepe.ca>
 <6a4d95fcc92c2_2f05d5100f7@djbw-dev.notmuch>
 <20260708143153.GH118978@ziepe.ca>
 <6a4f0b35683b4_353c8910011@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4f0b35683b4_353c8910011@djbw-dev.notmuch>

On Wed, Jul 08, 2026 at 07:45:09PM -0700, Dan Williams (nvidia) wrote:
> > force_dma_unencrypted() does not *prevent* device access to private
> > memory and provides no security properties on its own. It's only
> > purpose is to inform the DMA API what the HW restrictions are for
> > doing DMA.
> 
> Right, to be clear, this mode's security properties come from never
> asking the TSM to enable private DMA while the device is in RUN.

Ok, that's a twist I hadn't thought about. I don't see a reason to
support a driver probed with RUN but T=1 DMA disabled by the TSM.

Still, if we do this, I think having the TSM deal with it is probably
better than making a cross product of the trust level, something like:

 echo only-shared-dma > $pdev/tsm/accept

So maybe accept should be tweaked:

 echo full > $pdev/tsm/accept

? It doesn't matter much

> > > echo 1 > $pdev/tsm/accept
> > 
> > And now it is RUN. So I don't see the issue with enabling DMA at the
> > same time as gonig to RUN? (though defering it to driver probe would
> > be a very nice touch as well)
> 
> It requires "accept" to consider the trust level. E.g. what does it mean
> to do something like change requirements after accept?

> echo full $pdev/trust
> echo 1 > $pdev/tsm/accept
> echo adversary > $pdev/trust

> In that scenario this now adversary device may have been allowed to
> operate without an enforcing vIOMMU, and needs to unlock the device to
> correct that.

If accept enables DMA then it is up to userspace to ensure all policy
objectives are met before accepting, not after.

I think the statement kernel makes to userspace is the moment it
writes trust or accept the kernel is free to take action on it. ie
don't write a trust or accept until you mean it.

> > > There are also buses and paravisors that may know that private-DMA is
> > > enabled for a device by construction. In that case it is also a "trusted
> > > to access" signal, and not a "required to access" signal.
> > 
> > In this case they wire force_dma_unencrypted()=false.
> 
> Yeah, I just need a scheme where modular bus providers do not end up
> compromising the private / unexported method of changing the flag that
> force_dma_unencrypted() consumes.

Yeah, the bus and TSM really have to control this property, it is like
the other DMA attributes (eg dma seg boundary, etc)

> > At least if we omit the double check it can be fairly easy to add in
> > later if it really was needed for some time of use reason.
> 
> As long as IOMMU presence can be enumerated prior to acceptance, T=1
> always includes private DMA, and the T=1 status is tracked independent
> of the trust level then yes, the cross product can be avoided.

Ok. iommu has to be setup the moment the struct device is created, it
can't add on later. I *think* the iommu related sysfs ordering is done
properly before any uevents, but I haven't validated that.

> 'struct device' grows some "request" policy for trust and T=1 that can
> be changed by modules etc. 'struct device_private' grows the operational
> trust level stable under device_lock() and a new flag to reflect T=1.

I guess
 - The active trust level should be RO visible to the driver, iommu, etc
   It should be stable under a bound driver

 - The "dma require unencrypted" property needs to RO visible to the
   DMA API and stable under a bound driver. This would input where
   force_dma_unecrpyted() is in the flow [the name should align with
   all the other per-device DMA API specific properties like seg
   limit, boundary, mask, etc]

 - The requested trust policy should be internal to the driver core and
   be converted to the active trust level right before probe

 - We should have ways to enable/disable all DMA before/after probe,
   including both TSM and IOMMU approaches

Broadly all busses get some way to convert the requested trust policy
to the active trust level (eg by mixing in ACPI, etc, etc)

All busses get some way to set the "dma require unencrypted" property

IOMMU and drivers should be sensitive to the trust level

TSM is sensitive to accept, not the trust level

Userspace must ensure any security policy is met before accepting or
binding.

??

Jason

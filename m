Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494E399CED
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269047; cv=none; b=U//VpmEqCJNI6ClDn+J7ETRuryFEBHs+M5gdFhSpYVSZzD3dmpB2IbZ+p2N/GdOBKC++DGkTrTCG1R9/SLxRWNBx6k7eJCIHP9yhc0Za6JXIL2wO72zFgleuEZSi1a5+RJphGyT4Flh88QwtXRlHxQ82iZGvIGXmjXsfEfZm+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269047; c=relaxed/simple;
	bh=InEVFTLgsWT02bOUOgnGmif6wey2/aq2SBg+dMmvUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekbZD5bkW8evrNFxv3u7LNMNOoJwrWRPe4aIetrfje0VmmPGDfVcMNSn06BYIer/dAEQcNQo9jhC0IiUlVzZmk9Nn9B8w/P5NBcmaExnUwXm8z17FEV5J+Cib0WWcwNBP3iWzU15ECsm3Cve+Eun0I1w5cabJygdZkEoOpcjh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rp4mxmyL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rp4mxmyL"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so30178685a.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787269044; x=1787873844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TwdiO/ha14aqZZoymZaYgDW2JuO6Qn7ZG4BkebgqYts=;
        b=Rp4mxmyLxFKM3khPtQnv8AQNN+TEFnE41PS0VIjGaV5W1aPoO3cAYN0Zm4cFMNXlaW
         cOWbKwlFuJtWm7Lrts2mNnBVwene3Hqj2/+7g29b+B+3rfpI0d7JON4VFym8HylqNm+s
         KrE8J8mwrv00W1nK5sjv0bPJT/RijsGmZ6290PKsCsDm27w4ZdSCXseD4dttw/ljNbmO
         1nRdTeFFm3yeCv9Pmz/rWKbWsEOcvltPbbM+itkCH+/mERWqEeH62YuJ2wqgqUELiZtd
         kRPKvvOBX8HueIOfrXUf4QuW3ok8bP2+oKdacGBfr+hazhqYnw/Cm/RFrt3DHPxFCgr2
         vpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269044; x=1787873844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwdiO/ha14aqZZoymZaYgDW2JuO6Qn7ZG4BkebgqYts=;
        b=Pn7ThBkCUqCNLLf2SXdICgP4+t33YbEjaEd4q7GYp8yyThEfl+EKQ0quM5hODwU4My
         Tk+UFqtVKK7VbgNrLbmomVuJ8A/bD+8pLFa2UidJSyZv9/O6eiIbJGd2GppKeX1aHWXi
         kvgPYBxNlxa5+k7RNpcKdx34J5w9zT7EmuBhQyjo9GKR7c/klHvFv1C8Lld3w1Tskso9
         JXSdh/ym2E8n4WSSJHP1jn8iKF+5yVtnVe4jCBJvrXXVFg8KRhI0/dmdADWJk+M30zgN
         1FKm3EMaAaQ+q37Dtdk7U8+QbsRuBeNA66nFJ7EzjppGxfu07oHPOPWdyw+GPL3oOy0j
         69Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Cr5aeXrGU7kxrKJusf5CxCAiRBmUWeODjFR0N2KN4TipfS4ZfL+rc+aT/WoLxh/EyDTBP3CYkkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63yCQWaaZkCLvq9jWKYAcLgpYgXzTFm8q1pCTzvCQAeWZTY8l
	ZNOAm++8v6Zuwx9z4XgVoRX+68RIbsodYuwjmTopmdCJS16Vd3svUMDOUaNMI6K45PI=
X-Gm-Gg: AR+sD13N64utEKSgCTiLNM6tEbDXOgAmtO5QTg+g6m3qaYuIS4SLmFMKzEqPpha2AzI
	+AB7mtVrzXjHSY0rgypGo/OZeuzRM/TiI9cGd4SZI010Rek6sft86VJaTedTXEEoOolGGgy+yeF
	3STOp4vmi0SXHkujKV2C4Qj9ECi8r+/m234bT5RVrlCyJBDlCzQ0wCq7fs6HCw8RV5HMPOJV7ye
	pZoIF8x67L57wFjjhGqMWIHJF/fZtEzHSsnVYGkLqaqZiJsZzNK651RreAYCZRAhbbOgKxUfoOd
	1XHPH8LRGi174L+BWhZM6fjOP2GKu1tR9kbiIJVSbUQtT8faUX6bSqrYOl2WQW3a0GejI+fpx08
	NMVSn0W4BcdlPARYzNrswDAcG9BQRdt8NALB9yE1v10fofFyvZYAPp3K0Kn9TvcI/nfQzwhbmb4
	0WcZX//sI8GyG2DyX/gpARhODBCLrs5HxTlmrUJnv1LR+GHEZ6ZUpMwk9CPi8GD5SjnSgYIHYvr
	G6Su58WiiWUOqGA5ZmSmjYy8Vh7NzMwtdBr1tfpsdDIMEs=
X-Received: by 2002:a05:620a:2910:b0:937:1e9b:be6c with SMTP id af79cd13be357-9373942b0e3mr192488885a.10.1787269044209;
        Thu, 20 Aug 2026 16:37:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720586ea5sm470176585a.38.2026.08.20.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wxCK2-00000004fvf-3PzW;
	Thu, 20 Aug 2026 20:37:22 -0300
Date: Thu, 20 Aug 2026 20:37:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260820233722.GA1110819@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aod22_H66eUth9av@google.com>

On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:

> > The blocking domain operation looks like it might be simplest to
> > implement in the IOMMU core.  We can set a flag for a default blocking
> > domain on the IOMMU group when we take_dma_ownership of the group.  Then
> > release_dma_ownership picks the blocking rather than default domain.
> > 
> > This is then unwound in use_default_domain, called via dma_configure,
> > attaching the device to the default domain in probe of the next driver.
> > Therefore until probe by another driver, a device used by vfio would
> > remain in a blocking domain even while unused and unbound.
> 
> The devices are expected to be attached to the default_domain even when
> these are unbound and the use_default_domain assumes that, and it only
> checks the ownership and doesn't switch the domain to default_domain. I
> guess we should add a WARN in use_default_domain() if that is not true.
> I will probably send out a patch for that separately.
> 
> I think we can move the device back to default_domain after reset after
> unbind, maybe it can be done in pci_dma_cleanup() based on
> driver_managed_dma?

This blocking domain stuff sounds very similar to what Nicolin
implemented for the per-function ATS issue?

Broadly we must setup a blocking domain in the iommu if ATS is
available across reset or you get these ATS related issues.

I think at the time he looked at doing SRIOV as well but it was
tricky..

Jason

Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468673DC87B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336207; cv=none; b=OExA4ewGDRaTvgMtpP7TudKK5Fr29coo1+BBAxPtUHUlbb+ntfzLTwnj+p7xLbULL9H1uxEIEls0e8SyFemn261vQr2LtfMPE9jkHOyQuWc5jDy45SNldmcoVWjek1hAJ6ucEkjD49fz0azpDNfWn/NHeepigZa4z+OKnFjYcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336207; c=relaxed/simple;
	bh=F2YxxOkKlKZBIWFURMEVCr5gD32ZZSGaaonobu2u2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn4sFxkN3Ro5anPcmGRqY2rNWpmevnrYQ6SmiAro+teVXIJcYBWvHFxjSvHDFZkOJfji5eLxXCvE+AkAJwOuhB6JKFt2qPFq6bhbSgHpfq8l+SAi2ZYvBRNRBR2iLjp9utSkp/OzREQ7yxdDAc2aTbRCCdtlqs5sVfRlEZ67Sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E1NRdFXs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E1NRdFXs"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176096116fso6058631cf.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336205; x=1780941005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
        b=E1NRdFXsS+4pI/8us9aiFTiuOZ3sFgLkvWFF8gYQjhL9p10cYcKjMOBYXvv4sxqA7f
         ydRtf4GiDXCaBMupES4/hXlcFnSXwn8RQxh0I1mEjN0nGV14FOysSjd4SISi6gWIaxtN
         TPiNcOLVHcu6hSOjseVGwH42K7itWDC/CeqG2srydRM7E74Q3FspiyCsOsY/RzvtwJr4
         crdmag48U2+0A5DGllHS29LIV/q7CJ6xbHawWxDVfCKDQWLVWaPQWep+8UPgcIqSBznG
         Nq+dy69bBB05kU1MaW3d7GeDAAZH4ZYYNg9aC+8L9UN9EcB2lhR8tQKFgR+mOIGE3nyV
         UQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336205; x=1780941005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
        b=j5r+kcixW+jct71UDAa/ard45wZVOqKa444zoEkJYmJKSmnoHhS4REbSPtP28ih3NK
         ikbRV36pUCiq8OSmhYoIU3gDIWSNZE8DoZgvedl+CycYCDnm5Z0GIZ3nyQXawlshIo3k
         M4gJlGeGgo94y47mnBnlwFEe0ljtIk9VGzmhLFWmKHkTyJbSqtA60JgBu+nTx8iZEjYn
         Mcq3wIfkvPkfeQpdszM0tIIMbt8GBdxWC4mE+/H9vJogKpUH5I2wqp2uEthAlXj0/Wkt
         d6tpKO+TOKdMPyyvS7zSlJWmNGR9WDOPDmfai5W5GOPUFRVIPNnHTErn4Zj28N/JDxEU
         EPGg==
X-Forwarded-Encrypted: i=1; AFNElJ8icFxcmFiwImrYHZnkG3VEmpETu/ao+5HIsEXcC056ZhWRjaykYGrjte+jo0bJB9w0GEwM+olDfEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotTpIUpx5wtc5N/PKLp9w9+G67zRVUt3mVclbRT6OjhjeKGqu
	B8kHDf6jRhi2GWHQyFpKMzbuIFOvymnsdqh9YMXQ/tRxiZu0DctTS3TtXfXaIXCMTfQ=
X-Gm-Gg: Acq92OGN/W9yVzcoucMY9PgSgzmhN5OgN4DAi+cPfaYpk8Y5ltyrE0YWlumoASM2yXm
	roo8vA+hxAlKIvtzIfRa81zG1Y9LS7lw4zgiX1Crf0m+lGFqovTOhUF7HmxX633A06MXseOqYVv
	x0od9IaVomRmpZT6hMyS78iSvTFI3YKDggUM1BOkXfdgE9/s3OHBuKaQeLicae+vH8zeoWo242+
	HN0yZ7itlg3mv20JfyXg1j+kBunIUFu4kCtnnSyhMdedRBrvMCe6t1QobS4KlYdqpREaYnMU2oF
	wa9ThJs8/DcMAT2lH1iSpNf9+RplcdjCmrgSLHENT3Jyt3w3xgbY8J0+cuYB/6AjdFdbbgrfimA
	VzaY+BSb2thYEDxGIKf/NQBVvNj4lwueE1UG8fnvHa6POBiBfwR1NZWwljNg2WA87mAtz1G860s
	nTLyD4cpskgg7cdYf0sx4EmYNpP9zRxZs2pHNHQiXqiUSb0qmXKJI2SIxcYO8bGKNiT1F7jTJ53
	YNYlJNa837kyx0R
X-Received: by 2002:a05:622a:1148:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5173a722af3mr169052191cf.14.1780336205151;
        Mon, 01 Jun 2026 10:50:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm60989871cf.18.2026.06.01.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:50:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6m4-000000027Uh-034u;
	Mon, 01 Jun 2026 14:50:04 -0300
Date: Mon, 1 Jun 2026 14:50:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Zhiping Zhang <zhipingz@meta.com>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601175003.GC2487554@ziepe.ca>
References: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <ahn3ovmkEq-Y-LKt@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahn3ovmkEq-Y-LKt@kbusch-mbp>

On Fri, May 29, 2026 at 02:31:30PM -0600, Keith Busch wrote:
> On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> > On 5/29/26 08:34, Zhiping Zhang wrote:
> > ...
> > > There's no in-tree vendor PF driver
> > 
> > Well I have to admit it's a bit on the edge but this sentence is a show stopper.
> > 
> > DMA-buf is an in kernel interface for buffer sharing between drivers and any change to it needs an in kernel driver as justification for the added complexity.
> > 
> > > - the device is a Meta MTIA
> > > accelerator managed entirely from userspace via VFIO passthrough.
> > 
> > When you have a complete open source driver stack which utilizes VFIO passthrough as the interface to communicate with the kernel drivers then we can eventually talk about that.
> > 
> > But as far as I can see without upstreaming or at least open sourcing the full stack to utilize this functionality it's a clear NAK to upstreaming this.
> 
> But the existing dmabuf for vfio-pci was accepted upstream without these
> requirements. I see you had concerns about even that, but still Acked
> under the same model that's propsed in this series:
> 
>   https://lore.kernel.org/linux-pci/57b8876f-1399-4e4d-a44b-1177787aa17d@amd.com/

To be fair that is quite different there isn't a proprietary userspace
issue for that series, and there should be more users of the API when
the GPU drivers migrate..

Jason

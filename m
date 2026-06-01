Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8043E00A9
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336058; cv=none; b=tWtb7msm/HMURKiKx9/DpW1w66XAzizI/FVQaS9HDyyhjYsSfqEV/estGWiaeL7/v5x1jndRJiDQyxYG/Or0DKTNj8H0dOJv7EiK9bKBcTeEDHIfe2WCdoIWjgoEABCD6awMhCzMCwKsuPkL7d4mh4L5Z6BZVXTbBsB7e4U0H4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336058; c=relaxed/simple;
	bh=eDqBBuInzy1c9i8vrcrIJaFNBUagTiKlEOwIxuahu44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1Yv0dA+8ukbnCjTLrMECRI79umZGfSXaoYsoxSqnSk/sqggYs1uu5lz9PV9cFA/scP9zXApteTZOVo8i5rUvX7kV8VnNuLO9B0Ck7MzFXfY6zkIBYPXo/NFUYhRx/ULiBrMIl7NJd/0ebJxuyW85ZqvljTriU4pZEic0cxykrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JBYhAqZc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JBYhAqZc"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cceaa6f75bso53866526d6.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336056; x=1780940856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
        b=JBYhAqZcrdFABjH5HkSQ6NJsusDEPyaNx3vvmooevzrPf3fMyIsolj2AUHjspXjR4J
         F+nNZpzC3j3+xoAlPApfQdRSYv+RnG6xCEZkXzj+zLkyaUM6f07ZA1bK029II7sRJZQ1
         8mb6mCs7R9a54RwfAQBulmx1bryRUrJlOdCYoJLLDXvqsVZl63EOjr6deLshJ19RTTaX
         QGzMfSIm+4yCJd6s95DC0nEXdjkww26ZXt8SONmsbMRO20uIg2ozGQXqZWMzQv56i6Vc
         I3XxWperKVcR5Nh+gvyaYcp/1GBDI9Pz6SOhcKd4W1FuS1+KYCw/MA9B8XunvL20LNGF
         MGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336056; x=1780940856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
        b=RKktCDRd6AQ87plGWJM8U9NHnzfmh6yopTj+e25lD5H7zaQioPRWg5fXHSmADWOTtM
         fVvFDhpgHBuz6KaHS7suQ8xOHc4I4HrGx3Y/0PUQDGYYNJDr/t/d/P9FfLw8t0XDk6yV
         g7rB7JMJ7x5G+c4h+L2f8UCQ2EnglpS3wGL/pg7H9ItLEzWKVGr7nPrb2rc9oM9N5xfx
         9G6nsYtdx5PLogKDvxkkubztfR3LJgTIZCmQQWC92i3cWRqA9DpgiFMSQH4bLmiWWwUS
         0MuPATanZq4H9yyiwkBiILhXSYyJA152hFVNnMA0wgFnIjZTSoJaT8CA9EeB13jFhAbd
         Lkrg==
X-Forwarded-Encrypted: i=1; AFNElJ+saxxY8tsbIH4q9SsEs0fgZap6R5q0jzxcQMoaC4xm/pvE+RglYx/+lU1Z3NAXDuYx+RpMPy1+Ft0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5TdDUj4CWoPP13vhWG7bffwj1kYHG4iZWAzgrr2PJQdGcSm9
	6HovTuB6Ec/s6d/Bdujoj6syU516a4EFoMVaFGCNorxuF60jxtuKHlNXO635s059rhw=
X-Gm-Gg: Acq92OEaMVnQtS35xB0YbTtvTuWpBugpO3Nt9hc18Cdrmp9WDYvtRzFXJauNaQSmZU3
	06kAFIk9d2Tp8LNHsEYSwJzXsQ3ToYtdijwc1UhHV+YcPmVCu1rBKT7iEyHvbwLvNda/KFXKW0m
	J68CNrXlmdHf0a2JTAFx3voNycK1+dabWJU67ul98hSWH6KJ7lFgyfWImpTzWqr14j3jIt8fPXD
	Gk90uSQPOlXM5NQldvtimXSZt3q1W9wBHPFTIvgCbuH7zv6eD/oBgjP3wbJMN5Lsw6HzFLsdsII
	SH1dNsyYKO6t45FOHirOOx6IRaHtKibqCr9J8FEu85tZcUMWNb2JRvM/ddzlt1GPJylYUf2L52E
	NjRdavg/rO3STSMblUCWve5hiRRZF3uoc5Oy3c2ewf6IL1aY/17GEoyPLz4yu6uIE2240uk3J1l
	wS19XdrVRqLdEJSegJM57ATO455neyxCAFe3v78cfTXtd4riBWRdv8Z1QEi01kgk/vGzM+VT95R
	GzbmFpwmlOpaFo+
X-Received: by 2002:ad4:4eec:0:b0:8ac:b258:71d1 with SMTP id 6a1803df08f44-8ccefb29374mr211892386d6.3.1780336055817;
        Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea25f64bsm96664256d6.47.2026.06.01.10.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6je-000000027Jd-2qcE;
	Mon, 01 Jun 2026 14:47:34 -0300
Date: Mon, 1 Jun 2026 14:47:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601174734.GB2487554@ziepe.ca>
References: <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>

On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >> When you have a complete open source driver stack which utilizes
> >> VFIO passthrough as the interface to communicate with the kernel
> >> drivers then we can eventually talk about that.
> > 
> > That decision is not up to dmabuf
> 
> Yes it is. This is the DMA-buf API which is added here.

It is a DMA-buf kernel API that is added, I think it is overreaching
to try to veto a VFIO uAPI that calls it..

> > - what VFIO subsystem requires to
> > accept a new UAPI is up to the VFIO maintainers.
> 
> As far as I can see vfio-pci is used as a stub driver to avoid
> opening up the real driver.

Yeah, that's probably true.

Frankly, I'd rather they use VFIO like this than to upstream another
driver for proprietary custom built HW which nobody except Meta even
has, let alone can use.

> Upstreaming an API changes only makes sense if others can use it and
> this here is something completely special to this particular use
> case, without all components involved nobody else can use it.

It is not 'nobody else can use it', if it was true VFIO wouldn't be
leaning toward the uAPI being OK.

This exposes a PCI SIG defined TPH capability in a reasonable simple
VFIO uAPI that can be re-used by any other device that happens to
support TPH on inbound MMIO. The uAPI has sensible general semantics
based around the PCI spec.

Anyone can repeat the demonstration Meta outlined in their cover
letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
analyzer and you will see the PCI SIG defined TPH bits set the way the
VFIO uAPI says they should be set.

There is nothing uniquely tied to Meta's device here, or unusable by
someone else's devices. Arguably this is actually a mlx5 feature to
allow VFIO to control its TPH generation HW.

For a long time the general kernel has had a philosophy that as long
as these niche features are generally implemented and *in theory*
usable by anyone who wants it is OK. Every knows the initial userspace
implementations of *alot* of stuff starts locked up in proprietary
software owned by database, and now cloud, companies. Yes, some
subystems are stricter, that's OK too.

> So as far as I can see that here is a no-go. But at the end of the
> day it's Linus who needs to say if that's ok or not, that's why I
> put him on CC.

Well, based on what I heard when I argued for fwctl, and the
discussion with sched_ext, I don't think implementing functionality a
standards body defined in a logical way is going to raise concerns..

Jason

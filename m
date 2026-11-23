Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447536;
	b=pFT8e3X3AYuNKWFTyqpCvAbvhoJOJAFeTKNeDUg7XN3MbotPCQ/OV2EqlBIx5974EDgH
	 hWWYXm4EWuJWm3lYasb93gP0VCj9hjQ1IDb/jFC5bkmu3QByH8n2pA04IJYOUudn9Z5nt
	 Ty17G+NZgfyCXtc1WMhXaWXo1J42QBTXz+Ek2ap8oUiCPZdYvS9qapdJxZYo1QS6FI6fD
	 Ur4s3oRTA7PUX9nLN9ISTf1Xgn8kq47Ny+24IOy3FQ26gvOlIYqj1SwLertwIFloPjUMm
	 gsYH84Fthe/6Xgl42WmLimTnRR8hj9lp4O/4kYzCYH11u+iP1ggPUXcu7xnvCGZXKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
	b=pc/WoO91WHKVA3O5zubflwzOyo5Wq+hhFk6Q0a4+GRb4/YfPYyCyDaOMhTVNyUQi1RxR
	 vgYCtZxHEUEqpkd4C7D6JBAgQqtktUchlZ8RCZqAoQPfYwNgrb3n+U/HJoW8Vf1juJGI3
	 wexKmON1XW4uD4p2rWQSC1/YNM7hmbYtYru/V1wCQZsiDr3Ehxfp+BYFK3sH/3PCc/315
	 hAAh2Az/BM6IZlr9vUAirwGyD0KDJ2kl+9OHLvgvG6PEffUCQciAGN9NNDw+TkD5jT7ie
	 TFgb6KIIXueU1vjHXMzKLLoPT/HO7T0pqGxMLzrr/WOFUSZzeZCUiLPyKh6DQMnZ7TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=geoPWgr8;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D606A68D
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF53D606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=geoPWgr8
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-536717a4d83so27770881cf.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447535; x=1796052335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
        b=geoPWgr8pjlKGEIIcx+8rA9w4a9tBfQSb+P6nZ0h8OI3kaSiBQooskyMLiAJ7nlLf3
         62PVhWMEdz5UigRXrToyzNc9e0u+Bnx9964Yqkk2CUTWiptoSuzymfa8TmInECK2oyjp
         2Y3pBgJpgKxlNC83kDnU9shnFHCC/chXWN7qFVTmPhxi397iv4CpiMsbnqHxSVtHcMb1
         x9KNCHsyDTvdT+iGfKlkD8pvhc6lRHiq2w3l4NpZgI2wTy5Rn0aX6pYfw8HVx3P87Sla
         8v4avs48PteoKsIj4PSk4s1imRhLqSsK394Oq1RM7vWNYz4iNmtSsFWQDB7FuAhiI77I
         0tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447535; x=1796052335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
        b=OltQqMaoXfBl7EURhH6LM9ekJETbGF2ExU/c16ztdvec5qkDetPE3nDXfnBmTS6koA
         R9dYd+jtDwtPK7mv1GJHAMVbyhV7gh5Ohm9jtr7w4GFJ+sQIo6W/8mzvEtnZgrkJebcI
         pdH6QvODzU4ImeoUIfdOxS5E6mJ4bzdku5LEl8wzLSMtCO+E9D8Quynh3xaE9vPceHGv
         SBSC+HTuQF9BdcLXML8Le9NW76GE20ha4+Gu7B6n+tZnNB6mQsLq25SNAVJ1NJ0N6U3R
         oL753GEofMot2vf/stLKTo7qkCzUsG3ACptM6ggmpnUu+la2g8vdfGwHVRG7cRIycFGI
         DuLQ==
X-Forwarded-Encrypted: i=1; AL+hErFHOB1VMGTrjU/Q4o3jr7tV/ttYY4wOnegOaYvSwnJbaJ4pjLQOaTxhfdQZHGT10IkWJrU9mvqLbEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wnIGuDri7RLkI9QbPP7uuWDLfbwF01Xm7+nI4h1YHVy4BA4+N
	isuPQcXOY6ytAJ22kgzKyCADxFZU3UEaMl+KX7qu4KEtUUJR0TXR6k6b0VHfqdGBorE=
X-Gm-Gg: AZFdTZfNZMmNYUVMIl7eK/hMrP0lqU/S+u/KPmubdBEvdGVkcC5hBhQ1vgTzhvZ1R0K
	1VYC1krXveF1mvbpQt35chj+fB6EQZyMkJLxt7vbr1jUB598kx4wqZNeAZwgEMferQOtFCn6KT3
	4xy496SoAbs8kWZwKb0KLCWOWt+MNcT1OleJ0c5/DgS6QI6ZAUCIEAco6uunL4fi7NgBh3zfiI7
	QkMLb7a+Ns5sKrmBhzghalkADIWZB/twpCG/L89fy7BweUl74h2EIz9NB2RfnBqXOvQ40QGBRIR
	dCmn1y++k+ZfxlDFtzdi4amLIr13BeChk5jCnd6PeyInfMotvIl5PlC+zruyLLS9YhsdEF4l/55
	ksUY2RDDB+XMOlpu+V7CpESU2ULaw47C6mgi+z+ssyscBxL/pqcQ6oC+yxoLGAtMEnAZ3EFmyt9
	IWfbXESX6792IvFZRmtTXss6dB29Xnt5laxrcC0cbLotZZytbGNqB3kFJuEsIocr4qr07KnCY43
	oWqkv4rdtKGgRbgJ1HIcdZ1AHTynw/EWqP3b6ZB2jh38gov9W8uYuRGfflw+x8F9BMMDhtNCxed
	FOvupadcZq+HcWKYB9aYrnlkWj85l/Fh4D4Hxy2M7wMRq+bEqRyNsAuT+UsFOomjaqk0bCD7aQO
	TyPg=
X-Received: by 2002:a05:622a:a881:b0:536:6f7d:1145 with SMTP id d75a77b69052e-55d76a27f9fmr215459771cf.21.1795447534734;
        Mon, 23 Nov 2026 07:25:34 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78807b5fsm100671031cf.6.2026.11.23.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:25:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVvB-00000000sLi-2ANX;
	Mon, 23 Nov 2026 11:25:33 -0400
Date: Mon, 23 Nov 2026 11:25:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261123152533.GE179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123135638.GO14811@unreal>

On Mon, Nov 23, 2026 at 03:56:38PM +0200, Leon Romanovsky wrote:
> > >> >> But it should not, as you are making driver core changes that will
> > >> >> mirror the same thing that that patchset is attempting to do.  Please
> > >> >> work together on this.
> > >> >
> > >> > +10000000,
> > >> >
> > >> > Greg,
> > >> >
> > >> > This series came as a surprise to me given the fact that device trust
> > >> > series is exactly for that - allow confidential computing.

Device trust's primary role in enabling confidential computing is to
give space for the userspace to do all the TSM and attestation stuff
to get the device into T=1 private DMA mode.

It is the userspace that does all this and the userspace bridges from
"I got the device into T=1 mode" to "Now it meets my userspace policy
to be trust level Full" and then finally "Now I can bind and start a
driver"

The two concepts work together, but they are not linked inside the
kernel.

> > >> > Adversarial is equal to the "cc_accepted".

I expect most policies would make "cc_accepted" as a full trust level,
but we do want to allow adversarial as an option too.

> > >> I think the confusion stems from this thread:
> > >> 
> > >> https://lore.kernel.org/all/yq5amrr8yldi.fsf@kernel.org
> > >> 
> > >> Based on that discussion, I understood TRUST and eligibility for private
> > >> DMA to be complementary attributes. Device acceptance determines whether
> > >> a device may access private memory, while trust determines whether the
> > >> core must enforce additional restrictions. 

Yes.

> > > Device trust does little beyond preventing driver binding and recording the
> > > trust decision in "struct device". The missing piece, which I would expect
> > > you to address, is ensuring that the IOMMU and private DMA are configured
> > > only after the trust level has been decided or as part of that decision,
> > > rather than beforehand, as they are today.

They are orthogonal and unrelated.

All the TDISP and T=1 DMA flow is about how the DMA API works and has
no direct impact on trust level. You can choose any trust level for a
device using T=1 DMA.

Getting the device into T=1 should influence how the userspace decides
to set the trust level, but it doesn't interact inside the kernel.

Aneesh has it right that these are orthogonal and unrelated
activities. There may be some confusion as Dan attempted to couple
them, but after discussion we have moved away from that since it
doesn't meet all the use cases.

> > What I am still trying to understand is how you view the DMA allocation
> > and mapping paths determining whether a device can access private
> > memory. Paths such as force_dma_unencrypted() and SWIOTLB receive a
> > struct device pointer and need to decide whether to use private memory
> > or shared buffers.

It is Nicolin's work here that needs to go before the TSM drivers:

https://lore.kernel.org/all/cover.1794343501.git.nicolinc@nvidia.com/

Because that is going in and starting to fix the DMA API to work with
T=1 DMA devices.

The TSM side should sit on top of that to enable it for PCI devices,
not just integrated devices.

I think for now lets just focus the TSM series on the attestation side
and we will tackle the PCI and DMA API issues as another series.

Jason

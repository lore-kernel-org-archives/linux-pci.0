Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527398;
	b=t9kajASHjAgYRo8ONecLJ9WgCOvxvVaVEByhVLh88HLpxRKghjlXeACGcJHvI00NRH0G
	 i69zI6sVgCweFNs5R/PuORQkC+YF1J9s2l8/00zdXnCLBj3ntMnng+I8qCsjcf0xHOwvm
	 zcM7gCKv9vIi/e56r6erqjaqLF08SPNs0zKSYco72EMFPQ7DApZJFyewwyTz1hSsmuXJF
	 AOzii1Uz1j37yyI5b+NpFUR9XvFbUNXDu6DInSKg23zjAj8cnOddLfL/P1qIyB0uGwoRU
	 ovTW0IstGA7CoGT9c3sQsvMg7BPRyQChA7gpre+j6yKRtCQZB/a0UYgJqW3SQWeEGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
	b=vhsEVjAehr1YFPRcQPsH4KPnIO3NogVCfhE6jfw/9ZLfKeCAexfG5HkIhSJICXiuioCc
	 fRsnpFz5aUHyjn7ffrImSKRelhvn0yUsyHeHOQYe9JH/gPbRxnOD4LqUYrA9s/w5+iilR
	 ByGhju63XECiERnJPFSudnh4rH2g75y2/DzI4arhjYCgVnzXBvs4b5PZ2G4JQmWyv7mOG
	 BB6ncRPy/6xIHBWwULwDrgCTkcBXqabjHQ33kR/Cj5V0hkGEWw+xtAYm6K5mv5D1LsLVh
	 kvkRlmZdqtbb3hNpc/euV0+WLSb9Mcf/W0Zbh3pNfSN+mXJVvFJMU0WePaO14q21R5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jWEiKbZx;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E54606A321
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E54606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jWEiKbZx
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-920fed989b2so44114056d6.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795527397; x=1796132197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
        b=jWEiKbZxUbf23XYa4DO019H8IcOJyHi48JriuvrWNnMl/TkrZE/2w2CA+xdP8mHd0B
         bF3QgczPIfqD0I+2djEq4qJW2K85/O753X+5lrKGSgHCz5fr0ymS9Pm5z0WJYSM5wITI
         ucZZCgYeCPH53q6GduIMNWU7lD2jiavMIcQ2NNg7aLErcnXMiecoUO8h/fRmS8cvHF/z
         m5iokFSrqnSjv8RC+7djwlwebzw8hUYo8F4R8yWxEMM8m4JdAMXUe7+lWOghXoZY+H7d
         3v+ibml+ajSOLGIxoOp9yt1gYE+O6PPvMVC0qTG+afibB7VeVUu9FNoi0ab2PbNrNxyr
         klRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527397; x=1796132197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
        b=m0m5DK4Bb1pCDO/ql41iGyc6wEJqCkSV98VGogxmlQLoOSdBzm+W8qJ5GFNjVjKxdG
         wKFvljxiblnU79OcGyZnYdhWJ5lV6XueWLlr4WaJGs3wVNlHqKnWxbiI4LmKrCczDr2l
         +ti1rgft9qCtYMHrsjAgnE8fxlF+tDSPGD7Kd5MyRnB0852yKsoH2rEJos4V8OZsjTd2
         JmOdUxd+1Dl6WCMduiW/TiZmQeHojl4JZ9p9KQyP7sagIQoZbLeaC8n1/HxawG6KKj/I
         N0lTM5gDI7wCfpwsAKIsGEusiKxmWJtJHmE6PWYjh54HYuoA7QvZZBOg97XqmQjCpBFq
         bH5A==
X-Forwarded-Encrypted: i=1; AL+hErEOy6OXe0pLBZYHYTui7Ke5t8vI/EMM0MNRBZSCfdok+rjaarMtAZI2Bh5edLLEwIkXLn2FwFhMPps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7a3/Z44APjgW/iENoRWt1Ganrc0VGB4I+1p/E1O3jLIvdZX/7
	iUjQHHt3C/z7qYZSuzibJCDjQhz/fsGhgjnapSt5WVSNI/N+oOJ/qv+ReosP6GGxpxM=
X-Gm-Gg: AZFdTZf5ALWO1kyUDYxAIY9+Xr/9D0r3gnZQCOv5jVnHWZ4+462COa03s8p4ulZsYio
	2f/aqbk3aegWkG4pGmFTMebs1Ls12v8LWUCM6d6Ldx5lOm+1KGe5/AfgtpCMLIX0zmiGaekE9CI
	tOSZcNofLt/fX9OHeUDjzszsknQI8MVIGA+d6xnHuLGV7ykcih+UjlR2G4z4tAs7uIIW855bMjQ
	q+9xSaXpSdfSWlbJT25vV2V5qkpatnEB2dPqmJCuwlfkIscxfrMmAlbfkPOkuyIMxUpPloQqH13
	NmQ2byOAB9IUZ8NRsc9nNXbC/RTSDary//b/UraEFhvEg3WTVXg5euvn/WfFGtqsOUcKkQ7LsG2
	TOl9wsc148onZNPl46JQ+IHEuP5C31bVOJRQ+qkQpn8AegEzbEm3TvVFjtnezbqjIjVc8ONV4xC
	irBSI2SHs0aVBLuPT4t9kAHs06MAX/k7lPgmxH68RkqOB+KSrGkuJTs07OgRh1tZnxC+v5Y6ywp
	5hkKKeP08MMkgCUwri8E6mAfqrCe648zNB58F8s2342gdDiYdqVuq5otJzQn0sjdIciKoGLJjP3
	vfVQSnY=
X-Received: by 2002:a05:6214:4412:b0:921:435d:9242 with SMTP id 6a1803df08f44-921435d927fmr200448146d6.47.1795527396835;
        Tue, 24 Nov 2026 05:36:36 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bf848dsm134683816d6.44.2026.11.24.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:36:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqhH-00000000PyR-2zMF;
	Tue, 24 Nov 2026 09:36:35 -0400
Date: Tue, 24 Nov 2026 09:36:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jianxiong Gao <jxgao@google.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev,
	Zhichuang Sun <zhichuang@google.com>,
	Piranava Tamilselvan <piranavat@google.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
Message-ID: <20261124133635.GG9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-11-aneesh.kumar@kernel.org>
 <CAMGD6P0pNAnq9U80dnpgbz+hHbX1yH1bdmXjcie4oiq7KizU=A@mail.gmail.com>
 <yq5aeccabo46.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aeccabo46.fsf@kernel.org>

On Tue, Nov 24, 2026 at 02:30:25PM +0530, Aneesh Kumar K.V wrote:
> Jianxiong Gao <jxgao@google.com> writes:
> 
> > On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> + /* driver_managed_dma is unsupported. */
> >> + if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> >> + ret = -EOPNOTSUPP;
> >> + goto out;
> >> + }
> >
> > Hi Aneesh,
> > A short clarification question on this check: once a guest TSM driver
> > implements dma_enable, pci_tsm_dma_prepare() will reject binding
> > vfio-pci (and other driver_managed_dma drivers like pci-stub) with
> > -EOPNOTSUPP on both locked and accepted TDIs.
> > Is rejecting driver_managed_dma just a scope limit for this series, or
> > the intended long-term policy?
> >
> 
> Wouldn't that require an IOMMU to be available inside the guest? The
> current implementation uses dma-direct, and I haven't yet looked into
> private memory access through a stage-1 IOMMU.

Touching driver_managed_dma shouldn't be part of this series.

iommu support for shared/private memory is its own thing that should
come with enabling guest vIOMMU.

> > If it's a scope limit, is the expected
> > direction for in-guest vfio-pci to enable private DMA when it claims DMA
> > ownership / attaches an IOMMU domain (via iommufd or vfio_iommu_type1),
> > rather than during pci_dma_configure()?
> > We run a userspace accelerator driver over vfio-pci inside a confidential
> > guest on an accepted TDI (similar in model to DPDK/SPDK), so knowing the
> > planned direction for driver_managed_dma — and whether any upstream work
> > is planned for in-guest vfio-pci support on TDIs — would really help us
> > plan.

Is this with vfio-noiommu?

It should eventually work, but there will be a variety of
complications along the way :\

Jason

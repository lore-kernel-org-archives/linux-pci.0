Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAD3ECBEE
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884548; cv=none; b=aOS1XB4yLadKar00gXBHVPmSKjeVG9nDAMPyiMvIYu0E4cqJwi4W/uUfDV5Zp8b1yXcfjqANzVnf1cpMMJZCpz0KgVH2G2uXxEvDv0Hzk05m3pikVludq6UQH8ZOc7WWO0qlqak65mvinJcMOXxG2gsNn/f0rBK87C/AG6BuzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884548; c=relaxed/simple;
	bh=43M0QEo0eyyWPrbH4y4RCOZ7Hh/aYFkSTUf2UUibSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shJEuUtW+WxVIBkefbAd9EWKFhGwV19yJytp0E1uyYWjnceu9lZwnqp9GDAlh5N2VQTJjkA35l9TdAh38zzbqOmyZNZH02RsjZipt30Rqw2jq3auxXt1BnIejNKk3nlcEGGwiIRO8zgrl3udWxSPtq5oXUz/BqbqqxSsYCj7hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XsX7GuAu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XsX7GuAu"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b59772d441so5073896d6.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884546; x=1779489346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=XsX7GuAusaCW2LmT6u8ew3/AzUb4Xjxt9X3vjamS4IL1RmGAU3MR67ypmronfRfXyW
         E9y5QRxboLE3xsIS0gaVfI4K3BugHkAT4V3ABCEecxlDiB8tZ2L6mCeSHIEyTMjh9DoB
         BDhQJ8n1dGTTMDwbS8pH5Fga+FyizW0/5r4gbRmPlKm5rmI12FMQKJGg+6owsc2Dyr8i
         7d79LfafVPeV9yJyPzmy73OCqQI70UuUFRGgRFYtCCmcandMKqZA7Svkot47DBtDpU1D
         Z08l7bL2P5uO59hLhWP1kcSDSkmRqvWVnC7RLV3yeWeThxRbNW68z2gmfu4Bz4ER7HCg
         Pr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884546; x=1779489346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=SJoCUAeWp79eQPcaz7FpSk+U0pFodFnvdml0g6uN314ouRPLXyvuR0kD/5LOIJZCjm
         +UZKgKgXumjSP2aGw/qizUd4K8Q4Fny+JRnhRnMndXDHhq7eia8Te8l4aJ9D3zROX10Q
         qKSqkKzF/B58I+wVxWfdAIQwkwjQzYfRU2NkppM9k/66ny2R3xCE1p57nBqbqS3Ls9v0
         P5VrS0IHe5ROh1x74rt7nH4sRCoOr/f/kGzZs8+LtmfrS2dThZDKnt8ijfZEWRm040hT
         VBqhQKbsSRgeLx7ZfzwFcJ6AyXvCxVGftHCpYepUUfw1FgsLwqkkJRHPCCMEC6dflBic
         F1jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/u4u8lS6xXfR1y+1bk7KrfwctvtLXcP0ZfJ2cIJMScrOAz1D5+z5Jkv3QYibratWJq7U4hIlNcciM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKBKQcCI/Bj/f65mT+xdqHx0OeMlYC6ddt8LKI3AOozsyA2zg
	WnFXVqxbduSYd9qf1i/G6SIiITSp1asfa88QMxY9JTMcx6RE/haSomWSTuTnV1oCwTI=
X-Gm-Gg: Acq92OEgpx3LYc4P9SLoKSwg3aUHhFoe45HY0mlNep4731WePeHkOGPGMLLSZmcemQA
	n1/F1RXWeu1PFR7hdqkAPiWCv1q+5AG00+QqqPlJqFLnoZiWHGXhNDzAwkDeSfXC+q2oec99EoV
	FepXXG/aMssr1OoaXP3OeeOPb6pXO9g3u6f83m7FDUYR/H2Mcr94g0+NcHtlGaTORrH2sRFCoHI
	xycJ5sf+M3QK2Xr6sVpbWT1Be/MJuFcgmOHoYR+1JAPP8wwr8tCFWovFF25q0T8Uz4Cc791zper
	88Gdt00oT0aNv4NiKcGOBpIsCU5OHHxi1AnkyGm/UU0TAJ6gyEvHQ+ebYiW9r+W0jN8+ReyW5S1
	GVlISiWOT287zQ3O7fA1WlnoRZX0tGEuwQSgBvT4veTFnzFZISbT/RaJ3uj6pC2+Th3swkMBPGP
	9MPxJydHIq0YJdaxyffo3kWo7a6TrAlS73i7hoBidh39Tyzd3ss9PzwmnkRQ2C2F7J22WhnOGKf
	3tszDTujZYL/loW
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr952694285a.56.1778884546078;
        Fri, 15 May 2026 15:35:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baa3c045sm682967285a.13.2026.05.15.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO18D-00000008EMQ-0W2r;
	Fri, 15 May 2026 19:35:45 -0300
Date: Fri, 15 May 2026 19:35:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260515223545.GL7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn = start >> PAGE_SHIFT;
> +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> +	unsigned long nr_pages = end_pfn - start_pfn;
> +	u16 count = 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align = __ffs(start_pfn);
> +		else
> +			pfn_align = BITS_PER_LONG - 1;
> +
> +		size_align = __fls(nr_pages);
> +		order = min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift = order;
> +		iova_list[count].page_number = start_pfn;
> +
> +		flush_pages = 1UL << order;
> +		start_pfn += flush_pages;
> +		nr_pages -= flush_pages;
> +		count++;
> +	}

This seems like a really silly hypervisor interface. Why doesn't it
just accept a normal range? Splitting it into power of two aligned
ranges is very inefficient.

Jason

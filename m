Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416030BBB6
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098623; cv=none; b=cQmZFkgmk0SEDrSsuJOeAuliNlSc8UfKl5+u9CMSrcfdBJxJMQYQDW+nSyWWfs7A6XQwGbGqJsFLzU/g24gvyZ2Ae1fMAseSN2xBRScLCSDQ8pR8YmK+UaW+nESGrJaOiZ0+3KCvIoLaEUbbIzeTzXpia9DAD2+InVnHkZhba+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098623; c=relaxed/simple;
	bh=JqbyUGSlLgU7xpTZ+Kst/HuDrhY2T70S9MikqXlpd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT9cO1mKiQ9TjQlPTxCiC6570RLCjiKU49B5N5y7ibOT7wjbfPyC916wqaOTWh0gRgX4DvrX8ZpHEKV9t6aqJYiYObse5LrRxUQOC71DqF9/f7TSWN8HPt3jUGhNAdfOelQilxClypjRjOhM0Ull0o3Hm8rNlmPA9nRvx1LiHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BJNelsAl; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BJNelsAl"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e57a753f9so57374285a.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783098621; x=1783703421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=BJNelsAlO6FnCo9zXD9lU+4SoRJW3Tg0r1YDSlnhVtpce/fKXpv6TZQ96ggJUP0RW3
         OhY5I4MRnhMRmVVyF5tufLWyo6PRrBE2WMLMJ/fTAu/xd93sqmuhvsCKXrIHPo0AmOMZ
         Fwvb4f4cZNrgoYyiQ9FrQoQKs5K1CQtzKoV7BZd1wh/H0/vDSidipaNbRED6rpYuaodD
         fLFSsYGJGrSr9QGerD2znfRfvnicK811K+ffhJuhXjbO4/wWWAGx5M0+zI8ucdQqk4Uf
         9bpxIv39X++mU0XhhvBHWDFMQlFmqDCzRtt6RDDyj+lTFDDkk9rCxOPK09J6QQfYMFDA
         qsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098621; x=1783703421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=WbOiCKC3BSdWh3605AS/LuyBARyLdS5Lcp1cSF1PH4BRQ86JWvw+qf0CmkMQcAJAl3
         nDVDFHFpFdRSDefU/ijm710RNGv4ybRstpXdU9sX57NgYuZT03yCCMtFc0JzF+bUl021
         NvkAVhgiWwsayb5cxwN0fi2elY8irFJiSxqhH5WPLWt1EN99oDILVgajRqw2FCOS1fVc
         m56mrlXJ+9vTDuXy2X6HC0m2RV11w7UeJJ2H+K9uz3TFYc7U4xF5x0jo/FS1ubVjnfYQ
         zNUm0uuyDVgRnpz1rVmgiTDuRMs2sc6uEbdCu+Po25LxaaC0j6rFhdXV5H0o46yNAHrH
         hX+A==
X-Forwarded-Encrypted: i=1; AFNElJ84GRgQihCgu7CbqzDjTEdmdSe6Dzdyiz0DQUhC5It7Pm15FqpSt88P4aMA6visJ2kvZtHXdpYWxl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JZx1hxvWmyVtFNc5jvG4yYqNP7q38WAO/xvvJVD4M35ndBsI
	tizBRvUVj+AqLh39d5fu91KJiT4uIcNKzxS//mgGNZMt2ycaayVQ1MmiOCPgMSZLqa0=
X-Gm-Gg: AfdE7cmnagGl/ejgaO2pAZck9utiW5+V40oUymkg5TfiiKaiVstmUbbkx7Gq1ZcYEO3
	uRR7Y8946HoZHCMeyEFVmZuJ6f756km5FVTs4BdRLGtwUpIAhU4Ljr1abCymGPkrpHU77v4N21U
	zhwHSPIFoz55zHMUlAcQaWN3Jxad/KmPTYnXwzSofPtoCR/LYSeBs1w8+7gysYCgJWXmAgWXR8Y
	Pg+Xs367DWpojqC5xCNMz7vckrJJ3r8zP9cE3Ch6n2kGSVK3QY7kXkXOq73c58JkXN59ByBQeR3
	CBQlADhS7IMLLYW70pdiiwCvzYf6gfrBUE6pReyDSOJT6Wzgs5MJzTiYjbRKJ1xbqY0KbSyXqhw
	0XJClC3NzvcQeAaJX4eOO7xgqPNSh7nKTlcTTB8SUfbAwPt/l6Vw+OUm+NO+uEPSVRfbK4EhyTX
	Sof44NcRJjq2RglMJxOZm4EJ9CNXJctf93xGQUCFq1GbF2/syMtFQRPGSlj/4ihEL6JXE=
X-Received: by 2002:a05:620a:46a5:b0:915:5379:b511 with SMTP id af79cd13be357-92e9a48e177mr44923985a.43.1783098620659;
        Fri, 03 Jul 2026 10:10:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm200315285a.35.2026.07.03.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:10:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhP8-00000008GuS-3eyQ;
	Fri, 03 Jul 2026 14:10:18 -0300
Date: Fri, 3 Jul 2026 14:10:18 -0300
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
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260703171018.GA1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>

On Fri, Jul 03, 2026 at 12:05:18AM +0800, Yu Zhang wrote:

> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>  
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligned.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn = HVPFN_DOWN(start);
> +	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;

Pedantically end can be ULONG_MAX, you shouldn't be adding to it since
it will overflow.

> +	unsigned long mask_shift, aligned_pfn;
> +
> +	if (start_pfn == last_pfn) {
> +		mask_shift = 0;
> +	} else {
> +		/*
> +		 * Find the highest bit position where start_pfn and last_pfn
> +		 * differ.  A range aligned to one above that bit is the
> +		 * smallest power-of-two region that covers both endpoints.
> +		 */
> +		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
> +	}
> +
> +	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);

I think the whole thing is simpler if it stays using bytes until the end:

	sz_lg2 = __fls(gather->start ^ gather->end);
	if (sz_lg2 < HV_PAGE_SHIFT)
		cmd.sz_lg2 = HV_PAGE_SHIFT;

	page_number = (gather->start & ~(1UL << sz_lg2)) >> HV_PAGE_SHIFT;
	page_mask_shift = sz_lg2 - HV_PAGE_SIFT;

No overflows that way either

Jason

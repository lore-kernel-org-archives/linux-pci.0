Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C49314A8D
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537839; cv=none; b=SPHYg+pJj3fyjZK9Cm++KAICbzpPy8hzqsbVe3N3bs+BF184ne2FWEECiuHDkmxVs98hY/GNPAKfXSF43KUrBTPKqIOUMg460ANQXlYPyL1Xc29YtWC5uRl4dgOdQ5y1mGppE7oXGQRNuCKpxJp7+2rgMqPTpT/ekDV/5P8XwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537839; c=relaxed/simple;
	bh=oPx8rA1LxifIFXbFQU3CUDbGAZuvNtfeA5eTxK6h5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNfGWEgvs80Hg7XBw/+TPPFFVwypz30HSHho5z7fqQdpmihkdVTfNBLcM99A9Z4mYfLJ6o34kUvhCo0uy4j355RDLVDrgZmfWVh3LmhIJo+NXmihXHzHbiGf4gKgJUt/FylD2bJsjx2BeMfKw24tIcnW/Uq7erUeTyzstfris3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K1DObIFJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K1DObIFJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6391b114so75218185a.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537835; x=1787142635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=K1DObIFJ02M62a8WH5OMJo0XF8ybEoV5IKOKtoneADLfcGcd6D13fy71m1wkEHHor2
         TPme1C5Gi2840NobPWnm62GXfVqvTuoIJpbQG6LQabrmCciRAXa8JcuDN2FEBfb0i4RI
         xIXCpHjhYiZhX9MRUesBGq7FdMC7env1mhQylwZ9AwtesKzAzUS3wQ3OqvdJI4d7XEmb
         0jghcwKcPa1OOLlHbuiZ3yTkW737qSSlrmuAB6Lsf8/B4Nn9TeVJZ3e99eayK6NAGkNB
         wv0JCbD6UAKa3rdSQH4C0Hd+jmFBTG86tQbpwlUoPCLGJtpLfaJbWUJ9bBUeiCYXG8He
         sSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537835; x=1787142635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=Lig0ia3HloOkWN4nHTwoZfPjBRcBvc52vdv4/A+rriPW9Udcj5OMCV4DKQxI6uakx2
         GHW1iyZ3C+asiHSdrRYQ9+nCs+4F5K/dp3/XAvqnnueDqC4clgoXNbb2N8W3d1b3P4E8
         CbSGQBnx6WhugQLsA7ZFb7m6I1hQR8KHD+WvOWIsVanWoFKkuYZqy3srSTWtemIe2rGQ
         3Z3+YMJgUgJpyuaL7U2n6uH4ockuRZo5/D9UVt+GVwInYbjzDoGCdF34D85ItlqHPM3W
         nmHEhowj9WZBJ5y/Rmh91OvRUYo+y31+eeqWnIL5gEaQdisq0tmpLCG85rdfhzHrppJN
         W7gQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrpi2aszT02GN53Nh93mI/+RFhR95a3KcjkT4SPTjWOuehiAljDdORWl/Oez4GEckElD1tQvLMoHG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh152GAotiPa6qFSIkIiBmy2SQ7XThkIxodnsDCxWpPTyypJ0X
	SHCr7BX9Q7lP1/JZN07rJoAOfUsl8oeU6R113fUCa6AYJX5ooPmL3fInvfjk8XqDLTM=
X-Gm-Gg: AR+sD13PNQ1stNuark5XT2uDLV0cKi1D7awOkglB2WrNyT3lWTs6HcGhBibXem3QPdc
	rmerxGg2x/Pw9fGwXUzX1NNtitKyGTgwGKf0jt4ZUjzVgTVcy9UBKWWfhXgLWdpETnTfBblsIpV
	6O2+zNl1ApgrujGEW/mONlKGX5upl0ewxXSOollklVfng+s1Ucb+qfawA6iKQUHiG66xkvK8Ln7
	NY6B2sYfjXbbODCT4UHTx7PbWLUtfHvnRqlfN+dcLzxnRyOdMm04l5HvA8u0qPuUUchWfk0GNLM
	UFsKNcuHrSEa6QS7AJlKuspJ0CtiEaNa6/GwDge0dok0rP04uTsb0CbFXjPf8NlwM4wzcLKOfaP
	5olLc1OGneYCWDKBIm7QUF1F0sDzIxRikjdvptovkJqdxHWTwJcvMrlZV1cxrWfnnTWcB5S+2s+
	5nQemSwrZr9YH2FzB3xkKO2GlkQihKSVkXC1qG7jA5nxaN5rRw
X-Received: by 2002:a05:620a:4013:b0:930:e2ea:2881 with SMTP id af79cd13be357-936b3d940c1mr359405785a.36.1786537834756;
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f1388fsm117247585a.24.2026.08.12.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu86L-000000030Ox-0KWD;
	Wed, 12 Aug 2026 09:30:33 -0300
Date: Wed, 12 Aug 2026 09:30:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260812123033.GB662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
 <20260811162124.GK544626@ziepe.ca>
 <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>

On Wed, Aug 12, 2026 at 04:58:28PM +0800, Yu Zhang wrote:
> Thank you, Jason!
> Do you mean something like below?
> 
> -#define X86_IOMMU_MSI_RANGE_START        0xfee00000
> -#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +       return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +                                      IOMMU_RESV_MSI, GFP_KERNEL);
> +}

Yeah something like that.

Jason

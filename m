Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199705;
	b=vefE7YsghnXHuwP2aCagFc4md7jVtZcYE464J8VdMR1OgSixy0gOwMSgCZgNg3Rb7Kmc
	 pHzFB3l2Y6IvSkpJb7oO4kI4T0wMQVTcZL+ZeOCNokFDvJ6QD5JYnJvPshZnYe4Wcny9j
	 q6PSbWyXD3d/x6PZMzXkEgJ8gqsa0RfBa6APiv8/C56YCVHgPuKxQTc8A+d3B4w/a0WE5
	 eLz4/kfeKADG5se5R/krunhjQzqulvl8pHXiHW8ANVCcbyhR9mbqz6qw2IMNMuDBDn/Jl
	 WAATgRLfPPLgy5SZeG7Z+DvSBgimXwtmB2foAG/t9jk4TlRRkENwkDSwTCPml3kjSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
	b=F6XnK7Gnu8m5JMPyZMXOQHBiUD+5dJrSas0fR/A1HJJZCtVwd0doE6G7x+OxZtTcbTRp
	 PFS2jUNRBRqBm+5oqHnDXWDW9F8TWwA6ziIdJq4h0GBwomY+Qql56H/NukSmB6CforIdR
	 NTO5OGHuU5M4Np1JicPck+Y3bGiBsaHCdX98734MS5YuaNyHii8tfvNsF0zA830OxFpBj
	 cTnHgzcAm3jKAYDbS/ktNQKath6Umtmej2WAyf2nUDlwOl7KnOs/urjyWspSkg1bJWzUA
	 ubOpWkvyY1oB5edRKE5gr96fA+p0F8tnG+keRn+ghbDmetiKzt47ToTI1r9iF9sugPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JM5nliiE;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBA60A2611
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26EBA60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JM5nliiE
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91f0274f88cso17583706d6.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795199699; x=1795804499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=JM5nliiElBRIEJ+B90qYXzTnYzd/+stv+wN4hwHPgqTVP8FYNDHiBWaWDvaGRGBFxN
         DqILVZ3+XhMDQbPxlO8nhrLm/3w+AS8V4/RKa0SdUR6IexGhtW/Uv60cJ4DkbyFlLhOE
         Pl5l+2oZREQoIwCUMY+E4wr8rSVuY88AyEEMkOvGbhgTCninzjOvTw2NxmuFvZ7F+iej
         DSP94PiPMzI29zQ2p9efX119ggGHZGyIOl6SqlcuiuwZZ8zvQMORhl9uXP/+Kg0BjB6g
         LN1AMmDfqP8DHpgXbQTq5ecBBCz9h9vFIy3naJJn1zHRpF8CqaAU+DUip0emRErZQjgp
         a4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199699; x=1795804499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=PuuNCAQnAvK59i8dv18QW0wFh8FDpEtuAYSPXn6jStEuxT6R0pLiHHxyyhk8MF3I9k
         wOhyux5LWrNwSpjMKNORpVVQZOeCTqYDO0cWvCE4iEKRWXqGnNDQtlCAdvC+ccoMkdVd
         8/XhPyF2lkLEJxqh40hI/7Bdy1Xv3nfn5KZbwAk4Or6qk5wgt/wuoneC2rU91nAFF9pI
         WKWPXPUaqSqEmDiEqwaDU+BzE9lC0CMZ4cKT4omzx+miLBmEtNyIgQXT9jHipKDVfdRf
         /6W7BRk00HGVO7S43aoa/nML5Zfy2RTHJKkCltQyck1ozZOD1iGOQy2a/fslweS5I0p7
         48Aw==
X-Forwarded-Encrypted: i=1; AL+hErGEdPEE9sfw5QmRoQ8/gTfUjvZ6FubwSdH6DAatYVW1Kw+hpei423LHSB79Ripc3Is0guONxKHMCWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NL5vX8x4I3+eXtn5IDAgPIJehK/9SQQY7zmO4DvwDPJNLOHtj
	LHqpAjz9+7jyTRwUTgqEpBHW2bBA717QgoivBtcQMNsOCnSIUlfvqVCHxh96rI8nNnY=
X-Gm-Gg: AZFdTZekJE6+PjxC6NNvBkMOn+jFzpfcXqv3ZAnHRMinUL3FtNnVuAnRDZ/E2pvPH2N
	/6wflT1lXLfsWfBjoM3tFRK7mfpdHnib/Hy7QaLYhU4qTGaxdNztAGEAI4a9mi6vgnMv8YQTT9E
	zo6p3d7iUPljuvp79ffnUD2SzcJge1+8iyx55mfJlrQr9VxdOK++t5h+aIb4n/5s/eZnGg5CF3O
	YMBGxfD135lUjAMtQGaRuQXDo6hQpD0M2g2tfLdvPUw+pxyKpal/ayYxejKU5S6P7b5wvVEF/Qx
	Fi8WFXYOoZKN3rCiC/UkHWG0wzYSP6MNKw4gt0iWv5JEJqzukgbCRYdhlbnwe8FNREl87hOhkqp
	fC0uVNeNAaAnJasF3ZqBIcq/U+7jN8YhTLxfM8wBElrCrfZLCiFNaSEhb0GVKSwMbypyiG/h7wN
	vp3Uy6OsVnfgGkGCYLxMi6YENhhyTuGc6/MYO0cGSKrfTAWWeASp1+gQ6/EylNrSnMahcOOLiG4
	PyKQ4tstraQfd6gyOlYKB1aSG+K3S54RgfrXuXB6QAHPrwIHFjgKSRBPnjARgBoO3HNhkIqstEt
	jNAVLA==
X-Received: by 2002:a05:6214:4881:b0:921:152a:4e48 with SMTP id 6a1803df08f44-92134b1abb5mr65747176d6.32.1795199698766;
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm32821016d6.39.2026.11.20.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTRp-00000004jZ9-0OT6;
	Fri, 20 Nov 2026 14:34:57 -0400
Date: Fri, 20 Nov 2026 14:34:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 09/13] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261120183457.GQ3115493@ziepe.ca>
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-10-aneesh.kumar@kernel.org>
 <20261120094207.00002e89@linux.microsoft.com>
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
In-Reply-To: <20261120094207.00002e89@linux.microsoft.com>

On Fri, Nov 20, 2026 at 09:42:07AM -0800, Jacob Pan wrote:
> > Temporarily disable AMD vIOMMU allocation by returning NULL from
> > amd_iommufd_get_viommu_ops() while the vIOMMU interfaces are being
> > updated.
> > 
> why? if this merged, it would break AMD driver vIOMMU functionality.
> And not temporary as I didn't see enabling in this set.

It is broken already, it is missing some series to finish it. It was a
mistake to leave it on like this.

Jason

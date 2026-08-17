Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1843F5BFD
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969340; cv=none; b=cjjmS2G180ZLR3CTok3JK0PSbrMpv4+cv8bVpMYcNlfdtJBbeuDgPBNwa+d3ddA6DLSCWjGS0FW/JKNa4ST8YM3/T9TU86Grc3e/jfc59KLxzOy6mc7klRRuT3DS6udjwikKHTacsRt8DRN0+Yx1NmkCt5kZkyegszAnTrfnBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969340; c=relaxed/simple;
	bh=I+UkeZQjqj3g0bJcjZoQjrVdpo8txWH3MfMsXY6UQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGq/vyxX6D5gP2VQczeJcjCZdsa2HCfIJ+l2ouyO/E2JkmBq4FrtKjVW2enwlwfBz1/KyG/nm1gMbHvgKR+lNPjnz9irGd1Ku7KNBFNYiBQCfOIyLALUUfTDfb1tggePkOZdttT1M7WcuoLHYq2/34tBOxl8jIxNPfjETanwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YA4a0nO0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YA4a0nO0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ed3993c1eso162342285a.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969337; x=1787574137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=YA4a0nO0nH4v84iv6elfrsvINBNSoFqqFooCYFt/cRuYftKq9UxSrecdC1bO8LxTmj
         34iaCd1M6wxXfmSzn4njprKUhNyXxgNor+wdcMdW+oQ7bkKBdSqcvOIhfP1QPqH/MXdR
         TBQlF7ijV7sLpk1nwy6HXvYVby0j3i7zTi6nGZJvRbKknPLga1un1MuRPNj/F89+8J8U
         3R+UfBzK5j0qFbBD6gmKibLW/K3dsysN3qBHU3AgSIwz6pI0ebsRHBdAHESNHqtXoa+0
         LkqS1kSLp7+n4aDiVSMigDPOBeLnNvNjrvp0z/Y80YXnNAriMzzHP38XdapZG3uHhgC5
         s7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969337; x=1787574137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=aGRMONyX58PSN0XBNY5GX47wDFE5OPcobv8CA9MDTmOo6OzrwiUG2yk8KmX7w2atrk
         pCqc5b3t08/tfevmY/I2389c/YMuFl+wjx49m7oZl6cY5iY1gLxfwn2q4IvCTyI3aypm
         AJ7YXeSUc4Emu7+KgaeEwjTffYCkvrNQokZstUP9XLy/0Gpw4dfAKLdSxvTrucnUAtOi
         HTiS0QwiOtQoCPKyXqaGgFt6+FNlD7l1/VUXpvs9mJ+r2wuVqAY1N7e6BRLA6Ly3peNM
         TtvobpHAiOI5GHnCeVfkMuPFIN7I+J2IXLnhQAhZGi9H4knNTx1wM60FzfS/N0UhSw9I
         4uNA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1sunkDqZOzIlzbBS94U2EllVio9XiWv5/CyHeRj3WI/aIqj5XyGLbgVIgjPJoZ+/qigq1EHqkGTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaL9epLB9A/r+O3WQA2K4NxMA54H7Lv6L5HlxVtRMkcuiA57CE
	wMo6aulVx384fWiyUHf1pbk0hLv9tW2+shC4x/VX+MBgU7k5o86KVBMs06xuFiFopcE=
X-Gm-Gg: AR+sD12xRVUVcjJKFRAyZA26LISW6D3A4kB+1lGMsR/AynPK4RZm6d8nqdcAkZWE2VI
	pFLJbjDhqUU41jmnbaclg7Ko6qP/B416JQE5c5gIj5nsM7aKGYoTm25WooCxYk1ecmfM2FX+izL
	RpN8r1nIpbRq6Qn68S40gEKwzZ5w4wX8vZPlMCl1zN3qjCJOIrZX4+7j+wRkfl0Avrh04nUuBn1
	gNbazM1yLNAVy/V7WDpSKLszDrBk9E2vhwojhNk2Wx4MjKOffn/cxznSJWhdeVcNqvl5SWZQzSg
	Y4A2MNgAQIKgyjB6Ww4PuS24q7mM705qirmmbT6cNI5Ze7vXLwNTmuJwEVR1B2puLGw7nYxPMto
	U5XXWt5nsmehpI2nAawPq6oMJ3rIfuBGjsKA+wxNWctENlyqWD0Sa41qF6wThrW/aUEXahM8CHc
	yk/wdwf402WFHTgc8cbFUmwgoLtLsKAYoMzrWOTxD0RoT2EVi13A==
X-Received: by 2002:a05:620a:2552:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-936d202b715mr2670485685a.19.1786969337333;
        Mon, 17 Aug 2026 05:22:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fad12sm31868985a.36.2026.08.17.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:22:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwM4-00000005tO2-0GS8;
	Mon, 17 Aug 2026 09:22:16 -0300
Date: Mon, 17 Aug 2026 09:22:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817122216.GD933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>

On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > Why check it at all? Is there an issue with attaching the same thing
> > twice? Will it blip the DMA or something?
> 
> Actually, I do not think there should be any issue with attaching twice.
> Hyper-V *should* be able to accept such attachment. But I do not want to
> make such assumption just for a redundant hypercall.
> 
> Does this reasoning make sense, or would you prefer that I remove the
> check?

I would probably drop it. Having blocking always set blocking to the
HW regardless of what the SW tracking state says feels more robust to
me.

Jason

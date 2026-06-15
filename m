Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E543290AA
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561949; cv=none; b=LWNpGr5HDz+kAIxpWz+hBA3CfZAluxFxSjyOz/uF3cPfroDL+zlmEQbzdUgu+GcW0ZEq3pvo8OhBrenmJsYohVSQPimNCKd/9zMtXoOwm6xme+G/3RzDpwiBOM6gxeAA7/XF/9I4EWFxOsh6bs7sIBnNqDxpJYx9S8l4NrPbGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561949; c=relaxed/simple;
	bh=s3n8+3CSDVllms7r+qhZajny3rakZGtg6ZtOuwjCe+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzn0Yzf+hncsaohWHBFnDa2iiFyeGXHkv7Ar+4D4X/lFdF7XWUq38KQJAfVH2yYUus5ArKcM8yMzmZFQ6FxZTB62QyoR5cRy0EeoCXqfB4w1v+hnfKuZCQeFOAsqLM/Iz0UhtaTXUJqBtVCrHu53sdlp/Y48ewC8BBVfjJg4KTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEAYjKHa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEAYjKHa"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842358aaf36so1509947b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781561947; x=1782166747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHiAwX7OKZgj8s+7kUMrC2Agg+yOPIiQF0+UWU7tqUg=;
        b=IEAYjKHaPbgvhLzgjkl4BQnEaPbojaXWzY+3BadcaWTNuwUwFXQ8J4/xDGaThm4drO
         b2aYzmgCHf0x9hjwS3ingT1gxXFAr7kKJ3IOa3BNDOcAmj2J1/Jk3+nPDFPUsKrJHbP/
         jLy+3Fbau7Kbar9/T93vIvaKnE9m+kwD2Vlb1DYcG53A/Fmv7hSKharGeqFu9K7GPMaM
         jr2aF3dgRMCl9/FSSaHWz1Budsc0hPmy+PykxtR/IEn80r/kMCyJsMKA+2yBcEE5IuGC
         xNwO/QHnFDub3JvZB8gbip3/eeGrB6aefGt8xBs8Tr5nVOGzX94a5gTe7ckt0iTxTXEU
         5h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781561947; x=1782166747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHiAwX7OKZgj8s+7kUMrC2Agg+yOPIiQF0+UWU7tqUg=;
        b=McjhWmZe1HRIEw7Pr6pTvD5PL8Hy5nvZgieXKKs/b/+984PNLWaJzCKuSV5mV/TGsm
         rS/1Pujox4jDLCbX0W9DtS0GdqpnUhoe0DvwfdR2ETIhfl773vwbDDU9m7kMR72B8cyy
         eOrrUYwDdX14OtMqtKaSIl7vC3xSwdExdB3ITx49THYU9qlwTozS1FXCzhz6MexrS/nK
         sKeyyXia+mgbWqLA8hKLQ6lCWUaKcRSDWm54zqRg8Zouu6Os/YJEMF4KPWF3dz38nfTI
         4gyCQMw7uYQAwkVaLNmzcTfPsIzMwk+iAhPjriC1LeCA+SRGjD9O75Dp1+c2wqnaIH5h
         Yhqg==
X-Forwarded-Encrypted: i=1; AFNElJ/yollubguM4WTVerCa04EjV8qc5lSG6ikLIFUwqkFTBs1Oa3Gym/W6wtcV7qH601/7oxVehtRM8FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq670+50OiO+L8udLruJmof8ooEmVnTjxuJCRpQuZh0dDAvJjf
	DNT2X2+kKbtJTRSXolx86jsJpncp0Rwl2HWB25rlFYR+RLpXr47mmICG9/25dZD8gw==
X-Gm-Gg: Acq92OGAmhe6Qm9jqmqPqE1AlXFiaXhyTutElUZ0AS7pVyeBj3nNepAXLZ18D4XFkCq
	BQGWgJiqbEhygWRdR27jUJ8YlwMupNPCNm8heo6despbAiNzekvoR8eBUUAqw/uSLHiQNokfvV3
	x0wDg+VafdGe73Vm+ifn+Lsc1JISNI1I4Qysy6Cwgct2m/Ph5ybpkrCJKXf3aNFB7+JGPeUBn5g
	TmKvqnsJkwK7MD6U4cMmJIPKm0hgSeKYbZfx8jZOZ8TvLOI5LFtQa4BwPG1Pjw46jYdUspH8/SG
	BKr15u2Yfx+skmwPf4yYAtjwDj98fuezYOYrK6OuFbWHtYorclSc1QFMv43AC+bdvUFgw99CqIb
	zL3DfTgTuuCx05iGI7jyNNUDbJuQz6VRT+VHCqmdrpbgZde1gaGA8iHoou5jGhZuKqFIwmrQmCI
	dXLRFczBRWke8u1BVFYKaTrzTKRdh++26e2E0WP6WqeeqtydlizDp3sdxdzq4hbg==
X-Received: by 2002:a05:6a00:3e02:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-844e1a3d7c7mr13260407b3a.25.1781561946731;
        Mon, 15 Jun 2026 15:19:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accac96sm11985798b3a.14.2026.06.15.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:19:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:19:03 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajB6V6yBHOjgK5ew@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
 <178126123047.908199.12042730612990730743.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178126123047.908199.12042730612990730743.b4-reply@b4>

On 2026-06-12 10:47 AM, Pasha Tatashin wrote:
> On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> > On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> > 
> > > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > > 
> > > Please add Pratyush, Mike, and myself so we are notified directly of 
> > > incoming patches, the same as with other areas where the liveupdate/ 
> > > tree is specified.
> > 
> > Or we can add PCI liveupdate files to LIVEUPDATE entry.
> 
> That will not work, as we cannot serve as maintainers for 
> PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
> PCI components, and we will accept patches once they have been approved 
> by him.
> 
> The simplification we could do is to create an email alias 
> for the live-update tree maintainers. This would allow us to use a 
> single entry instead of listing all three of us individually.

We could create a Live Update mailing list for all code that can be CCed
on all patches that must be merged through the Live Update tree. I would
also be interested in subscribing to that list.

But if you want to create a LUO maintainers-only list that would work
fine too.

For now, I'll plan to add you as Reviewers under PCI LIVE UPDATE in v7.

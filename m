Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912363D6CB0
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957080; cv=none; b=D3fLwqWf369ZYz4+C6BY5LDQ2owFCYnAj5gV037OYhj2eIYWuzulH33QlsIi/4tkxy4GQ5iTye/kUgLlT/lJYpoh2RGKmRGgSdk1QLu0C8DedWtHgsDTr7PNrBAmNAS5ALCU5yD6RGUd82IaDXJ+HrvsRo+oA0GqYP74mdIHJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957080; c=relaxed/simple;
	bh=g6HU23i5fSRX/KH4Y44SrBTLW+Efym3AnaxqepOQoxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFZ+rrfx5zlRVLz5veeT4W3x/iYA3cYXc8tId/rJ9BCva0mhF3IrTuyasqFcS+KFc2AumM4HS5zjFrazn18M6Mr+QAWIcQBk9yxNRc78YzY+QnaRtgnzuUnA7YcA6Oos/MTaU2cgqhhBsIPy43LRLBxBp6Ocopmmy4I7wiL0HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pOA63DnS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pOA63DnS"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-527e352a167so8915981cf.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2026 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785957077; x=1786561877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0xkTaFSxQkbT4PpYQuH0yFvquaeQpeK5woUXN7RqdE=;
        b=pOA63DnSFQWKBMbGCC3N0TvHyPzPLnoupxk9N5OQwIGuWwLTXOmT0+/a4kTjMyiqHd
         46LF9Gjw2OLdsQM44ukt+mx5ssTdmkBJq5pOtiNJ6t0ddlbA7Zpz0/GYmUKdX0yyq5Yz
         UnC0ICazuqrSHLBoaXHnITIw9eRLA2q1HjFiaLDglUPjSfJ2klroUBzTCFLr3ehIryjK
         olk7TegfGqwG9L66Yv2d1EsLbHE4H5UxiD5yfEl9v52wT4KFbJaHfEzTNLnelZPteB8v
         jBMgMfZC57RAR+7QVusD3c0h/Jkfuv1fgIDrwSdvZy1CzNfsf+Mn7AeKQnTn+5SrOIc9
         JQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957077; x=1786561877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0xkTaFSxQkbT4PpYQuH0yFvquaeQpeK5woUXN7RqdE=;
        b=ohizNr+dbhWvYk7nKBQCtPAP4yOwUZiwo0jYVSSJcWN5BPOe17mP++zxIiz+hAYQmN
         1AWezLHtapMGhv1BZNdbU4OTQNc1c1bQh8RHqCw6P/5HS2m+B817vKpzYBiHWs40qeYd
         V4jXxSgdgLH9eFhmy5pp6JxUW4bf/+JjDnTI9YVtHRBLBjveeR4mybasTM2VKKX1okXh
         cmik1F4reFWZLxK6Zz1x8wGm03NoUow6BeX2HVlQusjbMniok9BZL3scToEgxhyty41V
         Z35vAhS4PJsYd5hqEKzq1n2eueUe1wi/X5CWJG3e92dqmAQcag7ZZkfdI/Ly2fScicoN
         RgjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/nGxYmOYkr+kNL2rvgf0Yn1y41h4LW/1dM4ab6NsJs/7FaaPsrZy/ZG86OSDBsFpWN55xNfyxUWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdNebivO63HDR3aDglRXhsY4LLteZT3uedSEcHNu+0/bJjwDi
	jsQG/8SafgnL5WZE2lDqzOwLI1BRWhOqOuKoFQJ28je8bIIwAx0ifXoq0/bZCQ1/8v8=
X-Gm-Gg: AR+sD11Davrpq4XJWBZayUspH9lX7Ec/G3v4W7KmECsREPWn+eNXQqbjnEIytXscWlj
	iwZOrc+jpvbV3EgttgQYseSTm8rCe5oJ8v0fyIZOyVU4xYA0DRC6pdfGKY0UkPFydQrlNc5qE2c
	166k+n0VKXPtE6CxlgaP/x/QTUs+8Kll6VYWh7bDIK5Sn1gytr0U1TG9sXQGAZirZvJ5SUaJtl4
	SqKplj+H33t6wioWwegULHZItb5RtGAfQpf0jdGXg13z+bcOL5wj65rDLVBkxS7Qo+734xlp+f1
	eU/HXQoBXQz40FZsfrZooSKUCIcDZfUdVb/gwA/gGTM7qvCQQQphU1bJX7QiVNFLR+PGOcW6deg
	NzeqJpFmV7ZQMMKsrj3ig0A5BmrRm63rUiyBKHs+jIuNCFk2XsIPwzxcD+n12Mu3xJ52xpTDoWQ
	8qApL294HXHfVo8/d6pMbm7w0ItlL5qkKZKrQr6g==
X-Received: by 2002:a05:622a:480c:b0:51c:1c73:5943 with SMTP id d75a77b69052e-52ce6145233mr106545321cf.23.1785957077642;
        Wed, 05 Aug 2026 12:11:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffe0f93sm32516756d6.21.2026.08.05.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:11:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrh1I-00000000NIN-0fnn;
	Wed, 05 Aug 2026 16:11:16 -0300
Date: Wed, 5 Aug 2026 16:11:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805191116.GE28508@ziepe.ca>
References: <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:

> > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
> >
> > > IIRC, they supported SME, but it wasn't usable due to other
> > > limitations (e.g., the requirement for identity mappings due to the
> > > display hw bug and the latency impact of encryption for displays in
> > > system memory).  Do you could effectively pick either SME or displays.
> >
> > IMHO the GPU driver should fail if it cannot work because it can't reach the
> > IOVA space requried for SME ...
> >
> > I don't think this should be a iommu problem to deal with
> 
> That means no display for the user which is a not a good user
> experience. Most users of systems with integrated graphics would
> probably prefer displays over SME.

You said IOVA translation doesn't work at all on these devices due to
a bug, so what is the iommu even supposed to do? It can't select
identity because the device doesn't work that way and it can't select
paging because it doesn't work that way either.

Or are you saying paging sort of works enough to do something
half-busted?

Why did AMD even offer SME in the BIOS on these systems if it doesn't
even work and turn it into Linux's problem?

Jason

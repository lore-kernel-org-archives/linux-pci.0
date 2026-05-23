Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B2397E9E
	for <linux-pci@vger.kernel.org>; Sat, 23 May 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539663; cv=none; b=EBY1GqVcd6vi4cTDZQE+nIgfqqoc7uOuTpwEfzwUT+1tz9bj0naAfMiv/0LqJGc3SIDKTPENWzE6aABKnoUZW8pjdxTg2nGA0MmAbEoGOcmFVOF0ArqVUOLBX/48ZgurnC4GOkD6SjvtNxpLulY3+MF1QvQmSzsQA1xyL3EhLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539663; c=relaxed/simple;
	bh=C7KmysjLP0UTCeUbpZ1KbuRx+VVPdkjCptZ7yQsfsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li88YRPaT0t3+BJIN3V9DxWEoPloBi/0Q+IrQMI72EWOQlhD35jq6PhODYNzKgKpwzj7fU7WNcnd0+q03xUC1qBtXoetmaaYYsd8/hGuXXuupRWU/evaX3Ai+fQEE6v4IS/+6mA2ypghtYnbzMga5wzJ1Np04ms29rHti1xhPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Me2luQuZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Me2luQuZ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90fe17c157aso895045785a.0
        for <linux-pci@vger.kernel.org>; Sat, 23 May 2026 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779539661; x=1780144461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGmPB+blT9GuKVe83FlEfl6zfVfiY6vZlRneqD64qpw=;
        b=Me2luQuZuq9KcuTkmucxQPsSOK0ob7ANhViFhYArkdPdALm7sjSkauPpxJzl5ngUF4
         yYztnvYugp2z6+zPrqdxnTQDA6/HhESt1HV3BLgkdkcUrfxr9f+uol0CDltrXIovGCEo
         7Kh9yybDZ3n+Zszrvorj2aGR8HPim4iHmpqllonv+LVg/Ybw/a8+XJpG/7dey2kIRaBL
         2thkBBvO2VJmUlj/sfWp6PEuj6yy1JlAIQlw1AFqcUVZsbc4s8vxbWT2yuUvdO8ljJwT
         MoNVQCfL77T42hJC8C4/OE0a1Nu65HTBLTh0EOdyBnXcZKmthmZIFov9BsvL+2JZYG/h
         rFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539661; x=1780144461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGmPB+blT9GuKVe83FlEfl6zfVfiY6vZlRneqD64qpw=;
        b=Uqp2NLl1wznjKc762Sm2eZJLBTfZ8VLLZEOjSlepwjPQBw+gp57zq0QwVzeX/4XBjv
         MUDsU+15n+kAfeE/BjU8vxrVqlx5p0x8B58slyGJlaxL4y58iDvkbfDSIquq4oMt9WM+
         ZWa3lz+TU4X9iQ4oUIWUo5+NJz5fmFWGMcyWOvm4+R9stnzmpPyuKj0afFVhjXDlY/M7
         G+W9JZd+YbaVGvql4KujNdOjkdXz3CbfDS17BWnCraGKaMa2DEPdyW8XQU4nEBNbDqeY
         /1mH66JUY4cQ76WuduaGCRjann5NG1HDYdx1wnA96NA67VC34apQfweGetRpKmvzTroM
         mHbA==
X-Forwarded-Encrypted: i=1; AFNElJ/egg5r25xB8OBkuP+olHk81Dq4Y/abGrc1tzRAsXIu5aVd8TnMTBRSHxDd2d2yAcNC1bqhySlxGXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2SPEJs1AcEu8n8i7gz3mB2/L9eX984y2ohOw8fYYq/DNBk5p
	JpbdTovV7DoEfaCIRj9ZIjnpj53mjPD3hGhbn1WFukTIfwEDcu8ZUIFNU9uXmDhHIn4=
X-Gm-Gg: Acq92OG146COIKfHHRqXo+wqdvMq3vvkyK4Ftwc03Mnr4SxE7yC911tFKgDinKdl5gH
	tkeLRkRDNqsipi2Tb1u5bT6MTD6R9V5X+E7BnoH6JqAoVzxq2tm4edybNW61Dv7e2goma5jIOSe
	G/7/AriHx89U8ktMJjAfa/88QlzCfX/Z2l/vDdN1JfTQVSAT+doWWEa+kvvW2IdMcF0CdaNmRgp
	MYTjpYVgCyKcnEBxa32XYjcbmsS9+PMp/YaDGirzAoyQEicTBzEdr5VzsXmCfF4irO62HzYZ03h
	4RNMhMogFauNjtD9x9WgnBsHCgZORNlSCH68JyPBgwH1de3deUyCZkj19aMFv/Jo17Wfo+Hfxis
	VUoaN9+rRKT0NDCsimClgTdaoMggdAbrq9D4+QXt3Eo/pROrfBEaydJzYpBArC1HthuUDktZtnf
	kGIsVLF1Fvd6crJUq4KpYma5ReBgwNCnrKAgJNQyAHCsKqLceqcJfDwNqXxA/bbHqm+RN2cdG4k
	+sBIZ7Uf6+m3K8o
X-Received: by 2002:a05:620a:6cc6:b0:8ee:bae8:2bb9 with SMTP id af79cd13be357-914b49b982emr1048141785a.30.1779539661131;
        Sat, 23 May 2026 05:34:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f1a33sm395502085a.32.2026.05.23.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:34:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQlYY-00000006CcC-3Twd;
	Sat, 23 May 2026 09:34:18 -0300
Date: Sat, 23 May 2026 09:34:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260523123418.GE7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
 <ahCAyZ_-2_CLIqPR@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCAyZ_-2_CLIqPR@google.com>

On Fri, May 22, 2026 at 04:14:01PM +0000, Pranjal Shrivastava wrote:
> > 
> > Though really pci_enable_ats is not working the way we want, writing
> > the enable register can't actually fail - it is all the sanity
> > checking for kernel bugs that is the problem here.
> > 
> > How about call pci_ats_supported() early in attach and fail, then if
> > pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> > 
> > Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> > all the sanity checks and cannot fail if supported is true.
> 
> Hmm, IIUC, the current situation says: 
> 
> pci_ats_supported ==> ATS cap check
> pci_prepare_ats ==> ATS enablement prep 
> 
> Thus, I feel if the prepare fails, we should expect enable to fail. But
> if prepare succeeds but enable didn't, that's the place we should
> WARN_ON and move on.. because we (IOMMU) did the best we could have..
> 
> With the updated variants of pci_ats_support / pci_prepare_ats (in
> patches 1 & 2), I believe we cover all the cases now..
> 
> And we plan to call prepare_ats only if (pci_ats_supported == true)
> 
> Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
> enable ATS failed, that's something the IOMMU can't help with, hence we
> WARN and move on? Does that sound good?

OK, what I really want to avoid is wrecking the attach flow. It is
designed so the failable things happen early and after a certain point
failure is no longer permitted, the enable_ats is after the point.

So it should continue to be structued like that - enable_ats
failing is a kernel bug because earlier checks preclude it..

Jason

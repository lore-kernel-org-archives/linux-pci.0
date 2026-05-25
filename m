Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55DE33E345
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734320; cv=none; b=I0RSPoHWawSdrVP9hmHQnrCfVDDuUqeqONtc7uOMLZQq0zir0HjsfIVFmoRCOVWoPrdOTW0ARVhSCEgASQfvQeQH3ajS7LSbZA4QA2Y+aUxpOADxO74Zyq4FHU6fPcCHmIEF3pynwxEf1xHoNT3VYZGk/jhE3yKf9stl7cKzefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734320; c=relaxed/simple;
	bh=zTNkiW5b7MMamBOw3BQ6V8ihn4ECsDDmYUh7l2X6XHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+pW0h22akg6cjq/POUS8/RPMLWcjOclGTT/UTOEVQhMbjTW9dcYxx5ujqR920+zSqudl8hyrpMXhLRsJpuOxs6RYWv+hpRFvDbLTxsjWyVJizkiQjHuk7lys6r5KNJkfcVKvGcpr3BJNBt47i4t+g5IvYLEIdTPKZ8JF9lwGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/nzMzWs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/nzMzWs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso745ad.1
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734318; x=1780339118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbJhtLfx8rmH0aBF9Lx4g+27V38wYv/GdoLwuvRH+Vk=;
        b=X/nzMzWsHvH4kfNwIJ2MMK/p681rhik9m5dFX9iid4+cYL9/rWbx0cbGCHfYggpKFR
         X6nFOpJWjUmfE8bZF+CJn/jWpfYcIdhZL0DSPQoN805Kul3MSaclCxnDwwAL8+rxh6yq
         puvhy4zFARS8tWYrcgtKp69cbRBwXD1oO50sYlSucB0ua7aXaA1YZ9j2F10tBh6ps8WF
         o3WeAK0saCPPlLpTvXWcRStjiqL/BZQRZtSLp3xMzxHWG+atxexTSQ0vCcYYkjV53rhT
         Mluphh4lEAdQDl1N1DvqZZ4lx9kKvXu0SBnMX+VoO7xwZbFd4U2cD2QDQAqQzJUrRcf5
         Ej4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734318; x=1780339118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbJhtLfx8rmH0aBF9Lx4g+27V38wYv/GdoLwuvRH+Vk=;
        b=GhEuncGXYQmhLXJV/His2fhPOi+frNLfdAYaltTzEbykXi8PzOb7kK+z9+V8AuUdOx
         LS8sujDNE/o/Of0i8QIbqcwWhRPMMjrOWZkO4rOdc92cFpB9oH4kTf7kInDk9gNUvDfm
         HdZ/+n2naQmAMQtyaXrKLtHKS00hWgfypAU3Je8J5D4u7TVA49y9AJGGUCI7zhVGvSVq
         hyGJC5582apo7o+O7ruCDkHV9Dc/fgTQYYQ707HF7y17W6TN37GlIFREBLNGN2/rJvJw
         5WTfjRoWwZfztHrt+jrBJo1WGov2/ft9OyBfGBwpnh4np9P5gtyElp7E83EjbQtyisdY
         L8Rw==
X-Forwarded-Encrypted: i=1; AFNElJ9HMoE9neHzPUPlYXekEtVUiGLsXKx1YjN4eAdbyWXKUk71g///EPRkASFXjAiaqxHNVZRn677bcIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTODZtxlCQ5VOLVafn4jXv/D8IebftbZIWZvLRw2dIEmB0veo
	J9lNbmDwrEIQxTZCt2XsheOmHEb2gLB1Hu3H89gsORT8ArRqV2RLaRTu2Yq/I4aWNA==
X-Gm-Gg: Acq92OEtzL1q1zHBNAotqwdKp2TNRm0nQ5Yl0ZK7vyxHbU3nvnbURs3rJaqqFWVqwZu
	Piy3wMfi1Oy3+Kd0t0fdlQGMUDPAW9gZ3hZSw6ScJGF86M11CvWDQGaWRexqi3vF/dgL41WpGj4
	GoLxoUrXWJNYB2LyXsh4SK7KQFH8JUFnqzBr2MAHvDRy0geG7EBdTsZK9oE6pTp3PjETpxav9xZ
	1Cr52CoBxhDnJ0E72pDJoufBaK7wPiMX0bf+ZSwOrx3Uu99M5ay4geg0rAJMEnlpQ3PsGrKkF7o
	LdE+uP2Mvx7q3DuMBBL9CLIeOycWocrVh26xoZ/XKe7XI2lbQqqC4yUcBQO8ozjwr3gNYsYy5+K
	AqZ7bDXmLXasoYz9UtR5JAX68q8m2E0r+FmE+QY9a2EmFUNmAm1xJyM9yU5PMwg/rkNy/KgalzH
	0UZX1jHXFvtke+arOXmUaqWJO5O6jOLKW4qsidNW7g51KI3xNYQKXzqWnMmKy3GquosTYS
X-Received: by 2002:a17:903:46c7:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bebe9e94e6mr3923625ad.2.1779734317533;
        Mon, 25 May 2026 11:38:37 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a75sm133234215ad.14.2026.05.25.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:38:36 -0700 (PDT)
Date: Mon, 25 May 2026 18:38:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <ahSXJlPX6dobnS2n@google.com>
References: <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
 <ahCAyZ_-2_CLIqPR@google.com>
 <20260523123418.GE7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523123418.GE7702@ziepe.ca>

On Sat, May 23, 2026 at 09:34:18AM -0300, Jason Gunthorpe wrote:
> On Fri, May 22, 2026 at 04:14:01PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > Though really pci_enable_ats is not working the way we want, writing
> > > the enable register can't actually fail - it is all the sanity
> > > checking for kernel bugs that is the problem here.
> > > 
> > > How about call pci_ats_supported() early in attach and fail, then if
> > > pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> > > 
> > > Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> > > all the sanity checks and cannot fail if supported is true.
> > 
> > Hmm, IIUC, the current situation says: 
> > 
> > pci_ats_supported ==> ATS cap check
> > pci_prepare_ats ==> ATS enablement prep 
> > 
> > Thus, I feel if the prepare fails, we should expect enable to fail. But
> > if prepare succeeds but enable didn't, that's the place we should
> > WARN_ON and move on.. because we (IOMMU) did the best we could have..
> > 
> > With the updated variants of pci_ats_support / pci_prepare_ats (in
> > patches 1 & 2), I believe we cover all the cases now..
> > 
> > And we plan to call prepare_ats only if (pci_ats_supported == true)
> > 
> > Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
> > enable ATS failed, that's something the IOMMU can't help with, hence we
> > WARN and move on? Does that sound good?
> 
> OK, what I really want to avoid is wrecking the attach flow. It is
> designed so the failable things happen early and after a certain point
> failure is no longer permitted, the enable_ats is after the point.
> 
> So it should continue to be structued like that - enable_ats
> failing is a kernel bug because earlier checks preclude it..

Ack. I see your point about maintaining the integrity of the attach flow
Will post another version

Thanks,
Praan

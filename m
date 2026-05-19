Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07C3403E4
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201718; cv=none; b=UKA22sTSVfgjrg9MToimwG7en2sVLGjgz/aEeCepCAin7Ny0+u7YLfulXeT+ac/stZd1yHM3Fjhr3Fi2vsRd1fm57IG0Gj3I/rivENhKz5o6SdV8rXLkb0oLOqnXi1m0oze+1l0tFqnlTlLQza2YbMWA/eZhc1F8wRgITvBH1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201718; c=relaxed/simple;
	bh=pp4L6xNEEJR55C1B8gZtr89JR1/fOu5Hhi4odc9u1ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSNTCS/kbSmb71ws++dXN6VfMP0+f9ipBpkKhwCPn7v/NG/xHscyvpOzkXSBHINMPrN0TNngeCbR/2SM73g+avv1kYev8XTisLOFOjr/YJb31SNoOFpgqRWei6spw2rm4TCL57ZPDJ1RMuokB2zG7pRv3Rqrg3FX7r2Tzl0tQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TKq9o3Rb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TKq9o3Rb"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so54156826d6.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201715; x=1779806515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rTiPxjiJCNzJ9fOJ7k+wq/0Uj6CBWUn6o1yJioydV8=;
        b=TKq9o3Rb7lFKWg744JB/a/Y7n+J8ZD8WTSSKIGo6Ujk4a4sWw88MlO0mCx3AIj9/+h
         SYjtaWxDmnmn5UwQzB4TwY2B/YfapBy1w4jJVJj10MNTtKCz8szJ6AyN9pROuUwZmYyb
         RpmpR3RCk+IJuxgtAPU2Ex1buivEdnMEIaQx/868gLnYF/e9zdznH1vVIsbUXARF3xEJ
         W1XgUQ79a1naZJFiTdXqZXiJA0vCYEhdDDhTdMsjOLysbm5gSnqEetQSnK/xhdiMeFhM
         ZNI0sj7sX5Nl2G35l67q3n4icoNEmvS/91O3CtqCgQVV9ansqOey9+cJyIlKgsY1+i3/
         7KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201715; x=1779806515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rTiPxjiJCNzJ9fOJ7k+wq/0Uj6CBWUn6o1yJioydV8=;
        b=MHLa/7xjUPyCBnKSqhp6gcj/L6yo6oBtE6nbKNG1UiAnpui2R1wNWIlKFW2TUEVsM4
         C19e96weF2cvfpHzrnFr0Zh/TMqB+yo/5Uz4yUeaEnu+lXYaGOxY3/SD35pXorKElaeC
         OXI708VYXmoZP+Js3pf4QpzHu9mFfsdbh9cHZi7/DRG+d9Xs/J+6/O3VUVHEGFhnnbPG
         8l76PVuG7fP6XlvF6XEIiDzAem4s8oy2hdoEQVDpeHJ3kTyiag+8mPphwhBdhq6MUlxk
         w7V5utI8lN09uJZrMeMJYEIqHEEQF3IafGZDmkIPN6onLn21mcDyDfkKI+7Ywgsok82W
         XHzw==
X-Forwarded-Encrypted: i=1; AFNElJ9Dz4Y9McGHlt14HSuYRlLc3EhQRxeCNGOVUCVVUWqFWUMfMg/eGyetU1iH6uSjvkIVMCgAxruYr2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck4sJvxZ7C9qQ77fnWzUXpWYcWRmOeoJDYhDciaCcoefa6bQ6
	xyjBxqW/oV3NelYm3CrHiPb/o5+7RlLb0vXSjrqFe0wt57bsD0nFNl1BtMZy8uhhNxrpq1G5VQB
	4KTFZ
X-Gm-Gg: Acq92OHy+7g8ulY+2F2a80K4qkQCgo0VqDdalg1ntQ+phudnSVji/uudmmybtmPLCNS
	I5AvWYv/qlc0RIeZUa5cw4sdUzr8O+cbvjg7ZUGaR8RyIXtobh+Xk1WGTj/vBkI2nYZduOqhvk1
	kSzceYZs400YzeBdyXM0ROaJXQd73Y0U6mHg2LBfCHaQUatVK2hSuAfjiO0Q9zZnPrMhm4v89ei
	rDmlgR6A47cUGoC/6UJdpGuoU0CQ5HdP95Dq5JAK1aPbeK8RAnXYuF4cu3AwdfL2b5hAJreQ/LK
	0tsXFgabt1Hn4MIdcBZpY+vz2b5bNbnjKd+luk4yM4Dwdyp/EPCW8c1VTiSbEHh5ILSV9/bF+J0
	zP3qcV6p7zA+cqAhFINQoebApOP/MRzP5+I1FSGJjwUxNB2ZWgwIYhjZjBDk/SjeZhDUFpNnrjh
	bsyVaArssaDUoGqZ4BgXLkO4iudZP8kqoNJiAmM5BlVUERND4U73JVo7sjXYNoKM9Ck2U3KfPec
	w81GQ==
X-Received: by 2002:a0c:e08a:0:b0:89e:a170:6af2 with SMTP id 6a1803df08f44-8ca0f6b9fecmr309184076d6.41.1779201714945;
        Tue, 19 May 2026 07:41:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360b274bsm91988506d6.21.2026.05.19.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLdq-0000000F8Mf-01nK;
	Tue, 19 May 2026 11:41:54 -0300
Date: Tue, 19 May 2026 11:41:53 -0300
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
Subject: Re: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <20260519144153.GG7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-2-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-2-praan@google.com>

On Tue, May 19, 2026 at 01:53:20PM +0000, Pranjal Shrivastava wrote:
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/pci/ats.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

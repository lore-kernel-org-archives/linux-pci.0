Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0883D8122
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653464; cv=none; b=O3n1TCjV9o1KpuZ729WfBxOBiQ+ziqFvH/FqtHIKKFJrtblmrj2ZqHUdHzbygyGpzKO7OLSwG0Li0f3l26eG9jpKKGPJf7DN8skrUG9+DR2Zt3BPowSPIvfWdj5V+1o3X9gN35R8/EYJ842jW9+VGnz6fxZSBLDyjMFqCKD7L4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653464; c=relaxed/simple;
	bh=lK2BFmWVVl023uFQVfWzK7Q0QzOCzFmm33ddjKEUoBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F02SoudnmWH/HtTqYWF4qKiwHGHH8w6mqfNWsaK66thbQ5O7l5wlLtbVo0MSvhsnUdtoRVr0jYi7nDZz9mes2CO48jGPn799aWHDnJOR6QROpBL+orrA+uvZJd+vrXUJ1Av1mF/9x9GSFpGkMN/ZqhJov54tuO5KsOsaQ/lqCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRpAONwb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRpAONwb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso100725ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653462; x=1788258262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3wkoXmohD3gha4H5ZeL5zxsjojGVMUQObrPCKo/HBgk=;
        b=WRpAONwbsD7OduDBi4eb51D+sKSEDl37nQ+UIA3EB6Dz1MAEV+zYAHfTu3kV/b6R9o
         wQNvr7TTr1V0nNUrAN/9Ex7ebxbzNHMNoS2qttnsp03PYogbH+OYSqCJmJpiH3tVNUib
         w2vuYZHTSPnKivb39k9zdtwvvbktLn/Uhshf0LKp3zCt26NDpzu7Gtc/h/rGLBHqn9qw
         1Swy/q/FyI4QgdCIqC3DvVMBxLRthUmcW5AeHHpBJHcYxz/FxnKEjUamyggRoDwgnFzI
         w0J0m6u/IsCNE/mZmupuuAHgvK19FM64t/sigNRwD4aJcht5l/k9j5E1mWdZXDeo2uWu
         ekKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653462; x=1788258262;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wkoXmohD3gha4H5ZeL5zxsjojGVMUQObrPCKo/HBgk=;
        b=HqR+418PfPD9WhByv2jp00KYzzCusXgYC3J0ln6qUmysUJkL+DYXefgsv4pUWhdYgi
         mdNcPHXWZgt2GxCpIKD9tjr3/IIuHTM2OCrcPTIVdr1jWz69AdeAyRhTkOcZqnj9oChF
         ZomAOq/bznhO1M3BsbY4wjPvSTzhnv3rM6qJs6yHbr3LMVZ3L6nVNrdbxWhdsLvvc8Iq
         hn4QOCkhDJ0VkpDM++3oCdsgGF3pFoTXLkQPtIIdPaG3OM/ZG+Nb2DrlqnmkwX44GNMp
         0a/DZTrB0Y01IFwozagkzRKq7EyRTEihDR7yBeOw5OziebW1sekdMvgNdXGSFJM8cYKK
         RFUw==
X-Forwarded-Encrypted: i=1; AHgh+Rrpi5X8y4/OqQp+hQROHTANJ3GrKkXf5udEBY8FUDFHxp1s6TWiwDhFX9vPEwBsTKiKCbWTEDsryco=@vger.kernel.org
X-Gm-Message-State: AFuF++nqWGDrH4x1z/JUJf/x17bD2HNZ3GI2Dq3JVTLmIgJm9Abcwg2I
	Z4IUio8UkSXlWv4Xatx7TerOqfnDltvoBGfkO3Z9pUjn13b/DADQL5CHVUGLIsyCAA==
X-Gm-Gg: AR+sD13rlXWicbUav5o1Fgjc7myGYkGaIb00FSKS2y//q462syWXEDQvvhYiC3/uODW
	Vgn0kB6X4C5KWtsCsEzc/Ym76qdlJgcKHDWxX7uUhuBtXBy5q+1K4qux5Z3JhSPK9XJfVxY1GCX
	/45M5WywPQ3ctc8Rs+JlZ0xnECIq7vGPY1dIJ8T3GDMWT7quqFjiBKOWHpuxSGzuc5HgY1V4xO9
	uRf02a7HZTGK46oc4urBT/jNDFOPJw049xWQxWO30Aojzc/9H12PU6uxi4by2PQDrF6FKgqXSgy
	JxgAcHMSEH+4jJwUKjMm6u6C6iRIPvOu8e4zGKyDf5I4QtA8uAg9BLz7coWwsS5WuHmylBP5R/w
	VYHuUl2oRZWBq7NGyCTfEiOLYDmZuZLQbkWLzCupqfKbD/et1d323TfL74rq23Ot1iyq9Zp70vK
	AxL2YYrJODy/niQ8edVufe3iGerDoXsYWMV1mfx+l6zM3nKiOAjNx90BX4ReycasTkMroTzrH4T
	34ESMBIk+xg1yLNbUhhx2qy8kuSORW/fjCb
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2d6f2f25ba2mr2716195ad.15.1787653462056;
        Tue, 25 Aug 2026 03:24:22 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f16d77csm2916024b3a.59.2026.08.25.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:24:21 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:24:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <ao1tUKdiMZSoM82a@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
 <178759520116.3131778.9383172724893797706.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520116.3131778.9383172724893797706.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 14 lines skipped ... ]
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> >   * This function checks if the driver got a valid device from the caller to
> >   * avoid dereferencing invalid pointers.
> >   */
> > -static bool check_device(struct device *dev)
> > +static bool iommu_lookup_device(struct device *dev,
> > +				struct amd_iommu **iommu_out, u16 *devid_out)
> >  {
> 
> If we are touching the names driver functions should not be called
> iommu_*, it is confusing..
> 

Ack. So just lookup_device works?

> Otherwise looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Praan

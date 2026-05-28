Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B7403139
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992107; cv=none; b=eq/x2X8XRFhlzXuX66mwquXENMyozAVXOmWP5O93cx7cWuY4Vms/NyyKJ2Zo2l5qNnnjWG/kDWsU0wiE3K6DDeqaRWH/AiIzoBoUzhULpxlptUAJcOJxjPvhoxZDUtQv7elChFAHhuX/jy3fQn8H1OP7+sYP0cpjn8g0UR2MG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992107; c=relaxed/simple;
	bh=oVw3Nd5J5iK2SatiaW52qk8wnvZOzD4L0X/96I7vm/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0zGjByxqeJ8CVOYpmYOIyLFGIz4eR+3idVzwPw+MI8nvulgUf62XqPoeJQEjSnM+C9/ePQ4hOG3mpPEOOiho3VeeLlH2RFBIPpq3BbIfBORfcySzdA//K6syX9ImVnMLge6o+9z6js3CoGDgxX5orKoPY8Wzad27eJOGKdDIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAc1JUfA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAc1JUfA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so185ad.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992105; x=1780596905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=FAc1JUfA0WkW40L3EwIaVOoXQ2HS53ve+XKSatxSDpx8O5dI5X/QYiVXTRjZv6+Oef
         eYshNseJBtGeF7OUl6JubrpTWCWpTQ1rYpLE5LISYRZEDQh1ootPkxKZbd33EFSYkDCI
         MMSoLjlHmjWn2uNbIO/CkGhgzMqyW3VAQLTzwzypNdCm0KtiYERVS510bWDYAluJyHMa
         Jgq/8gKOHGSAMk+PHVYy24P1bntfRTxv/2LcG/ym4Cn6bnis28Ppi9+Usm09TFx3nazW
         WvSkRb4fS0CWmUYrJCGl7tyGK6tkOeRituDZyocQwGa7Pq12YYT3+W9qjqJb3a4YVFSx
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992105; x=1780596905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=ny+38pKpLNAShfIkKg24+wLiAZ5Pw5KkHkawRDq4UgowoBSL7TZPxO2BHgPdzvH0ww
         93br6GZEvDFZWM2NDuJ8kaMiSDInk/2CnsSm49pAAsm3+Nh44J//+XyFsFAa3SLgvbAI
         nLOXMMMsXw4zQ7bDnHzEsbUHdfgfz2EAy/D1tgcumnrW6OjFhGbb912Ah6zPrWaIAv/T
         A4uiAUtCuRfcekYzAOVRyJDf3/S7PApCGiEzk2wmQvBHRdjJR7OKP5cvWO41Dg0/+46Q
         dhVP+gqigvUdqF+nA86qZCh0x+nZYxbmyLZiYXNZ2kWqjrB/XHs82iUcUQmzJ+PY6oZ1
         c0iw==
X-Forwarded-Encrypted: i=1; AFNElJ9pa5+PCwLDum+J/rEyMLCqk00Q3hB+ZEAISw3NMFWhCx81Mdr1XSlAOsDcvUIl2+R/GbezlfE8cog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUnLg+jKyatJunu4l/uEAHwUMRUb5jd4r476k30ksDxAl6/NG
	gLTMBsrHmaQiSVIvpiFeo54QCgaroN+C3rupkYyqK4TkR0c4PSuha/vma9e37Z9hXQ==
X-Gm-Gg: Acq92OEZ05s83tV1QEIR4aM7gHZmnu71QdkSpdVECXACRNybB2Zk1Jk/pEHsrwUYqXu
	NfE6FXJe2atKelthPxtIGlsK61vQclfcUeAVmlWhr/7wWm5rePXGBD4NYcoYQoZtqm+0gSGAJqd
	1/ML0b9suizA0G54SR49h4Zo0UMmaLi1I83PVadBsegC6CnXKkTu2QDVJLEz/u3dcvHabieHkjY
	lwaZGgOhjoLPCQzlotzQL3mZtIo5Rt1gWXh1B5kC+MvMPkOkSRQUhOAyIdqM2Kb0SZSpC507wL0
	C0d3wt3uRaGQMnbS90Vp6BSaZtN2ZixB39AEeuHodloknelKgj58fO4bGL3rOVGrlUbldiMTmu5
	JMPL9X05feSOO8Tvag2w5ACey9jbnaEbI4yEn+aM91AE2DL4UmRs9o/bv0izwadnRwKRxU8ObQc
	NH68K1/Y7z/XsC27I3nEVWtO/JGZGhVs1NmfOtxcscrVOPfhbnaQg6lVRIIWAyGZ2wZtf6
X-Received: by 2002:a17:902:da8d:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bf1e2f6227mr112265ad.2.1779992104891;
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908f8f80sm2156136a91.5.2026.05.28.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Date: Thu, 28 May 2026 18:14:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahiGIUDG2uvA6usM@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528180018.GB3195266@nvidia.com>

On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > > +	master->ats_always_on = true;
> > > > > +
> > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > 
> > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > requires Config=Translate with S1DSS in bypass?
> > > 
> > > Yeah, basically.
> > > 
> > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > a valid CD table pointer.
> > 
> > Ack. But do we expect transactions before attach_dev? What'd happen if
> > we don't allocate CDs here?
> 
> It can be done at any point before a non-abort STE is formed.
> 
> The core code pretty much does this immediately after probe so there
> isn't much point in moving it later.
> 

Right.. that's what I'm not understanding clearly, if the STE is Abort
anyway during probe, why are we breaking the alloc-at-attach convention? 
Usually, we allocate CD tables in the first attach_dev call. Why does
that not work here?

[Disclaimer: Not a pushback, just trying to understand the requirement]

Praan

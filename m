Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987935A3B1
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000761; cv=none; b=MniXSViFTgx1GndjdhT6NZsXcFKxs1aTBRIJFplEN4of1w1miP16q0ubg3D3aI60iC2C9wLqNX+QF/X6dhzouW8nGlhbLDq4XWlG7+71EFg9fDa73E7fCDIgj0NDyzFaZqkKg2K/VCDc2UDvKEeHzd9W1kjhObBFaFkEzQmA7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000761; c=relaxed/simple;
	bh=KqExw4yVF8fFYi6V24rBae9JPYjDk4kcYZvI5BlVCOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTJkcDGhnoehsCRbDGVRnPw8Qsece0tKQ1QmVG0wizzRi36nbFm+9Y3YkPoDV/EQEbhvgdE4Iar2z5uaiF8H8GhtWqI9ZuM3gk3xD32+jHNfUVF1wDX9NwmSv+jPgas3ZxTyT79U02V4nr5rI7tSXpcYtwXsnnqvtEeUK7QyN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSLLlC07; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSLLlC07"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso2295ad.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000759; x=1780605559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=aSLLlC07u77GJQTwuQxyzhP4+xahlBgRDYVON+pUV/Jcsz1wxnFI4rjObiRLovMYHX
         pH/ETFAfKr//tQvQCeX4TAe6D+vA+Cu9JpADVQLUycD9o1oyF39t+pJ/WUIsDAupMV1v
         0JG/ZC+SkFBNAKXrb+CtLQyW0A5ZbHtnKqBf6SRYBcjrLQrrgtc4dutAfBA0V7LH9r+d
         28aXtbPN66zkYMqNqUYd2N7u78oJ0kWYE8YgqR6nzXqgGKmfHoSQtVYEukWAl67nke9v
         kVBHceQseAn9HTvPX+9ZzWD/5xZLEXXcH6vm9lIlNSEE0uygLVOoHJFOpEl/iSnUVFml
         iaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000759; x=1780605559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=LvyyBiY98o2SyansG4cHGqulAhMAEwFNeaXTMf9StBa69HzEB4Ed5IXRKynjPm6RkX
         2s1f/HJHYdO0G81COLYv2tFTntb37aphQ30eTtY91Vsk3lxGl9Xczeez3pQgetAh1SNg
         1fyEQ/L+FADfU6zVISxMgzpoKP60+2vyoEnhMOvqWCfNhQ3tW4nAzL5jN2Id6K6Akz1n
         TXBf5J342cWe4GET91qHAjfbatCVw8jfjlNo385944aqLUkUxMs43lSY/RVMERi1+owc
         gbbCSefoE8YHcU8yJi51YKGVd3aLBdN2nx61zXubY80qIugx+O4shjKguZqPVH/CPq35
         CvNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dviZcHEck8kCB+F8MIz4PvFC4aOzYPrs4NoqX98Kww4F33D1fLP/tT/BdMb7Z72dBuvEX1iQyVDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycDzYEhxaWEnQeDqTZECykKAOKGTpwUVOkUsi2VQ8MaTpJ6ABx
	pzZ8oMz/bqDjJocvrXU51/JjTM5xGKDoS3ZFg9HWZTiPPqw2XFPavjHwD7EdbUtG3A==
X-Gm-Gg: Acq92OHSzfFXzPk+SnKt+Z/TDMy9qhbCmcg0oRe4tk0dFowT76/DKXL9DfeE5VpZ0n3
	60mUKbIb8VbZxSho/F58ADgVnT40a/z9LidCA1beDxbXyEFjXv856+BqUvTUGIzO5ko0LcreQeG
	LtozYdvhUZd+e8vgGYdi0M5iGxKuctNvfn/kIZnQr8FYZgsNiZjWkA43ztuoap3xTwad1hXkCTy
	fg26f4H+o6iZpj9kQuaSrSn/lsGlr/Co8iQxHr3yHCG27wMZ0ITqFOhoiR1asNIXmdgejn53GP6
	pC4M9Tv+zBetW8DK7wgADBHxxNUM2x/VkLX5/I0eev14j4w6fT0C2+/DFBmVs/c9gLGd6BszK5E
	lhxPZl4CkrWH3TZ4I007EL0B6MTL7+qi42JwyYAbvLABY/a5nQ/7VJpblJOswpfQOKp9sSUYvib
	1AGDhOKjv6KpARlFI+2VtAjezpB1VqLrP2zzKAehSb6PjIXMJMBNP6QmN4Iz+EM4aXfGAE
X-Received: by 2002:a17:903:1a67:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf2046519bmr79225ad.25.1780000759071;
        Thu, 28 May 2026 13:39:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e609a0asm1939385ad.26.2026.05.28.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:39:18 -0700 (PDT)
Date: Thu, 28 May 2026 20:39:11 +0000
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
Message-ID: <ahin734hJ0CSSepe@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
 <ahiGIUDG2uvA6usM@google.com>
 <ahiHc3y4wAxxtpLT@Asurada-Nvidia>
 <20260528200450.GC3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528200450.GC3195266@nvidia.com>

On Thu, May 28, 2026 at 05:04:50PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 11:20:35AM -0700, Nicolin Chen wrote:
> > On Thu, May 28, 2026 at 06:14:57PM +0000, Pranjal Shrivastava wrote:
> > > On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > > > > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > > > > 
> > > > > > > > +	master->ats_always_on = true;
> > > > > > > > +
> > > > > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > > > > 
> > > > > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > > > > requires Config=Translate with S1DSS in bypass?
> > > > > > 
> > > > > > Yeah, basically.
> > > > > > 
> > > > > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > > > > a valid CD table pointer.
> > > > > 
> > > > > Ack. But do we expect transactions before attach_dev? What'd happen if
> > > > > we don't allocate CDs here?
> > > > 
> > > > It can be done at any point before a non-abort STE is formed.
> > > > 
> > > > The core code pretty much does this immediately after probe so there
> > > > isn't much point in moving it later.
> > > > 
> > > 
> > > Right.. that's what I'm not understanding clearly, if the STE is Abort
> > > anyway during probe, why are we breaking the alloc-at-attach convention? 
> > > Usually, we allocate CD tables in the first attach_dev call. Why does
> > > that not work here?
> > 
> > It would work in attach_dev(). I just felt cleaner to have it in
> > probe(), paired with arm_smmu_free_cd_tables() in the release().
> 
> I thought it was like this because we don't have an alloc on attach
> flow for the identity domain, so add it there or add it here..

Right, doing it in attach would've been cleaner, but I don't mind the
existing way too (since it's merged anyway)

I went down this hole since the reason for the convention change wasn't
immediately clear.

Thanks for the clarification!
Praan

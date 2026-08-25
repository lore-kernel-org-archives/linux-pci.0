Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7583B2FD6
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684903; cv=none; b=Asi9n5jVtzcHS92osV1+YSPvS/IsBsjurectaujhwH0T5Ife1nRuAluSL6V+j9mSMFxDHSoTvNXdRxjudOoZONRwua22P8b/vZRD6ekpu0sVO8gbbVbMIMMAh6TmkN1MCRLN1em+OBp+9UbqOnifwpMA4tuaW8wmthoeY35tRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684903; c=relaxed/simple;
	bh=VgttgqeeOlrykLZCGS/qEjZQQbVFLqSvRQ4792GQ6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8O86qz0m4ADPei1pHaE2mxqqrdPYW9fuXQEb4JhE68qimFYlW/A/d5okQ4uoxbA322NAcCGUy76vHsdlh06Eb31eIlYK1htwpZ/V+aEv4H1cFS7cNWih+/RViI3E6mWbnPuTUTDSLePTE2SgY0jBt7ruTm51cEmDozV/CMmDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hD0oRyO6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hD0oRyO6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b440b97aso24155ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684902; x=1788289702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTbnZdKCLLlaDJ0a/A2nFTAg6s9FohnWs0NnAWaP8fU=;
        b=hD0oRyO6gXw6hdznoGSfO33NpPWi4djuVa5POBKpm546ihiHMrK2SRRbIq/EwLsZws
         wnxqw6beMxgeOWe9HSSg1PchdigX42GgTLQObDDDq3CdXP0ovPTD4hjVywtHZffHmio8
         qRSddNQAVpyj6whrChmqtXYVM7w9x0yUQne26osEmY02XLnqIfVIHLTYyempAwSuUsLY
         8Y8ktRy+BO2pU79y4Hc2QdKRDFK8Qv+uQy/wwjMY8f0uKPhyQz3nuRZ/e11iahUvHYkl
         bXkB17TNa8E1SEsR08Q6HXRk9nz0aaldtkPOtkpvhCdfR90zfAxMHEMuWw0vubzWwRlO
         vl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684902; x=1788289702;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTbnZdKCLLlaDJ0a/A2nFTAg6s9FohnWs0NnAWaP8fU=;
        b=bwvVCXvRiCznjnZh0hg4G7IwK0KHPopeG0bQZARJPeIHryHcyHoTLRy13AndpScJTJ
         kOPAcOgEu3aTXsQmZFJOXMeCtTdGnMl8umIyMjcwVIVoInjOLeDBTlBM9k88c/zLv2Zg
         tGR4zLd48z1taZXFqGko18EYnO9nnjxaWLNo4SdoRAkRgfHCcZ9yTvt/6aCvHcWDq+/D
         T0I67XJKife6KB6hrfHMJi/4rIQORTzWqpsBwDO+/tAEUxDLa1DL2rWQSSdbdNVdtbeI
         K0TMUw+dZ5IBFRGLIl1d9qMkizvA7gsYcLFg/XnQT8AtBIwA7f+d9CqZ2ltM6RG0eaCP
         r03Q==
X-Forwarded-Encrypted: i=1; AHgh+RowTXH2uPp4VthmoSUo8El3AsKkDuvSh+U17zwrMETpV0zu+rr1yVqxNmLkfyiX+dqCmOOdn2sroLc=@vger.kernel.org
X-Gm-Message-State: AFuF++nESC+DuulJMNii82D8uvVkoZ5ML3DWGkat2SCR+HqZBUGkifLy
	7jUiPxXmwULPViibDelDdXjsPixE3rZR7hG/ygC3+GpSePiW+h2dYshonvT0sn9+Tw==
X-Gm-Gg: AR+sD115O3RNX3QxBPqZoT43USRVT3Nce6bjV1tmC0m3s/ikYxjfeDZ/D6nkNjpdKir
	oRhrrZawTSRpULZh69MF4RsAB5DJAnwAg+XtfGnOoq/pE5lx4DgXDr7isAo/DXYE8NaErDkJ0Qd
	Ieo+h4Szsc4PEcNnph+emXdvIr3so4ZlHY5u/g1qnvMCs5LAgxPD6yptQSrsWGJpVtwhcR/M2HU
	a5tlDkKw+6adgLupBnQ6Bo3cNbYk14u9nnrQN/c4Zynp3rTWFE0SqIbEiIunYjaJMnA9y3vS0uq
	FIjvhgBEaugPmwEarMLnl2aED1tmf95NlaYJq0kcVozwOyOUmnu+l+4A7onKvwshErrmGABGCMh
	4YHWYAb3/RDAq18SFpJtxCk906+eK3yS2RyAL2IVJRcxmws1Kj+0wjO5c+xIEPZPuuhq/PqJleg
	BJqM3XnGGoSPi2KY29t9MiFGuOkC3e760v1wXlmng9dqHqXwrQ0zJ0uEkHb7YqXHLIlJZ1jedba
	bT3E/PVI/fY8Cr+wqiwg1EoyqEb6OOH6a0ESQ==
X-Received: by 2002:a17:902:e545:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d707bc9904mr640115ad.11.1787684900811;
        Tue, 25 Aug 2026 12:08:20 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a5832bsm805257a91.15.2026.08.25.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:08:20 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:08:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <ao3oHn8HiXIx5Wrl@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825175315.GD3325090@nvidia.com>

On Tue, Aug 25, 2026 at 02:53:15PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:
> 
> > I agree, but I wonder why the existing code used memset here 
> > (in ignore_device):
> > 
> > memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > 
> > I was thinking it might've been done for probe failures in a kdump
> > kernel (normal kexec would've called shutdown for clearing all DTEs).
> > (I see this was added long time back and existed when PCI segments were
> > added [1]).
> 
> For kdump you'd want to keep the original translation running in this
> case.
>  
> > Are you suggesting to remove the DTE clearing from this path entirely?
> 
> Yes
> 

Even I'm not sure why we had this memset here, I'll just dig into
the history once if there's anything. Otherwise, I'll simply drop this.

Vasant, please let us know if there was a different context to it?

Thanks,
Praan

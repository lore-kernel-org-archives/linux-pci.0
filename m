Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9342C4F8
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344467; cv=none; b=armCVW79Ozs/nxD93fvGeG8I+iyVlNLeUu6mKo0yopJRj0APOm1j4LtV6RwI71fSKTMwRO1HdM+Zpojrm7hZa+z5tRAeD6sytIWIq9QTDoK7YfbzzPzkbsuhoImfJK35qhkqlGWkUMOdrYgp74zlb8s6tm1cbyyHoafiC0h4AqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344467; c=relaxed/simple;
	bh=fSOZJ17rVEbG+FfK1DiMh3qgkRdHa+C33+C3HyGA1Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBAYMFvi240oDfj1SiLWZw+3NLw4u8v0FTZXghUbE9Wl7GPdhEiDgBbsjhX/lxAyrvjs/ms9BA3BXdwU9whGA+CJRS1DJQjPRsMQ/FOJFvdCvHAWltAgid63M619UQhQN3ynuHgAgtS/5ypenlUH1dS+rNFXtL2tWCL87wxN7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEGvEfIV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEGvEfIV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab97c86bdso505ad.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785344463; x=1785949263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtT0ExTXo5bL6h0YkCoaVWGGXnkWOHvTo5L6MU1yaIQ=;
        b=BEGvEfIVPia25HWYQyOmpAwClDSOZjE8ZLqbdTfn6xnC6I12VdCONnLWG5f2SuIHpz
         6EgM88RI+Jgja+3JGcA16o1ysVqQpvnZlMu7bpnZFvEEX4Jl3tIyZbYGP0jkj1QR1V8V
         7Snuriz8ID5ys2yV9mAHhQRFs2SWp1xtT6mKA+2nNMlX8LNqbOoIXw9FnOpUitaoejW0
         w+jYwyXFv2isGx+ArpXKaCDV+OS3Z9x8f6mWSb8snE7/i02idR8TsAE/TGfMCFqwJCFI
         ZW4Ux+wVCs17XguFUZ/cwMIE61nxB//G9hiNUi/tGVdxyyGp7Wo+6/e/fguMVtyGnWDS
         kDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344463; x=1785949263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtT0ExTXo5bL6h0YkCoaVWGGXnkWOHvTo5L6MU1yaIQ=;
        b=eml+cIM0iZ7BM9T89dLheGQbLUMxQD7MBYHiAFR8GVVlCyXjxpg/gO7znYQZBF58gw
         1Q6rgU/1QcLYkeIdXcjDEX2A/SIzBHfHB5EsZfJiazx8dPT9kd89ZpRqSYiVIaX++Np7
         xfZTr0eYGEiKng78p+ueVNsoTlsKz5gb/pxArPNIzaNeZApK04T+6ahz1BPnzJ/OEyVF
         p7wFnAT//Tpe/dVmsyQ0nq1XQoPOa5TdM2IkKiYTlJkAtrzMTCJjOPqjDf6Oa6L6pWdv
         iZyCvHuuRQ6MwPQk3Gkj1MwWMmsJTFAg6fhueVHCSQeMmk8aS00YBgM0cUg7xn4Kuua9
         m/dQ==
X-Forwarded-Encrypted: i=1; AHgh+RrS8x7g9YaMlUk99anHnWURh1z85HsIoiMfHmecbP0iRqSTsSekjKrSFNz2vMiT/ljE68itB6NKs7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzku7jSNOSOPFEwQdgQhK25XlLqtxR6TfO3gx6EIREDnUid8/0
	V14mYWBZQgBz4QDAGxbtGtnMcvjuXyL3iAB89beYwolbHt4UkRLx5ZKqBqSGFlkBnw==
X-Gm-Gg: AR+sD10CDqOL46lJUhWuczEZjgG1Y1eXS5RUS1k67bWFcI8K35vRGlBJeaUp3hXf+9T
	SysUa9DajvfyV8cfuqQIxAtBb0Uh0qhknJ06rtB4wYdZ3WhHCgkToJgjMqA5NsFIAhNmbOkM/my
	SxGJMCkK0t32sKuYZIrlbYask1G6yOjzbT4BJttrnCVmFiJ/iqLbt9i8BWPvTvdFGGKE54OZE1D
	jUX1yQsODF64RH+OHME/mLQ5R0fDaV6jwK8pXjPq3jAPmCGDNxCKUS2ivIdn3CHWa/ftuZDmkU4
	pjpxVOOGYVMAA+P35GmJFpm0IBce+fG5BM1JkvBuipZmV2fZce/Mga4xtyXiULMgZBF7lMNe0Rl
	EvRFVv8zTUShk1vPbuc8dm/VRP2dsaNWSD+m/TYe+ytHD8NRNNDDhpdAZ5lW+paEAHqfbUOWKZL
	vp0+rhZH2VGlIgK2+HfvcJDP8kGqfPoDKPXwaLRqtLJbrdvn8SA9QXvJ11//RTZA3Vh48np6R6y
	5Jx+kUGfkotn7DRYxWJuwA=
X-Received: by 2002:a17:902:f608:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d03210f8c4mr355465ad.1.1785344461607;
        Wed, 29 Jul 2026 10:01:01 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm1750258b3a.19.2026.07.29.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:01:01 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:00:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <amoxwA6EPeW1uuIp@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
 <ammMf5z-Gl-Wygk6@google.com>
 <ammO+4W/dGC8kTCr@nvidia.com>
 <ammTr2kvjpiOHkbT@google.com>
 <amousSY6qMX3felk@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amousSY6qMX3felk@nvidia.com>

On Wed, Jul 29, 2026 at 09:47:45AM -0700, Nicolin Chen wrote:
> On Wed, Jul 29, 2026 at 05:46:23AM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 28, 2026 at 10:26:19PM -0700, Nicolin Chen wrote:
> > > On Wed, Jul 29, 2026 at 05:15:43AM +0000, Pranjal Shrivastava wrote:
> > > > For PRIQ/EVTQ, my only worry was the HW producing more events,
> > > > say Device A is detached (we call drain from attach_release) but Device B
> > > > (still attached) starts an agressive DMA with multiple PRI requests/evts.
> > > > 
> > > > Maybe we should go back to snapshot based polling for that?
> > > 
> > > If you look closely, "pending" is the snapshot, regardless of the
> > > growing prod.
> > > 
> > >  * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
> > >  * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
> > >  *
> > >  *   cons0                cons                 prod0         (prod)
> > >  *     |<---- drained ---->|                     |             |
> > >  *  ---+###################+=====================+=============+--->
> > >  *     |<--------------- pending --------------->|
> > > 
> > 
> > Right, but we write back cons to cons_reg only after we see queue_empty()
> > We have a do { .. } while (!queue_empty(llq)); and then we call
> > queue_sync_cons_ovf(q). Same  for PRIQ handler.
> > 
> > IIUC the helper relies on cons_reg being updated:
> > 
> > cons = readl_relaxed(q->cons_reg);
> > drained += Q_POS(&q->llq, cons - prev);
> > 
> > Thus, if we get a storm of pri reqs / evts, we may never leave that loop
> > and queue_sync_cons_ovf(q).
> 
> cons_reg is updated by queue_remove_raw() every iteration inside
> that loop.
> 
> queue_sync_cons_ovf() doesn't update cons_reg unless an overflow.
> 

Ahh right, I was too focused on the storm *facepalm*. In that case the
new helper LGTM.

Thanks,
Praan

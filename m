Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F548BD2B
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679015; cv=none; b=gt4d26b9WH7WwE2cgKQooXfN1qykApeKt/k2b1thrJ8BnO8S7MdDrAPLP+dYiLNRKNUimxDrqCaUaaWCmH6xgcRvyfZSLBHFZBOJ0Bj+hr5wF/QjI2EmTq1/nwPr4lEDGi88o0oBi4fkByYDXjTJEFfIykSDZ+F6ImncGBdFe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679015; c=relaxed/simple;
	bh=WF09Bx2mtfrt6hRVd0SLFSWF4rEJup3wBMbdU8OJyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMfF1OUtcdKLrhnmtlx0k7GfW88qzNWcuZfiB5oBa4KiL2DLpDHskUYaFyjuRfLlzBnPJWABMY0xlrO03GFMSNIExvVzi7+8yiFkzl+20irPeeSGc62u+G+L416Z/BgqPD6wWvsPCdDwACqvhGMJkP+6TOl/3SVXVTzHv/hTf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4+v07w9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4+v07w9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b445a84fso6175ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787679007; x=1788283807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8wBJpCqawgcwqwfKU05d1Z2ZrVuf5nK5DNpdSKbZyiM=;
        b=I4+v07w9Ku5pI2CQzwxwzHe+uQKJFawYs9cgbPEsYW8GZr2VGzIo00kEMPRBC7re6j
         Di3mCQm9HCen+xyxEunOC4hHWlrb9ZqEBkgSC6jggHiFaGA8uS7f4DLwJ6JYcsR0RAh0
         O6lXWRgMHiA4v4yEsbvqfrVJhCsYOvkSuGgKqRzo/EqmnBk9C5V2vvS2aYN95fJOvUn4
         BRBIDzkrgUHYCousILbYnHrL7xjcT2r4vY4wUPzl8r/YcWHqj02nTdoLAw2XOS7kw2ED
         jhvBnt5zkZh6yRuYJqNt2x6w4PQiarxgY1/730mWkuiqg3puzFBqc5ZjX85G+sj1o8hq
         +Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679007; x=1788283807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wBJpCqawgcwqwfKU05d1Z2ZrVuf5nK5DNpdSKbZyiM=;
        b=PVPxfKCZTd6H/onW/X7K0cskid69dhQbeHsy8mTf1W3E+OaUG8ByOWXt4+NbbMbT98
         gIrvhPDh0jO9nrEsJzr5upXnyagDOjuT9BVP7uDPfAKog2e+JE7Qb8C307VKnEjt60wV
         tRTNF/uxdRhrE44EazViMxHJE7+clLDpEGaO1ENxYet8ToxaU2NOr4LbXbvEdLzBhh+C
         UNn2wzOgaldKxLIh5Iwv5tJuCM28l5xfzgz344kC65eMNhFvUb6ov1IVCx/gyx5gZgkI
         Oi2fsE+tna4opoOBpm2lLx7583L+I3LS6g8fX/NmL6kZ7+F5tBD4yroX7FcGDdxNrqpV
         otfA==
X-Forwarded-Encrypted: i=1; AHgh+RqHYViGiePEsUjX52yWa8hZhSFDjN5JXqWAoidsvDMaZQ1dKBnjG1WtRjPxCiXee7DaRNZBrNDCgNE=@vger.kernel.org
X-Gm-Message-State: AFuF++l5F14A+djZOzMkLd2Y3N8hqVwXoNlBoJOitYA0MFoxuovuSTz6
	saTfbr5pCw8JRTbkiLM9DJis3QfZkvnCiASHy/AtKqoJXPtiGTdcabyJAcNj7+rGzg==
X-Gm-Gg: AR+sD109+5QakhA5T0HJDn6p1ZOHE5S0boXuM39UvJwel5zf72njDX2ohNZ9pE/OgAK
	QoMaaijFAzkj9i3y5w/NAxtMSdEMovHWzfoMrwGS/54YrmBjU+ubOBw1kUNkLV3O3SY5bbqNRcX
	Qiq08CVF3m4o78vIfbmvKsrmYoNXFKVdTO7dxzSVvSeEo+/H+wjShH57+kY7leY2RXLnSdTA3+7
	XbGaJhEK9sfeFUWlSmI3iDV95jxcHhSFI/pMoLmi9bIgQZai/l4V5ogHNUx8FUqhXXfg6UZKRZp
	C9c1C9p2JD2ArHRF6qME+HY/90sy9QF52Jk8H+g2Os4tDP3QR5S8uOHkPxAW8AopatqxNrDCEg/
	Xy8Vmvz8isaZSDw8+xy+f/sAg2BOeQi0CA/Z4pzXyZEz4mUZgXAGiOQsIkgOACGxkhD8yaReXp4
	KSbDNwwy5ep7EcsQSH2jWGv3RGgpgTxEz/QJWvweDsSeeRVlewJqnkhrtngr2veThKa8S6gp1R9
	eNs0CiDfsQ9qihiZC2QZ9wZqU4fsCKuZGZKkw==
X-Received: by 2002:a17:903:acf:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d6e036d4cbmr8058505ad.0.1787679005676;
        Tue, 25 Aug 2026 10:30:05 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39662c80d6csm1544432a91.1.2026.08.25.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:30:05 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:29:59 +0000
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
Message-ID: <ao3RF0w_AXo5EXxv@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114916.GT244917@nvidia.com>

On Tue, Aug 25, 2026 at 08:49:16AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 10:32:07AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 52 lines skipped ... ]
> > > > +/*
> > > > + * Invalidate a DTE by clearing the Valid bit first.
> > > > + * Note: Lockless; Not to be used on a fully probed
> > > > + * device with live dev_data.
> > > > + */
> > > > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > > > +{
> > > > +	struct dev_table_entry new = {};
> > > > +
> > > > +	write_dte_lower128(ptr, &new);
> > > > +	write_dte_upper128(ptr, &new);
> > > > +}
> > > 
> > > No need just call update_dte256() with a 0'd new. This is how all the
> > > update flows work, and it flushes the DTE which this looks like it has
> > > been missing all long.
> > 
> > I originally considered using update_dte256(), but iommu_disable_device
> > is called from the early probe error path (err_deinit).
> 
> There is no reason to do that, the DTE isn't written by
> amd_iommu_probe_device(), so there is no reason to clear it on an
> error path.
> 
> It is wrong to write to the DTE table without flushing the
> HW cache.
> 

I agree, but I wonder why the existing code used memset here 
(in ignore_device):

memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));

I was thinking it might've been done for probe failures in a kdump
kernel (normal kexec would've called shutdown for clearing all DTEs).
(I see this was added long time back and existed when PCI segments were
added [1]).

Are you suggesting to remove the DTE clearing from this path entirely?

Thanks,
Praan

[1] https://lore.kernel.org/all/20220706113825.25582-23-vasant.hegde@amd.com/

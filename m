Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118225771
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038296; cv=none; b=f5lla9w5NQFF7/h20gxlSixBwCf0T1KwuSa+KvzBGHRwXO86sZzAoA4rMDwQzmYSDsTyikiPdZKuf0A7HunYRsFKksb5UfRnRpdszla71CMryksg1fN2lLGm0CxyS9DZEsfbMz0JH2ErJyrhYMc8lYbPOmdz2aLba80mLkESrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038296; c=relaxed/simple;
	bh=iam0u/2Jl6XkPvwi1qwhiflT+1xKVHGWQhuOjLQOVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umXc625GP8zrHRTOzmKOO4H24aSuykaWK10x/TeCtXgCUndCcQthlSvq73xAbPFLV/nfTzy6g4WnXDs5qwN1bcHTJ69NYRsbSuMyJefFOkqCSU/6m5rco6ni2QzbE/uVS2QsrLj4IJSbJEbkF32F3HmcZ4dI3dwFiZ8w3de7uCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7vyKSW3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7vyKSW3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2911f93cso835ad.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038295; x=1780643095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpdj4zdvOr4RmzrDJJcOOQOaZ4aQerKSX3Hu7HK0Ghk=;
        b=O7vyKSW39lsdQU5/LCB++owNRtEWOQSXfBdE1Q3ZAy+qWL08SHYBYn0Azgng5ELroj
         vZdXHMy13eMtbLFQmHSw1rcYqpvgBvla/G6oRaI96MhfMUNcr/bM+UuC8zALsyFRkKJq
         MXHgJCchgGf0eFzlghEMGYg/m95bnz9t3ZTDEL9eEEfpqJxZ/O9vq2rpOfB5gsgza1K0
         xq/xgm4e6U/wpRZa2KgT5VAUjUJinRBC/s9RXSGoliFwiScLYp/M8NOo/7jKtJuy9vVY
         rpYLts15OS8LJJdMWS1cmJN4KXN5bX3bJ1Ci9Ye4EQ/82wUF14ZmJfU+AkHCncMvAPlU
         H5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038295; x=1780643095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpdj4zdvOr4RmzrDJJcOOQOaZ4aQerKSX3Hu7HK0Ghk=;
        b=krQKdatMdwFXwXWFkP2AAB3w9zfZrrYs7Y71R7Trgrt8eOL2CF8trj7hdzMSJtYS7X
         7zi0jXq+TQNHceFegdDr88Eq0up9fUXHjpXR6Cp3qyj9hxN+G+0KxesvMJODfFIjbnWb
         O5wyOMdLX+FkV1TJ4SxR8JShTBZ8wHR0Qir/pJgSWMibeVLYHqhb8PqpZclGT1Z/fPpc
         89cZyINHdFzFR5JmnU/xAl4zShaFIKjO4s+R+Ezt8cvOXqe11zeHjJLrZJYR/DNkBLZW
         DZi5cZHRxlFc8kEHFsY06y9bBt6xq784ehqKLAJPQ0SFgoSBuifGMEx6yohpTkJsSTJB
         TfXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pQJBJ95QFtLiwGluervS1tpch6N0w4Pa++v2Tgy+5pF+iZTCB4NP+Rhglubw077dwj+Yrpdslcb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwv3p6l5ly8lLvx0Qr3ivdIZLDF8eRLW8Rc5vi0FRx0XMwkFM
	FLr45ToxNZDNBdm4BiumT9sv+NvCZ58uQh9SPSiRCuUVob6iKTKYBLB++J5ZnqYGNQ==
X-Gm-Gg: Acq92OEeZD65HlFlDLdq9PDHNKUoBFWcYTRVmIq6M/fZF/gkGy1c1rAIvfdmhRKljtt
	SXMwIdps9benoWeEKGvLHdTLNqDFHtBliTLnE4KjciL/xMKnCEkUiUrUX+3N80TcaZgZbAFsVkO
	7zQ2VzDAHZKta1lVh3M5u4CiN01fkKxkzdlnXL8cMWx0i5YJd00rx6P38Sfm/xXflqEO7B/FefI
	cNCOaMuDAAjCpe4Y2L9QLb+RFen60wvvcm1D+hYa4KLwJ/0nl0Ob3Yv+qpt//60zYyW5lrWqmdt
	gwmApI4jZM2AdUEsE1SonttBN5e76GQr7Uf4UTTMpWnHv/mDxY0TT/4aKIf5NAMg6nXGoGjiBJ6
	gHhJSLENlC5W0Vc2rzRvfq3/vW+WfL7l45dMcTCtSsG+W4yyuxuWqryrvkp8MC9/ITu/BdpLXxQ
	CwFocE+0+MnCm59Z16vq2Nb2JH4z8S+giUkJOr/XJWOFxc+mu8AO2UrukxL+GjEVZCvB14
X-Received: by 2002:a17:902:db0f:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2bf20d1645bmr1335815ad.14.1780038294503;
        Fri, 29 May 2026 00:04:54 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7c24sm914873a12.2.2026.05.29.00.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:04:53 -0700 (PDT)
Date: Fri, 29 May 2026 07:04:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Fix RB-tree corruption and
 Use-After-Free in probe
Message-ID: <ahk6jom_zexIt5S8@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-6-praan@google.com>
 <5c5e85f1-f745-4667-af0d-30af71288294@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5e85f1-f745-4667-af0d-30af71288294@linux.intel.com>

On Fri, May 29, 2026 at 11:20:47AM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > The intel_iommu_probe_device() function contains two pre-existing
> > memory safety issues on its error path:
> > 
> > 1. The info->node RB-tree member is zero-initialized via kzalloc. If
> >     a device does not support ATS, the device_rbtree_insert() call is
> >     skipped. If a subsequent probe step fails, the error path jumps to
> >     device_rbtree_remove(), which misinterprets the zeroed node as
> >     a tree root and corrupts the device RB-tree.
> > 
> > 2. The info structure is freed on failure, but the pointer remains
> >     linked to the device via dev_iommu_priv_set(). This leads to a
> >     Use-After-Free regression if the pointer is accessed later.
> > 
> > Fix these by explicitly initializing the RB-node as empty and guarding
> > its removal. Additionally, ensure dev_iommu_priv_set(dev, NULL) is
> > called before freeing the info structure in the error path.
> 
> Thanks for the fixes. Could you please separate these two fixes into two
> distinct patches and post them as a standalone series? These two fixes
> are quick cleanups and are not part of the current series, which focuses
> on improving the robustness of ATS enablement.

Ack. I'll send these as stanalone patches. I added these here to keep
Sashiko at bay.

Thanks,
Praan

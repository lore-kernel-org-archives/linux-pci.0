Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CF32B115
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550555; cv=none; b=cUsdQ5DrPSxxj/j/On9LiDL4o6BR/Rtzsk63if5c9HEmsQx3yetMBp44E/tgB9H85weXYNCKlFH4jBUYuSCDraomRM/gzbaN78tgNP2IeAWDUiufFS95ea3weks1KfaXiJABIBc5bEOjXmEfXwDvbrTeKr19589iSGKiYBXyZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550555; c=relaxed/simple;
	bh=nSVP0hjf/94PXAvWtt46EmkkqHdos3NIt1wmoREGLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR6mVIquWPOpBiAo/UIudXdORghlROd+KDRcwHSDrvMSKusmIwej1bFe404TSEIqEo6bJUIA4ylpRpEPxli7YH9u3JA5iRypG/CJvSyCw8e02CsD4QlNklb7IHXvblDG0a7fLE16V5UE5LR9OGNq7Zt86GAWtMDZqZcFU0WV2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZxGQi/Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZxGQi/Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so47135ad.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780550553; x=1781155353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt92/T/ew+FoBUCV9JwGPlixqsptuzo1rSptMNUtFGY=;
        b=JZxGQi/ZoJY55Ud+YmV/5Jgyjg3gGH4UpqvamUhzpEfes/iJCykJUhAr65ZPNn7TD0
         AmkObVoKH2T+mDO0NetlWdH4A8DnQknOTbmYvvropAh3z1wCIIDRjiG+X8REkDtu2v3R
         UMhA/uXXMnz5k+YRKMyTcXzdYngqo5btx3OtFDnHaccMjFr9bm0axLrtxGEd94qZmuZM
         23kqMhXWzTYa4jbpo3Vzc3DiEcHga+DZ0v4UP8Fkm7W9LoDB43Nrl/e71PEUoXjLuvRp
         Clv1UN7es8S8533nwVCNniprjeGQz5OJmIH4UcJieYHWwo8mabrHbjPmnjJVNeZivhRb
         I6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550553; x=1781155353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt92/T/ew+FoBUCV9JwGPlixqsptuzo1rSptMNUtFGY=;
        b=NmrR++1vhCBDzTYA3tgCxAQE8fM+oD0W3rFU3G4V7qUajWwc+ogyWBAX+0O5mBa14T
         OU09fH2vTwVl66CdbK+dNYD585Ojg3JxKwIcOKhr19sGIMaptCdshtovuwBQVXHSKV5I
         9DGnSejUSSjzJQ8vj7Jz9e5i7csLgMq6FI1QjBWW/5lXj29m+KIgnReO93v0iTkw3DDU
         y3pfZkWEFJRRcJVY11TXIukikuhyuzWzWypWVjIhB+qjqs9i6nF99fGUbmjAPalPLx1G
         owExhgLLeRt+7T8A7Kh+xdePx8uzkRgZ4iRhXFnDQIgFzLcU65GNbd5rEATalNaF+yMY
         Sblw==
X-Forwarded-Encrypted: i=1; AFNElJ8TSER+Guosytxv9+uPtHhwhetv8mZk0ITSEu4c+4J32k3TlrEWXgBQIQKT/cZTbWRFRFJHjXB8J34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjg1/gaOb9dT4KqW7bjrNxSyi+etMdgfXwVVLEenRsOu4EEdU7
	FO0G0jzUeHYI3WAOJs/SO/Caktc7soZprmclMUfp4HpTxdjsVaUSHybtc4/eQc1tFg==
X-Gm-Gg: Acq92OGx3nEqbEHytIwcjnlVVfPrRu0DyLoLHeYQT9AtJcj/rgFCtNBDBGAG9S0CKxG
	kX+2wPgYjXnEKyE942IryJy6jPi3XHDojGVI4pOg34TjNyfGH2Z+0XHWSuLOWln5BKtn9tYfuM/
	WzKvXUuFQ9fEQzB181hcpDrDpxw8afSq6QHLo8Vozl4sKpSFuYJc/YjGNpJHayoN/Qk1R/ky9Kw
	jSlUWHCyPrQBeorLdxl22QWeVOh3uj6oQgH0ERA/QC8WbK7LCyznwLnJOQbA6MXiJ8LvJ4ddFIS
	NC1PhXfBeoVjSVM/FkhYY8oqIN7LujBup4DUvEI3RVCPzWqLV7OFi0UoMN1DtxbNcNKn4BA4JmR
	+3+PjNRYGAG/+VFXtQcK0r0+kXR1Dmq8vqigzOQ8MWhxRICVpK83b6BYBDL7qbfP3vSa1oBvefX
	+Y7Rm99oEo9UVBL3eCoywCqEs0Kg3RqqVe55iY/rHhL9uD8oT3c08C19ytRZsrA42gZw/qrjY=
X-Received: by 2002:a17:902:f790:b0:2c0:c3ac:fdf9 with SMTP id d9443c01a7336-2c198b295acmr2052415ad.14.1780550552540;
        Wed, 03 Jun 2026 22:22:32 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm43367335ad.75.2026.06.03.22.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:22:31 -0700 (PDT)
Date: Thu, 4 Jun 2026 05:22:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Message-ID: <aiELVKlSTOEptU0O@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
 <aiAr_YZqVwijXyQ5@google.com>
 <20260603145903.GC1170766@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603145903.GC1170766@nvidia.com>

On Wed, Jun 03, 2026 at 11:59:03AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2026 at 01:28:29PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
> > > > From: Pranjal Shrivastava <praan@google.com>
> > > > Sent: Monday, June 1, 2026 10:37 PM
> > > > 
> > > > Clear the iommu->priv to NULL while returning an error from probe_device.
> > > > 
> > > > Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
> > > > handling")
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > 
> > > probably add a note that UAF is theoretical at this point.
> > > 
> > > iommu_init_device() calls dev_iommu_free() right after @probe_device()
> > > fails...
> > 
> > Ack. This is just to prevent a UAF against future refactors. I saw the
> > intel & amd iommu drivers doing it and felt this is missing from smmuv3
> 
> That is just pointless dead code, the core code immediately frees the
> memory this is NULLing
> 
> static int iommu_init_device(struct device *dev)
> {
> [..]
> err_free:
> 	dev->iommu->iommu_dev = NULL;
> 	dev_iommu_free(dev);
> 	return ret;
> 
> I would remove it from the other drivers not addd it here..

Ack. I tend to agree... I'll drop this patch here and request Baulu to
drop it from his PR too.

Thanks,
Praan

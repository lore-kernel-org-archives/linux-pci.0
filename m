Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6A3750D7
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216091; cv=none; b=NCZjaL1pyQ2aq9UZ6IbhydIbO2mHP/ROhISSMx5xFXhGOh160QqtOL9iFUGR+O5QD3xg/dm82ji6ACfvsdWS57vTCW1fbHMO6Xjgqf2ol7rQBzVoCKK7x2ohqkBv7jviFa2f3j5gRg2XxMfpeODGJsE53+EMjO1ECJkeun5AAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216091; c=relaxed/simple;
	bh=driLtFFPc2/aFa5tQeIQT0kqHjSvzncIJmA5n8m8Ti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujYFzKo4kgyJYYRyB1QdLVbh85e5K48HLtXwhjT0ldWDiCrL3rRptrX4WBcLtv1tFmWWATRma2d3fDdgPqN30Wxwc14t/37IDrZeO5qk81CkOUs5mBZVrlTH6FO/UwZeMJGppZ/5ilUsyZKTSc0zoyOwPlRR2+cYVFkIzDabbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hk6EukkN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hk6EukkN"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5175eab3a93so2114451cf.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781216089; x=1781820889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TU5lI+UtOlVYfDvzN8n1Q1p4EuEL8icx+G3TWgzZwc=;
        b=Hk6EukkN3JgY5a2y/WCgOZ5Ku02LMoqvT+bOkn8NbqlM6cSDWQcxUfBiTm/CBediGe
         koRdsbmPyWxuBFHdpGyHrLF1imrx41vycYoesSI9qpdWKsyZddRVSzxFMEJhHhX0MYgq
         RnEWYFDA7CjfI9E6JvQmlwaKD+Wo9EiNUsZAjfgjaUcudUtB7czxcbyb7Zv0GHLDoCzi
         G1OjPNieqq0gJA7dWkVXNvYGBKn3THrN9GRe7RL0FW17qUIwwzmEaq7qX10sypeVxnOz
         HfxhuczJdW4eKzmy0ZVaz2+RBLNXOQvEsWKkPCEsGvyk9oG4MwqVuJaTvOO7XKrCLxlI
         xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781216089; x=1781820889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TU5lI+UtOlVYfDvzN8n1Q1p4EuEL8icx+G3TWgzZwc=;
        b=fE3lIzpPcoLoWjoAjgVSSGBMBZi6c262B4+bPmhtJgMJTbPQj7Xy4g8HZcviELmwgW
         PVT+2KvoBnmwikwOUsH/pG4LdUVufUN0TYC+eP4jF7TNCqG4g5ORomMc/G0Pcwvw8hPp
         ec0mTqsighBXxyJWmx3CabUUn57HduThUfSZfruthUG6kmc3fbFj3R0/iSPeveFyuygL
         +maUT+/Py2AGmT7gEmvBmoyFWm3uPb9D9BSEn6wKwVIB7XIkLdJXmBaDYlT8uANlgk/R
         FMMzVcNdZpFKbwePcFigwRtewG/jdA6q4skUKJCj8SODceNCaJPvvGOC7NOrHVhJv9Ib
         xu1A==
X-Gm-Message-State: AOJu0YwzV3ToW1jA51xklJXliAquGt1ygvAZvIhb/2SAhHUXXQPU5eKu
	FXcRbhd7buRzRtN/eqrjfyfSg2Ls9bTRVdzjoUwKQwXQbMm5bORk/NaL9ZVnvBET/Ak=
X-Gm-Gg: Acq92OHiK7B6KHQ1871sP66tbzCTtSbrs81flxin6gNzooZdgdh3DIdd/odVg6NVu3f
	qKiklXnBbgrg16qHJLZIwmpI20vdgdk2DNot0ZzXIkyln7aa/AqIQ5/+5DL16ne9Sj++hb21unS
	JytiXLyF1nqCtKTYeH6vZV/cyqxLkexAMpmF81g/SodKGQHVcG9MuAvld8jjlyWbPdzFV1AMPf+
	ILjisMOXB+xjV9dovTTHUUnQLiKXi1qcE6++C8shLOe5QHmkQ5IyyYs9x9UZBcXcPrPK1V+CaP+
	rJvLIGy/dtCTR5wjYirZI/DSbe8pamh8nehcOpPaXthDHhU48FL0CNAdggCo+1VLWK7nsPFGNkP
	3FRX4ThxE887W7Vczcu3a9W5Qae3oQTZlKz1OlVf2hfqQwTWIzvCBZnGn0Zz9vP4pAdb7ea+1Cs
	beKV7pAhyXeCL1jKfWU/i9JOL2Q4+m8uWwlOB1nT+tashq3miUs4IskSSnFJmIioDLPveBrH9CT
	RUudg==
X-Received: by 2002:a05:622a:90d:b0:517:d869:427b with SMTP id d75a77b69052e-517fe4ecf87mr871481cf.29.1781216089450;
        Thu, 11 Jun 2026 15:14:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a00desm5011991cf.19.2026.06.11.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 15:14:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXnfj-00000006bNK-2S4X;
	Thu, 11 Jun 2026 19:14:47 -0300
Date: Thu, 11 Jun 2026 19:14:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <20260611221447.GH1066031@ziepe.ca>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airI0VIb563jHTcy@google.com>

On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> > 
> > > Users utilize the standard sysfs p2pmem/allocate interface for managing
> > > memory slices once a BAR is registered.
> > 
> > I'm shocked someone wants to use API, what are you expecting to do
> > with it??
> 
> Our primary use-case is PCIe BAR (DDR / HBM) -> NFS via P2PDMA while the
> PCIe device is managed by a user-space driver based on vfio-pci. While
> kernel drivers (e.g.drm) can register BARs with ZONE_DEVICE natively to
> enable this, VFIO currently lacks an equivalent mechanism.

I mean the weird sysfs mmap API. It is only useful if the device is
basically pure memory with no functionality. You can't even learn what
MMIO offset the returned allocation gives so it is almost completely
useless.

nvme could use it because CMB is pure memory and you reference it by
its MMIO address, but that doesn't apply to VFIO..

> > > An alternative implementation has been explored which integrates with the
> > > ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> > > registering a BAR as a system-wide P2P provider, VFIO optionally
> > > allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> > > new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.
> > 
> > That's probably more sensible but you can't have a DMABUF mmap
> > actually install non-special memory. The native vfio mmap still can,
> > but not mmap on the dmabuf fd. That's still workable, just keep in
> > mind.
> 
> Ack. I guess, we could have a separate mmap path in case of BARs that are
> struct page backed which doesn't go through the dmabuf exporter.

The dmabuf export is perfectly fine, you just have to think very
carefully about the mmap path.

I suppose if you build the proper revocation fence for zone device
pages as part of the vfio implementation it would be OK for dmabuf
mmap to expose them as well since it would have the right lifecycle
model.

That's the tricky thing with zone_device, you have to be careful to
wait for all the page references to be put back at all the right
times.

Come to think of it, since the sysfs API cannot do that in the way
VFIO wants I actually think you can't use it..

Jason

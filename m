Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F11A724C;
	Sun, 30 Aug 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080549; cv=none; b=niwOZnrB7Fh6E66Vlp3qUIIA826UwuQh2yUHJxvZ21dSHUM4FLwWlKevhaJQpgAgmdUkE20hQhTNxlPtmA26WN/BTRy+cKtuV2mh/LZqSq7YhkhWNP0NlKB/InOsLDr+IVKziHwOu0jHFBui+9CNFUkM+2daH4+EWHKNqGW/v4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080549; c=relaxed/simple;
	bh=02CLWUUyRHFwgLg4rbtWAIkgAwb1o/JlfMX1K1fIoLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVVX2KfFlnH7nYSEOshcSJUWn66Zh5na25gyyEKSG5Ye4RVdjQuFgyMSJ2CJjcM+NBPyHT/SGiOME34SQfNNg96dHy25hfGuYWfXwKcdKmT9Fqby1IM8Ba5rHUUOoyhu1w9+X8K+xSUwiSI8etx2IDH86WASaxbGEcTdO5/ALZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3JzSC32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3JzSC32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC761F000E9;
	Sun, 30 Aug 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788080548;
	bh=gZG+fbtzfW0EdsZ6oxJpMMUz9b/LqkrL4s/q3J5ieSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W3JzSC328eSA7ae3nUb1o5wcRQefeIE9PTf+ZF+ZF+hRQBblBSKPTNDPJqE2MAahV
	 qvkPC+mnwytnt373GLEFKpma7Ta4Bn3okEYjUkL4Zugzr4aQBkDy5SaFuqvjzbOTRb
	 qZf6HuwbWYth/c4249VlZYP4/I+QnjuKQzcDAAlF5EfCcLHSzqdxHjT0vg7B2JPmg+
	 bmV3N/z21TLmiwXgewKfosbGBgAlPkDOgV9TPgmCFWbUYpqs7QRKA/+9IITpMuGClk
	 hCzIRN+FPNvLlLqpBYrO/zOglaF5wQ3NH83MbabyCTWAfxVfVR0pAkDUMT/PQMCZYv
	 0pjW/N66DAyog==
Date: Sun, 30 Aug 2026 12:02:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v4 00/18] PCI/P2PDMA: Fix ACS egress control handling
Message-ID: <20260830090223.GC24140@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <178761377033.3197084.14418777457559555376.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178761377033.3197084.14418777457559555376.b4-review@b4>

On Mon, Aug 24, 2026 at 08:22:50PM -0300, Jason Gunthorpe wrote:
> > PCI P2PDMA treats any enabled ACS P2P Egress Control bit as an upstream
> > redirect. PCIe r7.0, sec 6.12.3, table 6-11 says the Egress Control
> > Vector bit for the target port decides instead: a clear bit routes a peer
> > request directly, regardless of P2P Request Redirect. Firmware can
> > therefore enable Egress Control with a permissive vector while Linux
> > incorrectly rejects a valid direct P2P path.
> 
> I've never seen anyone use the egress control vector and broadly Linux
> doesn't support it. The ACS command line shouldn't enable "P2P Egress
> Control Enable" for this reason.

I tried to follow the PCI specification as closely as possible here, but
of course I always welcome the idea of eliminating one of the paths.

> 
> It is not a bad thing to accommodate the egress vector when improving
> the ACS logic, but the main stream usage is the interaction of the
> other bits along with ATS & RO in the TLP. See the comment I left a
> long time ago:
> 
> https://elixir.bootlin.com/linux/v7.2/source/drivers/infiniband/hw/mlx5/mlx5_ib.h#L1649
> 
> So it would be nicer to read in the commit message how the mainstream
> stuff is fixed up and just a little bit about egress control.

I will split the series into bug-fix patches and code improvements.
This should also help describe the purpose of the series more clearly.

> 
> > [ ... 36 lines skipped ... ]
> > A pre-existing gap comes first. The routing analysis covers only Requests
> > carrying an Untranslated address; ACS Direct Translated P2P overrides
> > those controls, so that scope is now written down rather than implied.
> 
> What I talked about with Thomas is we probably need the P2P subsystem
> to know what kind of TLP the driver intends to put here when doing the
> evaluation: strict order, relaxed order and translated all have
> different possible routing options, and real system configure things
> so each one takes a different path :\
> 
> Currently I think the P2P subsystem is assuming strict order
> non-translated TLPs when it makes its calculations. Which is fine, but
> as we go toward enhancing this each of the different paths should be
> kept seperate.
> 
> I don't know how the driver facing API should work, but at least real
> devices have options to use ATS or not, use RO or not, and can make
> use of information from the P2P subsytem to make the right choice.

Do you see a function like mlx5_umem_needs_ats() being implemented as part of
the PCI P2P logic?
https://lore.kernel.org/all/4-v1-bd147097458e+ede-umem_dmabuf_jgg@nvidia.com/

> 
> Further, when we get to things like an ACPI description of this stuff,
> it would be nice to still discover these differences as well.
> 
> -- 
> Jason

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D83546FC;
	Sun, 30 Aug 2026 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788079073; cv=none; b=TQGNm4BEMRWWpRO7YHBnch7WTGywTIcp4qpxKPyTZ988obFk9ih0AqImgIY2jyAMUFERbf9dpP1E5c9aFYNz1dXll/KNErCs93oLA54iKNpYou3anX74t3Hge98RzqHLDLtHHasr3mnf1LPIZF0zdCJN4neqO8kMNnIhAWm9jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788079073; c=relaxed/simple;
	bh=do6V0nz5ORnIw2Iaxar20MZdeu+D5NcEzNgXxWs7QxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTLo0pSxYQeoP50HJksuVXD33bA6vRIWB2NqjenfiDV7JWndNXpC0Fm+as98V7bkzOKuZ4fJZYT7aCsRusAE4pV3baL/c2vIFU+mGC+1hg5DgLXP5halJwFgRaMwgJL5WsAgmXpnLn0SlVvPesoBdQQV0qm2afD4Hdj249yrBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTbBXjxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTbBXjxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20CE1F000E9;
	Sun, 30 Aug 2026 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788079072;
	bh=ZSb+3tsTnfDEue9hW5qnk3fiAcqrMh+VbK5lw5gjEr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WTbBXjxh2BldNHnZ8A03sGSxy6GaGFT6lIsFXxQi9jMJqI4CsRGrlw944KvWH1YAz
	 Exg2uEoDFk3NWrpAvCwhGYEEMrPlDBYeoeBaU/5BysTat4eGb33ORWqH5mplk5z9Ez
	 MAxQCtPYzKcbOPqKck10GUEdH04Gs806s1lpeOyXaU2kR2FOwy4GuI+8BPn6WlVvev
	 sMOnbR6r91lxbJsg1y3Ftk4EBobTPstTKD6XE9sl3HNSOdRxFLDI3UMdh6UOn/iUV5
	 9PZOCDKRyCAvgD3KVicCcvp0t5Ks5FAl0W+goxOe2sClr5aXq2YH/io1kK2K++lSkY
	 wYVDXo0mcIpFg==
Date: Sun, 30 Aug 2026 11:37:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Tushar Dave <tdave@nvidia.com>
Subject: Re: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
Message-ID: <20260830083748.GB24140@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
 <154f7e6c-741a-4b31-9514-3d9066034958@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154f7e6c-741a-4b31-9514-3d9066034958@deltatee.com>

On Tue, Aug 25, 2026 at 02:02:26PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-21 13:38, Leon Romanovsky wrote:
> > +	if (ret) {
> > +		pci_info(pdev,
> > +			 "P2PDMA ACS debug: Egress Control Vector read at %#x failed: %#x\n",
> > +			 offset, ret);
> 
> This patch seems to add a lot of printk()s with "debug" text. I'm
> wondering if maybe they should all be pci_dbg() prints? People trying to
> debug why they can't enable P2PDMA would want to enable them. Machines
> that are just accidentally doing a P2PDMA transaction and are not
> supported won't spew a lot more noise to dmesg.
> 
> In either case, I might suggest just dropping the "debug" prefix as I'm
> not sure it adds extra value.

Sure, I will change it. I wasn't sure how this patch would be received in
the first place.

Thanks

> 
> Logan
> 
> 

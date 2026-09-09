Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC629248F57;
	Wed,  9 Sep 2026 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920166; cv=none; b=hab1Oy9WlyDX4eBJysEs6UNMD+QmP4e3Dj8b12TAKKBrpUB7Gs7M3ns1LNFm58wBXiTURlTlUaCoJuLAn5EtiUDPSLcVEZxf2V7ML2m0s9GwAAFTEORBS3egqmCTwZXV+aN91o7CISacVcGQhkev1dPPoTxfeaqO5rykAu0FtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920166; c=relaxed/simple;
	bh=lUFrlgGfrmBslO74eUZpRflTrmPFslKsHsfBJt9X56A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=knaaSukKxnENx1OMFt9AFcFwxeIPJ2GSw9UubJfBnGfH4VIk6zKCnhQGXAIxptwUQS+ton8v5Jiz2ffihjcYxzgWXmdrQY1LqBVYimrL0RACADVX2dfx7doA5nx2YG51CRcLlOBR0UE/N4ipmEae7t4Gc8hSr/31HfIbzf+96e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouq7r6qK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouq7r6qK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D61F00A3A;
	Wed,  9 Sep 2026 02:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788920165;
	bh=8m9T0NBkpuEteUBrfyjLaTedu451cNX3Eh8hcZA5qSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ouq7r6qK3Z+2UYOyZTc4drccPC2te8bMopgDkApqA4gBGKLhLT14c46gGWdB6oweL
	 yx9/cC7/703WbE7AftZHsv8EbK8NVJJah6jF10Ji+3K/XTuAu+8m6fEK23O6PY4Qi5
	 Ri5wIVj7wkbdKC7XRDEjcQVo9xcDLcYRWwPaQEmIS1aR1EWvFsoepgqIlUMbsTFXit
	 3PZpASboUmFsrZ7bHNWgxXLNwwvVGq1adEbirVf2VUZgtIp1a8RABgeNX9nqlCkSkV
	 LGPA5NGIMfeG4OudP++a3ZYOnI2LsNLAUBFQOH1d+h398V5dr9/bT8O7J+A+NqqN98
	 zI9U65d+fQQSw==
Date: Tue, 8 Sep 2026 21:16:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tushar Dave <tdave@nvidia.com>,
	Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH 0/5] Batch of PCI peer-to-peer fixes
Message-ID: <20260909021603.GA155620@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>

On Sun, Aug 30, 2026 at 02:16:18PM +0300, Leon Romanovsky wrote:
> Hi Bjorn,
> 
> These fixes come from my larger series that aligns the code with the PCI
> specification regarding the handling of ACS bits [1].
> 
> This series has already been reviewed by Logan and Jason.
> 
> Thanks,
> 
> [1] https://lore.kernel.org/all/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com/
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (5):
>       PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
>       PCI/P2PDMA: Wait for RCU readers before freeing state
>       PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
>       PCI/P2PDMA: Safely terminate ACS redirect lists
>       PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
> 
>  drivers/pci/p2pdma.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Applied to pci/p2pdma for v7.4, thanks!

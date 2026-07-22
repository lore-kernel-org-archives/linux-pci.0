Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD054334B4;
	Wed, 22 Jul 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742210; cv=none; b=g1Q36IncmtXKipAYhTCcImIzLwB+QA6xoirMkyd6rzrh3zveQESh2c9kJ9yGUT6ei4meV2Z+jYpvrIeWEGNaMvduxW+SOkwGWPLUDyewvM4r7ugfa6G+modKkEeKc61P9XnzV7elanQVqUww3/rNbUexQt9ZgBSNJAXlSnQ16fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742210; c=relaxed/simple;
	bh=9Xmknx25XMoDQz3LYQmyRbvmKkdX/M2SE/i4DR+Jqhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IkDi+vLj0nXw+pftzNIYUi6RZFwl/P6TQRbESDlaOnLkbCAQg/2vGKMgvakQvIS3393hobGyWhY3PnOkgJUy3xR20/L6mgWMPnIWf2WlMaPXc5AvcuilZCC8UTrcwgHMkO39tDG3LVXAMndgevQyPuMmTUW07jxt2Ag/h2yyEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjwYlHph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjwYlHph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A691F000E9;
	Wed, 22 Jul 2026 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784742206;
	bh=SdbvsQGKH88GZhvyhkB7U/0tkgghxShyRp/mxneyu4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PjwYlHphSQWSj4tWgG2uwoRvKJKjHfTSGgOJfPc6K/kqeokCj0XKH6IFKZrL77LcA
	 Co72PW5yT7Tjjv6YqKWXuSqO6VpaRneiLvE+6xmOXPLPv0hNodDafxp3LKTH6BLVAv
	 9dGPLZZ9dHq/EZKSyZWXL7JWFG1rh6miNlc+BgVI0ifw6nNZc8HTO5oKbFoHdsT8sx
	 KchFw1D0eVhfUBWRKh+hVDcJ4D+55wIT+WguKaTSAjOxbT5nY3dtAQXkKhmY+rPnVj
	 H67laPTzqF7IGEUpuCndYLnvEGOFWs0H8M07ubT62LJCFLRHrFl0OzFpUhddIMpEAu
	 T2O5cGuDeIcsw==
Date: Wed, 22 Jul 2026 12:43:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Nvidia Vera Rubin device to P2P whitelist
Message-ID: <20260722174325.GA751662@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>

On Sun, Jul 05, 2026 at 12:54:07PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Nvidia Vera Rubin platforms support PCI peer‑to‑peer transactions.
> Add them to the P2P whitelist to enable this functionality.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to pci/p2pdma for v7.3, thanks for the reminder!

> ---
>  drivers/pci/p2pdma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b2d5266f8653..9334eb314663 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -564,6 +564,11 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_6XXX, 0},
>  	/* Google SoCs. */
>  	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
> +	/* Nvidia CPUs */
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f95, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f96, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f97, 0},
> +	{PCI_VENDOR_ID_NVIDIA, 0x2f98, 0},
>  	{}
>  };
>  
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260615-p2p-vr-514bd262a839
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

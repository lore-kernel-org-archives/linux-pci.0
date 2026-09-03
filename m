Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659D43F09F;
	Thu,  3 Sep 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467681; cv=none; b=DdTq0runChstRR5plpszyJD4+c+L80zplqAiYNLh7EV7RG87sHPnqE4gWYv8jYcNxz1cJI2LJwPxBew69AZRpAzOLNOCYKa/Cc37Ixc7RNazT5yFmQ8eV0XdVXOQ+Wu1OFULCECATW0ATPXeuYuOqaTo7LGDtXwFWQYPvRCPcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467681; c=relaxed/simple;
	bh=An3yq0m1SrSqpAYdlgs5chPoGOIH3CuXTLu8+EvxfNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QJNPeIYxbaVNwNMzrSYCdcpQMT1OhPNw6bln4ERQNBB1x2biQPRI/DHojzldpL5EZFG42sdwCDORBfZgA+j8Vvz6E3BU3TDJu1wQTZwWQuJW2/OmBlAgb4po2u6YbF6QBl9HcgWknMuYPWjQDjH/FK0CHhgaQNWXXr8B1jtCw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnMSXc0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnMSXc0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71661F000E9;
	Thu,  3 Sep 2026 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788467673;
	bh=EqrNiBjV5RlXYnlSS2QkYfayJgyCYHp0OIW8RZQ3v4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LnMSXc0njky9VyJCSsnFqNgzqtMngAh7Z0QpIoS6l+MtCS0LhNRzx2aMVrtJaL8VX
	 1Q9l862qXtEvUevgCQa1jQ981epaEu9ArFksrJWZQLq5qWveKzivlI93W2/mdRtsT5
	 cSapprbL74wfyf2jKR2Ls7FHgUr4uyhk2t1H/PAkm5Ptn2HM+p207G1P+KBs9lq4B7
	 yPegIWu7jOyJVz4SPCnSH1bP7GBmdmF3H6WJk+xJcoiXPK6cz6DSiIpvCdhmAFO/SR
	 PQxw4hD0ww/Ug5aVhx65LWv0gZbn7RWfJYAsMsrOGPyrBsTt0NpMsfBX3mxqVab4L6
	 wYP//HOPS6GOA==
Date: Thu, 3 Sep 2026 15:34:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Message-ID: <20260903203431.GA2238823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>

On Tue, Aug 25, 2026 at 09:28:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
> 
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
> 
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It looks like 2/2 might be updated, and it probably makes sense to
merge them both together, but let me know if you want me to take this.

> ---
>  Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> index d3f406cca694..63cff9e4d2c9 100644
> --- a/Documentation/driver-api/pci/p2pdma.rst
> +++ b/Documentation/driver-api/pci/p2pdma.rst
> @@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
>  is used to determine the mapping type. The phys_addr_t-based DMA API is used to
>  establish the dma_addr_t.
>  
> -Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
> +Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
>  to remove() it must deliver an invalidation shutdown to all DMABUF importing
> -drivers through move_notify() and synchronously DMA unmap all the MMIO.
> +drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
> +the MMIO. Importers unable to complete that unmap within bounded time have to
> +be rejected when they attach, which dma_buf_attach_revocable() checks for.
>  
>  No importing driver can continue to have a DMA map to the MMIO after the
>  exporting driver has destroyed its p2p_provider.
> 
> -- 
> 2.55.0
> 

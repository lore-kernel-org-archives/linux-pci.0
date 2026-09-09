Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DE2877DE;
	Wed,  9 Sep 2026 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915841; cv=none; b=T9p221Hc4JBGZamsy21idSNz+e4WNITaxymiin+TvgFj+UVL35btXw6giC383wDr0n2eEAqit+REWtU2ejQMkkGoHi/UQit75sCoKoWgtgJIrJJdZ0ZZscU0PinCYVZnHmZwLoGY6oi+3lWDOUDnfzjvLTra2UQv29uFd8NA/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915841; c=relaxed/simple;
	bh=Q6XBOI0DpvAghtz1EZ0Gw/WPckxXynrEuur5Hkcb7d4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hq3eGAEMinWqLS+9hT5jF+4V4/+bhX+X/A1mDQkiQaeinDRucIRQPhWdFZwkxrgqCbtG4AT/Wvx+ekEc1pRt1BWFcd3Z/9RPOc2rsXCAwkd1AZu3STqMW6VE1X1u3g8AMHgolmzusPrtu/S+MCCwL7wxI/aOcm/EW/+ooYFALEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6cy64LY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6cy64LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AED1F00A3A;
	Wed,  9 Sep 2026 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915839;
	bh=+OTVFvoIJRMEE6d8LUJXlnROYFy/L9nqB5cEsKlak4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=i6cy64LY2Pb/CFiHm+FWOIwUGlbx9U5t0umcA3JFqFjZGlo4JYPQwFJq7hZFPZfku
	 xy6jQId+8MiA2C19cFP1XKRwgnsKelGq+f+EdiF43OIE7poVNqgqqOetK+kJp5FEqK
	 rRFDml0Ll4io8xK87oJFWiAkilS305/FnshXF7vS6KQwk7Jf41NLaP7SdPdbwTifHc
	 PBqgsFh2UarL4lxvc/4cYVRoe/A+hLmpcGe+Hd7+gAwboml55pJ3PQ+WXjKMJigTXJ
	 qnhOCLbXo0LidWV679WH0lhFhO9Mfub8ixJ/W4x1vu8qwv3fICIw2YqzqmBlWhPAmo
	 p7sOV6L4dOlXg==
Date: Tue, 8 Sep 2026 20:03:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Message-ID: <20260909010358.GA53603@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260830-doc-p2p-move-v1-1-61a388620588@nvidia.com>

On Sun, Aug 30, 2026 at 03:31:49PM +0300, Leon Romanovsky wrote:
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
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied on pci/p2pdma for v7.4, thank you!

> ---
>  * Split from https://lore.kernel.org/all/20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com
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
> ---
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> change-id: 20260830-doc-p2p-move-05aad5de1ec1
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

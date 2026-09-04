Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620242048D;
	Fri,  4 Sep 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504012; cv=none; b=CnR3LojeReJlBwx2uusUyUqFVnvRjV0YdAnKISdMbAtjVbcgDU9rjLthq+BWg6sw2EF/NuWPgrlp4BZbGdHgtUkh6jm5zBCA5Dny0pzEVAnon9Psq34rBZkzXeMDeIDz+XDjaI9g5J9Jp0X9ZuUqhoh8K1I7j0/eNScO4ZD6nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504012; c=relaxed/simple;
	bh=J1KvWqh62WTQ03xd0+CqNZq1yEoLrhBiZ5RGBMHRC9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbFYeOcZ1THLGIGttbEVw3vrVvA+FMKDLdpmAVKtFRd8BVWyoeY6AQpRC1JHPF3+nOHbnpSw3mbuKhKWlreDFQPDJxSAcMufm3jK6ngs/dqpCAkms5kl0w8iWtjT0ac/AK/hxs46S7U+n2ZMFEmpXQrwDf4sOPe2aDmJ02LeivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3LXxkeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3LXxkeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BDE1F00A3D;
	Fri,  4 Sep 2026 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504010;
	bh=48bodTpVBmNx41ZQPaNGwPIsLCCxbhOYMD05wV5/gPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W3LXxkeIXv2NfmvPGTySH0nq3Mh06R0PeM7dlWTwsZPOH22mvCcf44py4XMUdcFmU
	 wXXXnPe5Z+tfZWsyPS0iJRdemgf4lVlUcvadFjDqXkUwh/q93JgCiqGZim5RtCW3TS
	 WqjD3BuwX3LcDlPtsXYfo/J5aGG7vwqRX6ysvThXyHq+uS6zPtr+FD5VJzTUanR2oW
	 oZSTOgO/lCK05vXMYeBdqpndkLR07ukLWSfrjK9d8DNwz2mrwPqrytKSTliw3QoMw0
	 3X1uoheFEOF1YYTtDBluK6nPn/6/HLc+nwh5UGKpgP3weeKS1LnTGDfG0OXsAcqaLN
	 YzAqezPlBF5ag==
Date: Fri, 4 Sep 2026 09:40:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Message-ID: <20260904064005.GE24140@unreal>
References: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
 <20260903203431.GA2238823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903203431.GA2238823@bhelgaas>

On Thu, Sep 03, 2026 at 03:34:31PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 25, 2026 at 09:28:01AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> > dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> > documentation pointing at move_notify(), a symbol that no longer
> > exists. Readers grepping for it find nothing, and this is the only
> > place in Documentation/ describing the revocation requirement.
> > 
> > Name the current function and record that importers which cannot unmap
> > within bounded time have to be rejected at attach time, which is what
> > makes the synchronous unmap on remove() achievable.
> > 
> > Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> It looks like 2/2 might be updated, and it probably makes sense to
> merge them both together, but let me know if you want me to take this.

This PCI patch is completely standalone, so I sent it separately:
https://lore.kernel.org/all/20260830-doc-p2p-move-v1-1-61a388620588@nvidia.com/

Can you please take it from there?

Thanks

> 
> > ---
> >  Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> > index d3f406cca694..63cff9e4d2c9 100644
> > --- a/Documentation/driver-api/pci/p2pdma.rst
> > +++ b/Documentation/driver-api/pci/p2pdma.rst
> > @@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
> >  is used to determine the mapping type. The phys_addr_t-based DMA API is used to
> >  establish the dma_addr_t.
> >  
> > -Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
> > +Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
> >  to remove() it must deliver an invalidation shutdown to all DMABUF importing
> > -drivers through move_notify() and synchronously DMA unmap all the MMIO.
> > +drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
> > +the MMIO. Importers unable to complete that unmap within bounded time have to
> > +be rejected when they attach, which dma_buf_attach_revocable() checks for.
> >  
> >  No importing driver can continue to have a DMA map to the MMIO after the
> >  exporting driver has destroyed its p2p_provider.
> > 
> > -- 
> > 2.55.0
> > 

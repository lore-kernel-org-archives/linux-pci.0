Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F63955C0;
	Sun, 30 Aug 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076720; cv=none; b=TZ367GRyQ7SN7cG+FZMmMg00eJ1ftcjwevLjLMn2ZDA0E/Pe2JuT+TsfS0fNjW8BwHHHr/rHshvWriCbAXMTWboDWJ+pf1UT+VtF9jqHHnkyya17HTIWBGyiSi4fUoHos1R9Fhz8RCvzp77F32F96WcGnmYvdV/T5of3PXB4tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076720; c=relaxed/simple;
	bh=RbIehlscokWvItXrupNe+Z4FkU50ruhLbEk8wF8HX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG74I0GWPKRQVqGnH/c0xL9SNeIvqWj07L4519aZZvCeMM5V47lQY+plDv0JbvKofx78x6Vl4TF1apoRhZj0bU+jXMxggjTIiFzVVxvKI1WGPe5/w+VjncsOOR1KRWnTntR67S/xLGe75jSyC4VrA3Evsx8KrmAR4qo60s/d2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAZD8oED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAZD8oED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1411F000E9;
	Sun, 30 Aug 2026 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076713;
	bh=HOmmRwqD7gQcSXkQ2l1n56F/y5mkR8//mASfpntUu1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAZD8oEDR0G4EHppVGa9RCnPv3EcH4cHhiWcT5UPvnDBgkW216fwGfVn/Bed3ZDSo
	 pnjQNj55YqMLEirLlYs6Y0NvDTCfCpbJxUphUzQ5P/ywpfe9tK0Oy2d6fqBoTF/ITS
	 l9RabAaOr0mt6n2sZXSEhAWI6cQTAIdnMuEE5GPLNbO5xJwY7xQ/lkcxpMz5uurJPw
	 ngNmXfnBedKQLNyUzayuGUx65bi8T5NCn+Dq5Xa88gjO96H+5CMlKnndxvlJbwk5K1
	 bbGYdkOHxT03bXNMmewBX+uT2P0ip9ZWDNnjMbpInxyzXKPw3RRkkwMLRQ3qHp8aP9
	 wlOuK60yS+79w==
Date: Sun, 30 Aug 2026 10:58:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] dma-buf: Document how exporters and
 importers agree on mapping lifetime
Message-ID: <20260830075828.GA24140@unreal>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>

On Thu, Aug 27, 2026 at 09:18:29PM +0200, Thomas Hellström wrote:
> Hi,
> 
> Some comments below:
> 
> On Tue, 2026-08-25 at 09:28 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Pinned, revoked and movable mappings are selected by which optional
> > callbacks each side implements and by whether dma_buf_pin() succeeds,
> > not by any flag or enum. Nothing in Documentation/ says so, and the
> > rules are spread over the kdoc of dma_buf_ops.pin,
> > dma_buf_attach_ops.invalidate_mappings and
> > dma_buf_invalidate_mappings(),
> > so a driver author has to know the symbol names before finding them.
> > 
> > Name, per flow, the callbacks both sides have to implement to end up
> > in
> > it, describe dma_buf_pin() as the runtime negotiation, and record
> > that
> > the pin is what tells a revoke from a move.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/driver-api/dma-buf.rst |  6 +++
> >  drivers/dma-buf/dma-buf.c            | 85
> > +++++++++++++++++++++++++++++++++++-
> >  2 files changed, 90 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/driver-api/dma-buf.rst
> > b/Documentation/driver-api/dma-buf.rst
> > index 2f36c21d9948..39c201f38aa6 100644
> > --- a/Documentation/driver-api/dma-buf.rst
> > +++ b/Documentation/driver-api/dma-buf.rst
> > @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
> >  .. kernel-doc:: drivers/dma-buf/dma-buf.c
> >     :doc: dma buf device access
> >  
> > +Mapping Lifetime Negotiation
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> > +   :doc: mapping lifetime negotiation
> > +
> >  CPU Access to DMA Buffer Objects
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..30afec7365bc 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size,
> > int flags)
> >   *    reference acquired with dma_buf_get() by calling
> > dma_buf_put().
> >   *
> >   * For the detailed semantics exporters are expected to implement
> > see
> > - * &dma_buf_ops.
> > + * &dma_buf_ops. Whether the exporter may still move or destroy the
> > backing
> > + * storage after step 3 depends on what exporter and importer
> > implement, see
> > + * the mapping lifetime negotiation section below.
> > + */
> > +
> > +/**
> > + * DOC: mapping lifetime negotiation
> > + *
> > + * No flag or enum says whether the exporter may move or take away
> > the backing
> > + * storage while an importer holds a mapping. Each side implements a
> > set of
> > + * optional callbacks, and dma_buf_pin() settles the result at
> > runtime. Three
> > + * flows come out of it:
> > + *
> > + * - Pinned: the storage never moves and is never taken away.
> > + * - Revoked: the storage never moves, but the exporter may take it
> > away.
> > + * - Movable: the exporter may relocate the storage at any time.
> 
> Perhaps add "even temporarily to locations that are not available for
> DMA".

I don't know. "Not available for DMA" defeats the whole purpose of dma-buf,
which is intended to expose DMA-capable memory to other peers. I imagine
that "everything is optional dmabuf world" this is possible, but it
looks to me like a partial version of revoked flow.

> 
> > + *
> > + * Every exporter implements &dma_buf_ops.map_dma_buf,
> > + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release.
> > dma_buf_export()
> > + * rejects an exporter missing any of them.
> > + *
> > + * An importer reaches its flow like this:
> > + *
> > + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> > + *    &dma_buf_attach_ops.invalidate_mappings NULL rules out
> > everything but the
> > + *    pinned flow, because the importer can then never be told
> > anything.
> > + * 2. Call dma_buf_pin() under the reservation lock.
> > + * 3. On failure run the movable flow, or give up.
> > + * 4. On success the storage stays put. Whether the exporter may
> > still take it
> > + *    away, which makes this the revoked flow instead of the pinned
> > one, is the
> > + *    exporter's choice and is not reported back.
> > + *
> > + * dma_buf_attach() is the shorthand for an importer which only ever
> > wants the
> > + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then
> > pins around
> > + * every dma_buf_map_attachment() and waits for the
> > DMA_RESV_USAGE_KERNEL
> > + * fences on the importer's behalf. Peer to peer needs
> > + * dma_buf_dynamic_attach(), because
> > &dma_buf_attach_ops.allow_peer2peer lives
> > + * in the attach ops.
> > + *
> > + * Pinned flow:
> > + *
> > + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to
> > hold the
> > + *   storage still on request. An exporter whose storage never moves
> > implements
> > + *   neither, and dma_buf_pin() then succeeds on its own. An
> > exporter which
> > + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
> > + * - Importer: nothing more. The mapping stays valid until it
> > unmaps.
> > + *
> > + * Revoked flow:
> > + *
> > + * - Exporter: answer dma_buf_pin() as above. Call
> > + *   dma_buf_invalidate_mappings() when the storage goes away and
> > fail
> > + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which
> > complete a
> > + *   revocation are described in dma_buf_invalidate_mappings().
> > + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap
> > within
> > + *   bounded time and drop the pin.
> > + *
> > + * Movable flow:
> > + *
> > + * - Exporter: call dma_buf_invalidate_mappings() before each move,
> > then wait
> > + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and
> > &dma_buf_ops.unpin play
> > + *   no part here.
> > + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings
> > drops the
> > + *   cached mapping and has to lead to dma_buf_unmap_attachment()
> > within
> > + *   bounded time.
> 
> Hear I would want to see the exporter being allowed to force unmap the
> dma mappings and reclaim thestorage when the fences mentioned above
> have signaled, but the importer has not yet called
> dma_buf_unmap_attachment(). That would allow importers to call
> dma_buf_unmap_attachment() lazily, just before the next map_attachment,
> which would allow simplifying importer implementations. 

How? It will move one piece of code as is to another place. In addition,
both exporter and importer need to stop HW access to same region.

> More of a related idea than something that needs fixing for this patch.
> 
> >  It need not stop the hardware, because access runs until the
> > + *   importer's &dma_buf.resv fences retire. Map again before the
> > next DMA.
> 
> A successful map will mean the exporter has placed the data in storage
> compatible with what was agreed during attachment?

Yes.

> 
> Thanks,
> Thomas
> 

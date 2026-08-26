Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E43783B4;
	Wed, 26 Aug 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752960; cv=none; b=pS9YFERLTtmvw7ubLb+yOR2rI+zPbeMHtcJdyEciR6Fb+X9vLRSUsKijcBrPsvOx9+cnRJgCecFu0r9bJjI4ioXgV86GqAYOkkq7ZQkNIRCNIwKPyIZlv+ytxUVS5+0H/ZUrqbyOQpyyuxQ8ZcbekwvkIlQ5XdvC9SdsUtkdyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752960; c=relaxed/simple;
	bh=DODTJ+UqpszGItninyyCgfB0kjNRPSl/FKyNU8m+Tjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhpAQpZ8m+oZ9gOlhWVMZNcfmPw0HBFTV/9hRmthKqVM/zuxQcVnzTM2p5aOhD19SDMng0YDyW8FdXIINbfq2II+eaVkej4z+xbR5g+u86O0Mko1tY4WA2pFJNHkEh3rtp+CwBGE2kN+ilzgxGTkmxofaCJFp9MrV3qm2iibLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na4zgF1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na4zgF1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5C11F000E9;
	Wed, 26 Aug 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752958;
	bh=CwK6P0OpQuB4PAnzAgSeVhLovFW30xfcthoeChas/qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Na4zgF1LeNdieDui+jfscUCYc/OhsXiV6FZoKoFjKtw8SV+rdRVZyRVBBhQoWq2/d
	 GjuJTX0JYBiyD7t4gzWbZHeqxa85IHSlmvJ7p1rQPfcuJtleaOJi4Gv/bDgoGJaYTy
	 X3inwrHmIrGGH2mYvjBiowNCCHM3IHltirthbuJlZIPiry+yAA6nXZXwHuadLGnZ83
	 1ZTwV6PJV73DHHqh03f3vFcwx38N5/B3vImfywkc+StiStKPujnAmrow2gfz6U0hBk
	 nbxtVxrD4Mq4zajts5l7oWdW5LzeHHYvn2z4Q/cOSgwTrWp8t8MaA8DKmfVm9dYf/8
	 kLtbLCCiwrLug==
Date: Wed, 26 Aug 2026 17:02:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
Message-ID: <20260826140234.GE42790@unreal>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <2776f9b0-c299-45ff-bf82-89b95e73fd60@amd.com>
 <20260826124341.GD42790@unreal>
 <39dc2f46-08c8-4eff-aa22-a7c67b5c7040@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39dc2f46-08c8-4eff-aa22-a7c67b5c7040@amd.com>

On Wed, Aug 26, 2026 at 03:06:04PM +0200, Christian König wrote:
> On 8/26/26 14:43, Leon Romanovsky wrote:
> > On Wed, Aug 26, 2026 at 01:41:51PM +0200, Christian König wrote:
> >> On 8/25/26 08:28, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> Pinned, revoked and movable mappings are selected by which optional
> >>> callbacks each side implements and by whether dma_buf_pin() succeeds,
> >>> not by any flag or enum. Nothing in Documentation/ says so, and the
> >>> rules are spread over the kdoc of dma_buf_ops.pin,
> >>> dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
> >>> so a driver author has to know the symbol names before finding them.
> >>>
> >>> Name, per flow, the callbacks both sides have to implement to end up in
> >>> it, describe dma_buf_pin() as the runtime negotiation, and record that
> >>> the pin is what tells a revoke from a move.
> >>>
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>> ---
> >>>  Documentation/driver-api/dma-buf.rst |  6 +++
> >>>  drivers/dma-buf/dma-buf.c            | 85 +++++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 90 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> >>> index 2f36c21d9948..39c201f38aa6 100644
> >>> --- a/Documentation/driver-api/dma-buf.rst
> >>> +++ b/Documentation/driver-api/dma-buf.rst
> >>> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
> >>>  .. kernel-doc:: drivers/dma-buf/dma-buf.c
> >>>     :doc: dma buf device access
> >>>  
> >>> +Mapping Lifetime Negotiation
> >>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> +
> >>> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> >>> +   :doc: mapping lifetime negotiation
> >>> +
> >>>  CPU Access to DMA Buffer Objects
> >>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>  
> >>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>> index d504c636dc29..30afec7365bc 100644
> >>> --- a/drivers/dma-buf/dma-buf.c
> >>> +++ b/drivers/dma-buf/dma-buf.c
> >>> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size, int flags)
> >>>   *    reference acquired with dma_buf_get() by calling dma_buf_put().
> >>>   *
> >>>   * For the detailed semantics exporters are expected to implement see
> >>> - * &dma_buf_ops.
> >>> + * &dma_buf_ops. Whether the exporter may still move or destroy the backing
> >>> + * storage after step 3 depends on what exporter and importer implement, see
> >>> + * the mapping lifetime negotiation section below.
> >>> + */
> >>> +
> >>> +/**
> >>> + * DOC: mapping lifetime negotiation
> >>> + *
> >>> + * No flag or enum says whether the exporter may move or take away the backing
> >>> + * storage while an importer holds a mapping. Each side implements a set of
> >>> + * optional callbacks, and dma_buf_pin() settles the result at runtime. Three
> >>> + * flows come out of it:
> >>> + *
> >>> + * - Pinned: the storage never moves and is never taken away.
> >>
> >> That's not quite correct. The backing store can still disappear if the exporter is physically hot removed.
> >>
> >> In that case the exporter will still try to invalidate the mapping even if it is pinned. A NULL invalidate_mapping callback is of course still never called and so still optional.
> > 
> > But what does this mean for an importer that has no idea the exporter no
> > longer exists? Will it crash? I think the revoke flow actually fixes this hot-remove case.
> 
> No, that used to work even before we had the invalidation callback.
> 
> What happens on a hot remove is that the exporter goes away but the driver stack keeps PCIe BARs or system memory resources allocated until all importers have destroyed their mappings.
> 
> See the invalidation callback is only optional, importers can implement it to speed thing up on teardown but they don't have to. A NULL invalidation callback is perfectly valid.
> 
> >>
> >>> + * - Revoked: the storage never moves, but the exporter may take it away.
> >>> + * - Movable: the exporter may relocate the storage at any time.
> >>> + *
> >>
> >>> + * Every exporter implements &dma_buf_ops.map_dma_buf,
> >>> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release. dma_buf_export()
> >>> + * rejects an exporter missing any of them.
> >>
> >> I think that this is superfluous, the check in dma_buf_export() should make sure that all exporters follow that.
> > 
> > Sure, will change.
> > 
> >>
> >>> + *
> >>> + * An importer reaches its flow like this:
> >>> + *
> >>> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> >>> + *    &dma_buf_attach_ops.invalidate_mappings NULL rules out everything but the
> >>> + *    pinned flow, because the importer can then never be told anything.
> >>
> >> I would rather write "Leaving out the optional dma_buf_attach_ops.invalidate_mappings callback pins the buffer while the attachment is present".
> >>
> >>> + * 2. Call dma_buf_pin() under the reservation lock.
> >>> + * 3. On failure run the movable flow, or give up.
> >>> + * 4. On success the storage stays put. Whether the exporter may still take it
> >>> + *    away, which makes this the revoked flow instead of the pinned one, is the
> >>> + *    exporter's choice and is not reported back.
> >>
> >> That sentence sounds not really readable.
> > 
> > I will try to rephrase in next version.
> > 
> >>
> >>> + *
> >>> + * dma_buf_attach() is the shorthand for an importer which only ever wants the
> >>> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then pins around
> >>> + * every dma_buf_map_attachment() and waits for the DMA_RESV_USAGE_KERNEL
> >>> + * fences on the importer's behalf. Peer to peer needs
> >>> + * dma_buf_dynamic_attach(), because &dma_buf_attach_ops.allow_peer2peer lives
> >>> + * in the attach ops.
> >>
> >> That's also superfluous.
> > 
> > Will change.
> > 
> >>
> >>> + *
> >>> + * Pinned flow:
> >>> + *
> >>> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold the
> >>> + *   storage still on request. An exporter whose storage never moves implements
> >>> + *   neither, and dma_buf_pin() then succeeds on its own. An exporter which
> >>> + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
> >>> + * - Importer: nothing more. The mapping stays valid until it unmaps.
> >>> + *
> >>> + * Revoked flow:
> >>> + *
> >>> + * - Exporter: answer dma_buf_pin() as above. Call
> >>> + *   dma_buf_invalidate_mappings() when the storage goes away and fail
> >>> + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which complete a
> >>> + *   revocation are described in dma_buf_invalidate_mappings().
> >>> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within
> >>> + *   bounded time and drop the pin.
> >>> + *
> >>> + * Movable flow:
> >>> + *
> >>> + * - Exporter: call dma_buf_invalidate_mappings() before each move, then wait
> >>> + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin play
> >>> + *   no part here.
> >>> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops the
> >>> + *   cached mapping and has to lead to dma_buf_unmap_attachment() within
> >>> + *   bounded time. It need not stop the hardware, because access runs until the
> >>> + *   importer's &dma_buf.resv fences retire. Map again before the next DMA.
> >>
> >> That is also not really correct. Those flows are not separated like this.
> > 
> > How will you split them?
> 
> Well you don't. Exporters and importers can have a much wider variety of use cases.
> 
> When the importer doesn't give an invalidation callback the framework will call pin/unpin when the attachment is mapped/unmapped. That is just a service of the framework to make importers simpler.
> 
> But it is perfectly possible that an importer which implements the invalidation callback calls pin/unpin manually later on. This for example happens on display scanout when an invalidation would cause garbage on the screen when the buffer is moved.
> 
> But even after an importer called pin it is possible that the invalidation callback is called in case of a hot remove. Using our example of display scanout once more it is probably better to stop displaying anything then keeping the resources allocated until userspace realizes that the export is not there any more.
> 
> The revoke flow is then basically just a special case of hot remove. The only difference is that userspace invokes it instead of an user pulling a cable.

OK, let me add some context on how this split came about and why I am
trying to document it.

Several people approached me offline because they need to implement an
importer that supports both revoke and movable flows. These require
completely different implementations in the driver internals.

So, to answer the question, we need to document how these flows are
identified and how they differ.

Naturally, they asked AI first, but all frontier LLMs gave them completely
incorrect answers.

With that goal in mind, could you please help document the dma-buf
lifetime model? "Everything is optional" sounds great, but is quite
misleading.

Thanks

> >>
> >>> + *
> >>> + * The pin tells a revoke from a move.
> >>> + * &dma_buf_attach_ops.invalidate_mappings carries no reason, and both flows
> >>> + * ask for the same unmap. An importer holding a pin can only be seeing a
> >>> + * revoke, because the exporter promised not to move. An importer without a pin
> >>> + * treats every call as a move and maps again.
> >>> + *
> >>> + * A revoke need not be forever. An exporter revoking around a temporary loss
> >>> + * of access takes mappings again afterwards. Giving up for good is the
> >>> + * importer's own choice, so an exporter must not wait for one to come back.
> >>> + *
> >>
> >>> + * &dma_buf_ops.attach is the only place where an exporter can turn an importer
> >>> + * away. An exporter which revokes rejects the importers for which
> >>> + * dma_buf_attach_revocable() returns false. An exporter of memory without
> >>> + * struct page rejects the importers which left
> >>> + * &dma_buf_attach_ops.allow_peer2peer clear.
> >>
> >> That is also not correct. A mapping can be rejected later on as well.
> > 
> > In API level yes, but I'm not sure that failure in map_dma_buf is equal
> > logically to failure in attach. So, I won't call it "rejected later".
> 
> No, exactly that is wrong.
> 
> See failure on attachment means that the two device can't talk with each other at all. But that is relatively rare, the dma_buf_attach_revocable() case is the only use case which comes to my mind.
> 
> The more common case is that while mapping the attachment we find that the buffer location is not accessible (any more) by the attachment because of hot plug or simply resource contention.
> 
> IIRC -EBUSY is even documented as perfectly valid reason to fail a mapping.
> 
> Regards,
> Christian.
> 
> > 
> >>
> >> Regards,
> >> Christian.
> >>
> >>> + *
> >>> + * Userspace sees none of this. The two drivers negotiate the flow between
> >>> + * themselves, and the DMA-buf file descriptor shows no trace of the result.
> >>>   */
> >>>  
> >>>  /**
> >>>
> >>
> 

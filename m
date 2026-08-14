Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1D2F7F17;
	Fri, 14 Aug 2026 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685732; cv=none; b=taa+dfoCgmfAtt+sT5uu8pvmVKRXGPn8WytmblGbJZrlkHDOGqUwe1Nb2NJd0FIdF6A7tMb6ottl+SCzQJaC/DTG8wy43arPFxhASWS865JNULgns2uK+8iGq1XkpSZDN4wE/RrSfN8ErUjVwRxIjfvuFjVX7x7QEimNbwihrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685732; c=relaxed/simple;
	bh=OKbUP45NoXw/W0P+Vo5xlxKS9komwQK5FQyObtrICBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdQjQBl2PVXo3eLUCU+g5kit30YNDf+pdG68/iGtfM5MmCti2oH1XrtCUBkvEhPNZpPDhr+8iguy4Rd9s+V/79/iE35yYNYc1c9aXkJO417xt1cU1OFuKqhVJW64q5ydUT0OJYnQtwVV35YlszFuytTw/KEIdUx4eh11FnUGamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/H8GXsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/H8GXsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CF11F000E9;
	Fri, 14 Aug 2026 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685731;
	bh=aIY5wWiG20hEjlRbGuGiBNM4zph08GMYiX48c1EdmFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O/H8GXsN/WDHmYZFne7EWX6Lu+WpbtqTMauuc3f/GaN60C7jXoBI906ktPpovJIgb
	 26VslhcgFuZG8PScaefvHUAfC2mkMLRRXAVpK1mUHoJef5iweNE8IPdElE79H7+cBw
	 8yRAhXnjx0fUkx207Pgfw1dfMaEuRmvoSPJH12YtAbJ/w4T5F6hLUwgDaQozynDkFl
	 utYlDOYwpDy1jHlGjiEs5zQ2j4qY7zETAqNwCMsnShTOIHKLnLji0S6BF1G/UJDDWC
	 D21O+RY9/Hy65Sa65S9GtnPMs0uvd5DaNQcFtHPr6/6RK6bI3m0oJTAZXTy5lKEpy5
	 ghNJDxKScTTrA==
Date: Fri, 14 Aug 2026 07:35:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Frank Li <Frank.Li@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dmaengine: Add DMA_SG support for multi-buffer
 scatter-gather transfers
Message-ID: <qcebhdmxwru7ogbvwcafm2s723f3rd2imymcprxbnbazfydnpf@snnqe7cjm7c6>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-1-c12bb05e42d6@oss.qualcomm.com>
 <antnT5DtrICNPvKO@vaman>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <antnT5DtrICNPvKO@vaman>

On Tue, Aug 11, 2026 at 11:47:51PM +0530, Vinod Koul wrote:
> On 03-08-26, 16:01, Sumit Kumar wrote:
> > A client that needs to copy several independent, non-contiguous memory
> > regions in one operation currently has to submit one DMA_MEMCPY
> > transaction per region, each with its own completion interrupt, even
> > when every region is known up front and the copies could be described
> > as a single hardware transaction.
> > 
> > Partially reintroduce the DMA_SG transaction type and device_prep_dma_sg()
> > API that was removed in commit c678fa66341c ("dmaengine: remove DMA_SG as
> > it is dead code in kernel"). Only the core API is restored here.
> > 
> > The API accepts separate source and destination scatter-gather lists,
> > where entry i of the source list is transferred to entry i of the
> > destination list. This allows multiple independent (src[i] -> dst[i])
> > transfers to be batched into a single DMA transaction instead of N
> > separate submissions, reducing submission and interrupt overhead.
> > 
> > DMA_SG is a memcpy-class operation: both endpoints are memory buffers,
> > and neither DMA address is a FIFO-style peripheral register. The source
> > and destination scatter-gather lists must contain the same number of
> > entries; providers reject requests where the entry counts differ.
> > 
> > Restore the DMA_SG entry in
> > Documentation/driver-api/dmaengine/provider.rst and add
> > CHECK_CAP(dma_sg, DMA_SG) to dma_async_device_register() to validate
> > that drivers setting the capability provide the corresponding function
> > pointer.
> > 
> > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> > ---
> >  Documentation/driver-api/dmaengine/provider.rst | 21 +++++++++++++++
> >  drivers/dma/dmaengine.c                         |  1 +
> >  include/linux/dmaengine.h                       | 35 +++++++++++++++++++++++++
> >  3 files changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> > index f4ed98f701c918ff81bc674845880f8d01efbf1d..638e4b83e9a2f90c056111dbdd7572a4ed0f536d 100644
> > --- a/Documentation/driver-api/dmaengine/provider.rst
> > +++ b/Documentation/driver-api/dmaengine/provider.rst
> > @@ -210,6 +210,27 @@ Currently, the types available are:
> >    - Used by the client drivers to register a callback that will be
> >      called on a regular basis through the DMA controller interrupt
> >  
> > +- DMA_SG
> > +
> > +  - The device supports memory to memory scatter-gather transfers
> > +    using paired source and destination scatter-gather lists, where
> > +    entry ``i`` of the source list is transferred to entry ``i`` of
> > +    the destination list in a single DMA transaction.
> > +
> > +  - The source and destination scatter-gather lists must contain the
> > +    same number of entries; providers reject (return NULL for) requests
> > +    where the entry counts differ. Providers that walk the two lists in
> > +    lockstep pair them entry-by-entry as passed in, so clients that
> > +    DMA-map the lists must ensure the mapped segmentation stays aligned
> > +    between the two lists (for example by not relying on the DMA layer
> > +    to merge entries of one list but not the other).
> > +
> > +  - Unlike DMA_MEMCPY, neither the source nor destination is a
> > +    FIFO-style peripheral register; both are memory buffers. Multiple
> > +    independent (src[i] -> dst[i]) copies are submitted as a single
> > +    DMA transaction, reducing submission and interrupt overhead
> > +    compared to N separate DMA_MEMCPY operations.
> > +
> >  - DMA_PRIVATE
> >  
> >    - The devices only supports slave transfers, and as such isn't
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 6ffd8bd82154af2af2807d1c8b7ae7475eab56d3..9e790b9f165063d696438ace6370df98dffb8a32 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -1211,6 +1211,7 @@ int dma_async_device_register(struct dma_device *device)
> >  	CHECK_CAP(dma_pq_val,      DMA_PQ_VAL);
> >  	CHECK_CAP(dma_memset,      DMA_MEMSET);
> >  	CHECK_CAP(dma_interrupt,   DMA_INTERRUPT);
> > +	CHECK_CAP(dma_sg,          DMA_SG);
> >  	CHECK_CAP(dma_cyclic,      DMA_CYCLIC);
> >  	CHECK_CAP(interleaved_dma, DMA_INTERLEAVE);
> >  
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index fe33a20abc6146d539670e0e6fe6c9d27d96aa2a..61aa72149f5d5cf1828b89d13d0b35f1a12bb000 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -65,6 +65,7 @@ enum dma_transaction_type {
> >  	DMA_COMPLETION_NO_ORDER,
> >  	DMA_REPEAT,
> >  	DMA_LOAD_EOT,
> > +	DMA_SG,
> >  /* last transaction type for creation of the capabilities mask */
> >  	DMA_TX_TYPE_END,
> >  };
> > @@ -848,6 +849,7 @@ struct dma_filter {
> >   *	The function takes a buffer of size buf_len. The callback function will
> >   *	be called after period_len bytes have been transferred.
> >   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> > + * @device_prep_dma_sg: prepares a memory to memory scatter-gather operation
> >   * @device_caps: May be used to override the generic DMA slave capabilities
> >   *	with per-channel specific ones
> >   * @device_config: Pushes a new configuration to a channel, return 0 or an error
> > @@ -954,6 +956,11 @@ struct dma_device {
> >  	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
> >  		struct dma_chan *chan, struct dma_interleaved_template *xt,
> >  		unsigned long flags);
> > +	struct dma_async_tx_descriptor *(*device_prep_dma_sg)
> > +		(struct dma_chan *chan,
> > +		 struct scatterlist *dst_sg, unsigned int dst_nents,
> > +		 struct scatterlist *src_sg, unsigned int src_nents,
> > +		 unsigned long flags);
> >  
> >  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
> >  	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);
> > @@ -1194,6 +1201,34 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
> >  	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
> >  }
> >  
> > +/**
> > + * dmaengine_prep_dma_sg() - Prepare a memory-to-memory scatter-gather DMA descriptor.
> > + * @chan: The channel to be used for this descriptor
> > + * @dst_sg: Destination scatter list
> > + * @dst_nents: Number of entries in destination scatter list
> > + * @src_sg: Source scatter list
> > + * @src_nents: Number of entries in source scatter list
> > + * @flags: DMA engine flags
> > + *
> > + * Prepares a DMA transaction that copies data from multiple source memory
> > + * regions to multiple destination memory regions in a single DMA transaction.
> > + * Entry i of the source list is paired with entry i of the destination list,
> > + * so both lists must contain the same number of entries; the call returns
> > + * NULL otherwise.
> > + */
> > +static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg
> > +		(struct dma_chan *chan,
> > +		 struct scatterlist *dst_sg, unsigned int dst_nents,
> > +		 struct scatterlist *src_sg, unsigned int src_nents,
> > +		 unsigned long flags)
> > +{
> > +	if (!chan || !chan->device || !chan->device->device_prep_dma_sg)
> > +		return NULL;
> 
> Can we check if  dst_nents is same as src_nents... or should we drop
> src/dst and just say nents to imply both...
> 

Makes sense! If both 'nents' are needed to be the same, the API can just accept
one 'nents' and imply both.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387D372B45;
	Tue, 14 Jul 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016138; cv=none; b=Dn+StMtKXsWUaTmW6w479qmUhP1KrRuemTX0NHfoTq6Z646oym2gBn1YoNvxjPqWrL3V+AgsCS3Rydr9jFkmDSWAu4qbLN9TGeoUEbabY/ICTPQi+6gWLBtCyv9lPvBJ3FJYizNUeuybBxrAXwmupAZx+HFGjEri7s/K4AZyWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016138; c=relaxed/simple;
	bh=Lcf4nKR26voolH2pfIkoDtL1N08ZRtyep7I475jkkXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1ulCl74wvOALz39PwDbgmC/yKVPCfVCSk9v3vhge/0Vk9FywcQgzd++E5PJ56KzEoHje49p+EBVgzaPMQPnoKPfQh0ArzkzORszSknm/xPRzAZn64I/kS1EmfRCG6TOWjUt1deH4SIC5cc+KHBuaFSVeaGvc+LCFDCH6g83/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd3Tpbkr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd3Tpbkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED48E1F000E9;
	Tue, 14 Jul 2026 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016137;
	bh=TrIeJmVXMyc9vJtT76XLafOEKO7HH8hJhTX0Einc3GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vd3Tpbkrp7xoeJE2wnGMrsPG9DytBnCImQpTEpa970Cm09wK91/Z0Li+4MEj5twyV
	 GfxLsdjO9wMaMlGVpMNVPrO4INwH9uX5v+tD4cYdJfFeRtwUmPbEXL0F1QIa1umcWt
	 gHX9JG39Kj8Y8DBeOEeGsu2Kso5XUuoPRekl6XT65PxeqNCMlrccIW5D7up7GVAmp6
	 O7BE7m8NPhOu0iV7d9K8TnKjjRHMT0mPD7GDhMLLt2K2JGlSX8D+VpkxQhz97OU6BY
	 04aztGwuA+g223Auj/938ojj64nat8n74JwevXf9EtIylorkVtEi2e4x4hViiM22G1
	 2xKELEYO414Pw==
Date: Tue, 14 Jul 2026 10:02:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, vkoul@kernel.org, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback
 to flush the async read/write
Message-ID: <dbjdfjrpci2wwpf7lcyqhwbkm6amdsxfbirrb5metqau4keui6@o33fswugtxjp>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-2-714e0d56e87c@oss.qualcomm.com>
 <20260629085917.350211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629085917.350211F000E9@smtp.kernel.org>

On Mon, Jun 29, 2026 at 08:59:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Incorrect ordering of channel teardown, disconnect notification, and DMA flushing in mhi_ep_remove() causes data delivery after disconnect.
> - [High] The newly introduced flush_async() callback lacks channel context, forcing a controller-wide flush that aborts DMA operations for all active channels.
> - [High] Dropping the channel lock during flush_async exposes a window for worker threads to process disconnected channels, defeating the fix and re-introducing the UAF.
> 
> Pre-existing issues:
> - [Critical] In-flight asynchronous DMA operations are not flushed before mhi_ep_ring_reset() frees ring->ring_cache.
> - [High] Lockless access to mhi_chan->xfer_cb in completion handlers causes a TOCTOU data race with mhi_ep_remove().
> --
> 
> commit 191c1d6e4eab8c4a6ee949c2b5b9499a56060800
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
> 
> This commit introduces a flush_async() callback in the MHI endpoint
> controller. It is called during device removal to ensure any in-flight
> asynchronous DMA operations are completed before continuing teardown.
> This aims to prevent use-after-free issues caused by delayed DMA callbacks.
> 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> [ ... ]
> > @@ -1636,6 +1637,12 @@ static void mhi_ep_remove(struct device *dev)
> >  		}
> >  
> >  		mhi_chan->state = MHI_CH_STATE_DISABLED;
> > +		mutex_unlock(&mhi_chan->lock);
> 
> [Severity: High]
> Does dropping the channel lock here leave a window for worker threads to
> process disconnected channels?
> 
> If mhi_ep_ch_ring_worker wakes up while the lock is dropped, it sees
> ring->started is still true. For Downlink channels, mhi_ep_process_ch_ring()
> skips the state check and fires xfer_cb() directly:
> 
> drivers/bus/mhi/ep/main.c:mhi_ep_process_ch_ring() {
>     if (ring->ch_id % 2) {
>         /* DL channel */
>         result.dir = mhi_chan->dir;
>         mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>     } else {
>     ...
> }
> 
> Could this execute xfer_cb() mid-teardown and cause a use-after-free?
> 

AI slop:

Even if xfer_cb() is fired, it won't cause any UAF as all the resources are
freed in the client driver remove() callback which gets called last.

> > +
> > +		if (mhi_cntrl->flush_async)
> > +			mhi_cntrl->flush_async(mhi_cntrl);
> 
> [Severity: High]
> Does this order of operations allow successful data delivery callbacks after
> disconnecting the client?
> 
> Since the channel lock is dropped, completing in-flight DMA operations during
> flush_async() will invoke their completion handlers. Those handlers find
> xfer_cb still populated and call it with a success status.
> 
> Should flush_async() be called before sending the -ENOTCONN disconnect
> status to avoid notifying the client after it may have freed its contexts?
> 

Not strictly required. Client drivers won't free the context until their
remove() callbacks are called.


> > +
> > +		mutex_lock(&mhi_chan->lock);
> >  		mhi_chan->xfer_cb = NULL;
> 
> [Severity: High]
> This is a pre-existing issue, but is there a data race when clearing xfer_cb
> concurrently with completion handlers?
> 
> In mhi_ep_read_completion(), the callback is checked locklessly:
> 
> drivers/bus/mhi/ep/main.c:mhi_ep_read_completion() {
>     if (mhi_chan->xfer_cb) {
>         ...
>         mhi_chan->xfer_cb(mhi_dev, &result);
>     }
> }
> 
> If mhi_ep_remove() clears mhi_chan->xfer_cb to NULL after the lockless check
> but before execution, could this result in a NULL pointer dereference or
> execution of freed memory?
> 
> >  		mutex_unlock(&mhi_chan->lock);
> >  	}
> > diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> > --- a/include/linux/mhi_ep.h
> > +++ b/include/linux/mhi_ep.h
> [ ... ]
> > @@ -164,6 +165,7 @@ struct mhi_ep_cntrl {
> >  	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
> >  	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
> >  	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
> > +	void (*flush_async)(struct mhi_ep_cntrl *mhi_cntrl);
> 
> [Severity: High]
> Does the flush_async callback need a channel argument to avoid flushing
> all channels on the controller?
> 
> When mhi_ep_remove() calls this without specifying a channel, an
> implementation like pci_epf_mhi_edma_flush_async() terminates the shared
> DMA channels indiscriminately:
> 
> drivers/pci/endpoint/functions/pci-epf-mhi.c:pci_epf_mhi_edma_flush_async() {
>     dmaengine_terminate_sync(epf_mhi->dma_chan_rx);
>     dmaengine_terminate_sync(epf_mhi->dma_chan_tx);
> }
> 
> Will this abruptly discard in-flight operations and cause data loss for all
> other active MHI clients sharing the controller?
> 

While it is true that flush_async() implementation will affect shared channels
also, there is no use in passing the channel argument to it. Because, there is
no way we can selectively flush DMA for a single MHI channel. If multiple MHI
channels are sharing the same DMA channels, and a single client is going away,
then there is not much to do. But this is not very common or may not happen at
all.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

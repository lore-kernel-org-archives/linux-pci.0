Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEE23395C;
	Wed, 22 Jul 2026 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691217; cv=none; b=VAtuMt7VMZzJ+ewAM20U1z0usfZMoNjk0IQ/n2IAd7wrLHY6CierEPBvun8mbuh9ndsdy2jjpaI4omr38g1WHFFcQHLrzRwRLXYCk6Hb1KJk54HWBqZFfeUpvM+nNG7DZC9axPRryae6FkuLk0doWXgMGQ3qYCAOjja6VDHACHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691217; c=relaxed/simple;
	bh=M2HQHJqVdQNEiV01yYm4Y5Gi5nkFE+8hq+0ZUsceYjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpTnUcjUgxQXuoOKc5JXmrT4thBLeiY/6HG2+Cwx1W22XMIN4BwgUWIDOmiUPU0QC9w6m8EuC8KgT6alEBzv8p6sf0FZAyxLxlbwHS+GORGOQkTvp06Dj9NdMdu+Dn8ootIzS+wwtPkroCEvOEtgeepNqfM631RSzcPphFhce0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta3allVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta3allVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BF1F000E9;
	Wed, 22 Jul 2026 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784691215;
	bh=DSaqgeqSYkbgA5e+c2ekMOCXJvziE1pv4FqFj2N09VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ta3allVk1/1keekEZ/7ZK09i0bHJkdH7z1jrvAdygHs0N6Co55lV1jphH7qCnRHiS
	 udBQy+wvmKAmfQQzj+02fw1NYYOgb1ABi7BOHNxLoBOiIj77q1k5n/W21nAUHnKymC
	 vmHhQj6ksiJcPvEbW8Nwq5MjAJHi1rgTEpMLtyBrmpwAyB+rYqZYHT020FzQ3UJTjj
	 TcS8rJLjdXuxhmYP0PPtH/JLway8Tzou7aomufi9qfTM9ZFFOnXRRQccMFAnEByUHl
	 mZh0+Nc4wBwREGCm9Pw9aPmCYlLB9liOlj/f4iPWNL1TjqU3Jr2zV8tlM+4VTN/05S
	 e00uZE+KgkyNA==
Date: Wed, 22 Jul 2026 05:33:28 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async()
 callback to flush the async read/write
Message-ID: <m2lmcrionmqdnpbauhdgaatyq3uexyupnyeeigfg4ftambqoxt@wpoj26lmtv2e>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-2-b6a9db011e85@oss.qualcomm.com>
 <20260714123126.5FA091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714123126.5FA091F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 12:31:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Draining async transfers *after* sending a disconnect notification causes out-of-order successful callbacks to be delivered to a disconnected client.
> - [High] Controller-wide `flush_async()` called inside a per-channel loop disrupts active channels and causes livelocks.
> 
> Pre-existing issues:
> - [Critical] The `MHI_PKT_TYPE_RESET_CHAN_CMD` handler frees the transfer ring without flushing in-flight async DMA operations.
> - [High] Lockless TOCTOU race on `mhi_chan->xfer_cb` in completion handlers leads to a Use-After-Free.
> - [High] Null pointer dereference on `mhi_chan->mhi_dev` in `mhi_ep_process_ch_ring` during controller teardown.
> --
> 
> --- Patch [2]: [PATCH v2 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write ---
> commit 2e23a5ef008c4098d55a3f07d062a8941cc90ccd
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Subject: bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
> 
> This patch introduces a flush_async() callback to the MHI EP controller and
> invokes it during device removal. It aims to prevent use-after-free issues
> by ensuring that any in-flight asynchronous DMA operations are completed
> before the channel's transfer callback is unregistered.
> 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> 
> [ ... ]
> 
> > @@ -1636,6 +1637,12 @@ static void mhi_ep_remove(struct device *dev)
> >  		}
> >  
> >  		mhi_chan->state = MHI_CH_STATE_DISABLED;
> > +		mutex_unlock(&mhi_chan->lock);
> > +
> > +		if (mhi_cntrl->flush_async)
> > +			mhi_cntrl->flush_async(mhi_cntrl);
> > +
> 
> [Severity: High]
> Does this sequence result in successful callbacks being delivered after the
> client has already been notified of disconnection?
> 
> When mhi_ep_remove() sends -ENOTCONN to mhi_chan->xfer_cb(), it signals the
> client to free its context. If we then drop the lock and block on
> flush_async() while xfer_cb is still registered, pending DMA completions
> can invoke mhi_ep_read_completion():
> 
> mhi_ep_read_completion()
>     if (mhi_chan->xfer_cb) {
>         ...
>         mhi_chan->xfer_cb(mhi_dev, &result);
>     }
> 
> Can this lead to the client driver receiving a success callback after it has
> already freed its resources in response to the -ENOTCONN notification?
> 

This is a valid concern too. Will fix it.

> [Severity: High]
> Can calling a controller-wide flush operation inside a per-channel loop
> disrupt other active channels or cause a livelock?
> 
> The code loops over the device's channels (UL then DL). When disabling the UL
> channel, it calls mhi_cntrl->flush_async(). Since flush_async() operates on
> the controller context and MHI EP architectures typically share RX/TX DMA
> channels across the entire controller, the DL channel might still be active
> and queuing new transfers.
> 
> Could waiting for all controller DMAs to flush while other channels are active
> cause a livelock or drain traffic inappropriately?
> 

This will be fixed by moving the flush_async() call outside of the channel loop.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

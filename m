Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4A46D099;
	Tue, 21 Jul 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650565; cv=none; b=j2iDqDwsg+UFLtwnobI7p/bftKpJm7cNl4dmsaBnUzTEmYt8EM1Eyd7ytkV2jKAR2mjXvXIG3MEr1XFM40B2v8I0bhsFOvF5A/shUQKV3T1OfNp2HaesgZyhFMOQro23HNusp+f3koRS2a4lw7Ja1pirc750OO/AZ+jUr+3I+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650565; c=relaxed/simple;
	bh=NF7m7sXWK3jL3IZA54OTtlWh2pEqFednJNV0MuYAN7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivuU7tJNsViXmOgSX6fx8Uvft3eM8oAIxtmvxhu9wtjPZwIU6/7NlEK195vMSR74UzKBWdwDmuJxIRrFZYrGklwxQEAu8QXDMKCTdwp2IUxdJeEu7gz44I/yiM6JxVcWho4JvzR8XFidAJUH3addWNBDAUOaza9u3EZWuGUDOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZizH9xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZizH9xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E0B1F00A3A;
	Tue, 21 Jul 2026 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650563;
	bh=RyNxHg81ZggZzP40oRqyhJVqp6HHsIYQX+/3Qe7jgCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZizH9xcKfn6V6Iul8ouhjkepfiIO8F/nazHbFOwG2B5NB7iMN5Eir/+NEZaPlb5F
	 FugNAgK1xgpL/Nesmu4Bvkny5BFM4aajKg50R9S5RzUubezGca50MbReDfaayOzQRG
	 OD2gN5w93FiTys5tyKgTGcDAZKXsBKRYLOkrKPX6ssOzW+b6QUPo53ZwYlPAFKFjqf
	 BctljMuUwJPszKKZK75p4kUp7+4Mp5mNpsMEbRKb7tGMNQWV8f7asno2KO4AaSmwBm
	 KTHVLG50BUZnAFtSugqjlhl5Z7k0cwVftpuoxmwF4R8NqmnvJKIBfqAxWtxb5czBbm
	 FaK1cxtGBzYxQ==
Date: Tue, 21 Jul 2026 18:15:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Implement
 device_synchronize() callback
Message-ID: <wnfdmxsof5opa3ozxlwd6e2kbmnziekkacbsjb3tpiueqcjrit@y6f6hh2e4l3y>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
 <20260714122431.72B951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714122431.72B951F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 12:24:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Misuse of the `read_poll_timeout` macro causes an unlocked read-modify-write data race on `chan->status`, which can overwrite the interrupt handler's state completion and lead to an infinite loop.
> 
> Pre-existing issues:
> - [High] The `dw_edma_device_terminate_all()` function performs read and write access to the state machine variables `chan->status` and `chan->request` without acquiring the required `chan->vc.lock` spinlock.
> --
> 
> --- Patch [1]: [PATCH v2 1/3] dmaengine: dw-edma: Implement device_synchronize() callback ---
> commit dad772ddd69c60671b5bb40802d893826d2fa9c5
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> dmaengine: dw-edma: Implement device_synchronize() callback
> 
> This commit implements the device_synchronize() callback for the dw-edma
> driver. It uses read_poll_timeout() to wait for all in-flight DMA operations
> to complete by polling the channel status. Once complete, it drains the
> tasklet using vchan_synchronize().
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79fa..df0d1a946ed06 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > @@ -331,6 +332,20 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  	return err;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does
> dw_edma_device_terminate_all() perform read and write accesses to state
> machine variables without acquiring the required chan->vc.lock spinlock?
> 
> Looking at dw_edma_device_terminate_all(), it modifies chan->status and
> chan->request locklessly:
> 
>     } else if (chan->request > EDMA_REQ_PAUSE) {
>         err = -EPERM;
>     } else {
>         chan->request = EDMA_REQ_STOP;
>     }
> 
> Since the DMA engine API allows asynchronous termination, could this race with
> dw_edma_done_interrupt() or dw_edma_device_issue_pending(), both of which hold
> the spinlock while modifying the same fields? If the interrupt handler reads
> chan->request right before terminate_all writes it, it might mistakenly start
> the next pending transfer instead of stopping it.
> 
> >  
> > +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +
> > +	/*
> > +	 * Make sure all the in-flight DMA operations are completed before
> > +	 * draining the tasklet using vchan_synchronize().
> > +	 */
> > +	read_poll_timeout(READ_ONCE, chan->status, chan->status != EDMA_ST_BUSY,
> > +			  10, 0, false, chan->status);
> 
> [Severity: High]
> Could this read_poll_timeout() macro usage introduce a regression by causing
> an unlocked read-modify-write data race on chan->status?
> 
> The read_poll_timeout() macro expands to (val) = op(args). By passing
> chan->status as the val parameter, it expands to:
> 
>     (chan->status) = READ_ONCE(chan->status)
> 
> This loop executes without the chan->vc.lock spinlock. If the hardware
> interrupt handler dw_edma_done_interrupt() fires exactly after READ_ONCE()
> reads EDMA_ST_BUSY but before the assignment back to chan->status, it will
> cleanly set chan->status = EDMA_ST_IDLE. 
> 
> Would the polling thread then overwrite the newly set EDMA_ST_IDLE state with
> its stale EDMA_ST_BUSY value? Because the timeout parameter is 0, if this
> corrupted EDMA_ST_BUSY state is written back, no further interrupts will arrive
> to clear it, which could result in a permanent hang.
> 

This is a valid concern. This should be fixed by using a local variable for
holding the chan->status.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

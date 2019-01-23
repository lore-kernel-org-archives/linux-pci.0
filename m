Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798CC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FF22133D
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548249004;
	bh=o6DQUVz+6vCdivvnlinheFVyKFvCfnt6SQmN2iiwEcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPaD0i0ngoO7/FZrOW7m/WdYf7dIlJEgkMSEQT0UucZlN4XQGEnv4spu6wdHljgzR
	 wslLdBSosa0zt5eS4RVh1niJrV6d+6jxdcrMvPnMtYFhuDarsPlE+8gbkox765LWbA
	 fRD76c+K5cxSq0YWvOUCMnF0xuiikc7tRfF7fk7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfAWNKD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWNKD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 08:10:03 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C43620855;
        Wed, 23 Jan 2019 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548249002;
        bh=o6DQUVz+6vCdivvnlinheFVyKFvCfnt6SQmN2iiwEcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is3FyitpmqwQgU/oWNtZNc5uVkOi4mJrhIpsJiWIuyclapbpTZwJ89AO/dR9wjOJo
         cB4OSghVsnzDs7UY2m63Tq53mNzThrUamvRpF48lDXe2vCFReltceFqBAR9wleiFWN
         3/ZwvyEuptq/LRfTOl1phWr0FXZF8p15+K+mgYf0=
Date:   Wed, 23 Jan 2019 18:38:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190123130829.GQ4635@vkoul-mobl>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190120114425.GV4635@vkoul-mobl>
 <14acfcee-b367-be9c-714b-de0508ff1a7d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14acfcee-b367-be9c-714b-de0508ff1a7d@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-19, 15:48, Gustavo Pimentel wrote:
> On 20/01/2019 11:44, Vinod Koul wrote:
> > On 11-01-19, 19:33, Gustavo Pimentel wrote:
> >> Add Synopsys eDMA IP core driver to kernel.
> >>
> >> This core driver, initializes and configures the eDMA IP using vma-helpers
> >> functions and dma-engine subsystem.
> > 
> > A description of eDMA IP will help review the driver
> 
> I've the IP description on the cover-letter, but I'll bring it to this patch, if
> it helps.

yeah cover doesnt get applied, changelog are very important
documentation for kernel

> >> @@ -0,0 +1,1059 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > 
> > 2019 now
> 
> I've changed to "Copyright (c) 2018-present Synopsys, Inc. and/or its
> affiliates." this way it's always up to date and I also kept 2018, because it
> was the date that I started to develop this driver, if you don't mind.

yeah 18 is fine :) it need to end with current year always

> >> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> >> +{
> >> +	struct dw_edma_chan *chan = desc->chan;
> >> +	struct dw_edma *dw = chan->chip->dw;
> >> +	struct dw_edma_chunk *chunk;
> >> +
> >> +	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
> >> +	if (unlikely(!chunk))
> >> +		return NULL;
> >> +
> >> +	INIT_LIST_HEAD(&chunk->list);
> >> +	chunk->chan = chan;
> >> +	chunk->cb = !(desc->chunks_alloc % 2);
> > 
> > cb ..?
> 
> CB = change bit, is a property of this eDMA IP. Basically it is a kind of
> handshake which serves to validate whether the linked list has been updated or
> not, especially useful in cases of recycled linked list elements (every linked
> list recycle is a new chunk, this will allow to differentiate each chunk).

okay please add that somewhere. Also it would help me if you explain
what is chunk and other terminologies used in this driver

> >> +static int dw_edma_device_config(struct dma_chan *dchan,
> >> +				 struct dma_slave_config *config)
> >> +{
> >> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> >> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
> >> +	unsigned long flags;
> >> +	int err = 0;
> >> +
> >> +	spin_lock_irqsave(&chan->vc.lock, flags);
> >> +
> >> +	if (!config) {
> >> +		err = -EINVAL;
> >> +		goto err_config;
> >> +	}
> >> +
> >> +	if (chan->status != EDMA_ST_IDLE) {
> >> +		dev_err(chan2dev(chan), "channel is busy or paused\n");
> >> +		err = -EPERM;
> > 
> > this is not correct behaviour, device_config can be called anytime and
> > values can take affect on next transaction submitted..
> 
> Hum, I thought we could only reconfigure after transfer being finished.

Nope, anytime. They take effect for next prepare when you use it

> >> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
> >> +		&config->src_addr, &config->dst_addr);
> >> +
> >> +	chan->src_addr = config->src_addr;
> >> +	chan->dst_addr = config->dst_addr;
> >> +
> >> +	err = ops->device_config(dchan);
> > 
> > what does this do?
> 
> This is an initialization procedure to setup interrupts (data and addresses) to
> each channel on the eDMA IP,  in order to be triggered after transfer being
> completed or aborted. Due the fact the config() can be called at anytime,
> doesn't make sense to have this procedure here, I'll moved it to probe().

Yeah I am not still convinced about having another layer! Have you
though about using common lib for common parts ..?

> > this looks incorrect interpretation to me. The status is to be retrieved
> > for the given cookie passed and given that you do not even use this
> > argument tells me that you have understood this as 'channel' status
> > reporting, which is not correct
> 
> Yes, you're right, my interpretation assumes this function reports
> channel/transaction status. What would be the correct implementation?
> Something like this?
> 
> {
> 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> 	const struct dw_edma_core_ops *ops = chan2ops(chan);
> 	struct dw_edma_desc *desc;
> 	struct virt_dma_desc *vd;
> 	unsigned long flags;
> 	enum dma_status ret;
> 	u32 residue = 0;
> 
> 	spin_lock_irqsave(&chan->vc.lock, flags);
> 
> 	ret = dma_cookie_status(chan, cookie, txstate);
> 	if (ret == DMA_COMPLETE)
> 		goto ret_status;
> 
> 	vd = vchan_next_desc(&chan->vc);
> 	if (!vd)
> 		goto ret_status;
> 
> 	desc = vd2dw_edma_desc(vd);
> 	if (!desc)
> 		residue = desc->alloc_sz - desc->xfer_sz;
> 		
> 	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
> 		ret = DMA_PAUSED;

this looks better, please do keep in mind txstate can be null, so
residue caln can be skipped

> >> +static struct dma_async_tx_descriptor *
> >> +dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> >> +			     unsigned int sg_len,
> >> +			     enum dma_transfer_direction direction,
> >> +			     unsigned long flags, void *context)
> >> +{
> >> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> >> +	struct dw_edma_desc *desc;
> >> +	struct dw_edma_chunk *chunk;
> >> +	struct dw_edma_burst *burst;
> >> +	struct scatterlist *sg;
> >> +	unsigned long sflags;
> >> +	phys_addr_t src_addr;
> >> +	phys_addr_t dst_addr;
> >> +	int i;
> >> +
> >> +	if (sg_len < 1) {
> >> +		dev_err(chan2dev(chan), "invalid sg length %u\n", sg_len);
> >> +		return NULL;
> >> +	}
> >> +
> >> +	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
> > 
> > what is the second part of the check, can you explain that, who sets
> > chan->dir?
> 
> The chan->dir is set on probe() during the process of configuring each channel.

So you have channels that are unidirectional?

> >> +		dev_dbg(chan2dev(chan),	"prepare operation (WRITE)\n");
> >> +	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
> >> +		dev_dbg(chan2dev(chan),	"prepare operation (READ)\n");
> >> +	} else {
> >> +		dev_err(chan2dev(chan), "invalid direction\n");
> >> +		return NULL;
> >> +	}
> >> +
> >> +	if (!chan->configured) {
> >> +		dev_err(chan2dev(chan), "(prep_slave_sg) channel not configured\n");
> >> +		return NULL;
> >> +	}
> >> +
> >> +	if (chan->status != EDMA_ST_IDLE) {
> >> +		dev_err(chan2dev(chan), "channel is busy or paused\n");
> >> +		return NULL;
> >> +	}
> > 
> > No, wrong again. The txn must be prepared and then on submit added to a
> > queue. You are writing a driver for dmaengine, surely you dont expect
> > the channel to be free and then do a txn.. that would be very
> > inefficient!
> 
> I did not realize that the flow could be as you mentioned. The documentation I
> read about the subsystem did not give me this idea. Thank you for clarifying me.

I think we have improved  that part a lot, please do feel free to point
out inconsistency
See DMA usage in Documentation/driver-api/dmaengine/client.rst

> >> +int dw_edma_probe(struct dw_edma_chip *chip)
> >> +{
> >> +	struct dw_edma *dw = chip->dw;
> >> +	struct device *dev = chip->dev;
> >> +	const struct dw_edma_core_ops *ops;
> >> +	size_t ll_chunk = dw->ll_region.sz;
> >> +	size_t dt_chunk = dw->dt_region.sz;
> >> +	u32 ch_tot;
> >> +	int i, j, err;
> >> +
> >> +	raw_spin_lock_init(&dw->lock);
> >> +
> >> +	/* Callback operation selection accordingly to eDMA version */
> >> +	switch (dw->version) {
> >> +	default:
> >> +		dev_err(dev, "unsupported version\n");
> >> +		return -EPERM;
> >> +	}
> > 
> > So we have only one case which returns error, was this code tested?
> 
> Yes it was, but I understand what your point of view.
> This was done like this, because I wanna to segment the patch series like this:
>  1) Adding eDMA driver core, which contains the driver skeleton and the whole
> logic associated.
>  2) and 3) Adding the callbacks for the eDMA register mapping version 0 (it will
> appear in the future a new version, I thought that this new version would came
> while I was trying to get the feedback about this patch series, therefore would
> have another 2 patches for the version 1 isolated and independent from the
> version 0).
>  4) and 5) Adding the PCIe glue-logic and device ID associated.
>  6) Adding maintainer for this driver.
>  7) Adding a test driver.
> 
> Since this switch will only have the associated case on patch 2, that why on
> patch 1 doesn't appear any possibility.
> 
> If you feel logic to squash patch 2 with patch 1, just say something and I'll do
> it for you :)

well each patch should build and work on its own, otherwise we get
problems :) But since this is a new driver it is okay. Anyway this patch
is quite _huge_ so lets not add more to it..

I would have moved the callback check to subsequent one..

> >> +	pm_runtime_get_sync(dev);
> >> +
> >> +	/* Find out how many write channels are supported by hardware */
> >> +	dw->wr_ch_cnt = ops->ch_count(dw, EDMA_DIR_WRITE);
> >> +	if (!dw->wr_ch_cnt) {
> >> +		dev_err(dev, "invalid number of write channels(0)\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* Find out how many read channels are supported by hardware */
> >> +	dw->rd_ch_cnt = ops->ch_count(dw, EDMA_DIR_READ);
> >> +	if (!dw->rd_ch_cnt) {
> >> +		dev_err(dev, "invalid number of read channels(0)\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
> >> +		dw->wr_ch_cnt, dw->rd_ch_cnt);
> >> +
> >> +	ch_tot = dw->wr_ch_cnt + dw->rd_ch_cnt;
> >> +
> >> +	/* Allocate channels */
> >> +	dw->chan = devm_kcalloc(dev, ch_tot, sizeof(*dw->chan), GFP_KERNEL);
> > 
> > you may use struct_size() here
> 
> Hum, this would be useful if I wanted to allocate the dw struct as well, right?
> Since dw struct is already allocated, it looks like this can't be used, or am I
> missing something?

yeah you can allocate dw + chan one shot...
-- 
~Vinod

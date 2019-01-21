Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB6C2F421
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5620823
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jPCSeC5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfAUPzZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:55:25 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:54340 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfAUPzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 10:55:24 -0500
Received: from mailhost.synopsys.com (dc2-mailhost.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id F0E4610C1101;
        Mon, 21 Jan 2019 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548086124; bh=ALFOt9hd1dJV63poYd9hMBaxvVLTmN4V4hlzCFEpy4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jPCSeC5gpTfrbwQ46l/vXbm4spQuG0frc8HzCidKpUfqN6O8j1T1YA1gkPv54aOFg
         cFlIANwQ90zMo//Sitkz0JGXKmKo9drV+Z+C95jxgtk6wkyaZT80QbTyGhzzyTOFJv
         6Lr6y1zxrC4WCD4MqRIGDRJ31liGmY0gvfYuioMw4Kp9zrMwBiMvWhHk8OPkqi0Vlm
         cvA5MjNccnafEoBWSa8I+fTzFI4pT37ESW61aG0BYzuGWv738lSWStXKZB+Gg1hoi/
         RLQXhDLRBlQCSNXMk1NnT8a/pdcpSXCerpbnSet7/tlUwI34mwS3PMKy4WzXgP33sN
         ydqwlzLHuu0zA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 805E3A0407;
        Mon, 21 Jan 2019 15:55:23 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 07:53:01 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 16:52:59 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 16:52:58 +0100
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190120114425.GV4635@vkoul-mobl>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <14acfcee-b367-be9c-714b-de0508ff1a7d@synopsys.com>
Date:   Mon, 21 Jan 2019 15:48:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190120114425.GV4635@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/01/2019 11:44, Vinod Koul wrote:
> On 11-01-19, 19:33, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP core driver to kernel.
>>
>> This core driver, initializes and configures the eDMA IP using vma-helpers
>> functions and dma-engine subsystem.
> 
> A description of eDMA IP will help review the driver

I've the IP description on the cover-letter, but I'll bring it to this patch, if
it helps.

> 
>> Also creates an abstration layer through callbacks allowing different
>> registers mappings in the future, organized in to versions.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA option in kernel configuration,
>> however it requires and selects automatically DMA_ENGINE and
>> DMA_VIRTUAL_CHANNELS option too.
>>
>> Changes:
>> RFC v1->RFC v2:
> 
> These do not belong to change log, either move them to cover-letter or
> keep them after s-o-b lines..

Ok, Andy has also referred that. I'll keep them after s-o-b lines.

> 
>> @@ -0,0 +1,1059 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> 
> 2019 now

I've changed to "Copyright (c) 2018-present Synopsys, Inc. and/or its
affiliates." this way it's always up to date and I also kept 2018, because it
was the date that I started to develop this driver, if you don't mind.

> 
>> +static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
>> +{
>> +	struct dw_edma_chan *chan = chunk->chan;
>> +	struct dw_edma_burst *burst;
>> +
>> +	burst = kvzalloc(sizeof(*burst), GFP_NOWAIT);
> 
> Is there a specific reason for kvzalloc(),  do you submit this to HW..

There is not reason for that, it were remains of an initial implementation. I'll
replace them by kzalloc.
Nicely spotted!

> 
>> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
>> +{
>> +	struct dw_edma_chan *chan = desc->chan;
>> +	struct dw_edma *dw = chan->chip->dw;
>> +	struct dw_edma_chunk *chunk;
>> +
>> +	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
>> +	if (unlikely(!chunk))
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&chunk->list);
>> +	chunk->chan = chan;
>> +	chunk->cb = !(desc->chunks_alloc % 2);
> 
> cb ..?

CB = change bit, is a property of this eDMA IP. Basically it is a kind of
handshake which serves to validate whether the linked list has been updated or
not, especially useful in cases of recycled linked list elements (every linked
list recycle is a new chunk, this will allow to differentiate each chunk).

> 
>> +static int dw_edma_device_config(struct dma_chan *dchan,
>> +				 struct dma_slave_config *config)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
>> +	unsigned long flags;
>> +	int err = 0;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	if (!config) {
>> +		err = -EINVAL;
>> +		goto err_config;
>> +	}
>> +
>> +	if (chan->status != EDMA_ST_IDLE) {
>> +		dev_err(chan2dev(chan), "channel is busy or paused\n");
>> +		err = -EPERM;
> 
> this is not correct behaviour, device_config can be called anytime and
> values can take affect on next transaction submitted..

Hum, I thought we could only reconfigure after transfer being finished.

> 
>> +		goto err_config;
>> +	}
>> +
>> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
>> +		&config->src_addr, &config->dst_addr);
>> +
>> +	chan->src_addr = config->src_addr;
>> +	chan->dst_addr = config->dst_addr;
>> +
>> +	err = ops->device_config(dchan);
> 
> what does this do?

This is an initialization procedure to setup interrupts (data and addresses) to
each channel on the eDMA IP,  in order to be triggered after transfer being
completed or aborted. Due the fact the config() can be called at anytime,
doesn't make sense to have this procedure here, I'll moved it to probe().

> 
>> +static enum dma_status
>> +dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>> +			 struct dma_tx_state *txstate)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
>> +	unsigned long flags;
>> +	enum dma_status ret;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	ret = ops->ch_status(chan);
>> +	if (ret == DMA_ERROR) {
>> +		goto ret_status;
>> +	} else if (ret == DMA_IN_PROGRESS) {
>> +		chan->status = EDMA_ST_BUSY;
>> +		goto ret_status;
> 
> so in this case you set residue as zero, which is not correct

Ok, the residue should be the remaining bytes to transfer, right?

> 
>> +	} else {
>> +		/* DMA_COMPLETE */
>> +		if (chan->status == EDMA_ST_PAUSE)
>> +			ret = DMA_PAUSED;
>> +		else if (chan->status == EDMA_ST_BUSY)
>> +			ret = DMA_IN_PROGRESS;
> 
> ?? if txn is complete how are you returning DMA_IN_PROGRESS?

This IP reports DMA_COMPLETE when it successfully completes the transfer of all
linked list elements, given that there may be even more elements of the linked
list to be transferred the overall state is set to DMA_IN_PROGRESS.
> 
>> +		else
>> +			ret = DMA_COMPLETE;
>> +	}
> 
> this looks incorrect interpretation to me. The status is to be retrieved
> for the given cookie passed and given that you do not even use this
> argument tells me that you have understood this as 'channel' status
> reporting, which is not correct

Yes, you're right, my interpretation assumes this function reports
channel/transaction status. What would be the correct implementation?
Something like this?

{
	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
	const struct dw_edma_core_ops *ops = chan2ops(chan);
	struct dw_edma_desc *desc;
	struct virt_dma_desc *vd;
	unsigned long flags;
	enum dma_status ret;
	u32 residue = 0;

	spin_lock_irqsave(&chan->vc.lock, flags);

	ret = dma_cookie_status(chan, cookie, txstate);
	if (ret == DMA_COMPLETE)
		goto ret_status;

	vd = vchan_next_desc(&chan->vc);
	if (!vd)
		goto ret_status;

	desc = vd2dw_edma_desc(vd);
	if (!desc)
		residue = desc->alloc_sz - desc->xfer_sz;
		
	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
		ret = DMA_PAUSED;

ret_status:
	spin_unlock_irqrestore(&chan->vc.lock, flags);
	dma_set_residue(txstate, residue);
	
	return ret;
}

> 
>> +static struct dma_async_tx_descriptor *
>> +dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>> +			     unsigned int sg_len,
>> +			     enum dma_transfer_direction direction,
>> +			     unsigned long flags, void *context)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	struct dw_edma_desc *desc;
>> +	struct dw_edma_chunk *chunk;
>> +	struct dw_edma_burst *burst;
>> +	struct scatterlist *sg;
>> +	unsigned long sflags;
>> +	phys_addr_t src_addr;
>> +	phys_addr_t dst_addr;
>> +	int i;
>> +
>> +	if (sg_len < 1) {
>> +		dev_err(chan2dev(chan), "invalid sg length %u\n", sg_len);
>> +		return NULL;
>> +	}
>> +
>> +	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
> 
> what is the second part of the check, can you explain that, who sets
> chan->dir?

The chan->dir is set on probe() during the process of configuring each channel.

> 
>> +		dev_dbg(chan2dev(chan),	"prepare operation (WRITE)\n");
>> +	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
>> +		dev_dbg(chan2dev(chan),	"prepare operation (READ)\n");
>> +	} else {
>> +		dev_err(chan2dev(chan), "invalid direction\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (!chan->configured) {
>> +		dev_err(chan2dev(chan), "(prep_slave_sg) channel not configured\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (chan->status != EDMA_ST_IDLE) {
>> +		dev_err(chan2dev(chan), "channel is busy or paused\n");
>> +		return NULL;
>> +	}
> 
> No, wrong again. The txn must be prepared and then on submit added to a
> queue. You are writing a driver for dmaengine, surely you dont expect
> the channel to be free and then do a txn.. that would be very
> inefficient!

I did not realize that the flow could be as you mentioned. The documentation I
read about the subsystem did not give me this idea. Thank you for clarifying me.

> 
>> +static struct dma_async_tx_descriptor *
>> +dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
>> +			       size_t len, size_t cyclic_cnt,
>> +			       enum dma_transfer_direction direction,
>> +			       unsigned long flags)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	struct dw_edma_desc *desc;
>> +	struct dw_edma_chunk *chunk;
>> +	struct dw_edma_burst *burst;
>> +	unsigned long sflags;
>> +	phys_addr_t src_addr;
>> +	phys_addr_t dst_addr;
>> +	u32 i;
>> +
>> +	if (!len || !cyclic_cnt) {
>> +		dev_err(chan2dev(chan), "invalid len or cyclic count\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
>> +		dev_dbg(chan2dev(chan),	"prepare operation (WRITE)\n");
>> +	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
>> +		dev_dbg(chan2dev(chan),	"prepare operation (READ)\n");
>> +	} else {
>> +		dev_err(chan2dev(chan), "invalid direction\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (!chan->configured) {
>> +		dev_err(chan2dev(chan), "(prep_dma_cyclic) channel not configured\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (chan->status != EDMA_ST_IDLE) {
>> +		dev_err(chan2dev(chan), "channel is busy or paused\n");
>> +		return NULL;
>> +	}
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, sflags);
>> +
>> +	desc = dw_edma_alloc_desc(chan);
>> +	if (unlikely(!desc))
>> +		goto err_alloc;
>> +
>> +	chunk = dw_edma_alloc_chunk(desc);
>> +	if (unlikely(!chunk))
>> +		goto err_alloc;
>> +
>> +	src_addr = chan->src_addr;
>> +	dst_addr = chan->dst_addr;
>> +
>> +	for (i = 0; i < cyclic_cnt; i++) {
>> +		if (chunk->bursts_alloc == chan->ll_max) {
>> +			chunk = dw_edma_alloc_chunk(desc);
>> +			if (unlikely(!chunk))
>> +				goto err_alloc;
>> +		}
>> +
>> +		burst = dw_edma_alloc_burst(chunk);
>> +
>> +		if (unlikely(!burst))
>> +			goto err_alloc;
>> +
>> +		burst->sz = len;
>> +		chunk->ll_region.sz += burst->sz;
>> +		desc->alloc_sz += burst->sz;
>> +
>> +		burst->sar = src_addr;
>> +		burst->dar = dst_addr;
>> +
>> +		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
>> +			i + 1, cyclic_cnt, burst->sar, burst->dar, burst->sz);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&chan->vc.lock, sflags);
>> +	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> 
> how is it different from previous? am sure we can reuse bits!

There are some differences, but I agree I can rewrite the code of this and
previous function in order to reuse code between them. This function was a last
minute added feature :).

> 
>> +static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>> +{
>> +	struct dw_edma *dw = chan->chip->dw;
>> +	const struct dw_edma_core_ops *ops = dw->ops;
>> +	struct virt_dma_desc *vd;
>> +	struct dw_edma_desc *desc;
>> +	unsigned long flags;
>> +
>> +	ops->clear_done_int(chan);
>> +	dev_dbg(chan2dev(chan), "clear done interrupt\n");
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +	vd = vchan_next_desc(&chan->vc);
>> +	switch (chan->request) {
>> +	case EDMA_REQ_NONE:
>> +		if (!vd)
>> +			break;
>> +
>> +		desc = vd2dw_edma_desc(vd);
>> +		if (desc->chunks_alloc) {
>> +			dev_dbg(chan2dev(chan), "sub-transfer complete\n");
>> +			chan->status = EDMA_ST_BUSY;
>> +			dev_dbg(chan2dev(chan), "transferred %u bytes\n",
>> +				desc->xfer_sz);
>> +			dw_edma_start_transfer(chan);
>> +		} else {
>> +			list_del(&vd->node);
>> +			vchan_cookie_complete(vd);
>> +			chan->status = EDMA_ST_IDLE;
>> +			dev_dbg(chan2dev(chan), "transfer complete\n");
>> +		}
>> +		break;
>> +	case EDMA_REQ_STOP:
>> +		if (!vd)
>> +			break;
>> +
>> +		list_del(&vd->node);
>> +		vchan_cookie_complete(vd);
>> +		chan->request = EDMA_REQ_NONE;
>> +		chan->status = EDMA_ST_IDLE;
>> +		chan->configured = false;
> 
> why is configuration deemed invalid, it can still be used again!

At the time I thought, that was necessary to reconfigure every time that we
required to do a new transfer. You already explained to me that is not
necessary. My bad!

> 
>> +int dw_edma_probe(struct dw_edma_chip *chip)
>> +{
>> +	struct dw_edma *dw = chip->dw;
>> +	struct device *dev = chip->dev;
>> +	const struct dw_edma_core_ops *ops;
>> +	size_t ll_chunk = dw->ll_region.sz;
>> +	size_t dt_chunk = dw->dt_region.sz;
>> +	u32 ch_tot;
>> +	int i, j, err;
>> +
>> +	raw_spin_lock_init(&dw->lock);
>> +
>> +	/* Callback operation selection accordingly to eDMA version */
>> +	switch (dw->version) {
>> +	default:
>> +		dev_err(dev, "unsupported version\n");
>> +		return -EPERM;
>> +	}
> 
> So we have only one case which returns error, was this code tested?

Yes it was, but I understand what your point of view.
This was done like this, because I wanna to segment the patch series like this:
 1) Adding eDMA driver core, which contains the driver skeleton and the whole
logic associated.
 2) and 3) Adding the callbacks for the eDMA register mapping version 0 (it will
appear in the future a new version, I thought that this new version would came
while I was trying to get the feedback about this patch series, therefore would
have another 2 patches for the version 1 isolated and independent from the
version 0).
 4) and 5) Adding the PCIe glue-logic and device ID associated.
 6) Adding maintainer for this driver.
 7) Adding a test driver.

Since this switch will only have the associated case on patch 2, that why on
patch 1 doesn't appear any possibility.

If you feel logic to squash patch 2 with patch 1, just say something and I'll do
it for you :)

> 
>> +
>> +	pm_runtime_get_sync(dev);
>> +
>> +	/* Find out how many write channels are supported by hardware */
>> +	dw->wr_ch_cnt = ops->ch_count(dw, EDMA_DIR_WRITE);
>> +	if (!dw->wr_ch_cnt) {
>> +		dev_err(dev, "invalid number of write channels(0)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Find out how many read channels are supported by hardware */
>> +	dw->rd_ch_cnt = ops->ch_count(dw, EDMA_DIR_READ);
>> +	if (!dw->rd_ch_cnt) {
>> +		dev_err(dev, "invalid number of read channels(0)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
>> +		dw->wr_ch_cnt, dw->rd_ch_cnt);
>> +
>> +	ch_tot = dw->wr_ch_cnt + dw->rd_ch_cnt;
>> +
>> +	/* Allocate channels */
>> +	dw->chan = devm_kcalloc(dev, ch_tot, sizeof(*dw->chan), GFP_KERNEL);
> 
> you may use struct_size() here

Hum, this would be useful if I wanted to allocate the dw struct as well, right?
Since dw struct is already allocated, it looks like this can't be used, or am I
missing something?

> 
>> +	if (!dw->chan)
>> +		return -ENOMEM;
>> +
>> +	/* Calculate the linked list chunk for each channel */
>> +	ll_chunk /= roundup_pow_of_two(ch_tot);
>> +
>> +	/* Calculate the linked list chunk for each channel */
>> +	dt_chunk /= roundup_pow_of_two(ch_tot);
>> +
>> +	/* Disable eDMA, only to establish the ideal initial conditions */
>> +	ops->off(dw);
>> +
>> +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
>> +
>> +	/* Request IRQs */
>> +	if (dw->nr_irqs != 1) {
>> +		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < dw->nr_irqs; i++) {
>> +		err = devm_request_irq(dev, pci_irq_vector(to_pci_dev(dev), i),
>> +				       dw_edma_interrupt_all,
>> +				       IRQF_SHARED, dw->name, chip);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	/* Create write channels */
>> +	INIT_LIST_HEAD(&dw->wr_edma.channels);
>> +	for (i = 0; i < dw->wr_ch_cnt; i++) {
>> +		struct dw_edma_chan *chan = &dw->chan[i];
>> +		struct dw_edma_region *dt_region;
>> +
>> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
>> +		if (!dt_region)
>> +			return -ENOMEM;
>> +
>> +		chan->vc.chan.private = dt_region;
>> +
>> +		chan->chip = chip;
>> +		chan->id = i;
>> +		chan->dir = EDMA_DIR_WRITE;
>> +		chan->configured = false;
>> +		chan->request = EDMA_REQ_NONE;
>> +		chan->status = EDMA_ST_IDLE;
>> +
>> +		chan->ll_off = (ll_chunk * i);
>> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
>> +
>> +		chan->dt_off = (dt_chunk * i);
>> +
>> +		dev_dbg(dev, "L. List:\tChannel write[%u] off=0x%.8lx, max_cnt=%u\n",
>> +			i, chan->ll_off, chan->ll_max);
>> +
>> +		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
>> +
>> +		dev_dbg(dev, "MSI:\t\tChannel write[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
>> +			i, chan->msi.address_hi, chan->msi.address_lo,
>> +			chan->msi.data);
>> +
>> +		chan->vc.desc_free = vchan_free_desc;
>> +		vchan_init(&chan->vc, &dw->wr_edma);
>> +
>> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
>> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
>> +		dt_region->sz = dt_chunk;
>> +
>> +		dev_dbg(dev, "Data:\tChannel write[%u] off=0x%.8lx\n",
>> +			i, chan->dt_off);
>> +	}
>> +	dma_cap_zero(dw->wr_edma.cap_mask);
>> +	dma_cap_set(DMA_SLAVE, dw->wr_edma.cap_mask);
>> +	dma_cap_set(DMA_CYCLIC, dw->wr_edma.cap_mask);
>> +	dw->wr_edma.directions = BIT(DMA_DEV_TO_MEM);
>> +	dw->wr_edma.chancnt = dw->wr_ch_cnt;
>> +
>> +	/* Create read channels */
>> +	INIT_LIST_HEAD(&dw->rd_edma.channels);
>> +	for (j = 0; j < dw->rd_ch_cnt; j++, i++) {
>> +		struct dw_edma_chan *chan = &dw->chan[i];
>> +		struct dw_edma_region *dt_region;
>> +
>> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
>> +		if (!dt_region)
>> +			return -ENOMEM;
>> +
>> +		chan->vc.chan.private = dt_region;
>> +
>> +		chan->chip = chip;
>> +		chan->id = j;
>> +		chan->dir = EDMA_DIR_READ;
>> +		chan->configured = false;
>> +		chan->request = EDMA_REQ_NONE;
>> +		chan->status = EDMA_ST_IDLE;
>> +
>> +		chan->ll_off = (ll_chunk * i);
>> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
>> +
>> +		chan->dt_off = (dt_chunk * i);
>> +
>> +		dev_dbg(dev, "L. List:\tChannel read[%u] off=0x%.8lx, max_cnt=%u\n",
>> +			j, chan->ll_off, chan->ll_max);
>> +
>> +		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
>> +
>> +		dev_dbg(dev, "MSI:\t\tChannel read[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
>> +			j, chan->msi.address_hi, chan->msi.address_lo,
>> +			chan->msi.data);
>> +
>> +		chan->vc.desc_free = vchan_free_desc;
>> +		vchan_init(&chan->vc, &dw->rd_edma);
>> +
>> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
>> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
>> +		dt_region->sz = dt_chunk;
>> +
>> +		dev_dbg(dev, "Data:\tChannel read[%u] off=0x%.8lx\n",
>> +			i, chan->dt_off);
> 
> this is similar to previous with obvious changes, I think this can be
> made common routine invoke for R and W ...

OK, I can rewrite the code to simplify this.

> 
> So HW provides read channels and write channels and not generic channels
> which can be used for either R or W?
> 

The HW, provides a well defined channels, with different registers sets.
Initially I thought to maskared it, but since the number of channels can be
client configurable [0..8] for each type of channel and also asymmetric (write
vs read), I prefer to kept then separated.


Once again, thanks Vinod!



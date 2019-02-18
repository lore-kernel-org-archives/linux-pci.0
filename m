Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72701C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212742184A
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 15:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lUGAnYI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfBRPtZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:49:25 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:50808 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfBRPtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 10:49:25 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 82DEB24E25A1;
        Mon, 18 Feb 2019 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550504963; bh=8zApRIPStbFy6ZzZT5RE8692vGSdVdXVd8IlKc1sJNg=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=lUGAnYI6QTQ63IcfAop0aMNQsNXHbjuHU6hGDlSNq1S6JtfI6tavCPttLotE44OQh
         9kLshm2qs5LCQtSjrfBXyaRle9rJiTe7BD0lJE2qtnh9VOoZEALRLXZmRHqr3dvqaA
         RE/2bP1y7/3pFRLkum7VC6+NNvBjrYETmFJBr+vQBLcoEaMHwYgP3z39TNJvH4gAQj
         rgCzwZFqz+MRSPTsgo6TcLw12s09LpuD2EnbllHKu9BL899x4YECWnZmgD5zLM5yOD
         oGnSFQSE/Mpj25sJwhn6o25dbPNrNyAkwcft0S/ZovzfX4d/KBaY4NLo+f0+QGGUmE
         gZ95HYOfJKuWw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E9873A0071;
        Mon, 18 Feb 2019 15:49:22 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 07:49:22 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 16:49:20 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 16:49:19 +0100
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [RFC v5 1/6] dmaengine: Add Synopsys eDMA IP core driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        "Luis Oliveira" <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
 <19f8b7128b658821f7c4b0196ef5c958b640de55.1549905325.git.gustavo.pimentel@synopsys.com>
 <20190211184944.GH9224@smile.fi.intel.com>
Message-ID: <fdbba924-a8ef-4e46-d053-c91d26b2b9bc@synopsys.com>
Date:   Mon, 18 Feb 2019 15:44:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211184944.GH9224@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On 11/02/2019 18:49, Andy Shevchenko wrote:
> On Mon, Feb 11, 2019 at 06:34:30PM +0100, Gustavo Pimentel wrote:
>> Add Synopsys PCIe Endpoint eDMA IP core driver to kernel.
>>
>> This IP is generally distributed with Synopsys PCIe Endpoint IP (depends
>> of the use and licensing agreement).
>>
>> This core driver, initializes and configures the eDMA IP using vma-helpers
>> functions and dma-engine subsystem.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA option in kernel configuration,
>> however it requires and selects automatically DMA_ENGINE and
>> DMA_VIRTUAL_CHANNELS option too.
> 
> First comment here is that: try to shrink your code base by let's say 15%.
> I believe something here is done is suboptimal way or doesn't take into
> consideration existing facilities in the kernel.

Ok, it's quite possible. Based on this and other code revisions I've discover
some helpers that I didn't know or hasn't aware/didn't see in previous driver
implementations.

Those helpers keep the code much cleaner and readable, thanks to all for show me
them!

> 
>> +static void dw_edma_free_chunk(struct dw_edma_desc *desc)
>> +{
>> +	struct dw_edma_chan *chan = desc->chan;
>> +	struct dw_edma_chunk *child, *_next;
>> +
> 
>> +	if (!desc->chunk)
>> +		return;
> 
> Is it necessary check? Why?

It was just a pointer validation fail safe. I can remove it.

> 
>> +
>> +	/* Remove all the list elements */
>> +	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
>> +		dw_edma_free_burst(child);
>> +		if (child->bursts_alloc)
>> +			dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
>> +				child->bursts_alloc);
>> +		list_del(&child->list);
>> +		kfree(child);
>> +		desc->chunks_alloc--;
>> +	}
>> +
>> +	/* Remove the list head */
>> +	kfree(child);
>> +	desc->chunk = NULL;
>> +}
> 
>> +static int dw_edma_device_config(struct dma_chan *dchan,
>> +				 struct dma_slave_config *config)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	unsigned long flags;
>> +	int err = 0;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
> 
>> +	if (!config) {
>> +		err = -EINVAL;
>> +		goto err_config;
>> +	}
> 
> Is it necessary check? Why?

It was just a pointer validation fail safe (old habit from user space tools,
trying to protect to all costs any misuse from the user). I can remove it, no
problem.

> 
> Why this is under spin lock?
> 
>> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
>> +		&config->src_addr, &config->dst_addr);
> 
> And this.
> 
> What do you protect by locks? Check all your locking carefully.

In this case, I was trying to protect the config data and configure variable,
since this information is manipulated here and by dw_edma_device_transfer(),
which is called by dw_edma_device_prep_slave_sg() and/or
dw_edma_device_prep_dma_cyclic()

But you comment was about the debug print itself or about the config
data/configured variable?

> 
>> +
>> +	chan->src_addr = config->src_addr;
>> +	chan->dst_addr = config->dst_addr;
>> +
>> +	chan->configured = true;
>> +	dev_dbg(chan2dev(chan),	"channel configured\n");
>> +
>> +err_config:
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +	return err;
>> +}
>> +
>> +static int dw_edma_device_pause(struct dma_chan *dchan)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	unsigned long flags;
>> +	int err = 0;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	if (!chan->configured) {
> 
>> +		dev_err(chan2dev(chan), "(pause) channel not configured\n");
> 
> Why this is under spinlock?

The goal was to protect the configured, status and request variables. Once again
your comment was about the variables itself or about the debug prints?

> 
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	}
>> +
>> +	if (chan->status != EDMA_ST_BUSY) {
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	}
>> +
>> +	if (chan->request != EDMA_REQ_NONE) {
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	}
>> +
>> +	chan->request = EDMA_REQ_PAUSE;
> 
>> +	dev_dbg(chan2dev(chan), "pause requested\n");
> 
> Ditto.
> 
> Moreover, check what functional tracer can provide you for debugging.

I saw in dw-axi-dmac driver the use of dev_dbg() instead of dev_dbg(), that is
what you recommend (besides of removing some debug prints)?

> 
>> +
>> +err_pause:
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +	return err;
>> +}
> 
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	struct dw_edma_desc *desc;
>> +	struct virt_dma_desc *vd;
>> +	unsigned long flags;
>> +	enum dma_status ret;
>> +	u32 residue = 0;
>> +
>> +	ret = dma_cookie_status(dchan, cookie, txstate);
>> +	if (ret == DMA_COMPLETE)
>> +		return ret;
>> +
> 
>> +	if (!txstate)
>> +		return ret;
> 
> So, if there is no txstate, you can't return PAUSED state? Why?

I misunderstood Vinod's comment "this looks better, please do keep in mind
txstate can be null, so residue can can be skipped"

The txstate variable should be verified after checking if the channel is on
PAUSE state.

> 
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
>> +		ret = DMA_PAUSED;

	if (!txstate)
		goto ret_status;

Sounds good?

>> +
>> +	vd = vchan_find_desc(&chan->vc, cookie);
>> +	if (!vd)
>> +		goto ret_status;
>> +
>> +	desc = vd2dw_edma_desc(vd);
>> +	if (desc)
>> +		residue = desc->alloc_sz - desc->xfer_sz;
>> +
>> +ret_status:
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +	dma_set_residue(txstate, residue);
>> +
>> +	return ret;
>> +}
> 
>> +	for (i = 0; i < cnt; i++) {
>> +		if (!xfer->cyclic && !sg)
>> +			break;
>> +
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
>> +		if (xfer->cyclic)
>> +			burst->sz = xfer->xfer.cyclic.len;
>> +		else
>> +			burst->sz = sg_dma_len(sg);
>> +
>> +		chunk->ll_region.sz += burst->sz;
>> +		desc->alloc_sz += burst->sz;
>> +
>> +		if (direction == DMA_DEV_TO_MEM) {
>> +			burst->sar = src_addr;
>> +			if (xfer->cyclic) {
>> +				burst->dar = xfer->xfer.cyclic.paddr;
>> +			} else {
>> +				burst->dar = sg_dma_address(sg);
>> +				src_addr += sg_dma_len(sg);
>> +			}
>> +		} else {
>> +			burst->dar = dst_addr;
>> +			if (xfer->cyclic) {
>> +				burst->sar = xfer->xfer.cyclic.paddr;
>> +			} else {
>> +				burst->sar = sg_dma_address(sg);
>> +				dst_addr += sg_dma_len(sg);
>> +			}
>> +		}
>> +
>> +		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
>> +			i + 1, cnt, burst->sar, burst->dar, burst->sz);
>> +
>> +		if (!xfer->cyclic)
>> +			sg = sg_next(sg);
> 
> Shouldn't you rather to use for_each_sg()?

I used that helper on the prep_slave_sg(), but now that I have a common function
for both functions prep_slave_sg() and prep_dma_cyclic(). I think IMHO that
helper doesn't make much sense now, but If you have an suggestion I'll be glad
to know it.

> 
>> +	}
> 
> 
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +	vd = vchan_next_desc(&chan->vc);
>> +	switch (chan->request) {
>> +	case EDMA_REQ_NONE:
> 
>> +		if (!vd)
>> +			break;
> 
> Shouldn't be outside of switch?

Yes, it should.

> 
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
>> +		dev_dbg(chan2dev(chan), "transfer stop\n");
>> +		break;
>> +	case EDMA_REQ_PAUSE:
>> +		chan->request = EDMA_REQ_NONE;
>> +		chan->status = EDMA_ST_PAUSE;
>> +		break;
>> +	default:
>> +		dev_err(chan2dev(chan), "invalid status state\n");
>> +		break;
>> +	}
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +}
> 
>> +static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
>> +{
>> +	struct dw_edma_irq *dw_irq = data;
>> +	struct dw_edma *dw = dw_irq->dw;
>> +	unsigned long total, pos, val;
>> +	unsigned long off;
>> +	u32 mask;
>> +
>> +	if (write) {
>> +		total = dw->wr_ch_cnt;
>> +		off = 0;
>> +		mask = dw_irq->wr_mask;
>> +	} else {
>> +		total = dw->rd_ch_cnt;
>> +		off = dw->wr_ch_cnt;
>> +		mask = dw_irq->rd_mask;
>> +	}
>> +
>> +	pos = 0;
>> +	val = dw_edma_v0_core_status_done_int(dw, write ?
>> +					      EDMA_DIR_WRITE :
>> +					      EDMA_DIR_READ);
>> +	val &= mask;
>> +	while ((pos = find_next_bit(&val, total, pos)) != total) {
> 
> Is this funny version of for_each_set_bit()?

I wasn't aware of that helper. I'll change the while loop.

> 
>> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
>> +
>> +		dw_edma_done_interrupt(chan);
>> +		pos++;
>> +	}
>> +
>> +	pos = 0;
>> +	val = dw_edma_v0_core_status_abort_int(dw, write ?
>> +					       EDMA_DIR_WRITE :
>> +					       EDMA_DIR_READ);
>> +	val &= mask;
> 
>> +	while ((pos = find_next_bit(&val, total, pos)) != total) {
> 
> Ditto.

I wasn't aware of that helper. I'll change the while loop.

> 
>> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
>> +
>> +		dw_edma_abort_interrupt(chan);
>> +		pos++;
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +	do {
>> +		ret = dw_edma_device_terminate_all(dchan);
>> +		if (!ret)
>> +			break;
>> +
>> +		if (time_after_eq(jiffies, timeout)) {
>> +			dev_err(chan2dev(chan), "free timeout\n");
>> +			return;
>> +		}
>> +
>> +		cpu_relax();
> 
>> +	} while (1);
> 
> So, what prevents you to do while (time_before(...)); here?

Once again, I wasn't aware of that helper. I'll change the do while loop.

> 
>> +
>> +	dev_dbg(dchan2dev(dchan), "channel freed\n");
>> +
>> +	pm_runtime_put(chan->chip->dev);
>> +}
> 
>> +static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
>> +				 u32 wr_alloc, u32 rd_alloc)
>> +{
>> +	struct dw_edma_region *dt_region;
>> +	struct device *dev = chip->dev;
>> +	struct dw_edma *dw = chip->dw;
>> +	struct dw_edma_chan *chan;
>> +	size_t ll_chunk, dt_chunk;
>> +	struct dw_edma_irq *irq;
>> +	struct dma_device *dma;
>> +	u32 i, j, cnt, ch_cnt;
>> +	u32 alloc, off_alloc;
>> +	int err = 0;
>> +	u32 pos;
>> +
>> +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>> +	ll_chunk = dw->ll_region.sz;
>> +	dt_chunk = dw->dt_region.sz;
>> +
>> +	/* Calculate linked list chunk for each channel */
>> +	ll_chunk /= roundup_pow_of_two(ch_cnt);
>> +
>> +	/* Calculate linked list chunk for each channel */
>> +	dt_chunk /= roundup_pow_of_two(ch_cnt);
> 
>> +	INIT_LIST_HEAD(&dma->channels);
>> +
>> +	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
>> +		chan = &dw->chan[i];
>> +
>> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
>> +		if (!dt_region)
>> +			return -ENOMEM;
>> +
>> +		chan->vc.chan.private = dt_region;
>> +
>> +		chan->chip = chip;
>> +		chan->id = j;
>> +		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
>> +		chan->configured = false;
>> +		chan->request = EDMA_REQ_NONE;
>> +		chan->status = EDMA_ST_IDLE;
>> +
>> +		chan->ll_off = (ll_chunk * i);
>> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
>> +
>> +		chan->dt_off = (dt_chunk * i);
>> +
>> +		dev_dbg(dev, "L. List:\tChannel %s[%u] off=0x%.8lx, max_cnt=%u\n",
>> +			write ? "write" : "read", j,
>> +			chan->ll_off, chan->ll_max);
>> +
>> +		if (dw->nr_irqs == 1)
>> +			pos = 0;
>> +		else
>> +			pos = off_alloc + (j % alloc);
>> +
>> +		irq = &dw->irq[pos];
>> +
>> +		if (write)
>> +			irq->wr_mask |= BIT(j);
>> +		else
>> +			irq->rd_mask |= BIT(j);
>> +
>> +		irq->dw = dw;
>> +		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
>> +
>> +		dev_dbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
>> +			write ? "write" : "read", j,
>> +			chan->msi.address_hi, chan->msi.address_lo,
>> +			chan->msi.data);
>> +
>> +		chan->vc.desc_free = vchan_free_desc;
>> +		vchan_init(&chan->vc, dma);
>> +
>> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
>> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
>> +		dt_region->sz = dt_chunk;
>> +
>> +		dev_dbg(dev, "Data:\tChannel %s[%u] off=0x%.8lx\n",
>> +			write ? "write" : "read", j, chan->dt_off);
>> +
>> +		dw_edma_v0_core_device_config(chan);
>> +	}
>> +
>> +	/* Set DMA channel capabilities */
>> +	dma_cap_zero(dma->cap_mask);
>> +	dma_cap_set(DMA_SLAVE, dma->cap_mask);
>> +	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
> 
> Doesn't it used for slave transfers?
> DMA_PRIVATE is good to be set for this.

Yep, makes sense.

> 
>> +	return err;
>> +}
>> +
>> +static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
>> +{
>> +	if (*nr_irqs && *alloc < cnt) {
>> +		(*alloc)++;
>> +		(*nr_irqs)--;
>> +	}
> 
> I don't see any allocation here.

Bad function and variable naming... Maybe it should be dw_edma_IRQ_spreader or
dw_edma_IRQ_distributor or similar.

I tried to add some intelligence to this driver, in order to be flexible enough
to adapt it to different situations that can happen.

Because who has this IP can configure have the freedom to configure independently:
 - the number of DEV_TO_MEM channels
 - the number of MEM_TO_DEV channels
 - the number of IRQs

this creates a world of possibilities in terms of IRQs assignment to those channels.

In a perfect world, the best case would be to have an unique IRQ assigned to
each channel, however that may not be possible.

Therefore, this algorithm tries to spread evenly the IRQs between the DEV_TO_MEM
and MEM_TO_DEV channels.

Let imagine the following case:
 - 3 MEM_TO_DEV channels
 - 2 DEV_TO_MEM channels
 - 3 IRQs

MEM_TO_DEV channels
 - #0 => IRQ #0
 - #1 => IRQ #1 (shared between channels #1 and #2)
 - #2 => IRQ #1 (shared between channels #1 and #2)
DEV_TO_MEM channels
 - #0 => IRQ #2 (shared between channels #0 and #1)
 - #1 => IRQ #2 (shared between channels #0 and #1)


or this other case:
 - 5 MEM_TO_DEV channels
 - 5 DEV_TO_MEM channels
 - 4 IRQs

MEM_TO_DEV channels
 - #0 => IRQ #0 (shared between channels #0, #1 and #2)
 - #1 => IRQ #0 (shared between channels #0, #1 and #2)
 - #2 => IRQ #0 (shared between channels #0, #1 and #2)
 - #3 => IRQ #1 (shared between channels #3 and #4)
 - #4 => IRQ #1 (shared between channels #3 and #4)
DEV_TO_MEM channels
 - #0 => IRQ #2 (shared between channels #0, #1 and #2)
 - #1 => IRQ #2 (shared between channels #0, #1 and #2)
 - #2 => IRQ #2 (shared between channels #0, #1 and #2)
 - #3 => IRQ #3 (shared between channels #3 and #4)
 - #4 => IRQ #3 (shared between channels #3 and #4)

> 
>> +}
>> +
>> +static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
>> +{
> 
>> +	while (*mask * alloc < cnt)
>> +		(*mask)++;
> 
> Do you really need a loop here?

That is the algorithm that I've designed. Based on what I have explain, perhaps
there is something that you know of that already does what I pretend to do.
I've searched for algorithms and linux kernel functions it but the only thing
with similar results is linear programming, but the code implementation of it
seems to be overkill for this.

> 
>> +}
>> +
>> +static int dw_edma_irq_request(struct dw_edma_chip *chip,
>> +			       u32 *wr_alloc, u32 *rd_alloc)
>> +{
>> +	struct device *dev = chip->dev;
>> +	struct dw_edma *dw = chip->dw;
>> +	u32 wr_mask = 1;
>> +	u32 rd_mask = 1;
>> +	int i, err = 0;
>> +	u32 ch_cnt;
>> +
>> +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>> +
>> +	if (dw->nr_irqs < 1) {
>> +		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dw->nr_irqs == 1) {
>> +		/* Common IRQ shared among all channels */
>> +		err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
>> +				  dw_edma_interrupt_common,
>> +				  IRQF_SHARED, dw->name, &dw->irq[0]);
>> +		if (err) {
>> +			dw->nr_irqs = 0;
>> +			return err;
>> +		}
>> +
>> +		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
>> +				   &dw->irq[0].msi);
> 
> Are you going to call each time to pci_irq_vector()? Btw, am I missed pci_irq_alloc()?

In this case this is called only once (dw->nr_irqs == 1).

> 
>> +	} else {
> 
>> +		/* Distribute IRQs equally among all channels */
>> +		int tmp = dw->nr_irqs;
> 
> Is it always achievable?

Yes, base on what I have explained before, it possible to distribute the
available IRQ among the channels which after that we have to share the already
assigned IRQ to the remaining channels in order to give the each channel a way
to generate an interrupt. Never the less this is a best effort algorithm.

> 
>> +
>> +		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
>> +			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
>> +			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
>> +		}
>> +
>> +		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
>> +		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
>> +
>> +		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
>> +			err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
>> +					  i < *wr_alloc ?
>> +						dw_edma_interrupt_write :
>> +						dw_edma_interrupt_read,
>> +					  IRQF_SHARED, dw->name,
>> +					  &dw->irq[i]);
>> +			if (err) {
>> +				dw->nr_irqs = i;
>> +				return err;
>> +			}
>> +
>> +			get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
>> +					   &dw->irq[i].msi);
>> +		}
>> +
>> +		dw->nr_irqs = i;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +int dw_edma_probe(struct dw_edma_chip *chip)
>> +{
>> +	struct device *dev = chip->dev;
>> +	struct dw_edma *dw = chip->dw;
>> +	u32 wr_alloc = 0;
>> +	u32 rd_alloc = 0;
>> +	int i, err;
>> +
>> +	raw_spin_lock_init(&dw->lock);
>> +
>> +	/* Find out how many write channels are supported by hardware */
>> +	dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
>> +	if (!dw->wr_ch_cnt) {
>> +		dev_err(dev, "invalid number of write channels(0)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Find out how many read channels are supported by hardware */
>> +	dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
>> +	if (!dw->rd_ch_cnt) {
>> +		dev_err(dev, "invalid number of read channels(0)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
>> +		dw->wr_ch_cnt, dw->rd_ch_cnt);
>> +
>> +	/* Allocate channels */
>> +	dw->chan = devm_kcalloc(dev, dw->wr_ch_cnt + dw->rd_ch_cnt,
>> +				sizeof(*dw->chan), GFP_KERNEL);
>> +	if (!dw->chan)
>> +		return -ENOMEM;
>> +
>> +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
>> +
>> +	/* Disable eDMA, only to establish the ideal initial conditions */
>> +	dw_edma_v0_core_off(dw);
>> +
>> +	/* Request IRQs */
>> +	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
>> +	if (err)
>> +		return err;
>> +
> 
>> +	/* Setup write channels */
>> +	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
>> +	if (err)
>> +		goto err_irq_free;
>> +
>> +	/* Setup read channels */
>> +	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
>> +	if (err)
>> +		goto err_irq_free;
> 
> I think you may look into ep93xx driver to see how different type of channels
> are allocated and be set up.

I took a look at this driver, but I'm not seeing what I can copy to improve my
driver, it seems to behave differently from mine. For starters, they do not
distinguish different channels like WRITE / READ, as I have to do on mine, but I
might seen it wrongly.

> 
>> +
>> +	/* Power management */
>> +	pm_runtime_enable(dev);
>> +
>> +	/* Turn debugfs on */
>> +	err = dw_edma_v0_core_debugfs_on(chip);
>> +	if (err) {
>> +		dev_err(dev, "unable to create debugfs structure\n");
>> +		goto err_pm_disable;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_pm_disable:
>> +	pm_runtime_disable(dev);
>> +err_irq_free:
>> +	for (i = (dw->nr_irqs - 1); i >= 0; i--)
>> +		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
>> +
>> +	dw->nr_irqs = 0;
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(dw_edma_probe);
> 
>> +/**
>> + * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>> + * @dev:		 struct device of the eDMA controller
>> + * @id:			 instance ID
>> + * @irq:		 irq line
>> + * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>> + */
>> +struct dw_edma_chip {
>> +	struct device		*dev;
>> +	int			id;
>> +	int			irq;
>> +	struct dw_edma		*dw;
>> +};
>> +
>> +/* Export to the platform drivers */
>> +#if IS_ENABLED(CONFIG_DW_EDMA)
>> +int dw_edma_probe(struct dw_edma_chip *chip);
>> +int dw_edma_remove(struct dw_edma_chip *chip);
>> +#else
>> +static inline int dw_edma_probe(struct dw_edma_chip *chip)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int dw_edma_remove(struct dw_edma_chip *chip)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_DW_EDMA */
> 
> Is it going to be used as a library?

My goal is to provide this code as a driver to be use by all customers that have
this IP, avoiding duplicated code and re-inventing the wheel over and over. That
way, the customers can focus their energy on writing the main driver code (which
can be USB EP, Ethernet EP, whatever) and implementing on their side the access
to this driver by looking the reference PCIe glue-logic driver that I'm
providing. I don't know if this as clarified your question or not.

> 

Once again thanks for your feedback Andy!

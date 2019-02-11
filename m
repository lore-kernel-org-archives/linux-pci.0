Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D40C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1821B68
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBKStv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:49:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:56943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfBKStv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 13:49:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="298915257"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2019 10:49:45 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gtGeG-0007DA-Fo; Mon, 11 Feb 2019 20:49:44 +0200
Date:   Mon, 11 Feb 2019 20:49:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v5 1/6] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190211184944.GH9224@smile.fi.intel.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
 <19f8b7128b658821f7c4b0196ef5c958b640de55.1549905325.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f8b7128b658821f7c4b0196ef5c958b640de55.1549905325.git.gustavo.pimentel@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 06:34:30PM +0100, Gustavo Pimentel wrote:
> Add Synopsys PCIe Endpoint eDMA IP core driver to kernel.
> 
> This IP is generally distributed with Synopsys PCIe Endpoint IP (depends
> of the use and licensing agreement).
> 
> This core driver, initializes and configures the eDMA IP using vma-helpers
> functions and dma-engine subsystem.
> 
> This driver can be compile as built-in or external module in kernel.
> 
> To enable this driver just select DW_EDMA option in kernel configuration,
> however it requires and selects automatically DMA_ENGINE and
> DMA_VIRTUAL_CHANNELS option too.

First comment here is that: try to shrink your code base by let's say 15%.
I believe something here is done is suboptimal way or doesn't take into
consideration existing facilities in the kernel.

> +static void dw_edma_free_chunk(struct dw_edma_desc *desc)
> +{
> +	struct dw_edma_chan *chan = desc->chan;
> +	struct dw_edma_chunk *child, *_next;
> +

> +	if (!desc->chunk)
> +		return;

Is it necessary check? Why?

> +
> +	/* Remove all the list elements */
> +	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
> +		dw_edma_free_burst(child);
> +		if (child->bursts_alloc)
> +			dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
> +				child->bursts_alloc);
> +		list_del(&child->list);
> +		kfree(child);
> +		desc->chunks_alloc--;
> +	}
> +
> +	/* Remove the list head */
> +	kfree(child);
> +	desc->chunk = NULL;
> +}

> +static int dw_edma_device_config(struct dma_chan *dchan,
> +				 struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +

> +	if (!config) {
> +		err = -EINVAL;
> +		goto err_config;
> +	}

Is it necessary check? Why?

Why this is under spin lock?

> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
> +		&config->src_addr, &config->dst_addr);

And this.

What do you protect by locks? Check all your locking carefully.

> +
> +	chan->src_addr = config->src_addr;
> +	chan->dst_addr = config->dst_addr;
> +
> +	chan->configured = true;
> +	dev_dbg(chan2dev(chan),	"channel configured\n");
> +
> +err_config:
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	return err;
> +}
> +
> +static int dw_edma_device_pause(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	if (!chan->configured) {

> +		dev_err(chan2dev(chan), "(pause) channel not configured\n");

Why this is under spinlock?

> +		err = -EPERM;
> +		goto err_pause;
> +	}
> +
> +	if (chan->status != EDMA_ST_BUSY) {
> +		err = -EPERM;
> +		goto err_pause;
> +	}
> +
> +	if (chan->request != EDMA_REQ_NONE) {
> +		err = -EPERM;
> +		goto err_pause;
> +	}
> +
> +	chan->request = EDMA_REQ_PAUSE;

> +	dev_dbg(chan2dev(chan), "pause requested\n");

Ditto.

Moreover, check what functional tracer can provide you for debugging.

> +
> +err_pause:
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	return err;
> +}

> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct dw_edma_desc *desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	enum dma_status ret;
> +	u32 residue = 0;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +

> +	if (!txstate)
> +		return ret;

So, if there is no txstate, you can't return PAUSED state? Why?

> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
> +		ret = DMA_PAUSED;
> +
> +	vd = vchan_find_desc(&chan->vc, cookie);
> +	if (!vd)
> +		goto ret_status;
> +
> +	desc = vd2dw_edma_desc(vd);
> +	if (desc)
> +		residue = desc->alloc_sz - desc->xfer_sz;
> +
> +ret_status:
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	dma_set_residue(txstate, residue);
> +
> +	return ret;
> +}

> +	for (i = 0; i < cnt; i++) {
> +		if (!xfer->cyclic && !sg)
> +			break;
> +
> +		if (chunk->bursts_alloc == chan->ll_max) {
> +			chunk = dw_edma_alloc_chunk(desc);
> +			if (unlikely(!chunk))
> +				goto err_alloc;
> +		}
> +
> +		burst = dw_edma_alloc_burst(chunk);
> +
> +		if (unlikely(!burst))
> +			goto err_alloc;
> +
> +		if (xfer->cyclic)
> +			burst->sz = xfer->xfer.cyclic.len;
> +		else
> +			burst->sz = sg_dma_len(sg);
> +
> +		chunk->ll_region.sz += burst->sz;
> +		desc->alloc_sz += burst->sz;
> +
> +		if (direction == DMA_DEV_TO_MEM) {
> +			burst->sar = src_addr;
> +			if (xfer->cyclic) {
> +				burst->dar = xfer->xfer.cyclic.paddr;
> +			} else {
> +				burst->dar = sg_dma_address(sg);
> +				src_addr += sg_dma_len(sg);
> +			}
> +		} else {
> +			burst->dar = dst_addr;
> +			if (xfer->cyclic) {
> +				burst->sar = xfer->xfer.cyclic.paddr;
> +			} else {
> +				burst->sar = sg_dma_address(sg);
> +				dst_addr += sg_dma_len(sg);
> +			}
> +		}
> +
> +		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
> +			i + 1, cnt, burst->sar, burst->dar, burst->sz);
> +
> +		if (!xfer->cyclic)
> +			sg = sg_next(sg);

Shouldn't you rather to use for_each_sg()?

> +	}


> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	vd = vchan_next_desc(&chan->vc);
> +	switch (chan->request) {
> +	case EDMA_REQ_NONE:

> +		if (!vd)
> +			break;

Shouldn't be outside of switch?

> +
> +		desc = vd2dw_edma_desc(vd);
> +		if (desc->chunks_alloc) {
> +			dev_dbg(chan2dev(chan), "sub-transfer complete\n");
> +			chan->status = EDMA_ST_BUSY;
> +			dev_dbg(chan2dev(chan), "transferred %u bytes\n",
> +				desc->xfer_sz);
> +			dw_edma_start_transfer(chan);
> +		} else {
> +			list_del(&vd->node);
> +			vchan_cookie_complete(vd);
> +			chan->status = EDMA_ST_IDLE;
> +			dev_dbg(chan2dev(chan), "transfer complete\n");
> +		}
> +		break;
> +	case EDMA_REQ_STOP:
> +		if (!vd)
> +			break;
> +
> +		list_del(&vd->node);
> +		vchan_cookie_complete(vd);
> +		chan->request = EDMA_REQ_NONE;
> +		chan->status = EDMA_ST_IDLE;
> +		dev_dbg(chan2dev(chan), "transfer stop\n");
> +		break;
> +	case EDMA_REQ_PAUSE:
> +		chan->request = EDMA_REQ_NONE;
> +		chan->status = EDMA_ST_PAUSE;
> +		break;
> +	default:
> +		dev_err(chan2dev(chan), "invalid status state\n");
> +		break;
> +	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +}

> +static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> +{
> +	struct dw_edma_irq *dw_irq = data;
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
> +	unsigned long off;
> +	u32 mask;
> +
> +	if (write) {
> +		total = dw->wr_ch_cnt;
> +		off = 0;
> +		mask = dw_irq->wr_mask;
> +	} else {
> +		total = dw->rd_ch_cnt;
> +		off = dw->wr_ch_cnt;
> +		mask = dw_irq->rd_mask;
> +	}
> +
> +	pos = 0;
> +	val = dw_edma_v0_core_status_done_int(dw, write ?
> +					      EDMA_DIR_WRITE :
> +					      EDMA_DIR_READ);
> +	val &= mask;
> +	while ((pos = find_next_bit(&val, total, pos)) != total) {

Is this funny version of for_each_set_bit()?

> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
> +
> +		dw_edma_done_interrupt(chan);
> +		pos++;
> +	}
> +
> +	pos = 0;
> +	val = dw_edma_v0_core_status_abort_int(dw, write ?
> +					       EDMA_DIR_WRITE :
> +					       EDMA_DIR_READ);
> +	val &= mask;

> +	while ((pos = find_next_bit(&val, total, pos)) != total) {

Ditto.

> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
> +
> +		dw_edma_abort_interrupt(chan);
> +		pos++;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +	do {
> +		ret = dw_edma_device_terminate_all(dchan);
> +		if (!ret)
> +			break;
> +
> +		if (time_after_eq(jiffies, timeout)) {
> +			dev_err(chan2dev(chan), "free timeout\n");
> +			return;
> +		}
> +
> +		cpu_relax();

> +	} while (1);

So, what prevents you to do while (time_before(...)); here?

> +
> +	dev_dbg(dchan2dev(dchan), "channel freed\n");
> +
> +	pm_runtime_put(chan->chip->dev);
> +}

> +static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> +				 u32 wr_alloc, u32 rd_alloc)
> +{
> +	struct dw_edma_region *dt_region;
> +	struct device *dev = chip->dev;
> +	struct dw_edma *dw = chip->dw;
> +	struct dw_edma_chan *chan;
> +	size_t ll_chunk, dt_chunk;
> +	struct dw_edma_irq *irq;
> +	struct dma_device *dma;
> +	u32 i, j, cnt, ch_cnt;
> +	u32 alloc, off_alloc;
> +	int err = 0;
> +	u32 pos;
> +
> +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> +	ll_chunk = dw->ll_region.sz;
> +	dt_chunk = dw->dt_region.sz;
> +
> +	/* Calculate linked list chunk for each channel */
> +	ll_chunk /= roundup_pow_of_two(ch_cnt);
> +
> +	/* Calculate linked list chunk for each channel */
> +	dt_chunk /= roundup_pow_of_two(ch_cnt);

> +	INIT_LIST_HEAD(&dma->channels);
> +
> +	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
> +		chan = &dw->chan[i];
> +
> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
> +		if (!dt_region)
> +			return -ENOMEM;
> +
> +		chan->vc.chan.private = dt_region;
> +
> +		chan->chip = chip;
> +		chan->id = j;
> +		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
> +		chan->configured = false;
> +		chan->request = EDMA_REQ_NONE;
> +		chan->status = EDMA_ST_IDLE;
> +
> +		chan->ll_off = (ll_chunk * i);
> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
> +
> +		chan->dt_off = (dt_chunk * i);
> +
> +		dev_dbg(dev, "L. List:\tChannel %s[%u] off=0x%.8lx, max_cnt=%u\n",
> +			write ? "write" : "read", j,
> +			chan->ll_off, chan->ll_max);
> +
> +		if (dw->nr_irqs == 1)
> +			pos = 0;
> +		else
> +			pos = off_alloc + (j % alloc);
> +
> +		irq = &dw->irq[pos];
> +
> +		if (write)
> +			irq->wr_mask |= BIT(j);
> +		else
> +			irq->rd_mask |= BIT(j);
> +
> +		irq->dw = dw;
> +		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> +
> +		dev_dbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> +			write ? "write" : "read", j,
> +			chan->msi.address_hi, chan->msi.address_lo,
> +			chan->msi.data);
> +
> +		chan->vc.desc_free = vchan_free_desc;
> +		vchan_init(&chan->vc, dma);
> +
> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
> +		dt_region->sz = dt_chunk;
> +
> +		dev_dbg(dev, "Data:\tChannel %s[%u] off=0x%.8lx\n",
> +			write ? "write" : "read", j, chan->dt_off);
> +
> +		dw_edma_v0_core_device_config(chan);
> +	}
> +
> +	/* Set DMA channel capabilities */
> +	dma_cap_zero(dma->cap_mask);
> +	dma_cap_set(DMA_SLAVE, dma->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, dma->cap_mask);

Doesn't it used for slave transfers?
DMA_PRIVATE is good to be set for this.

> +	return err;
> +}
> +
> +static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
> +{
> +	if (*nr_irqs && *alloc < cnt) {
> +		(*alloc)++;
> +		(*nr_irqs)--;
> +	}

I don't see any allocation here.

> +}
> +
> +static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
> +{

> +	while (*mask * alloc < cnt)
> +		(*mask)++;

Do you really need a loop here?

> +}
> +
> +static int dw_edma_irq_request(struct dw_edma_chip *chip,
> +			       u32 *wr_alloc, u32 *rd_alloc)
> +{
> +	struct device *dev = chip->dev;
> +	struct dw_edma *dw = chip->dw;
> +	u32 wr_mask = 1;
> +	u32 rd_mask = 1;
> +	int i, err = 0;
> +	u32 ch_cnt;
> +
> +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> +
> +	if (dw->nr_irqs < 1) {
> +		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
> +		return -EINVAL;
> +	}
> +
> +	if (dw->nr_irqs == 1) {
> +		/* Common IRQ shared among all channels */
> +		err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
> +				  dw_edma_interrupt_common,
> +				  IRQF_SHARED, dw->name, &dw->irq[0]);
> +		if (err) {
> +			dw->nr_irqs = 0;
> +			return err;
> +		}
> +
> +		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
> +				   &dw->irq[0].msi);

Are you going to call each time to pci_irq_vector()? Btw, am I missed pci_irq_alloc()?

> +	} else {

> +		/* Distribute IRQs equally among all channels */
> +		int tmp = dw->nr_irqs;

Is it always achievable?

> +
> +		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
> +			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
> +			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
> +		}
> +
> +		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
> +		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> +
> +		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> +			err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
> +					  i < *wr_alloc ?
> +						dw_edma_interrupt_write :
> +						dw_edma_interrupt_read,
> +					  IRQF_SHARED, dw->name,
> +					  &dw->irq[i]);
> +			if (err) {
> +				dw->nr_irqs = i;
> +				return err;
> +			}
> +
> +			get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
> +					   &dw->irq[i].msi);
> +		}
> +
> +		dw->nr_irqs = i;
> +	}
> +
> +	return err;
> +}
> +
> +int dw_edma_probe(struct dw_edma_chip *chip)
> +{
> +	struct device *dev = chip->dev;
> +	struct dw_edma *dw = chip->dw;
> +	u32 wr_alloc = 0;
> +	u32 rd_alloc = 0;
> +	int i, err;
> +
> +	raw_spin_lock_init(&dw->lock);
> +
> +	/* Find out how many write channels are supported by hardware */
> +	dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
> +	if (!dw->wr_ch_cnt) {
> +		dev_err(dev, "invalid number of write channels(0)\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find out how many read channels are supported by hardware */
> +	dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
> +	if (!dw->rd_ch_cnt) {
> +		dev_err(dev, "invalid number of read channels(0)\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
> +		dw->wr_ch_cnt, dw->rd_ch_cnt);
> +
> +	/* Allocate channels */
> +	dw->chan = devm_kcalloc(dev, dw->wr_ch_cnt + dw->rd_ch_cnt,
> +				sizeof(*dw->chan), GFP_KERNEL);
> +	if (!dw->chan)
> +		return -ENOMEM;
> +
> +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
> +
> +	/* Disable eDMA, only to establish the ideal initial conditions */
> +	dw_edma_v0_core_off(dw);
> +
> +	/* Request IRQs */
> +	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
> +	if (err)
> +		return err;
> +

> +	/* Setup write channels */
> +	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
> +	if (err)
> +		goto err_irq_free;
> +
> +	/* Setup read channels */
> +	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
> +	if (err)
> +		goto err_irq_free;

I think you may look into ep93xx driver to see how different type of channels
are allocated and be set up.

> +
> +	/* Power management */
> +	pm_runtime_enable(dev);
> +
> +	/* Turn debugfs on */
> +	err = dw_edma_v0_core_debugfs_on(chip);
> +	if (err) {
> +		dev_err(dev, "unable to create debugfs structure\n");
> +		goto err_pm_disable;
> +	}
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_disable(dev);
> +err_irq_free:
> +	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> +		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +
> +	dw->nr_irqs = 0;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_probe);

> +/**
> + * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> + * @dev:		 struct device of the eDMA controller
> + * @id:			 instance ID
> + * @irq:		 irq line
> + * @dw:			 struct dw_edma that is filed by dw_edma_probe()
> + */
> +struct dw_edma_chip {
> +	struct device		*dev;
> +	int			id;
> +	int			irq;
> +	struct dw_edma		*dw;
> +};
> +
> +/* Export to the platform drivers */
> +#if IS_ENABLED(CONFIG_DW_EDMA)
> +int dw_edma_probe(struct dw_edma_chip *chip);
> +int dw_edma_remove(struct dw_edma_chip *chip);
> +#else
> +static inline int dw_edma_probe(struct dw_edma_chip *chip)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int dw_edma_remove(struct dw_edma_chip *chip)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DW_EDMA */

Is it going to be used as a library?

-- 
With Best Regards,
Andy Shevchenko



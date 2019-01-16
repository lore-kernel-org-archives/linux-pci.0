Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3930AC43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FDE20859
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HaA9RfSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391918AbfAPKVo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:21:44 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:45454 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbfAPKVn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:21:43 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 887AC24E0F8F;
        Wed, 16 Jan 2019 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547634102; bh=WdrT+bhsgDldBip6DNSzWaNovAKMYEoXNu8pbtfXhsE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=HaA9RfSPslMUGAZwfnWsj+AsVEl4oxVcMZlwr9vACyRSKB0s4KyWvejHvSslwGiJc
         VG6ZdMXBuE2y9QFIDg8HyOkOwNm5QPAY8egA3R8Hd0K6DywvpFIOOOPFOVPCGknstv
         nY7UOwpgJYQQhKt+fQ0SAjAlm9kEYIY1WdDfUTHTiGLjZnPQ0OptCkxdQc2PmUV4CQ
         LKeM6dSlrFZyJGNpiZaj+2vasds3Se/OC3lPRtncIer0bnhpYYIbYTlWRpuRYnaFh9
         LFszxWgu42u1/RNZJe+fozlxI7ZgyH+GQdN6uI1ZnYcKldzkvRR6zTAhpWKrBbJPsZ
         yWvmFiUx1q8xQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8252B588C;
        Wed, 16 Jan 2019 02:21:41 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 02:21:41 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 11:21:39 +0100
Received: from [10.107.19.24] (10.107.19.24) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 11:21:38 +0100
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
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
        "Pedro Sousa" <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <e374b2fe-23bd-0bc5-be17-abced19bb4f7@synopsys.com>
Date:   Wed, 16 Jan 2019 10:21:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.24]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 1/11/2019 6:33 PM, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP core driver to kernel.
> 
> This core driver, initializes and configures the eDMA IP using vma-helpers
> functions and dma-engine subsystem.
> 
> Also creates an abstration layer through callbacks allowing different
> registers mappings in the future, organized in to versions.
> 
> This driver can be compile as built-in or external module in kernel.
> 
> To enable this driver just select DW_EDMA option in kernel configuration,
> however it requires and selects automatically DMA_ENGINE and
> DMA_VIRTUAL_CHANNELS option too.
> 
> Changes:
> RFC v1->RFC v2:
>  - Replace comments // (C99 style) by /**/
>  - Fix the headers of the .c and .h files according to the most recent
>    convention
>  - Fix errors and checks pointed out by checkpatch with --strict option
>  - Replace patch small description tag from dma by dmaengine
>  - Change some dev_info() into dev_dbg()
>  - Remove unnecessary zero initialization after kzalloc
>  - Remove direction validation on config() API, since the direction
>    parameter is deprecated
>  - Refactor code to replace atomic_t by u32 variable type
>  - Replace start_transfer() name by dw_edma_start_transfer()
>  - Add spinlock to dw_edma_device_prep_slave_sg()
>  - Add spinlock to dw_edma_free_chunk()
>  - Simplify switch case into if on dw_edma_device_pause(),
>    dw_edma_device_resume() and dw_edma_device_terminate_all()
> RFC v2->RFC v3:
>  - Add driver parameter to disable msix feature
>  - Fix printk variable of phys_addr_t type
>  - Fix printk variable of __iomem type
>  - Fix printk variable of size_t type
>  - Add comments or improve existing ones
>  - Add possibility to work with multiple IRQs feature
>  - Fix source and destination addresses
>  - Add define to magic numbers
>  - Add DMA cyclic transfer feature
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jose Abreu <jose.abreu@synopsys.com>
> Cc: Luis Oliveira <lolivei@synopsys.com>
> Cc: Vitor Soares <vitor.soares@synopsys.com>
> Cc: Nelson Costa <nelson.costa@synopsys.com>
> Cc: Pedro Sousa <pedrom.sousa@synopsys.com>


> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> +{
> +	struct dw_edma_chan *chan = desc->chan;
> +	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma_chunk *chunk;
> +
> +	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
> +	if (unlikely(!chunk))
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&chunk->list);
> +	chunk->chan = chan;
> +	chunk->cb = !(desc->chunks_alloc % 2);
> +	chunk->ll_region.paddr = dw->ll_region.paddr + chan->ll_off;
> +	chunk->ll_region.vaddr = dw->ll_region.vaddr + chan->ll_off;
> +
> +	if (desc->chunk) {
> +		/* Create and add new element into the linked list */
> +		desc->chunks_alloc++;
> +		dev_dbg(chan2dev(chan), "alloc new chunk element (%d)\n",
> +			desc->chunks_alloc);
> +		list_add_tail(&chunk->list, &desc->chunk->list);
> +		dw_edma_alloc_burst(chunk);

No return check ?

> +	} else {
> +		/* List head */
> +		chunk->burst = NULL;
> +		desc->chunks_alloc = 0;
> +		desc->chunk = chunk;
> +		dev_dbg(chan2dev(chan), "alloc new chunk head\n");
> +	}
> +
> +	return chunk;
> +}
> +
> +static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma_desc *desc;
> +
> +	dev_dbg(chan2dev(chan), "alloc new descriptor\n");
> +
> +	desc = kvzalloc(sizeof(*desc), GFP_NOWAIT);
> +	if (unlikely(!desc))
> +		return NULL;
> +
> +	desc->chan = chan;
> +	dw_edma_alloc_chunk(desc);

No return check ?

> +
> +	return desc;
> +}
> +

> +static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> +{
> +	struct virt_dma_desc *vd;
> +	struct dw_edma_desc *desc;
> +	struct dw_edma_chunk *child;
> +	const struct dw_edma_core_ops *ops = chan2ops(chan);

Reverse tree order here and in remaining functions ...

> +
> +	vd = vchan_next_desc(&chan->vc);
> +	if (!vd)
> +		return;
> +
> +	desc = vd2dw_edma_desc(vd);
> +	if (!desc)
> +		return;
> +
> +	child = list_first_entry_or_null(&desc->chunk->list,
> +					 struct dw_edma_chunk, list);
> +	if (!child)
> +		return;
> +
> +	ops->start(child, !desc->xfer_sz);
> +	desc->xfer_sz += child->ll_region.sz;
> +	dev_dbg(chan2dev(chan), "transfer of %u bytes started\n",
> +		child->ll_region.sz);
> +
> +	dw_edma_free_burst(child);
> +	if (child->bursts_alloc)
> +		dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
> +			child->bursts_alloc);
> +	list_del(&child->list);
> +	kvfree(child);
> +	desc->chunks_alloc--;
> +}
> +

> +int dw_edma_probe(struct dw_edma_chip *chip)
> +{
> +	struct dw_edma *dw = chip->dw;
> +	struct device *dev = chip->dev;
> +	const struct dw_edma_core_ops *ops;
> +	size_t ll_chunk = dw->ll_region.sz;
> +	size_t dt_chunk = dw->dt_region.sz;
> +	u32 ch_tot;
> +	int i, j, err;
> +
> +	raw_spin_lock_init(&dw->lock);

Why raw ?

> +
> +	/* Callback operation selection accordingly to eDMA version */
> +	switch (dw->version) {
> +	default:
> +		dev_err(dev, "unsupported version\n");
> +		return -EPERM;
> +	}
> +
> +	pm_runtime_get_sync(dev);

Why do you need to increase usage count at probe ? And shouldn't
this be after pm_runtime_enable() ?

> +
> +	/* Find out how many write channels are supported by hardware */
> +	dw->wr_ch_cnt = ops->ch_count(dw, EDMA_DIR_WRITE);
> +	if (!dw->wr_ch_cnt) {
> +		dev_err(dev, "invalid number of write channels(0)\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find out how many read channels are supported by hardware */
> +	dw->rd_ch_cnt = ops->ch_count(dw, EDMA_DIR_READ);
> +	if (!dw->rd_ch_cnt) {
> +		dev_err(dev, "invalid number of read channels(0)\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
> +		dw->wr_ch_cnt, dw->rd_ch_cnt);
> +
> +	ch_tot = dw->wr_ch_cnt + dw->rd_ch_cnt;
> +
> +	/* Allocate channels */
> +	dw->chan = devm_kcalloc(dev, ch_tot, sizeof(*dw->chan), GFP_KERNEL);
> +	if (!dw->chan)
> +		return -ENOMEM;
> +
> +	/* Calculate the linked list chunk for each channel */
> +	ll_chunk /= roundup_pow_of_two(ch_tot);
> +
> +	/* Calculate the linked list chunk for each channel */
> +	dt_chunk /= roundup_pow_of_two(ch_tot);
> +
> +	/* Disable eDMA, only to establish the ideal initial conditions */
> +	ops->off(dw);
> +
> +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
> +
> +	/* Request IRQs */
> +	if (dw->nr_irqs != 1) {
> +		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < dw->nr_irqs; i++) {
> +		err = devm_request_irq(dev, pci_irq_vector(to_pci_dev(dev), i),
> +				       dw_edma_interrupt_all,
> +				       IRQF_SHARED, dw->name, chip);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Create write channels */
> +	INIT_LIST_HEAD(&dw->wr_edma.channels);
> +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +		struct dw_edma_chan *chan = &dw->chan[i];
> +		struct dw_edma_region *dt_region;
> +
> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
> +		if (!dt_region)
> +			return -ENOMEM;
> +
> +		chan->vc.chan.private = dt_region;
> +
> +		chan->chip = chip;
> +		chan->id = i;
> +		chan->dir = EDMA_DIR_WRITE;
> +		chan->configured = false;
> +		chan->request = EDMA_REQ_NONE;
> +		chan->status = EDMA_ST_IDLE;
> +
> +		chan->ll_off = (ll_chunk * i);
> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
> +
> +		chan->dt_off = (dt_chunk * i);
> +
> +		dev_dbg(dev, "L. List:\tChannel write[%u] off=0x%.8lx, max_cnt=%u\n",
> +			i, chan->ll_off, chan->ll_max);
> +
> +		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
> +
> +		dev_dbg(dev, "MSI:\t\tChannel write[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> +			i, chan->msi.address_hi, chan->msi.address_lo,
> +			chan->msi.data);
> +
> +		chan->vc.desc_free = vchan_free_desc;
> +		vchan_init(&chan->vc, &dw->wr_edma);
> +
> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
> +		dt_region->sz = dt_chunk;
> +
> +		dev_dbg(dev, "Data:\tChannel write[%u] off=0x%.8lx\n",
> +			i, chan->dt_off);
> +	}
> +	dma_cap_zero(dw->wr_edma.cap_mask);
> +	dma_cap_set(DMA_SLAVE, dw->wr_edma.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, dw->wr_edma.cap_mask);
> +	dw->wr_edma.directions = BIT(DMA_DEV_TO_MEM);
> +	dw->wr_edma.chancnt = dw->wr_ch_cnt;
> +
> +	/* Create read channels */
> +	INIT_LIST_HEAD(&dw->rd_edma.channels);
> +	for (j = 0; j < dw->rd_ch_cnt; j++, i++) {
> +		struct dw_edma_chan *chan = &dw->chan[i];
> +		struct dw_edma_region *dt_region;
> +
> +		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
> +		if (!dt_region)
> +			return -ENOMEM;
> +
> +		chan->vc.chan.private = dt_region;
> +
> +		chan->chip = chip;
> +		chan->id = j;
> +		chan->dir = EDMA_DIR_READ;
> +		chan->configured = false;
> +		chan->request = EDMA_REQ_NONE;
> +		chan->status = EDMA_ST_IDLE;
> +
> +		chan->ll_off = (ll_chunk * i);
> +		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
> +
> +		chan->dt_off = (dt_chunk * i);
> +
> +		dev_dbg(dev, "L. List:\tChannel read[%u] off=0x%.8lx, max_cnt=%u\n",
> +			j, chan->ll_off, chan->ll_max);
> +
> +		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
> +
> +		dev_dbg(dev, "MSI:\t\tChannel read[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> +			j, chan->msi.address_hi, chan->msi.address_lo,
> +			chan->msi.data);
> +
> +		chan->vc.desc_free = vchan_free_desc;
> +		vchan_init(&chan->vc, &dw->rd_edma);
> +
> +		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
> +		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
> +		dt_region->sz = dt_chunk;
> +
> +		dev_dbg(dev, "Data:\tChannel read[%u] off=0x%.8lx\n",
> +			i, chan->dt_off);
> +	}
> +	dma_cap_zero(dw->rd_edma.cap_mask);
> +	dma_cap_set(DMA_SLAVE, dw->rd_edma.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, dw->rd_edma.cap_mask);
> +	dw->rd_edma.directions = BIT(DMA_MEM_TO_DEV);
> +	dw->rd_edma.chancnt = dw->rd_ch_cnt;
> +
> +	/* Set DMA channels  capabilities */
> +	SET_BOTH_CH(src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
> +	SET_BOTH_CH(dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
> +	SET_BOTH_CH(residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);
> +
> +	SET_BOTH_CH(dev, dev);
> +
> +	SET_BOTH_CH(device_alloc_chan_resources, dw_edma_alloc_chan_resources);
> +	SET_BOTH_CH(device_free_chan_resources, dw_edma_free_chan_resources);
> +
> +	SET_BOTH_CH(device_config, dw_edma_device_config);
> +	SET_BOTH_CH(device_pause, dw_edma_device_pause);
> +	SET_BOTH_CH(device_resume, dw_edma_device_resume);
> +	SET_BOTH_CH(device_terminate_all, dw_edma_device_terminate_all);
> +	SET_BOTH_CH(device_issue_pending, dw_edma_device_issue_pending);
> +	SET_BOTH_CH(device_tx_status, dw_edma_device_tx_status);
> +	SET_BOTH_CH(device_prep_slave_sg, dw_edma_device_prep_slave_sg);
> +	SET_BOTH_CH(device_prep_dma_cyclic, dw_edma_device_prep_dma_cyclic);
> +
> +	/* Power management */
> +	pm_runtime_enable(dev);
> +
> +	/* Register DMA device */
> +	err = dma_async_device_register(&dw->wr_edma);
> +	if (err)
> +		goto err_pm_disable;
> +
> +	err = dma_async_device_register(&dw->rd_edma);
> +	if (err)
> +		goto err_pm_disable;
> +
> +	/* Turn debugfs on */
> +	err = ops->debugfs_on(chip);
> +	if (err) {
> +		dev_err(dev, "unable to create debugfs structure\n");
> +		goto err_pm_disable;
> +	}
> +
> +	dev_info(dev, "DesignWare eDMA controller driver loaded completely\n");
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_disable(dev);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_probe);
> +
> +int dw_edma_remove(struct dw_edma_chip *chip)
> +{
> +	struct dw_edma *dw = chip->dw;
> +	struct device *dev = chip->dev;
> +	const struct dw_edma_core_ops *ops = dw->ops;
> +	struct dw_edma_chan *chan, *_chan;
> +	int i;
> +
> +	/* Disable eDMA */
> +	if (ops)
> +		ops->off(dw);
> +
> +	/* Free irqs */

But devm will automatically free it, no ?

> +	for (i = 0; i < dw->nr_irqs; i++) {
> +		if (pci_irq_vector(to_pci_dev(dev), i) < 0)
> +			continue;
> +
> +		devm_free_irq(dev, pci_irq_vector(to_pci_dev(dev), i), chip);
> +	}
> +
> +	/* Power management */
> +	pm_runtime_disable(dev);
> +
> +	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
> +				 vc.chan.device_node) {
> +		list_del(&chan->vc.chan.device_node);
> +		tasklet_kill(&chan->vc.task);
> +	}
> +
> +	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
> +				 vc.chan.device_node) {
> +		list_del(&chan->vc.chan.device_node);
> +		tasklet_kill(&chan->vc.task);
> +	}
> +
> +	/* Deregister eDMA device */
> +	dma_async_device_unregister(&dw->wr_edma);
> +	dma_async_device_unregister(&dw->rd_edma);
> +
> +	/* Turn debugfs off */
> +	if (ops)
> +		ops->debugfs_off();
> +
> +	dev_info(dev, "DesignWare eDMA controller driver unloaded complete\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_remove);

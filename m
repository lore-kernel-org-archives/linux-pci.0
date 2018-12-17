Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77464C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E05420675
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545029492;
	bh=GC/tcewZD3obc+ZgwWPGcvzzs+IomdJ4iyHXeQ23D34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vpe2DWPSYqFxKm2HCTvZK49WBhTZShTIA5rOS8D6Yz4TkfFYJIni12FA7ICKZicyZ
	 +1OrgmGiJBX/FvW5JzExirAlF7pTLdNRedF3ZwCz+IA/MQVwb9sV6oFxdiwftmmi/m
	 VAnY+Atk73iBi2m/n2ojJBd+WzjcKlY6p0rDh1ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLQGvb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQGvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 01:51:31 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CF520675;
        Mon, 17 Dec 2018 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545029489;
        bh=GC/tcewZD3obc+ZgwWPGcvzzs+IomdJ4iyHXeQ23D34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FV4R95XL5nO+zmWuYeEdKpvqXqmRVp1NtIg9Fabrzi+u2Qc89RZaiZGK+2GxELs3B
         rcjIlhoUwzNwX76AH/G9YkKBIkVBxpYrI6vS1YskKyp1Q+5tdQBJUWq/sUZfpWIiEt
         tB9m9DVNWwjGQd+y0OU66tJfuZQQ/P/0D/i04o7M=
Date:   Mon, 17 Dec 2018 12:21:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20181217065120.GH2472@vkoul-mobl>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12-12-18, 12:13, Gustavo Pimentel wrote:
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

The subsystem name is dmaengine: so please use that tag. If you are not
aware then git log for that subsystem helps you with the patterns
expected

I did a quick look at the patch, I have highlighted few concerns and
they repeat in similar code patterns in this patch

> +#include "dw-edma-core.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +#define DRV_CORE_NAME				"dw-edma-core"

Why is this required?

> +
> +#define SET(reg, name, val)			\
> +	reg.name = val
> +
> +#define SET_BOTH_CH(name, value)		\
> +	do {					\
> +		SET(dw->wr_edma, name, value);	\
> +		SET(dw->rd_edma, name, value);	\
> +	} while (0)

I am not sure how this helps, makes things not explicit..

> +static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma_burst *burst;
> +
> +	burst = kzalloc(sizeof(struct dw_edma_burst), GFP_NOWAIT);
> +	if (unlikely(!burst)) {
> +		dev_err(chan2dev(chan), ": fail to alloc new burst\n");

no need to log mem alloc failures

> +		return NULL;
> +	}
> +
> +	INIT_LIST_HEAD(&burst->list);
> +	burst->sar = 0;
> +	burst->dar = 0;
> +	burst->sz = 0;

you did kzalloc right?

> +
> +	if (chunk->burst) {
> +		atomic_inc(&chunk->bursts_alloc);

why does this need atomic variables?

> +static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_burst *child, *_next;
> +
> +	if (!chunk->burst)
> +		return;
> +
> +	// Remove all the list elements

We dont use C99 style comments, please use 
        /* single line */
and
        /*
         * multi
         * line
         */

> +static void start_transfer(struct dw_edma_chan *chan)
> +{
> +	struct virt_dma_desc *vd;
> +	struct dw_edma_desc *desc;
> +	struct dw_edma_chunk *child, *_next;
> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
> +
> +	vd = vchan_next_desc(&chan->vc);
> +	if (!vd)
> +		return;
> +
> +	desc = vd2dw_edma_desc(vd);
> +	if (!desc)
> +		return;
> +
> +	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
> +		ops->start(child, !desc->xfer_sz);
> +		desc->xfer_sz += child->sz;
> +		dev_dbg(chan2dev(chan),
> +			": transfer of %u bytes started\n", child->sz);
> +
> +		dw_edma_free_burst(child);
> +		if (atomic_read(&child->bursts_alloc))
> +			dev_dbg(chan2dev(chan),
> +				": %d bursts still allocated\n",
> +				atomic_read(&child->bursts_alloc));
> +		list_del(&child->list);
> +		kfree(child);
> +		atomic_dec(&desc->chunks_alloc);
> +
> +		return;
> +	}
> +}
> +
> +static int dw_edma_device_config(struct dma_chan *dchan,
> +				 struct dma_slave_config *config)

please align to preceding brace. Also running checkpatch with --strict
option helps, warning checkpatch is a guidebook and not a rule book!


> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
> +	enum dma_transfer_direction dir;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	if (!config) {
> +		err = -EINVAL;
> +		goto err_config;
> +	}
> +
> +	if (chan->configured) {
> +		dev_err(chan2dev(chan), ": channel already configured\n");
> +		err = -EPERM;
> +		goto err_config;
> +	}
> +
> +	dir = config->direction;

Direction is depreciated, I have already removed the usages, so please
do not add new ones.

You need to take direction for respective prep_ calls

> +	if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
> +		dev_info(chan2dev(chan),
> +			": direction DMA_DEV_TO_MEM (EDMA_DIR_WRITE)\n");
> +		chan->p_addr = config->src_addr;
> +	} else if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
> +		dev_info(chan2dev(chan),
> +			": direction DMA_MEM_TO_DEV (EDMA_DIR_READ)\n");
> +		chan->p_addr = config->dst_addr;
> +	} else {
> +		dev_err(chan2dev(chan), ": invalid direction\n");
> +		err = -EINVAL;
> +		goto err_config;
> +	}

This should be removed

> +
> +	dev_info(chan2dev(chan),
> +		": src_addr(physical) = 0x%.16x\n", config->src_addr);
> +	dev_info(chan2dev(chan),
> +		": dst_addr(physical) = 0x%.16x\n", config->dst_addr);

You have too many logs, it is good for bringup and initial work but not
suited for production.

> +
> +	err = ops->device_config(dchan);

okay what does this callback do. You are already under and dmaengine fwk
so what is the need to add one more abstraction layer, can you explain
that in details please

> +static int dw_edma_device_pause(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	if (!chan->configured) {
> +		dev_err(dchan2dev(dchan), ": channel not configured\n");
> +		err = -EPERM;
> +		goto err_pause;
> +	}
> +
> +	switch (chan->status) {
> +	case EDMA_ST_IDLE:
> +		dev_err(dchan2dev(dchan), ": channel is idle\n");
> +		err = -EPERM;
> +		goto err_pause;
> +	case EDMA_ST_PAUSE:
> +		dev_err(dchan2dev(dchan), ": channel is already paused\n");
> +		err = -EPERM;
> +		goto err_pause;
> +	case EDMA_ST_BUSY:
> +		// Only acceptable state
> +		break;

Doesn't it look as overkill to use switch for single acceptable case.
Why not do

        if (chan->status != EDMA_ST_BUSY) {
                err = -EPERM;
                ...
        }

> +	default:
> +		dev_err(dchan2dev(dchan), ": invalid status state\n");
> +		err = -EINVAL;
> +		goto err_pause;
> +	}
> +
> +	switch (chan->request) {

what is the need to track channel status and channel requests?
-- 
~Vinod

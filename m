Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27684C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF6A206A2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IkzxxNUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbeLQQA5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:00:57 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeLQQA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 11:00:57 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8493B10C07F6;
        Mon, 17 Dec 2018 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545062456; bh=i0DwuaWbPwcCjOWCfAqVJKZAlkKmlkRlZX8qOxuXs7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=IkzxxNUu8OQ0UEhBNAQl7OqrokZH+DZL9axBISzTKzJbsDTIl+O9fjDxK63fmGJgH
         1cG0dNI/6YVaK5KX6tqyP54z1KhTK+R8YJgjGz0fMMqmlLvqwTAdDrajNh8OLXMGgf
         noqPocv2SFRsyInO+GNmI4J+Av6GKq/rPIZVD+/d8SxltV2v1Y+2C5J9vyvcMRLn/E
         Q5eSHHeYfRq01KgULBTIB6eY3LdmRxKUOEiwykK6OyYOUusEdfBkQZuCsDS44Y4adj
         ey+yQrJLqDzNE3vkTZlcPVdJoTnSDv8nDinBE//1g27iMVqCSLULwzwg/4pioQ+6FP
         +YJ4FRMmGgXvw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3E3813DAE;
        Mon, 17 Dec 2018 08:00:56 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Dec 2018 08:00:56 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Dec 2018 17:00:53 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Dec 2018 17:00:53 +0100
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181217065120.GH2472@vkoul-mobl>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
Date:   Mon, 17 Dec 2018 15:56:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217065120.GH2472@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vinod,

On 17/12/2018 06:51, Vinod Koul wrote:
> On 12-12-18, 12:13, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP core driver to kernel.
>>
>> This core driver, initializes and configures the eDMA IP using vma-helpers
>> functions and dma-engine subsystem.
>>
>> Also creates an abstration layer through callbacks allowing different
>> registers mappings in the future, organized in to versions.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA option in kernel configuration,
>> however it requires and selects automatically DMA_ENGINE and
>> DMA_VIRTUAL_CHANNELS option too.
> 
> The subsystem name is dmaengine: so please use that tag. If you are not
> aware then git log for that subsystem helps you with the patterns
> expected

Ok, I'll change all patch description tags. For some reason I got the idea that
this would be the correct tag.

> 
> I did a quick look at the patch, I have highlighted few concerns and
> they repeat in similar code patterns in this patch

Ok, great! Thanks Vinod.

> 
>> +#include "dw-edma-core.h"
>> +#include "../dmaengine.h"
>> +#include "../virt-dma.h"
>> +
>> +#define DRV_CORE_NAME				"dw-edma-core"
> 
> Why is this required?

It's use on devm_request_irq(), requires a name probably for debugging proposes
or to show some output to the user.

> 
>> +
>> +#define SET(reg, name, val)			\
>> +	reg.name = val
>> +
>> +#define SET_BOTH_CH(name, value)		\
>> +	do {					\
>> +		SET(dw->wr_edma, name, value);	\
>> +		SET(dw->rd_edma, name, value);	\
>> +	} while (0)
> 
> I am not sure how this helps, makes things not explicit..

Since this driver has 2 channels (write and read) I'd like to simplify all the
configurations that I've to make on both channels (avoiding any omission), that
why I created this macro.

Should I add some comment on top of this macro or do you think that is better to
replicate the code for each channel?

> 
>> +static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
>> +{
>> +	struct dw_edma_chan *chan = chunk->chan;
>> +	struct dw_edma_burst *burst;
>> +
>> +	burst = kzalloc(sizeof(struct dw_edma_burst), GFP_NOWAIT);
>> +	if (unlikely(!burst)) {
>> +		dev_err(chan2dev(chan), ": fail to alloc new burst\n");
> 
> no need to log mem alloc failures

Ok.

> 
>> +		return NULL;
>> +	}
>> +
>> +	INIT_LIST_HEAD(&burst->list);
>> +	burst->sar = 0;
>> +	burst->dar = 0;
>> +	burst->sz = 0;
> 
> you did kzalloc right?

Nice catch! I don't need those zero initialization, since I use kzalloc. I'll
remove them.

> 
>> +
>> +	if (chunk->burst) {
>> +		atomic_inc(&chunk->bursts_alloc);
> 
> why does this need atomic variables?

Since the variable bursts_alloc can be manipulated through the following
functions: dw_edma_free_desc(), dw_edma_done_interrupt(),
dw_edma_device_resume(), dw_edma_device_issue_pending() and
dw_edma_device_prep_slave_sg() (which can be called in different contexts), I
thought it would be safer to define this variable as atomic.

However looking now, I notice that I don't need it since
dw_edma_done_interrupt(), dw_edma_device_resume() and
dw_edma_device_issue_pending() are protected by a spin lock, however I also
noticed that dw_edma_free_desc() and dw_edma_device_prep_slave_sg() aren't
protected at all. I'll add the spin lock to those functions and replace the
atomic variable bu a u32 type.

> 
>> +static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
>> +{
>> +	struct dw_edma_burst *child, *_next;
>> +
>> +	if (!chunk->burst)
>> +		return;
>> +
>> +	// Remove all the list elements
> 
> We dont use C99 style comments, please use 
>         /* single line */
> and
>         /*
>          * multi
>          * line
>          */

Understood, Bjorn also warned me about that. I'll fix that.

> 
>> +static void start_transfer(struct dw_edma_chan *chan)
>> +{
>> +	struct virt_dma_desc *vd;
>> +	struct dw_edma_desc *desc;
>> +	struct dw_edma_chunk *child, *_next;
>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
>> +
>> +	vd = vchan_next_desc(&chan->vc);
>> +	if (!vd)
>> +		return;
>> +
>> +	desc = vd2dw_edma_desc(vd);
>> +	if (!desc)
>> +		return;
>> +
>> +	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
>> +		ops->start(child, !desc->xfer_sz);
>> +		desc->xfer_sz += child->sz;
>> +		dev_dbg(chan2dev(chan),
>> +			": transfer of %u bytes started\n", child->sz);
>> +
>> +		dw_edma_free_burst(child);
>> +		if (atomic_read(&child->bursts_alloc))
>> +			dev_dbg(chan2dev(chan),
>> +				": %d bursts still allocated\n",
>> +				atomic_read(&child->bursts_alloc));
>> +		list_del(&child->list);
>> +		kfree(child);
>> +		atomic_dec(&desc->chunks_alloc);
>> +
>> +		return;
>> +	}
>> +}
>> +
>> +static int dw_edma_device_config(struct dma_chan *dchan,
>> +				 struct dma_slave_config *config)
> 
> please align to preceding brace. Also running checkpatch with --strict
> option helps, warning checkpatch is a guidebook and not a rule book!

I didn't know that option on the checkpatch script. Cool!
I've fixed some warnings and checks with that option, but there is some false
positives there that I didn't fixed most of them related with macros (reuse and
parenthesis).

> 
> 
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
>> +	enum dma_transfer_direction dir;
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
>> +	if (chan->configured) {
>> +		dev_err(chan2dev(chan), ": channel already configured\n");
>> +		err = -EPERM;
>> +		goto err_config;
>> +	}
>> +
>> +	dir = config->direction;
> 
> Direction is depreciated, I have already removed the usages, so please
> do not add new ones.
> 
> You need to take direction for respective prep_ calls

Ok, I already do that. IMHO I found it strange to have the same information
repeated on two places. But now that you say that this is deprecated, it makes
sense now.

> 
>> +	if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
>> +		dev_info(chan2dev(chan),
>> +			": direction DMA_DEV_TO_MEM (EDMA_DIR_WRITE)\n");
>> +		chan->p_addr = config->src_addr;
>> +	} else if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
>> +		dev_info(chan2dev(chan),
>> +			": direction DMA_MEM_TO_DEV (EDMA_DIR_READ)\n");
>> +		chan->p_addr = config->dst_addr;
>> +	} else {
>> +		dev_err(chan2dev(chan), ": invalid direction\n");
>> +		err = -EINVAL;
>> +		goto err_config;
>> +	}
> 
> This should be removed

Yeah, it was just for validation purposes. Now that direction is deprecated on
the API, makes no sense to validate it.

> 
>> +
>> +	dev_info(chan2dev(chan),
>> +		": src_addr(physical) = 0x%.16x\n", config->src_addr);
>> +	dev_info(chan2dev(chan),
>> +		": dst_addr(physical) = 0x%.16x\n", config->dst_addr);
> 
> You have too many logs, it is good for bringup and initial work but not
> suited for production.

You're right. Andy Shevchenko also warned me about that. I've move pretty all
from info to dbg.

> 
>> +
>> +	err = ops->device_config(dchan);
> 
> okay what does this callback do. You are already under and dmaengine fwk
> so what is the need to add one more abstraction layer, can you explain
> that in details please

This callback just configures the eDMA HW block interrupt address (abort and
done) and data for each channel. This callback could easily moved to the
dw_edma_probe() where each channel is created at first.
Should I do it in your opinion?

> 
>> +static int dw_edma_device_pause(struct dma_chan *dchan)
>> +{
>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>> +	unsigned long flags;
>> +	int err = 0;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	if (!chan->configured) {
>> +		dev_err(dchan2dev(dchan), ": channel not configured\n");
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	}
>> +
>> +	switch (chan->status) {
>> +	case EDMA_ST_IDLE:
>> +		dev_err(dchan2dev(dchan), ": channel is idle\n");
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	case EDMA_ST_PAUSE:
>> +		dev_err(dchan2dev(dchan), ": channel is already paused\n");
>> +		err = -EPERM;
>> +		goto err_pause;
>> +	case EDMA_ST_BUSY:
>> +		// Only acceptable state
>> +		break;
> 
> Doesn't it look as overkill to use switch for single acceptable case.
> Why not do
> 
>         if (chan->status != EDMA_ST_BUSY) {
>                 err = -EPERM;
>                 ...
>         }

The idea behind of this was to have more information about the current state,
but like you said before it's nice for bring up and initial work but not it not
suitable for production. I'll rework it.
> 
>> +	default:
>> +		dev_err(dchan2dev(dchan), ": invalid status state\n");
>> +		err = -EINVAL;
>> +		goto err_pause;
>> +	}
>> +
>> +	switch (chan->request) {
> 
> what is the need to track channel status and channel requests?
> 

Just to avoid mistakes from other driver that would use this driver to transfer
data to/from the device. Maybe I'm being paranoid.


Thanks Vinod for the review!

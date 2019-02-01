Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B9C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 04:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876922184A
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 04:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548994533;
	bh=/uFoG+GGI8zAZ3fYBk52rBU//wyD2K7rQSF0Cu7pJqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=si8nRaXuTgE1UnXyfJW1IJA3fFnA752gFXnYyvL1ohVJVocndC3ECaqlKaeoG6w3X
	 WK4t0L9pG6bDloQKJxhcO7GbyDIAY2vJLsg269gtfcnxLHi2JAMbjJ3P4RrF3zqabl
	 l4WY57TUXZSfsJ1CXQwtApfvaUfEIouCr4qpNUTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfBAEPc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfBAEPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 23:15:32 -0500
Received: from localhost (unknown [171.76.100.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDF220823;
        Fri,  1 Feb 2019 04:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548994531;
        bh=/uFoG+GGI8zAZ3fYBk52rBU//wyD2K7rQSF0Cu7pJqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYUv++NjJLw9lfCgvSQL7bsQKE1iZY4bWLrfgdvSA3w62zRl/5LKK114w9gFVFoLs
         7ps8qaK/k6wamNNmrnK3+RS18SnFQAvkSBERZuuQvznrf6u9hHWDs+93+XyIAy4L5Q
         2dDrcGWyPavCNsR+/mcroHZw8plwbTVcAJIdAdHw=
Date:   Fri, 1 Feb 2019 09:44:00 +0530
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
Message-ID: <20190201041400.GL4635@vkoul-mobl>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190120114425.GV4635@vkoul-mobl>
 <14acfcee-b367-be9c-714b-de0508ff1a7d@synopsys.com>
 <20190123130829.GQ4635@vkoul-mobl>
 <c98718c3-26ec-8e9b-435b-98be7e9bd211@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98718c3-26ec-8e9b-435b-98be7e9bd211@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31-01-19, 11:33, Gustavo Pimentel wrote:
> On 23/01/2019 13:08, Vinod Koul wrote:
> > On 21-01-19, 15:48, Gustavo Pimentel wrote:
> >> On 20/01/2019 11:44, Vinod Koul wrote:
> >>> On 11-01-19, 19:33, Gustavo Pimentel wrote:

> >>>> @@ -0,0 +1,1059 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> >>>
> >>> 2019 now
> >>
> >> I've changed to "Copyright (c) 2018-present Synopsys, Inc. and/or its
> >> affiliates." this way it's always up to date and I also kept 2018, because it
> >> was the date that I started to develop this driver, if you don't mind.
> > 
> > yeah 18 is fine :) it need to end with current year always
> 
> Just to be sure, are you saying that must be: "Copyright (c) 2018-2019 Synopsys,
> Inc. and/or its affiliates."?

Yup :)

> >>>> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> >>>> +{
> >>>> +	struct dw_edma_chan *chan = desc->chan;
> >>>> +	struct dw_edma *dw = chan->chip->dw;
> >>>> +	struct dw_edma_chunk *chunk;
> >>>> +
> >>>> +	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
> >>>> +	if (unlikely(!chunk))
> >>>> +		return NULL;
> >>>> +
> >>>> +	INIT_LIST_HEAD(&chunk->list);
> >>>> +	chunk->chan = chan;
> >>>> +	chunk->cb = !(desc->chunks_alloc % 2);
> >>>
> >>> cb ..?
> >>
> >> CB = change bit, is a property of this eDMA IP. Basically it is a kind of
> >> handshake which serves to validate whether the linked list has been updated or
> >> not, especially useful in cases of recycled linked list elements (every linked
> >> list recycle is a new chunk, this will allow to differentiate each chunk).
> > 
> > okay please add that somewhere. Also it would help me if you explain
> > what is chunk and other terminologies used in this driver
> 
> I'm thinking to put the below description on the patch, please check if this is
> sufficient explicit and clear to understand what this IP needs and does.
> 
> In order to transfer data from point A to B as fast as possible this IP requires
> a dedicated memory space where will reside a linked list of elements.

rephrasing: a dedicated memory space containing linked list of elements

> All elements of this linked list are continuous and each one describes a data
> transfer (source and destination addresses, length and a control variable).
> 
> For the sake of simplicity, lets assume a memory space for channel write 0 which
> allows about 42 elements.
> 
> +---------+
> | Desc #0 |--+
> +---------+  |
>              V
>         +----------+
>         | Chunk #0 |---+
>         |  CB = 1  |   |   +----------+   +-----+   +-----------+   +-----+
>         +----------+   +-->| Burst #0 |-->| ... |-->| Burst #41 |-->| llp |
>               |            +----------+   +-----+   +-----------+   +-----+
>               V
>         +----------+
>         | Chunk #1 |---+
>         |  CB = 0  |   |   +-----------+   +-----+   +-----------+   +-----+
>         +----------+   +-->| Burst #42 |-->| ... |-->| Burst #83 |-->| llp |
>               |            +-----------+   +-----+   +-----------+   +-----+
>               V
>         +----------+
>         | Chunk #2 |---+
>         |  CB = 1  |   |   +-----------+   +-----+   +------------+   +-----+
>         +----------+   +-->| Burst #84 |-->| ... |-->| Burst #125 |-->| llp |
>               |            +-----------+   +-----+   +------------+   +-----+
>               V
>         +----------+
>         | Chunk #3 |---+
>         |  CB = 0  |   |   +------------+   +-----+   +------------+   +-----+
>         +----------+   +-->| Burst #126 |-->| ... |-->| Burst #129 |-->| llp |
>                            +------------+   +-----+   +------------+   +-----+

This is great and required to understand the driver.

How does controller move from Burnst #41 of Chunk 0 to Chunk 1 ?
Is Burst 0 to 129 a link list with Burst 0, 42, 84 and 126 having a
callback (done bit set)..

This sound **very** similar to dw dma concepts!

> 
> Legend:
> 
> *Linked list*, also know as Chunk
> *Linked list element*, also know as Burst
> *CB*, also know as Change Bit, it's a control bit (and typically is toggled)
> that allows to easily identify and differentiate between the current linked list
> and the previous or the next one.
> *LLP*, is a special element that indicates the end of the linked list element
> stream also informs that the next CB should be toggle.
> 
> On scatter-gather transfer mode, the client will submit a scatter-gather list of
> n (on this case 130) elements, that will be divide in multiple Chunks, each
> Chunk will have (on this case 42) a limited number of Bursts and after
> transferring all Bursts, an interrupt will be triggered, which will allow to
> recycle the all linked list dedicated memory again with the new information
> relative to the next Chunk and respective Burst associated and repeat the whole
> cycle again.
> 
> On cyclic transfer mode, the client will submit a buffer pointer, length of it
> and number of repetitions, in this case each burst will correspond directly to
> each repetition.
> 
> Each Burst can describes a data transfer from point A(source) to point
> B(destination) with a length that can be from 1 byte up to 4 GB. Since dedicated
> the memory space where the linked list will reside is limited, the whole n burst
> elements will be organized in several Chunks, that will be used later to recycle
> the dedicated memory space to initiate a new sequence of data transfers.
> 
> The whole transfer is considered has completed when it was transferred all bursts.
> 
> Currently this IP has a set well-known register map, which includes support for
> legacy and unroll modes. Legacy mode is version of this register map that has

whats  unroll..

> multiplexer register that allows to switch registers between all write and read
> channels and the unroll modes repeats all write and read channels registers with
> an offset between them. This register map is called v0.
> 
> The IP team is creating a new register map more suitable to the latest PCIe
> features, that very likely will change the map register, which this version will
> be called v1. As soon as this new version is released by the IP team the support
> for this version in be included on this driver.
> 
> What do you think? There is any gray area that I could clarify?

This sounds good. But we are also catering to a WIP IP which can change
right. Doesnt sound very good idea to me :)

> >>>> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
> >>>> +		&config->src_addr, &config->dst_addr);
> >>>> +
> >>>> +	chan->src_addr = config->src_addr;
> >>>> +	chan->dst_addr = config->dst_addr;
> >>>> +
> >>>> +	err = ops->device_config(dchan);
> >>>
> >>> what does this do?
> >>
> >> This is an initialization procedure to setup interrupts (data and addresses) to
> >> each channel on the eDMA IP,  in order to be triggered after transfer being
> >> completed or aborted. Due the fact the config() can be called at anytime,
> >> doesn't make sense to have this procedure here, I'll moved it to probe().
> > 
> > Yeah I am not still convinced about having another layer! Have you
> > though about using common lib for common parts ..?
> 
> Maybe I'm explaining myself wrongly. I don't have any clue about the new
> register map for the future versions. I honestly tried to implement the common
> lib for the whole process that interact with dma engine controller to ease in
> the future any new addition of register mapping, by having this common callbacks
> that will only be responsible for interfacing the HW accordingly to register map
> version. Maybe I can simplify something in the future, but I only be able to
> conclude that after having some idea about the new register map.
> 
> IMHO I think this is the easier and clean way to do it, in terms of code
> maintenance and architecture, but if you have another idea that you can show me
> or pointing out for a driver that implements something similar, I'm no problem
> to check it out.

That is what my fear was :)

Lets step back and solve one problem at a time. Right now that is v0 of
IP. Please write a simple driver which solve v0 without any layers
involved.

Once v1 is in good shape, you would know what it required and then we
can split v0 driver into common lib and v0 driver and then add v1
driver.


> >>> what is the second part of the check, can you explain that, who sets
> >>> chan->dir?
> >>
> >> The chan->dir is set on probe() during the process of configuring each channel.
> > 
> > So you have channels that are unidirectional?
> 
> Yes. That's one another reason IMHO to keep the dw-edma-test separate from
> dma-test, since this IP is more picky and have this particularities.

That is okay, that should be handled by prep calls, if you get a prep
call for direction you dont support return error and move to next
available one.

That can be done generically in dmatest driver and to answer your
question, yes I would test that :)

> >>>> +int dw_edma_probe(struct dw_edma_chip *chip)
> >>>> +{
> >>>> +	struct dw_edma *dw = chip->dw;
> >>>> +	struct device *dev = chip->dev;
> >>>> +	const struct dw_edma_core_ops *ops;
> >>>> +	size_t ll_chunk = dw->ll_region.sz;
> >>>> +	size_t dt_chunk = dw->dt_region.sz;
> >>>> +	u32 ch_tot;
> >>>> +	int i, j, err;
> >>>> +
> >>>> +	raw_spin_lock_init(&dw->lock);
> >>>> +
> >>>> +	/* Callback operation selection accordingly to eDMA version */
> >>>> +	switch (dw->version) {
> >>>> +	default:
> >>>> +		dev_err(dev, "unsupported version\n");
> >>>> +		return -EPERM;
> >>>> +	}
> >>>
> >>> So we have only one case which returns error, was this code tested?
> >>
> >> Yes it was, but I understand what your point of view.
> >> This was done like this, because I wanna to segment the patch series like this:
> >>  1) Adding eDMA driver core, which contains the driver skeleton and the whole
> >> logic associated.
> >>  2) and 3) Adding the callbacks for the eDMA register mapping version 0 (it will
> >> appear in the future a new version, I thought that this new version would came
> >> while I was trying to get the feedback about this patch series, therefore would
> >> have another 2 patches for the version 1 isolated and independent from the
> >> version 0).
> >>  4) and 5) Adding the PCIe glue-logic and device ID associated.
> >>  6) Adding maintainer for this driver.
> >>  7) Adding a test driver.
> >>
> >> Since this switch will only have the associated case on patch 2, that why on
> >> patch 1 doesn't appear any possibility.
> >>
> >> If you feel logic to squash patch 2 with patch 1, just say something and I'll do
> >> it for you :)
> > 
> > well each patch should build and work on its own, otherwise we get
> > problems :) But since this is a new driver it is okay. Anyway this patch
> > is quite _huge_ so lets not add more to it..
> > 
> > I would have moved the callback check to subsequent one..
> 
> Sorry. I didn't catch this. Can you explain it?

I would have moved these lines to next patch to give them right meaning,
here it feels wrong:

        switch (dw->version) {
        case foo:
                ...
        default:
                ...
        }
-- 
~Vinod

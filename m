Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C19C282C2
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78FF218B0
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JTeAW5X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBFSLb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:11:31 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:56196 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFSLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 13:11:31 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id AF62610C0F4C;
        Wed,  6 Feb 2019 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549476690; bh=s33C18bZNgVhlamyL00mbZBWH0XT40ABhX5DXmDC1X4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=JTeAW5X8X/2+zyII5Fijs7qvqYmazp1kwwR6zqSuve8Alh9JOdREKEtewvQfuhzrU
         dzNBP9W8bp+TywzNTZUTbd3sYAEpHwYbtTMBoQU3fRdw1IHZ1MaiQYoNccuGiMULNL
         fofaIzqsNWWFa5a69XkSmunJTp9t1+V3wTHMzmt50mjQQhTusTc+pTRv8iM6wmmAiU
         CFA8aq+bMhyy1DER6ISevp3VzOEpOd2jRsyi4C+B/AvIDHg7EJRFUNrHAINpf1QXxP
         X65eYoy65Tutpm8QrcPELA0qBbRA7MKK/L5dAyd4i6QHpgf+IgCwJ3uE8d4loXq9z2
         1txM9ARdl91rQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 967BBA005A;
        Wed,  6 Feb 2019 18:11:29 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Feb 2019 10:11:29 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Feb 2019 19:11:27 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Feb 2019 19:11:26 +0100
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
 <14acfcee-b367-be9c-714b-de0508ff1a7d@synopsys.com>
 <20190123130829.GQ4635@vkoul-mobl>
 <c98718c3-26ec-8e9b-435b-98be7e9bd211@synopsys.com>
 <20190201041400.GL4635@vkoul-mobl>
 <aceb7b5a-54ec-d501-74a1-d1396e221c84@synopsys.com>
 <20190202100735.GD4296@vkoul-mobl>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e8cbba52-ce74-5baf-d319-3e27ce46d1f8@synopsys.com>
Date:   Wed, 6 Feb 2019 18:06:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190202100735.GD4296@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/02/2019 10:07, Vinod Koul wrote:
> On 01-02-19, 11:23, Gustavo Pimentel wrote:
>> On 01/02/2019 04:14, Vinod Koul wrote:
>>> On 31-01-19, 11:33, Gustavo Pimentel wrote:
>>>> On 23/01/2019 13:08, Vinod Koul wrote:
>>>>> On 21-01-19, 15:48, Gustavo Pimentel wrote:
>>>>>> On 20/01/2019 11:44, Vinod Koul wrote:
>>>>>>> On 11-01-19, 19:33, Gustavo Pimentel wrote:
>>>
>>>>>>>> @@ -0,0 +1,1059 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>> +/*
>>>>>>>> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
>>>>>>>
>>>>>>> 2019 now
>>>>>>
>>>>>> I've changed to "Copyright (c) 2018-present Synopsys, Inc. and/or its
>>>>>> affiliates." this way it's always up to date and I also kept 2018, because it
>>>>>> was the date that I started to develop this driver, if you don't mind.
>>>>>
>>>>> yeah 18 is fine :) it need to end with current year always
>>>>
>>>> Just to be sure, are you saying that must be: "Copyright (c) 2018-2019 Synopsys,
>>>> Inc. and/or its affiliates."?
>>>
>>> Yup :)
>>>
>>>>>>>> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
>>>>>>>> +{
>>>>>>>> +	struct dw_edma_chan *chan = desc->chan;
>>>>>>>> +	struct dw_edma *dw = chan->chip->dw;
>>>>>>>> +	struct dw_edma_chunk *chunk;
>>>>>>>> +
>>>>>>>> +	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
>>>>>>>> +	if (unlikely(!chunk))
>>>>>>>> +		return NULL;
>>>>>>>> +
>>>>>>>> +	INIT_LIST_HEAD(&chunk->list);
>>>>>>>> +	chunk->chan = chan;
>>>>>>>> +	chunk->cb = !(desc->chunks_alloc % 2);
>>>>>>>
>>>>>>> cb ..?
>>>>>>
>>>>>> CB = change bit, is a property of this eDMA IP. Basically it is a kind of
>>>>>> handshake which serves to validate whether the linked list has been updated or
>>>>>> not, especially useful in cases of recycled linked list elements (every linked
>>>>>> list recycle is a new chunk, this will allow to differentiate each chunk).
>>>>>
>>>>> okay please add that somewhere. Also it would help me if you explain
>>>>> what is chunk and other terminologies used in this driver
>>>>
>>>> I'm thinking to put the below description on the patch, please check if this is
>>>> sufficient explicit and clear to understand what this IP needs and does.
>>>>
>>>> In order to transfer data from point A to B as fast as possible this IP requires
>>>> a dedicated memory space where will reside a linked list of elements.
>>>
>>> rephrasing: a dedicated memory space containing linked list of elements
>>>
>>>> All elements of this linked list are continuous and each one describes a data
>>>> transfer (source and destination addresses, length and a control variable).
>>>>
>>>> For the sake of simplicity, lets assume a memory space for channel write 0 which
>>>> allows about 42 elements.
>>>>
>>>> +---------+
>>>> | Desc #0 |--+
>>>> +---------+  |
>>>>              V
>>>>         +----------+
>>>>         | Chunk #0 |---+
>>>>         |  CB = 1  |   |   +----------+   +-----+   +-----------+   +-----+
>>>>         +----------+   +-->| Burst #0 |-->| ... |-->| Burst #41 |-->| llp |
>>>>               |            +----------+   +-----+   +-----------+   +-----+
>>>>               V
>>>>         +----------+
>>>>         | Chunk #1 |---+
>>>>         |  CB = 0  |   |   +-----------+   +-----+   +-----------+   +-----+
>>>>         +----------+   +-->| Burst #42 |-->| ... |-->| Burst #83 |-->| llp |
>>>>               |            +-----------+   +-----+   +-----------+   +-----+
>>>>               V
>>>>         +----------+
>>>>         | Chunk #2 |---+
>>>>         |  CB = 1  |   |   +-----------+   +-----+   +------------+   +-----+
>>>>         +----------+   +-->| Burst #84 |-->| ... |-->| Burst #125 |-->| llp |
>>>>               |            +-----------+   +-----+   +------------+   +-----+
>>>>               V
>>>>         +----------+
>>>>         | Chunk #3 |---+
>>>>         |  CB = 0  |   |   +------------+   +-----+   +------------+   +-----+
>>>>         +----------+   +-->| Burst #126 |-->| ... |-->| Burst #129 |-->| llp |
>>>>                            +------------+   +-----+   +------------+   +-----+
>>>
>>> This is great and required to understand the driver.
>>>
>>> How does controller move from Burnst #41 of Chunk 0 to Chunk 1 ?
>>
>> I forgot to explain that...
>>
>> On every last Burst of the Chunk (Burst #41, Burst #83, Burst #125 or even Burst
>> #129) is set some flags on their control variable (RIE and LIE bits) that will
>> trigger the send of "done" interruption.
>>
>> On the interruptions callback, is decided whether to recycle the linked list
>> memory space by writing a new set of Bursts elements (if still exists Chunks to
>> transfer) or is considered completed (if there is no Chunks available to transfer)
>>
>>> Is Burst 0 to 129 a link list with Burst 0, 42, 84 and 126 having a
>>> callback (done bit set)..
>>
>> I didn't quite understand it your question.
>>
>> It comes from the prep_slave_sg n elements (130 applying the example), where
>> will be divide in several Chunks (#0, #1, #2, #3 and #4 applying the example) (a
>> linked list that will contain another linked list for the Bursts, CB, Chunk
>> size). The linked list inside of each Chunk will contain a number of Bursts
>> (limited to the memory space size), each one will possess Source Address,
>> Destination Address and size of that sub-transfer.
> 
> Thanks this helps :)
> 
> so in this case what does prep_slave_sg n elements corrosponds to (130
> bursts) ..? If so how do you split a transaction to chunks and bursts?

In the example case, prep_slave_sg API receives a total of 130 elements and the
dw-edma-core implementation will slice in 4 chunks (the first 3 chunks will
containing 42 bursts each and the last chunk only containing 4 bursts).

The burst maximum capacity of each chunk depends of the linked list memory space
size available or destined for, in the example case I didn't specify the
actually space amount, but the maximum number of bursts is calculated by:

maximum number of bursts = (linked list memory size / 24) - 1

the size is in bytes and 24 is the size of each burst information element.
It's also subtracted 1 element because on the end of each burst stream is needed
the llp element and for simplicity it's size is considered to be equal to the
burst element.

> 
> 
>>
>>>
>>> This sound **very** similar to dw dma concepts!
>>
>> I believe some parts of dw dma and dw edma behavior are similar and that makes
>> perfectly sense since both dma are done by Synopsys and may be exist a shared
>> knowledge, however they are different IPs applied to different products.
>>
>>>
>>>>
>>>> Legend:
>>>>
>>>> *Linked list*, also know as Chunk
>>>> *Linked list element*, also know as Burst
>>>> *CB*, also know as Change Bit, it's a control bit (and typically is toggled)
>>>> that allows to easily identify and differentiate between the current linked list
>>>> and the previous or the next one.
>>>> *LLP*, is a special element that indicates the end of the linked list element
>>>> stream also informs that the next CB should be toggle.
>>>>
>>>> On scatter-gather transfer mode, the client will submit a scatter-gather list of
>>>> n (on this case 130) elements, that will be divide in multiple Chunks, each
>>>> Chunk will have (on this case 42) a limited number of Bursts and after
>>>> transferring all Bursts, an interrupt will be triggered, which will allow to
>>>> recycle the all linked list dedicated memory again with the new information
>>>> relative to the next Chunk and respective Burst associated and repeat the whole
>>>> cycle again.
>>>>
>>>> On cyclic transfer mode, the client will submit a buffer pointer, length of it
>>>> and number of repetitions, in this case each burst will correspond directly to
>>>> each repetition.
>>>>
>>>> Each Burst can describes a data transfer from point A(source) to point
>>>> B(destination) with a length that can be from 1 byte up to 4 GB. Since dedicated
>>>> the memory space where the linked list will reside is limited, the whole n burst
>>>> elements will be organized in several Chunks, that will be used later to recycle
>>>> the dedicated memory space to initiate a new sequence of data transfers.
>>>>
>>>> The whole transfer is considered has completed when it was transferred all bursts.
>>>>
>>>> Currently this IP has a set well-known register map, which includes support for
>>>> legacy and unroll modes. Legacy mode is version of this register map that has
>>>
>>> whats  unroll..
>>>
>>>> multiplexer register that allows to switch registers between all write and read
>>
>> The unroll is explained here, see below
>>
>>>> channels and the unroll modes repeats all write and read channels registers with
>>>> an offset between them. This register map is called v0.
>>>>
>>>> The IP team is creating a new register map more suitable to the latest PCIe
>>>> features, that very likely will change the map register, which this version will
>>>> be called v1. As soon as this new version is released by the IP team the support
>>>> for this version in be included on this driver.
>>>>
>>>> What do you think? There is any gray area that I could clarify?
>>>
>>> This sounds good. But we are also catering to a WIP IP which can change
>>> right. Doesnt sound very good idea to me :)
>>
>> This IP exists for several years like this and it works quite fine, however
>> because of new features and requests (SR-IOV, more dma channels, function
>> segregation and isolation, performance improvement) that are coming it's natural
>> to have exist improvements. The drivers should follow the evolution and be
>> sufficient robust enough to adapt to this new circumstance.
> 
> Kernel driver should be modular be design, if we keep things simple then
> adding/splitting to support future revisions should be easy!
> 
>>>>>>>> +	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
>>>>>>>> +		&config->src_addr, &config->dst_addr);
>>>>>>>> +
>>>>>>>> +	chan->src_addr = config->src_addr;
>>>>>>>> +	chan->dst_addr = config->dst_addr;
>>>>>>>> +
>>>>>>>> +	err = ops->device_config(dchan);
>>>>>>>
>>>>>>> what does this do?
>>>>>>
>>>>>> This is an initialization procedure to setup interrupts (data and addresses) to
>>>>>> each channel on the eDMA IP,  in order to be triggered after transfer being
>>>>>> completed or aborted. Due the fact the config() can be called at anytime,
>>>>>> doesn't make sense to have this procedure here, I'll moved it to probe().
>>>>>
>>>>> Yeah I am not still convinced about having another layer! Have you
>>>>> though about using common lib for common parts ..?
>>>>
>>>> Maybe I'm explaining myself wrongly. I don't have any clue about the new
>>>> register map for the future versions. I honestly tried to implement the common
>>>> lib for the whole process that interact with dma engine controller to ease in
>>>> the future any new addition of register mapping, by having this common callbacks
>>>> that will only be responsible for interfacing the HW accordingly to register map
>>>> version. Maybe I can simplify something in the future, but I only be able to
>>>> conclude that after having some idea about the new register map.
>>>>
>>>> IMHO I think this is the easier and clean way to do it, in terms of code
>>>> maintenance and architecture, but if you have another idea that you can show me
>>>> or pointing out for a driver that implements something similar, I'm no problem
>>>> to check it out.
>>>
>>> That is what my fear was :)
>>>
>>> Lets step back and solve one problem at a time. Right now that is v0 of
>>> IP. Please write a simple driver which solve v0 without any layers
>>> involved.
>>>
>>> Once v1 is in good shape, you would know what it required and then we
>>> can split v0 driver into common lib and v0 driver and then add v1
>>> driver.
>>
>> Can I keep the code segregation as it is now? With the dw-edma-v0-core.c/h,
>> dw-edma-v0-debugfs.c/h and dw-edma-v0-regs.h
>>
>> That way I would only replace the callbacks calls to direct function calls and
>> remove the switch case callback selection base on the version.
> 
> That sound better, please keep patches smallish (anything going more
> than 600 lines becomes harder to review) and logically split.
> 
>>>>>>> what is the second part of the check, can you explain that, who sets
>>>>>>> chan->dir?
>>>>>>
>>>>>> The chan->dir is set on probe() during the process of configuring each channel.
>>>>>
>>>>> So you have channels that are unidirectional?
>>>>
>>>> Yes. That's one another reason IMHO to keep the dw-edma-test separate from
>>>> dma-test, since this IP is more picky and have this particularities.
>>>
>>> That is okay, that should be handled by prep calls, if you get a prep
>>> call for direction you dont support return error and move to next
>>> available one.
>>>
>>> That can be done generically in dmatest driver and to answer your
>>> question, yes I would test that :)
>>
>> Like you said, let do this in small steps. For now I would like to suggest to
>> leave out the dw-dma-test driver and just focus on the current driver, if you
>> don't mind. I never thought that his test driver would raise this kind of discuss.
> 
> Well dmatest is just a testing aid and doesnt care about internal
> designs of your driver. I would say keep it as it is useful aid and will
> help other folks as well :)
> 

Let's see, I honestly hope so...

Gustavo

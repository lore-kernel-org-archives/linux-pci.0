Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B53C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E820657
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CL2juzBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfAPOGz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:06:55 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:51610 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfAPOGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 09:06:55 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F87A24E21E0;
        Wed, 16 Jan 2019 06:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547647615; bh=nuYid/MPdLAjZvon8pDX1xdHMs9K8I43TIZLXDe8T9U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=CL2juzBpC95hm7xkoVVCvOz58ti5K35MxlkiC0jSM1WpKyuLettlkZWbbRcj92VYz
         qmn1iNxkrtGZj6ELZpEqQn8BDMFWGdKqstK7IuB5D3z2NebGxaWdtcvfbAWcVc/P8u
         Bsk5cmKxPBX+RUmWD4eFlz1X8ZuXATiVV9B18vIX5sddKXZq33YX93Je3PxuVSisI0
         IpNlIrd2Fj9RKlQ7F4aA4jYq6QXAc6IqinWgTDxoXxFAVOA6FNA2RgzKutSEeYT/6H
         SIM1SRh/X8v4TFCWtRoBUzbCVdAsM27h5905EbDtE43uaxQ2AAcGaFgXbW4du+nJw6
         2p7Sg4bchGR4A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 627985562;
        Wed, 16 Jan 2019 06:06:54 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 06:06:54 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 15:06:52 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 15:06:51 +0100
Subject: Re: [RFC v3 2/7] dmaengine: Add Synopsys eDMA IP version 0 support
To:     Jose Abreu <jose.abreu@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <eb8fee407dbeb515100a2039d1b3464ce12452d4.1547230339.git.gustavo.pimentel@synopsys.com>
 <c7c2ff4a-5766-d829-ac3f-43fc280a457a@synopsys.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5fbdc016-138c-ced0-4dd5-9791bee9d34c@synopsys.com>
Date:   Wed, 16 Jan 2019 14:02:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c7c2ff4a-5766-d829-ac3f-43fc280a457a@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jose,

On 16/01/2019 10:33, Jose Abreu wrote:
> Hi Gustavo,
> 
> On 1/11/2019 6:33 PM, Gustavo Pimentel wrote:
>> Add support for the eDMA IP version 0 driver for both register maps (legacy
>> and unroll).
>>
>> The legacy register mapping was the initial implementation, which consisted
>> in having all registers belonging to channels multiplexed, which could be
>> change anytime (which could led a race-condition) by view port register
>> (access to only one channel available each time).
>>
>> This register mapping is not very effective and efficient in a multithread
>> environment, which has led to the development of unroll registers mapping,
>> which consists of having all channels registers accessible any time by
>> spreading all channels registers by an offset between them.
>>
>> This version supports a maximum of 16 independent channels (8 write +
>> 8 read), which can run simultaneously.
>>
>> Implements a scatter-gather transfer through a linked list, where the size
>> of linked list depends on the allocated memory divided equally among all
>> channels.
>>
>> Each linked list descriptor can transfer from 1 byte to 4 Gbytes and is
>> alignmented to DWORD.
>>
>> Both SAR (Source Address Register) and DAR (Destination Address Register)
>> are alignmented to byte.
>>
>> Changes:
>> RFC v1->RFC v2:
>>  - Replace comments // (C99 style) by /**/
>>  - Replace magic numbers by defines
>>  - Replace boolean return from ternary operation by a double negation
>>    operation
>>  - Replace QWORD_HI/QWORD_LO macros by upper_32_bits()/lower_32_bits()
>>  - Fix the headers of the .c and .h files according to the most recent
>>    convention
>>  - Fix errors and checks pointed out by checkpatch with --strict option
>>  - Replace patch small description tag from dma by dmaengine
>>  - Refactor code to replace atomic_t by u32 variable type
>> RFC v2->RFC v3:
>>  - Code rewrite to use FIELD_PREP() and FIELD_GET()
>>  - Add define to magic numbers
>>  - Fix minor bugs
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Russell King <rmk+kernel@armlinux.org.uk>
>> Cc: Niklas Cassel <niklas.cassel@linaro.org>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> Cc: Jose Abreu <jose.abreu@synopsys.com>
>> Cc: Luis Oliveira <lolivei@synopsys.com>
>> Cc: Vitor Soares <vitor.soares@synopsys.com>
>> Cc: Nelson Costa <nelson.costa@synopsys.com>
>> Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
> 
>> +void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>> +{
>> +	struct dw_edma_chan *chan = chunk->chan;
>> +	struct dw_edma *dw = chan->chip->dw;
>> +	u32 tmp;
>> +	u64 llp;
>> +
>> +	dw_edma_v0_core_write_chunk(chunk);
>> +
>> +	if (first) {
>> +		/* Enable engine */
>> +		SET_RW(dw, chan->dir, engine_en, BIT(0));
>> +		/* Interrupt unmask - done, abort */
>> +		tmp = GET_RW(dw, chan->dir, int_mask);
>> +		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>> +		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
>> +		SET_RW(dw, chan->dir, int_mask, tmp);
>> +		/* Linked list error */
>> +		tmp = GET_RW(dw, chan->dir, linked_list_err_en);
>> +		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
>> +		SET_RW(dw, chan->dir, linked_list_err_en, tmp);
>> +		/* Channel control */
>> +		SET_CH(dw, chan->dir, chan->id, ch_control1,
>> +		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>> +		/* Linked list - low, high */
>> +		llp = cpu_to_le64(chunk->ll_region.paddr);
>> +		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
>> +		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
>> +	}
>> +	/* Doorbell */
> 
> Not sure if DMA subsystem does this but maybe you need some kind
> of barrier to ensure everything is coherent before granting
> control to eDMA ?

Each readl and writel inside of helper macros (SET_RW/GETRW and SET_CH/GET_CH)
has a memory barrier, that grants that the coherency, however this is platform
dependent.

> 
>> +	SET_RW(dw, chan->dir, doorbell,
>> +	       FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
>> +}
>> +

Thanks!

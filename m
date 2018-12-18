Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13ADC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651A82184A
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DmNAAPYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLRLCd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:33 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37358 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRLCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 06:02:32 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4F2B910C1D89;
        Tue, 18 Dec 2018 03:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545130952; bh=MkWyqMTdRZI7it6cdx8HpeWTaFv72bZI8zT1LRcTRUI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=DmNAAPYMbv+ssq+GF+3/NNaQ+7zGSS29DM0FY6ku7L1BWuEdki/4sVKqmx8Ky2qoF
         DDnJ7e4f9ENvNtNBdqcjiVhRzdthmENAub8bwjak/5EyE2BTiOpHPl4B0/rHruR5/O
         a+klS2hTU8xWXLWW8JvvtA+XOw9AXHBPaOz7zwG4PrGT5CMj5cDQLJANm41A06fHmH
         w9jRQ5H4Wzfbb0KPqwHvhnTeY3z53pY/kuomuQdZQRai0KAxu2EI04e5XFthZCyjXj
         EqigQIGIZNPYA1nSyJjcZySLOLbIDLlE0S8Uu3w5ULlds5YuseeRGA0B9Fq2QvyvCK
         ZzcbNerBDmhJw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3601B390E;
        Tue, 18 Dec 2018 03:02:32 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 03:02:32 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 12:02:29 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 12:02:29 +0100
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
 <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
 <20181218035438.GO2472@vkoul-mobl>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <63b25f88-e993-e786-6b6f-e610916936f3@synopsys.com>
Date:   Tue, 18 Dec 2018 10:58:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218035438.GO2472@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 18/12/2018 03:54, Vinod Koul wrote:
> On 17-12-18, 15:56, Gustavo Pimentel wrote:
> 
>>>> +
>>>> +#define SET(reg, name, val)			\
>>>> +	reg.name = val
>>>> +
>>>> +#define SET_BOTH_CH(name, value)		\
>>>> +	do {					\
>>>> +		SET(dw->wr_edma, name, value);	\
>>>> +		SET(dw->rd_edma, name, value);	\
>>>> +	} while (0)
>>>
>>> I am not sure how this helps, makes things not explicit..
>>
>> Since this driver has 2 channels (write and read) I'd like to simplify all the
>> configurations that I've to make on both channels (avoiding any omission), that
>> why I created this macro.
> 
> So in order to configure a channel you need to write to both?

No. Let me show you in a different point of view. I think we're talking about
different things.

On dw_edma_probe() ~ line 755

I've this:

SET_BOTH_CH(src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET_BOTH_CH(dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET_BOTH_CH(residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);

SET_BOTH_CH(dev, chip->dev);

SET_BOTH_CH(device_alloc_chan_resources, dw_edma_alloc_chan_resources);
SET_BOTH_CH(device_free_chan_resources, dw_edma_free_chan_resources);

SET_BOTH_CH(device_config, dw_edma_device_config);
SET_BOTH_CH(device_pause, dw_edma_device_pause);
SET_BOTH_CH(device_resume, dw_edma_device_resume);
SET_BOTH_CH(device_terminate_all, dw_edma_device_terminate_all);
SET_BOTH_CH(device_issue_pending, dw_edma_device_issue_pending);
SET_BOTH_CH(device_tx_status, dw_edma_device_tx_status);
SET_BOTH_CH(device_prep_slave_sg, dw_edma_device_prep_slave_sg);

which is equivalent to do this:

SET(dw->wr_edma, src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET(dw->rd_edma, src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET(dw->wr_edma, dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET(dw->rd_edma, dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
SET(dw->wr_edma, residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);
SET(dw->rd_edma, residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);

SET(dw->wr_edma, dev, chip->dev);
SET(dw->rd_edma, dev, chip->dev);

SET(dw->wr_edma, device_alloc_chan_resources, dw_edma_alloc_chan_resources);
SET(dw->rd_edma, device_alloc_chan_resources, dw_edma_alloc_chan_resources);
SET(dw->wr_edma, device_free_chan_resources, dw_edma_free_chan_resources);
SET(dw->rd_edma, device_free_chan_resources, dw_edma_free_chan_resources);

SET(dw->wr_edma, device_config, dw_edma_device_config);
SET(dw->rd_edma, device_config, dw_edma_device_config);
SET(dw->wr_edma, device_pause, dw_edma_device_pause);
SET(dw->rd_edma, device_pause, dw_edma_device_pause);
SET(dw->wr_edma, device_resume, dw_edma_device_resume);
SET(dw->rd_edma, device_resume, dw_edma_device_resume);
SET(dw->wr_edma, device_terminate_all, dw_edma_device_terminate_all);
SET(dw->rd_edma, device_terminate_all, dw_edma_device_terminate_all);
SET(dw->wr_edma, device_issue_pending, dw_edma_device_issue_pending);
SET(dw->rd_edma, device_issue_pending, dw_edma_device_issue_pending);
SET(dw->wr_edma, device_tx_status, dw_edma_device_tx_status);
SET(dw->rd_edma, device_tx_status, dw_edma_device_tx_status);
SET(dw->wr_edma, device_prep_slave_sg, dw_edma_device_prep_slave_sg);
SET(dw->rd_edma, device_prep_slave_sg, dw_edma_device_prep_slave_sg);

What you type of coding style do prefer in your opinion?
I only created the macro to simplify the visual coding view of those operations.

> 
>> Should I add some comment on top of this macro or do you think that is better to
>> replicate the code for each channel?
> 
> That will help to explain..
> 
>>>> +
>>>> +	err = ops->device_config(dchan);
>>>
>>> okay what does this callback do. You are already under and dmaengine fwk
>>> so what is the need to add one more abstraction layer, can you explain
>>> that in details please
>>
>> This callback just configures the eDMA HW block interrupt address (abort and
>> done) and data for each channel. This callback could easily moved to the
>> dw_edma_probe() where each channel is created at first.
>> Should I do it in your opinion?
> 
> My question is about callbacks in this driver in general. You are
> already under a dmaengine fwk, so this is adding one more layer on top
> with callbacks implementing low level stiff. Why do we need another layer
> is the question..

Feel free to ask anytime.

I created a second layer, because I've knowledge that will be necessary to
implement in the future several eDMA registers mapping versions, which may or
may not require a different handling, that's why I created that layer.

Gustavo

> 


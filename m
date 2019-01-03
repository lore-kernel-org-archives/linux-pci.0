Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4DEC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA44720883
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 09:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PkRML02F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfACJ5y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:57:54 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59284 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfACJ5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2019 04:57:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5AF4824E0AE4;
        Thu,  3 Jan 2019 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546509473; bh=PH1Y44Rwd1QV4cqSGbmcCOuFd68kwM1T+8SypyFqCuA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To:From;
        b=PkRML02FV8JLSdQhZ1OTaFnIoIzWSUZSA3q7qS2NAXn0qyI9oIcl+epH3RvXCLWwi
         SC+xEysdxEMRksuzq627y5ORglkj4YXWRbB/CBUXSqDwqXMmoNTyWVIJsIbNf2Vu7G
         phMZgG2XiFus7zQnKhhoMS9klN1hrkIUcD6uWRvlXKBu8DzsYghoubsF+BzXoqUhZk
         KvqUEgsXUfi60a13Lco0puENsJNwTTkfpfbZT1ugVaJ0PtyawcGSuZqhHef8beDXWX
         yEBhP20gg9HhteKbwJH0j0ktn4E/ffefCpEy1XN5A2/aG5a0nKWATYSMEg1Tj1GS6P
         qr+8HghuKW2DQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4369A370E;
        Thu,  3 Jan 2019 01:57:53 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 01:57:53 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 10:57:51 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 10:57:50 +0100
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
Message-ID: <256fef2b-0dea-edee-396a-353520159005@synopsys.com>
Date:   Thu, 3 Jan 2019 09:53:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vinod,

(snipped)

>>> +{
>>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
>>> +	enum dma_transfer_direction dir;
>>> +	unsigned long flags;
>>> +	int err = 0;
>>> +
>>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>>> +
>>> +	if (!config) {
>>> +		err = -EINVAL;
>>> +		goto err_config;
>>> +	}
>>> +
>>> +	if (chan->configured) {
>>> +		dev_err(chan2dev(chan), ": channel already configured\n");
>>> +		err = -EPERM;
>>> +		goto err_config;
>>> +	}
>>> +
>>> +	dir = config->direction;
>>
>> Direction is depreciated, I have already removed the usages, so please
>> do not add new ones.
>>
>> You need to take direction for respective prep_ calls
> 
> Ok, I already do that. IMHO I found it strange to have the same information
> repeated on two places. But now that you say that this is deprecated, it makes
> sense now.
> 
>>
>>> +	if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
>>> +		dev_info(chan2dev(chan),
>>> +			": direction DMA_DEV_TO_MEM (EDMA_DIR_WRITE)\n");
>>> +		chan->p_addr = config->src_addr;
>>> +	} else if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
>>> +		dev_info(chan2dev(chan),
>>> +			": direction DMA_MEM_TO_DEV (EDMA_DIR_READ)\n");
>>> +		chan->p_addr = config->dst_addr;
>>> +	} else {
>>> +		dev_err(chan2dev(chan), ": invalid direction\n");
>>> +		err = -EINVAL;
>>> +		goto err_config;
>>> +	}
>>
>> This should be removed
> 
> Yeah, it was just for validation purposes. Now that direction is deprecated on
> the API, makes no sense to validate it.
> 
>>
>>> +
>>> +	dev_info(chan2dev(chan),
>>> +		": src_addr(physical) = 0x%.16x\n", config->src_addr);
>>> +	dev_info(chan2dev(chan),
>>> +		": dst_addr(physical) = 0x%.16x\n", config->dst_addr);
>>

I've a doubt now. As you know, for a DMA transfer you need the source and
destination addresses, which in the limited can be swapped according to the
direction MEM_TO_DEV/DEV_TO_MEM case.

For the sake of simplicity, I'll just consider now the MEM_TO_DEV case, since
the other case is similar but the source and destination address are swapped.

In my code I can get some of the information that I need by using the
sg_dma_address() in the scatter-gather list (which gives me the source address).

The remaining information I got from here, using the direction to help me to
select which address I'll use later on the DMA transfer, in this case the
destination address.

Since this is deprecated how should I proceed? How can I get that information?
There is some similar function to sg_dma_address() that could give me the
destination address?

Regards,
Gustavo

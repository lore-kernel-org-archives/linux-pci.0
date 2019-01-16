Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3C5C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA764206C2
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 12:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iG2mxDB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbfAPMBF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:01:05 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:48152 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390001AbfAPMBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 07:01:04 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 79B3A24E0600;
        Wed, 16 Jan 2019 04:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547640064; bh=XhTYBVG0GNTpvdt/A6CyJAYXyqExqLZEAX3Sa7dxaFg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=iG2mxDB4LMgVRHryJEAmELGy+EG9JRrP8BiMf/iS3DhD5nqPAHKet0tL4LT7Bnp0t
         aPBznLJNgG+qxRTR/Xdz5iMnhcaArvlNMgaofjRfM4FbvLGiAweutG9KKnZ0ztoQfg
         vB4kQo6dMh/UHHledYJ8Ar8Hffy8OhhV+F0spvObA6dRmzkXRt8fjS8KfS6SCH1YPl
         9y7GK/uQ5jxHpSkhIW7x9VWNBvamJ+tl44LNEJcGt3tJ1L57X/RYKC5rnQCteUHK3S
         Le5XAsS+C6qfWi//+LEZm4jn6b03JHNIhGxRHXfjTG/sUDTCQF3inv82qTW63a/w+2
         4APxFRG/ibCsg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5FD295D5D;
        Wed, 16 Jan 2019 04:01:04 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 04:01:04 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 13:01:02 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 13:01:02 +0100
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
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
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        "Pedro Sousa" <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <1876fee2-9f8c-925c-a9ab-cf69fe6693a1@synopsys.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <488fda69-6e92-00ae-a5f2-2fe099a0ac8f@synopsys.com>
Date:   Wed, 16 Jan 2019 11:56:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1876fee2-9f8c-925c-a9ab-cf69fe6693a1@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jose,

On 16/01/2019 10:45, Jose Abreu wrote:
> Hi Gustavo,
> 
> On 1/11/2019 6:33 PM, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP test and sample driver to be use for testing
>> purposes and also as a reference for any developer who needs to
>> implement and use Synopsys eDMA.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA_TEST option in kernel
>> configuration, however it requires and selects automatically DW_EDMA
>> option too.
>>
>> Changes:
>> RFC v1->RFC v2:
>>  - No changes
>> RFC v2->RFC v3:
>>  - Add test module
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
>> +static int dw_edma_test_add_channel(struct dw_edma_test_info *info,
>> +				    struct dma_chan *chan,
>> +				    u32 channel)
>> +{
>> +	struct dw_edma_test_params *params = &info->params;
>> +	struct dw_edma_test_thread *thread;
>> +	struct dw_edma_test_chan *tchan;
>> +
>> +	tchan = kvmalloc(sizeof(*tchan), GFP_KERNEL);
>> +	if (!tchan)
>> +		return -ENOMEM;
>> +
>> +	tchan->chan = chan;
>> +
>> +	thread = kvzalloc(sizeof(*thread), GFP_KERNEL);
>> +	if (!thread) {
>> +		kvfree(tchan);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	thread->info = info;
>> +	thread->chan = tchan->chan;
>> +	switch (channel) {
>> +	case EDMA_CH_WR:
>> +		thread->direction = DMA_DEV_TO_MEM;
>> +		break;
>> +	case EDMA_CH_RD:
>> +		thread->direction = DMA_MEM_TO_DEV;
>> +		break;
>> +	default:
>> +		kvfree(tchan);
> 
> You are leaking thread here.

Yes, indeed.

> 
>> +		return -EPERM;
>> +	}
>> +	thread->test_done.wait = &thread->done_wait;
>> +	init_waitqueue_head(&thread->done_wait);
>> +
>> +	if (!params->repetitions)
>> +		thread->task = kthread_create(dw_edma_test_sg, thread, "%s",
>> +					      dma_chan_name(chan));
>> +	else
>> +		thread->task = kthread_create(dw_edma_test_cyclic, thread, "%s",
>> +					      dma_chan_name(chan));
>> +
>> +	if (IS_ERR(thread->task)) {
>> +		pr_err("failed to create thread %s\n", dma_chan_name(chan));
>> +		kvfree(tchan);
>> +		kvfree(thread);
>> +		return -EPERM;
>> +	}
>> +
>> +	tchan->thread = thread;
>> +	dev_dbg(chan->device->dev, "add thread %s\n", dma_chan_name(chan));
>> +	list_add_tail(&tchan->node, &info->channels);
>> +
>> +	return 0;
>> +}
>> +

Thanks!

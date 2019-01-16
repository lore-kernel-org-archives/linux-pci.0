Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE4C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4460920657
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wo5AhgDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392182AbfAPKpi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:45:38 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46166 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392180AbfAPKpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:45:38 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C57A924E013C;
        Wed, 16 Jan 2019 02:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547635537; bh=D88w4o+R9EI7482Y4gbwVarIS+5jOupFuMbyFH3iTJs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Wo5AhgDfQX7Zm1gnafjhFZ+Wv9zJJOHcUeGfRhnd1GB2LODx+sQkUVY3HxfEnX/Ig
         5A7PMbZirejt3UeLaYFZnL8Nyq/Dy9KcDNUVu+zlyi+ZjUwHXHDqHZVT1FUOjk/6vU
         vsfaRrH4m8RepWjZo+CZGVuhMYdSbbBqihQOwk2iaZzKY8nubr9meTUmmAbb2SR6Zv
         X18QdclRV556Lki0vO2x8QKvBLY5zNKHD2XrlTeZeLO/yI2m/0x4EGVzCDZOkgJweE
         47ASSNsDoO8q/Tg58emqGeX/lXQ92+bDHHRqzvy5NfTL03uUEmPC1ppNPl6YqjIplE
         ImYhCY94QcHqQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A9B2F3760;
        Wed, 16 Jan 2019 02:45:37 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 02:45:37 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 11:45:35 +0100
Received: from [10.107.19.24] (10.107.19.24) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 11:45:35 +0100
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
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
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <1876fee2-9f8c-925c-a9ab-cf69fe6693a1@synopsys.com>
Date:   Wed, 16 Jan 2019 10:45:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
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
> Add Synopsys eDMA IP test and sample driver to be use for testing
> purposes and also as a reference for any developer who needs to
> implement and use Synopsys eDMA.
> 
> This driver can be compile as built-in or external module in kernel.
> 
> To enable this driver just select DW_EDMA_TEST option in kernel
> configuration, however it requires and selects automatically DW_EDMA
> option too.
> 
> Changes:
> RFC v1->RFC v2:
>  - No changes
> RFC v2->RFC v3:
>  - Add test module
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

> +static int dw_edma_test_add_channel(struct dw_edma_test_info *info,
> +				    struct dma_chan *chan,
> +				    u32 channel)
> +{
> +	struct dw_edma_test_params *params = &info->params;
> +	struct dw_edma_test_thread *thread;
> +	struct dw_edma_test_chan *tchan;
> +
> +	tchan = kvmalloc(sizeof(*tchan), GFP_KERNEL);
> +	if (!tchan)
> +		return -ENOMEM;
> +
> +	tchan->chan = chan;
> +
> +	thread = kvzalloc(sizeof(*thread), GFP_KERNEL);
> +	if (!thread) {
> +		kvfree(tchan);
> +		return -ENOMEM;
> +	}
> +
> +	thread->info = info;
> +	thread->chan = tchan->chan;
> +	switch (channel) {
> +	case EDMA_CH_WR:
> +		thread->direction = DMA_DEV_TO_MEM;
> +		break;
> +	case EDMA_CH_RD:
> +		thread->direction = DMA_MEM_TO_DEV;
> +		break;
> +	default:
> +		kvfree(tchan);

You are leaking thread here.

> +		return -EPERM;
> +	}
> +	thread->test_done.wait = &thread->done_wait;
> +	init_waitqueue_head(&thread->done_wait);
> +
> +	if (!params->repetitions)
> +		thread->task = kthread_create(dw_edma_test_sg, thread, "%s",
> +					      dma_chan_name(chan));
> +	else
> +		thread->task = kthread_create(dw_edma_test_cyclic, thread, "%s",
> +					      dma_chan_name(chan));
> +
> +	if (IS_ERR(thread->task)) {
> +		pr_err("failed to create thread %s\n", dma_chan_name(chan));
> +		kvfree(tchan);
> +		kvfree(thread);
> +		return -EPERM;
> +	}
> +
> +	tchan->thread = thread;
> +	dev_dbg(chan->device->dev, "add thread %s\n", dma_chan_name(chan));
> +	list_add_tail(&tchan->node, &info->channels);
> +
> +	return 0;
> +}
> +

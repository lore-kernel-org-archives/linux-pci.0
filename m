Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFEC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70720870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QrwQRE5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C70720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeLMLz2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:55:28 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:56532 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbeLMLz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 06:55:28 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B86CD10C0BEB;
        Thu, 13 Dec 2018 03:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544702127; bh=xxwxtwjZCK2CjVU+3/FgvqUrzpYAnmKqC4gAT0J+/eU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=QrwQRE5gkm9shSVJPgpQttC5mi0QfIlcGsGLDV6pIq0siYQjX75DqRDa/xCBJXSSw
         Cc2waCRpdUQPF9yu9rKpNvxm0X4jxCn2HIU9pVdNL5yPw0+a3ateMhGfU5RGRJ3W0y
         lFWc11SV5mXQKgVmC/5stcn6wEe8ibBVUAMSJVCi3GwTt9aYh9b1zm4Lc0XHBdyNeS
         okbME2VYduZdgUwLtbkMrnYYP14UOkG1u2D9j8lYTBwKutOHbRYEN64DYbpnVrmoLi
         aaPF+FfPTQwlVgChH5hfCjDCNPBuvCcPZMR57ltHaGb91bbH2SR36S6HjRVQYmc2or
         WwcDlVNCcv/LQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id A4FD0391E;
        Thu, 13 Dec 2018 03:55:27 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 03:55:27 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:55:25 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:55:25 +0100
Subject: Re: [RFC 2/6] dma: Add Synopsys eDMA IP version 0 support
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bb2574d32c7aeb332c79436655f5ab1f9bac540e.1544610287.git.gustavo.pimentel@synopsys.com>
 <1544621983.3270.26.camel@synopsys.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <1bf4961d-78dd-629b-c552-de8ef9a6a67f@synopsys.com>
Date:   Thu, 13 Dec 2018 11:51:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544621983.3270.26.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/12/2018 13:39, Eugeniy Paltsev wrote:
> Hi Gustavo,
> 
> On Wed, 2018-12-12 at 12:13 +0100, Gustavo Pimentel wrote:
>> Add support for the eDMA IP version 0 driver for both register maps (legacy
>> and unroll).
> [snip]
>> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
>> new file mode 100644
>> index 0000000..cc362b0
>> --- /dev/null
>> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
>> @@ -0,0 +1,346 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
>> +// Synopsys DesignWare eDMA v0 core
>> +
>> +#include "dw-edma-core.h"
>> +#include "dw-edma-v0-core.h"
>> +#include "dw-edma-v0-regs.h"
>> +#include "dw-edma-v0-debugfs.h"
>> +
>> +#define QWORD_HI(value)		((value & 0xFFFFFFFF00000000llu) >> 32)
> Use upper_32_bits() macros.
> 
>> +#define QWORD_LO(value)		(value & 0x00000000FFFFFFFFllu)
> Use lower_32_bits() macros.

Ok, makes sense.

> 
>> +enum dw_edma_control {
>> +	DW_EDMA_CB		= BIT(0),
>> +	DW_EDMA_TCB		= BIT(1),
>> +	DW_EDMA_LLP		= BIT(2),
>> +	DW_EDMA_LIE		= BIT(3),
>> +	DW_EDMA_RIE		= BIT(4),
> 
> 
> [snip]
>> +		viewport_sel = (ch & 0x00000007ul);
> [snip]
>> +void dw_edma_v0_core_off(struct dw_edma *dw)
>> +{
>> +	SET_BOTH(dw, int_mask, 0x00FF00FFul);
>> +	SET_BOTH(dw, int_clear, 0x00FF00FFul);
>> +	SET_BOTH(dw, engine_en, 0x00000000ul);
>> +}
> [snip]
>> +		num_ch &= 0x0000000Ful;
>> +	} else {
>> +		num_ch &= 0x000F0000ul;
> 
> I guess it's better to name this magic numbers via defines.
> 
Ok, also makes sense.
> 
> [snip]
> 
>> +
>> +bool dw_edma_v0_core_status_done_int(struct dw_edma_chan *chan)
>> +{
>> +	struct dw_edma *dw = chan->chip->dw;
>> +	u32 tmp;
>> +
>> +	tmp = GET_RW(dw, chan->dir, int_status);
>> +	tmp &= BIT(chan->id);
>> +
>> +	return tmp ? true : false;
> 
> return !!tmp;

Ok, I'll do it.

> 
>> +}
>> +
>> +bool dw_edma_v0_core_status_abort_int(struct dw_edma_chan *chan)
>> +{
>> +	struct dw_edma *dw = chan->chip->dw;
>> +	u32 tmp;
>> +
>> +	tmp = GET_RW(dw, chan->dir, int_status);
>> +	tmp &= BIT(chan->id + 16);
>> +
>> +	return tmp ? true : false;
> ditto.
> 

Thanks!


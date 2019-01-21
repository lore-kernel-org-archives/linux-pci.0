Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C9C282F6
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6D92084A
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fBAMGhL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfAUJTZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:19:25 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:52890 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfAUJTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 04:19:25 -0500
Received: from mailhost.synopsys.com (unknown [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9861424E22F7;
        Mon, 21 Jan 2019 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548062364; bh=s+MFA0gmbKpIZgk5L8Ci30hZHWObtu9PQfgUY9RK5lA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=fBAMGhL94UkVEqti71fIDjG/LR2xFu3e6FRZVi4nU/O8/CdN+ER/6r4xvqipkCw3x
         w4VuOl8LGgpP16OR8qpRYRJsUNfQrjqcdzppdM3e1KPJoQZIjubZLZWcxQ3Ma/ImMS
         H/jTcRFHpJWXCFJzXEVC2YtYbmwLcTQMlwl/MmGb2mZ05vMCux4Il+pQUFf1A9/FWz
         1cwfDuQJbKbwCqPqzDrbJsS0E60IB+dziHf+O3EMRS+aE6eyttK67yHmVzQDM3jaAy
         taVCzNiHLDZ6GrDXtenqvpg59GKQi0RddDd6HtLe8OGVL3glweuqffCyVIqCnFTxYq
         ksD7rWjxN97aA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 35932A00E4;
        Mon, 21 Jan 2019 09:19:22 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 01:19:22 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 10:19:20 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 10:19:20 +0100
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Luis de Oliveira" <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <e374b2fe-23bd-0bc5-be17-abced19bb4f7@synopsys.com>
 <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
 <20190119162152.GE9170@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <35c5c304-356d-1796-33e5-11f48cce704f@synopsys.com>
Date:   Mon, 21 Jan 2019 09:14:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119162152.GE9170@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/01/2019 16:21, Andy Shevchenko wrote:
> On Wed, Jan 16, 2019 at 11:53:00AM +0000, Gustavo Pimentel wrote:
>> On 16/01/2019 10:21, Jose Abreu wrote:
>>> On 1/11/2019 6:33 PM, Gustavo Pimentel wrote:
> 
>>>> +	/* Free irqs */
>>>
>>> But devm will automatically free it, no ?
>>
>> Yes, it shouldn't be there. I'll remove it.
> 
> It depends. If the driver is using tasklets it must free it explicitly like this.

In this driver I'm not using tasklets.

> 
> P.S. devm_*_irq() is quite doubtful to have in the first place.

For curiosity, why?

> 	
> 


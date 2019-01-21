Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A035C2F421
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB3320880
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O1/yokhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfAUPyX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:54:23 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54298 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAUPyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 10:54:22 -0500
Received: from mailhost.synopsys.com (dc8-mailhost.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 08C9610C1753;
        Mon, 21 Jan 2019 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548086062; bh=4PjP73RH9YBgkyJ4/nTg6y6AVpjZQ6k/s3Zni+5KXP4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=O1/yokhZntr8/xlj3RsDaq3hrtMGFwsqadkYpZPPsTHHIBnP+unUw1kZoIzVj/PrK
         YJ8MakCWI0jDbl75WTbvzI5M/T2wBFWwp5Z2+XCRkEooOmLXmcbSXBJ3ZWw1e3hNzm
         yLBlcvwC1loibzlzRynGg/N5x+oEU2ggjIpTLSMi9/3T7mDXavRHEhkHvtes5iusxT
         gFSDv+FNEROfAA1FReqbYjvTnQcyJe4KAOcZRJptK08VsGO64ky9NiEu3xQkvFaObx
         NrRIEHE/LQVqD4/0d+AgMHmomhJNWtF7nkyntKW7FG57gNFNft9exvDQQqlRVgTxqa
         M6ghwTN9J301Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 23BCBA009F;
        Mon, 21 Jan 2019 15:54:21 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 07:54:14 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 16:54:12 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 16:54:12 +0100
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <e374b2fe-23bd-0bc5-be17-abced19bb4f7@synopsys.com>
 <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
 <20190120114724.GW4635@vkoul-mobl>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <57d74bc5-9c30-8815-7a6a-37ce9073f5d8@synopsys.com>
Date:   Mon, 21 Jan 2019 15:49:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190120114724.GW4635@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/01/2019 11:47, Vinod Koul wrote:
> On 16-01-19, 11:53, Gustavo Pimentel wrote:
> 
>>>> +	/* Free irqs */
>>>
>>> But devm will automatically free it, no ?
>>
>> Yes, it shouldn't be there. I'll remove it.
> 
> Nope this is correct. we need to ensure irqs are freed and tasklets are
> quiesced otherwise you can end up with a case when a spurious interrupt
> and then tasklets spinning while core unrolls. devm for irq is not a
> good idea unless you really know what you are doing!
> 

Ok. Nice explanation.

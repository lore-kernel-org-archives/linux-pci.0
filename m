Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FDC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2E20863
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JDy1AklV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBKJVE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:04 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:46074 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfBKJVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 04:21:04 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B505024E08D3;
        Mon, 11 Feb 2019 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549876863; bh=EH7VUg+Q6lexcjexkohozI0rSLmhGviJeaDcN1x3nUE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=JDy1AklVuRaUUtc7nbF6kCAoJzU6Ls9VjwmIg9C+v3dywd7RVO2S8ufGGry0mf0uO
         Fo3lfozgOIbZx4eBJIOe6QMYXjO4p6SE27+4Ujm0Lq6Rw8pbb9demtcXRZSdzIborM
         oI4B3y6875w2/gOJwFqcaTyEz9/3a+eBUlNZkF7Sr9sQTLcvqTrYq+VQKZLK0Lq8L6
         Z5eMFFJx1T9G5p4VMSHSgLXXSbf/LnlwlqTH7kDUthauL9CLUs/qeooXL09mR8ppUU
         WBwE900QVtL/gDbQpw1m2Z5C7Z+2rG+ZOnW8KF6/SqcqWYzvt2X2lg0Q80bikZQByJ
         BelbZSs4IJ2vQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A963BA009D;
        Mon, 11 Feb 2019 09:21:00 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 01:20:17 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 10:20:15 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 10:20:14 +0100
Subject: Re: [PATCH v2] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wen Yang <wen.yang99@zte.com.cn>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <20181206125225.9497-1-wen.yang99@zte.com.cn>
 <20190208122027.GE13009@e107981-ln.cambridge.arm.com>
 <aa4280f5-9750-05e9-7737-044d8f127521@ti.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <ba5489d4-671b-5b52-3917-ea478f7233e0@synopsys.com>
Date:   Mon, 11 Feb 2019 09:15:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <aa4280f5-9750-05e9-7737-044d8f127521@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/02/2019 05:48, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 08/02/19 5:50 PM, Lorenzo Pieralisi wrote:
>> On Thu, Dec 06, 2018 at 08:52:25PM +0800, Wen Yang wrote:
>>> kmemdup has implemented the function that kmalloc() + memcpy().
>>> We prefer to kmemdup rather than code opened implementation.
>>>
>>> This issue was detected with the help of coccinelle.
>>>
>>> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
>>> CC: Kishon Vijay Abraham I <kishon@ti.com>
>>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> CC: Niklas Cassel <niklas.cassel@axis.com>
>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>> CC: linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM)
>>> CC: linux-kernel@vger.kernel.org (open list)
>>> ---
>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> Kishon,
>>
>> this looks OK to me, anything I am missing ?
> 
> For the existing code this might seem the right thing to do but ideally the
> memcpy here should be changed to memcpy_fromio/memcpy_toio.
> 
> Also later when we plan to use DMA (on the endpoint) for data transfer, we have
> to use kzalloc and dma_map_single APIs.

Are you considering to use the eDMA driver that I'm developing?

> 
> So maybe the right thing would be to just fix it to use memcpy_fromio here.
> 
> Thanks
> Kishon
>>
>> Lorenzo
>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> index 3e86fa3c7da3..8df6c019f8a2 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>> @@ -169,14 +169,12 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>>>  		goto err_addr;
>>>  	}
>>>  
>>> -	buf = kzalloc(reg->size, GFP_KERNEL);
>>> +	buf = kmemdup(src_addr, reg->size, GFP_KERNEL);
>>>  	if (!buf) {
>>>  		ret = -ENOMEM;
>>>  		goto err_map_addr;
>>>  	}
>>>  
>>> -	memcpy(buf, src_addr, reg->size);
>>> -
>>>  	crc32 = crc32_le(~0, buf, reg->size);
>>>  	if (crc32 != reg->checksum)
>>>  		ret = -EIO;
>>> -- 
>>> 2.19.1
>>>


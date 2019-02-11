Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A34BC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15029218A6
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dndHrDQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBKMiL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:38:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55780 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfBKMiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 07:38:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1BCbxZY071925;
        Mon, 11 Feb 2019 06:37:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549888679;
        bh=dv1w3WK91cUXPAdWZvGkj+HejO42UrAup40etPBxbrI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dndHrDQSk/Q9hPcLF/dIszPOLnFLCbbwJT5lgJTm1SbUfdCgzI0f3Z0gGINxNPi1x
         GKoUEIPCNhB0nqm67W+RIPn6auGZ5nvWXeOzYhfQbazOmtS/CtanCpptiB6l/aUFsR
         fpTzPHgnWYP9lzYMcgYnCgTQhSS0CWXId8dt21ow=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1BCbxch025432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 06:37:59 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 06:37:58 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 06:37:58 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1BCbsm7005477;
        Mon, 11 Feb 2019 06:37:56 -0600
Subject: Re: [PATCH v2] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wen Yang <wen.yang99@zte.com.cn>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <20181206125225.9497-1-wen.yang99@zte.com.cn>
 <20190208122027.GE13009@e107981-ln.cambridge.arm.com>
 <aa4280f5-9750-05e9-7737-044d8f127521@ti.com>
 <ba5489d4-671b-5b52-3917-ea478f7233e0@synopsys.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <64f74be5-1d49-012c-46de-e49c6006997f@ti.com>
Date:   Mon, 11 Feb 2019 18:07:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ba5489d4-671b-5b52-3917-ea478f7233e0@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 11/02/19 2:45 PM, Gustavo Pimentel wrote:
> On 11/02/2019 05:48, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 08/02/19 5:50 PM, Lorenzo Pieralisi wrote:
>>> On Thu, Dec 06, 2018 at 08:52:25PM +0800, Wen Yang wrote:
>>>> kmemdup has implemented the function that kmalloc() + memcpy().
>>>> We prefer to kmemdup rather than code opened implementation.
>>>>
>>>> This issue was detected with the help of coccinelle.
>>>>
>>>> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
>>>> CC: Kishon Vijay Abraham I <kishon@ti.com>
>>>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>>> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>> CC: Niklas Cassel <niklas.cassel@axis.com>
>>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>>> CC: linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM)
>>>> CC: linux-kernel@vger.kernel.org (open list)
>>>> ---
>>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> Kishon,
>>>
>>> this looks OK to me, anything I am missing ?
>>
>> For the existing code this might seem the right thing to do but ideally the
>> memcpy here should be changed to memcpy_fromio/memcpy_toio.
>>
>> Also later when we plan to use DMA (on the endpoint) for data transfer, we have
>> to use kzalloc and dma_map_single APIs.
> 
> Are you considering to use the eDMA driver that I'm developing?

I used system DMA for my testing. But in the DesignWare driver, we should be
able to choose between system DMA or any other DMA based on the platforms
capabilities.

Thanks
Kishon

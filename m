Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96475C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 05:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6231720873
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 05:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BTAFReVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfBKFtP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:49:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48712 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKFtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 00:49:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1B5n4eg080661;
        Sun, 10 Feb 2019 23:49:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549864144;
        bh=qiqXLGy/wp1zD1QJmnuAlOFLiFkxWPZmqOodvt6seNY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BTAFReVxLuhkfhKAI6KR3HMU2YOElcSiQ4Dzaiaj/jVUc51Z7OdBOX2Kd8HPGW5i8
         LxUcflnwG7Sy8hRuz/4O8H1cETSPGUxWJqJ84V3J5MlQehh50I5XB/UiXSuV2sCnJp
         MvMW+zX6zPqQPe4yi6B5dEP0eu5Ej2oX7GjO3eGI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1B5n3xB001406
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Feb 2019 23:49:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 10
 Feb 2019 23:49:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 10 Feb 2019 23:49:03 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1B5mxBU027901;
        Sun, 10 Feb 2019 23:49:00 -0600
Subject: Re: [PATCH v2] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wen Yang <wen.yang99@zte.com.cn>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhong.weidong@zte.com.cn>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <20181206125225.9497-1-wen.yang99@zte.com.cn>
 <20190208122027.GE13009@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <aa4280f5-9750-05e9-7737-044d8f127521@ti.com>
Date:   Mon, 11 Feb 2019 11:18:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208122027.GE13009@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 08/02/19 5:50 PM, Lorenzo Pieralisi wrote:
> On Thu, Dec 06, 2018 at 08:52:25PM +0800, Wen Yang wrote:
>> kmemdup has implemented the function that kmalloc() + memcpy().
>> We prefer to kmemdup rather than code opened implementation.
>>
>> This issue was detected with the help of coccinelle.
>>
>> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
>> CC: Kishon Vijay Abraham I <kishon@ti.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> CC: Niklas Cassel <niklas.cassel@axis.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>> CC: linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM)
>> CC: linux-kernel@vger.kernel.org (open list)
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Kishon,
> 
> this looks OK to me, anything I am missing ?

For the existing code this might seem the right thing to do but ideally the
memcpy here should be changed to memcpy_fromio/memcpy_toio.

Also later when we plan to use DMA (on the endpoint) for data transfer, we have
to use kzalloc and dma_map_single APIs.

So maybe the right thing would be to just fix it to use memcpy_fromio here.

Thanks
Kishon
> 
> Lorenzo
> 
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 3e86fa3c7da3..8df6c019f8a2 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -169,14 +169,12 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>>  		goto err_addr;
>>  	}
>>  
>> -	buf = kzalloc(reg->size, GFP_KERNEL);
>> +	buf = kmemdup(src_addr, reg->size, GFP_KERNEL);
>>  	if (!buf) {
>>  		ret = -ENOMEM;
>>  		goto err_map_addr;
>>  	}
>>  
>> -	memcpy(buf, src_addr, reg->size);
>> -
>>  	crc32 = crc32_le(~0, buf, reg->size);
>>  	if (crc32 != reg->checksum)
>>  		ret = -EIO;
>> -- 
>> 2.19.1
>>

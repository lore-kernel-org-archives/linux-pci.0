Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84429C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F79220831
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XGSDQnjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F79220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKTUJ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:09:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54528 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKTUJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 15:09:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK9fbaU037393;
        Tue, 20 Nov 2018 03:41:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542706897;
        bh=x/kln5wrJIwFTImhOGi6bG8ofHlLAMRMySmLfeVK3Qo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XGSDQnjc+UoCVYlF1RXP9NLPEL1QF1SD7yDQFZmb0tnQh6eHoVf/ok/UdtZ34KFak
         Ioa16WJuHcbUmNdbtVqN/IiZkhc5IJ62txUCElBuh9I0rqvA3M+KrlssjcrUy41i6u
         Pfx5glQit5ujwh2vJYhK6V2Xd9VwIxPAoK3vxwho=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK9fbOk027075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 03:41:37 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 03:41:36 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 03:41:36 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK9fXLt018462;
        Tue, 20 Nov 2018 03:41:34 -0600
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181112225710.29557-1-swarren@wwwdotorg.org>
 <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
 <87acc658-489a-6b8f-44cb-f9fbad3297a3@wwwdotorg.org>
 <3f4797f3-5477-a31f-9292-ac89c21533fd@synopsys.com>
 <8a004998-095c-b7a9-0b41-bf6a61f2380d@wwwdotorg.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5378fbe9-a037-bd06-4090-e9612b09042b@ti.com>
Date:   Tue, 20 Nov 2018 15:11:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8a004998-095c-b7a9-0b41-bf6a61f2380d@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 15/11/18 11:54 PM, Stephen Warren wrote:
> On 11/14/18 9:33 PM, Gustavo Pimentel wrote:
>> Hi Stephen,
>>
>> On 14/11/2018 04:31, Stephen Warren wrote:
>>> On 11/12/18 9:19 PM, Gustavo Pimentel wrote:
>>>> Hi Stephen,
>>>>
>>>> I'd suggest to change the designware on the patch name by dwc and use another
>>>> description for the patch instead of don't hard-code DBI/ATU offset.
>>>
>>> What issue do you see with the patch description? I believe it's
>>> correct/accurate. Perhaps the confusion is due to the question you
>>> raised below; see my answer there.
>>>
>>>> On 12/11/2018 22:57, Stephen Warren wrote:
>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>
>>>>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>>>>> ATU, DMA, etc. The relationship between the addresses of these register
>>>>> spaces is entirely determined by the implementation of the IP block, not
>>>>> by the IP block design itself. Hence, the DWC driver must not make
>>>>> assumptions that one register space can be accessed at a fixed offset from
>>>>> any other register space. To avoid such assumptions, introduce an
>>>>> explicit/separate register pointer for the ATU register space. In
>>>>> particular, the current assumption is not valid for NVIDIA's T194 SoC.
>>>>
>>>> If I understood this patch correctly, you basically replace the dbi_base offset
>>>> by atu_base offset that still depends of dbi_base offset.
>>>
>>> That's not what the patch does.
>>>
>>> The patch leaves most DBI accesses still using dbi_base, but updates
>>> just a few accesses to use atu_base. Thus, after the patch, all accesses
>>> use the correct base address for the register being accessed.
>>>
>>> There is a default value supplied for atu_base, which does indeed depend
>>> on dbi_base. This maintains backwards compatibility, so that all the
>>> existing drivers don't need to be updated to explicitly set atu_base,
>>> and will continue to use the existing offset between DBI and ATU base.
>>
>> I think we're talking about the same thing, but with different terms.
>>
>>> In the future, we'll send a driver for the NVIDIA Tegra SoC which does
>>> explicitly set atu_base to a non-default value.
>>
>> That's what I wanted to know. Because otherwise this patch was just to turn the
>> code more readable.
> 
> So it sounds like I've addressed your questions? If so, is the next step
> for you to ack the patch and Bjorn to apply it? Thanks!

I had posted a patch sometime back to fix the same issue of hardcoding 
ATU offset [1]. However that patch also fixed ATU identification logic. 
I can post that as a separate patch if Lorenzo wants to merge this one.

FWIW:
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon

[1] -> https://lkml.org/lkml/2018/9/21/484
> 

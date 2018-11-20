Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D311C32789
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160820831
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C160820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKUC4H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:56:07 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:41462 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeKUC4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 21:56:07 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 01D121C00E7;
        Tue, 20 Nov 2018 09:26:07 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
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
 <5378fbe9-a037-bd06-4090-e9612b09042b@ti.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <161af14d-1353-605e-4092-dbf357dd31ba@wwwdotorg.org>
Date:   Tue, 20 Nov 2018 09:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5378fbe9-a037-bd06-4090-e9612b09042b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/18 2:41 AM, Kishon Vijay Abraham I wrote:
> On 15/11/18 11:54 PM, Stephen Warren wrote:
>> On 11/14/18 9:33 PM, Gustavo Pimentel wrote:
>>> On 14/11/2018 04:31, Stephen Warren wrote:
>>>> On 11/12/18 9:19 PM, Gustavo Pimentel wrote:
>>>>> On 12/11/2018 22:57, Stephen Warren wrote:
>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>
>>>>>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>>>>>> ATU, DMA, etc. The relationship between the addresses of these register
>>>>>> spaces is entirely determined by the implementation of the IP block, not
>>>>>> by the IP block design itself. Hence, the DWC driver must not make
>>>>>> assumptions that one register space can be accessed at a fixed offset from
>>>>>> any other register space. To avoid such assumptions, introduce an
>>>>>> explicit/separate register pointer for the ATU register space. In
>>>>>> particular, the current assumption is not valid for NVIDIA's T194 
>>>>>> SoC.
>>>>>
>>>>> If I understood this patch correctly, you basically replace the dbi_base offset
>>>>> by atu_base offset that still depends of dbi_base offset.
>>>>
>>>> That's not what the patch does.
>>>>
>>>> The patch leaves most DBI accesses still using dbi_base, but updates
>>>> just a few accesses to use atu_base. Thus, after the patch, all accesses
>>>> use the correct base address for the register being accessed.
>>>>
>>>> There is a default value supplied for atu_base, which does indeed depend
>>>> on dbi_base. This maintains backwards compatibility, so that all the
>>>> existing drivers don't need to be updated to explicitly set atu_base,
>>>> and will continue to use the existing offset between DBI and ATU base.
>>>
>>> I think we're talking about the same thing, but with different terms.
>>>
>>>> In the future, we'll send a driver for the NVIDIA Tegra SoC which does
>>>> explicitly set atu_base to a non-default value.
>>>
>>> That's what I wanted to know. Because otherwise this patch was just 
>>> to turn the code more readable.
>>
>> So it sounds like I've addressed your questions? If so, is the next step
>> for you to ack the patch and Bjorn to apply it? Thanks!
> 
> I had posted a patch sometime back to fix the same issue of hardcoding 
> ATU offset [1]. However that patch also fixed ATU identification logic. 
> I can post that as a separate patch if Lorenzo wants to merge this one.
> 
> FWIW:
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks
> Kishon
> 
> [1] -> https://lkml.org/lkml/2018/9/21/484

Ah, interesting. I see one problem with that patch on NVIDIA hardware. 
Specifically, it looks like your patch enhances the driver to always set 
iatu_unroll_enabled in dw_pcie_setup() for either RP or EP mode? If so, 
that won't work well for us since the DBI registers can't be accessed at 
that time on our HW. Still, in our particular case, the driver would set 
the version number field and so that register access would actually be 
avoided, so the issue won't actually happen, so maybe the patch is OK... 
I'd love to see at least one of the patches applied.

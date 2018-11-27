Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57FC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8C82086B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8C82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeK1FKa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:10:30 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:38784 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeK1FKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 00:10:30 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 58A731C012D;
        Tue, 27 Nov 2018 11:11:45 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH V2] PCI: dwc: Don't hard-code DBI/ATU offset
To:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181120175750.26141-1-swarren@wwwdotorg.org>
 <acc9aca4-2f1a-70cf-72f4-9f631951a75c@nvidia.com>
 <1f407736-7cfd-0aa7-202f-ab70314be422@wwwdotorg.org>
 <fc21e093-6b9b-4a4f-fb28-a83ed932828a@nvidia.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <e7150ec7-b767-99ee-35aa-03e7d73657cb@wwwdotorg.org>
Date:   Tue, 27 Nov 2018 11:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fc21e093-6b9b-4a4f-fb28-a83ed932828a@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/26/18 8:52 PM, Vidya Sagar wrote:
> 
> On 11/26/2018 10:24 PM, Stephen Warren wrote:
>> On 11/25/18 10:51 PM, Vidya Sagar wrote:
>>>
>>> On 11/20/2018 11:27 PM, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>>>> ATU, DMA, etc. The relationship between the addresses of these register
>>>> spaces is entirely determined by the implementation of the IP block, 
>>>> not
>>>> by the IP block design itself. Hence, the DWC driver must not make
>>>> assumptions that one register space can be accessed at a fixed 
>>>> offset from
>>>> any other register space. To avoid such assumptions, introduce an
>>>> explicit/separate register pointer for the ATU register space. In
>>>> particular, the current assumption is not valid for NVIDIA's T194 SoC.
>>>>
>>>> The ATU register space is only used on systems that require unrolled 
>>>> ATU
>>>> access. This property is detected at run-time for host controllers, and
>>>> when this is detected, this patch provides a default value for atu_base
>>>> that matches the previous assumption re: register layout. An 
>>>> alternative
>>>> would be to update all drivers for HW that requires unrolled access to
>>>> explicitly set atu_base. However, it's hard to tell which drivers would
>>>> require atu_base to be set. The unrolled property is not detected for
>>>> endpoint systems, and so any endpoint driver that requires unrolled 
>>>> access
>>>> must explicitly set the iatu_unroll_enabled flag (none do at 
>>>> present), and
>>>> so a check is added to require the driver to also set atu_base while at
>>>> it.
>>>>
>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>> ---
>>>> v2:
>>>> * Modified patch subject
>>>> * Added missing outer brackets to PCIE_GET_ATU_INB_UNR_REG_OFFSET macro
>>>> ---
>>>>   .../pci/controller/dwc/pcie-designware-ep.c   |  4 ++++
>>>>   .../pci/controller/dwc/pcie-designware-host.c |  3 +++
>>>>   drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++----
>>>>   drivers/pci/controller/dwc/pcie-designware.h  | 20 
>>>> +++++++++++++++----
>>>>   4 files changed, 27 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> index 1e7b02221eac..880210366e71 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> @@ -504,6 +504,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>>           dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
>>>>           return -EINVAL;
>>>>       }
>>>> +    if (pci->iatu_unroll_enabled && !pci->atu_base) {
>>>> +        dev_err(dev, "atu_base is not populated\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>>       ret = of_property_read_u32(np, "num-ib-windows", 
>>>> &ep->num_ib_windows);
>>>>       if (ret < 0) {
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 29a05759a294..2ebb7f4768cf 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -699,6 +699,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>           dev_dbg(pci->dev, "iATU unroll: %s\n",
>>>>               pci->iatu_unroll_enabled ? "enabled" : "disabled");
>>>
>>> I see that dw_pcie_setup_rc() API has code where 
>>> pci->iatu_unroll_enabled gets set based on reading a viewport register.
>>>
>>> IMO, we need a check like following to avoid pci->iatu_unroll_enabled 
>>> getting modified (if already set)
>>>
>>> if (!pci->iatu_unroll_enabled)
>>>      pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
>>
>> That's only true if you believe that dw_pcie_iatu_unroll_enabled() 
>> will give the wrong answer in some circumstances. It's working OK 
>> right now, so I'm not sure why that function would start having problems?
 >
> Since dw_pcie_iatu_unroll_enabled() is reading PCIE_ATU_VIEWPORT 
> register and in case of Nvidia's DWC based PCIe implementation, this 
> register is not listed. In case, if it is returning '0', then, 
> pci->iatu_unroll_enabled which was set by implementation specific driver 
> gets overwritten with this value. Though it is working fine now, I'm not 
> sure if we can take this for granted that it would always work.

For current hardware, I think we can assume this works, because it does 
now. The HW behaviour isn't going to suddenly change for a specific chip 
that's already designed. The behaviour seems to be a property of the 
core DWC HW since the driver already relies on it for multiple different 
vendor uses of the core DWC HW. If for some reason it turns out that 
this doesn't work for a future HW design, we can always fix it up then.

I don't think this patch affects this issue at all though. If you want 
to modify the DWC core and all DWC HW-specific drivers so that the 
HW-specific drivers always set iatu_unroll_enabled when required, rather 
than auto-detecting the value, that seems fine, but I think you should 
send a separate patch for that.

Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64951C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 05:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1EF2083E
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 05:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QLYg9FxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1EF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeKOPnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:43:47 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:45052 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKOPnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 10:43:46 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2619224E0A2E;
        Wed, 14 Nov 2018 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542260243; bh=oS8+ZkQRWTankuL8ezHUOPIfN4KBNU+3Sezx8Kusicg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=QLYg9FxJZdANbScSLw2clFwcsj+YAiKDtTZLR06gOiAe3ARm/jRbe6qgDv1x2FhSX
         ulRFB8vM1uJ4IvkyNLp8e12xhpU5Jlupo/EnIpGnGbkJDuB3FvpsivaBiGg73GEDPq
         +hST9ZhWEFW0rhtB33Zcg6hPCbUvbPPPpJYsqRvb8fB5lt2W3iXAE4r5cLdTqcZ+3q
         zKsV+AQ/ALEOvX/K5Qr7W5IxpmFMJChQYPXr06jMHLDTD9G6BI/HY9vI8fbw5B9gV5
         ksJFIzhpAkNXOnyrONdSHtgxRvZlGf6x09flFRh3fcav74Uz7gmS+HdnzecWPLPTtn
         On4nc8sPOVy8A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id D26B83650;
        Wed, 14 Nov 2018 21:37:22 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 14 Nov 2018 21:37:22 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 06:37:20 +0100
Received: from [10.4.120.14] (10.4.120.14) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 15 Nov
 2018 06:37:19 +0100
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "Stephen Warren" <swarren@nvidia.com>
References: <20181112225710.29557-1-swarren@wwwdotorg.org>
 <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
 <87acc658-489a-6b8f-44cb-f9fbad3297a3@wwwdotorg.org>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3f4797f3-5477-a31f-9292-ac89c21533fd@synopsys.com>
Date:   Thu, 15 Nov 2018 05:33:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87acc658-489a-6b8f-44cb-f9fbad3297a3@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.14]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

On 14/11/2018 04:31, Stephen Warren wrote:
> On 11/12/18 9:19 PM, Gustavo Pimentel wrote:
>> Hi Stephen,
>>
>> I'd suggest to change the designware on the patch name by dwc and use another
>> description for the patch instead of don't hard-code DBI/ATU offset.
> 
> What issue do you see with the patch description? I believe it's
> correct/accurate. Perhaps the confusion is due to the question you
> raised below; see my answer there.
> 
>> On 12/11/2018 22:57, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>>> ATU, DMA, etc. The relationship between the addresses of these register
>>> spaces is entirely determined by the implementation of the IP block, not
>>> by the IP block design itself. Hence, the DWC driver must not make
>>> assumptions that one register space can be accessed at a fixed offset from
>>> any other register space. To avoid such assumptions, introduce an
>>> explicit/separate register pointer for the ATU register space. In
>>> particular, the current assumption is not valid for NVIDIA's T194 SoC.
>>
>> If I understood this patch correctly, you basically replace the dbi_base offset
>> by atu_base offset that still depends of dbi_base offset.
> 
> That's not what the patch does.
> 
> The patch leaves most DBI accesses still using dbi_base, but updates
> just a few accesses to use atu_base. Thus, after the patch, all accesses
> use the correct base address for the register being accessed.
> 
> There is a default value supplied for atu_base, which does indeed depend
> on dbi_base. This maintains backwards compatibility, so that all the
> existing drivers don't need to be updated to explicitly set atu_base,
> and will continue to use the existing offset between DBI and ATU base.


I think we're talking about the same thing, but with different terms.

> 
> In the future, we'll send a driver for the NVIDIA Tegra SoC which does
> explicitly set atu_base to a non-default value.

That's what I wanted to know. Because otherwise this patch was just to turn the
code more readable.

> 
>> I agree the code is
>> now more readable, but I'm not seeing it by applying this patch what is the
>> benefit since you are not allowing to change the current atu_base. I though that
>> was the propose of this patch.
> 
> atu_base may be set by the implementation-specific driver before calling
> dw_pcie_ep_init(), or the host controller equivalent.

Agree, as long that maintains the retro-compatibility.

> 
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> 
>>> -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
>>> -			((0x3 << 20) | ((region) << 9))
>>> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
>>> +		((region) << 9)
>>
>> I'd suggest to remove the parenthesis around the region variable, like this:
>> (region << 9)
> 
> Note that this is a pre-existing issue, and not caused/influenced by
> this patch. The existing code is correct though; it's best practice to
> always bracket all macro parameters, so that if the expression passed to
> the macro contains operators, the macro implementation can guarantee the
> correct calculation bracketing.
> 

Well seen.

Regards,
Gustavo

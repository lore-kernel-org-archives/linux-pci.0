Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E044C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC632077C
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Hl2FL+Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfDPNPZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:15:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2339 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDPNPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 09:15:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5d5570000>; Tue, 16 Apr 2019 06:15:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 06:15:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 06:15:23 -0700
Received: from [10.24.45.163] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 13:15:17 +0000
Subject: Re: [PATCH V2 01/16] PCI: Add #defines for PCIe spec r4.0 features
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-2-git-send-email-vidyas@nvidia.com>
 <20190411101353.GE4633@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4f672035-262b-1e53-2718-8c0c5612b3f3@nvidia.com>
Date:   Tue, 16 Apr 2019 18:45:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411101353.GE4633@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555420503; bh=t0GOs2azBJjgZp+xHC5CZdwgEzN9x3n9cfJyNGjL2B8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hl2FL+KgDXcmLsCOPR2ZFCWSBKk6S4/asPCeICE12zyUPJA7g3kmBg8GsNWh0nHz1
         Xnc7JBmLbfoMn+srWMDXdLMCq5QBvJGkKVlKq7WJ/q89t6MuKfnObbxTW7UzHW9DWl
         lCLgXbjY7Dp9pn6X0qivl02m+xn1PuvhqaDsp5hauFR98xZEOpsxkO43ttB8PZSmZZ
         TVWHjhWrHyE/3qZPeUf1vTmkBgDUCmcbjK0LHbCxVewY8lnRhg3EiSSImO/S7OkJDF
         rzBkr+jkUAA7CXA4nFdQyMeYGJDEf1JM+9jQqg7bIUpWAKxJ+hYIE7zKFygGavXfJj
         4scgZjDZ8kP/w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/11/2019 3:43 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:28AM +0530, Vidya Sagar wrote:
>> Add #defines for the Data Link Feature and Physical Layer 16.0 GT/s
>> features.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from [v1]:
>> * None
>>
>>   include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 5c98133f2c94..3e01b55d548d 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -705,7 +705,9 @@
>>   #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>>   #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>>   #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
>> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
>> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>> +#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */
>> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
>>   
>>   #define PCI_EXT_CAP_DSN_SIZEOF	12
>>   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
>> @@ -1045,4 +1047,22 @@
>>   #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>>   #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
>>   
>> +/* Data Link Feature */
>> +#define PCI_DLF_CAP		0x04	/* Capabilities Register */
>> +#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Feature Supported */
>> +#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
>> +#define PCI_DLF_STS		0x08	/* Status Register */
>> +#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Feature Supported */
>> +#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Feature Support Valid */
>> +
>> +/* Physical Layer 16.0 GT/s */
>> +#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
>> +#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
>> +#define PCI_PL_16GT_STS		0x0c	/* Status Register */
>> +#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */
>> +#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
> 
> This looks correct comparing to the specification. However, this leaves
> out some definitions, so I'm wondering if perhaps this should include
> all field definitions. There are also extended capabilities between the
> current maximum 0x1F and 0x25. Perhaps those should be added as well. I
> guess this could always be done as a follow-up.
> 
> Perhaps it'd be better to change the subject to more accurately reflect
> that you're only adding a couple of PCIe 4.0 features.
I'll change subject accordingly.

> 
> Other than that:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 


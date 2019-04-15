Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F36C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494272147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K2asaL54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfDOPta (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:49:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6446 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOPta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:49:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4a8050000>; Mon, 15 Apr 2019 08:49:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:49:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:49:29 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:48:52 +0000
Subject: Re: [PATCH 23/30] dt-bindings: pci: tegra: Document PCIe DPD pinctrl
 optional prop
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-24-mmaddireddy@nvidia.com> <20190415140749.GY29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <f493390c-4be5-ad74-1b2b-27e815ec4dcb@nvidia.com>
Date:   Mon, 15 Apr 2019 21:18:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415140749.GY29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555343366; bh=lLjGt/vMuZHNwv6dteL8YN9ZnC3Rd7va1j2L3FHsI7w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=K2asaL54PYpnZClL/2JIIXIbm16jRJ4XuCTSwWrpQbgvrNxEdXgxvo3urO457s1qT
         kwMHbKnh0DafrHlwRYJey10jmKRYrIFJRm9gyr1ok22ToOESZt6RRliTR15fFsL81W
         CJfT1wM5iqBzQ4qfWCZJXjdOA/X8OxdBbrQ7avsxEqEnHrPcJlOnZV4CQucPYLn52U
         8VAKJ6uypXGB8HxvIoWziJdwwQfI73wsL7FDGJyWxtuQZFBsUjl36lRV8LtNdzEKZk
         x6LYHqQmh0TTfHMSWgYcotoqDMNyQF79QFw8C/IjpkAgj/38Epq4zGXflLznnNxyC9
         bjQ0oCXUoT0yA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:37 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:48PM +0530, Manikanta Maddireddy wrote:
>> Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
>> in low power mode.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt      | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> index 145a4f04194f..fbbd3bcb3435 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> @@ -65,6 +65,15 @@ Required properties:
>>    - afi
>>    - pcie_x
>>  
>> +Optional properties:
>> +- pinctrl-names : The pin control state names.
>> +- pinctrl-0: PCIe IO(bias & REFCLK) deep power down(DPD) disable state.
>> +  In Tegra210 PCIe clamps are not controlling IO signals, so there
>> +  is leakagae power even after PCIe power partition is off. Pass
> leakage
>
>> +  pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
>> +- pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
>> +  Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
> This is confusingly documented. Your pinctrl-names should list exactly
> what states are supported. The generic pinctrl bindings already specify
> how to define pinctrl states, so I don't think you need to describe all
> of the pinctrl-{0,1,...} states again.
>
> Also, looking at the driver you seem to use custom names for the pinctrl
> states, but those states are really just the "active" and the "idle"
> states, for which there are standard names.
>
> Something like this perhaps:
>
> - pinctrl-names: A list of pinctrl state names. Must contain the
>   following entries:
>   - "default": active state, puts PCIe I/O out of deep power down state
>   - "idle": puts PCIe I/O into deep power down state
>
> It then goes without saying that the phandle pointed to by pinctrl-0
> corresponds to the pinctrl state named by the first entry in
> pinctrl-names.
>
> If you use those default names for the states, I don't think you even
> need extra code, the pinctrl subsystem should be able to take of that
> for you.
>
> Thierry
I will take care of naming in V2. However pinctrl states should be controlled
by PCIe driver because it knows when the "PCIe link up" is initiated and
when then link is down.

Manikanta
>
>> +
>>  Required properties on Tegra124 and later (deprecated):
>>  - phys: Must contain an entry for each entry in phy-names.
>>  - phy-names: Must include the following entries:
>> -- 
>> 2.17.1
>>


Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C4C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96E120693
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nlVTCHWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfDPO3V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:29:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6580 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPO3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 10:29:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5e6ad0000>; Tue, 16 Apr 2019 07:29:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 07:29:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 07:29:20 -0700
Received: from [10.24.45.163] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 14:29:15 +0000
Subject: Re: [PATCH V2 07/16] dt-bindings: PCI: designware: Add binding for
 CDM register check
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
 <1554407683-31580-8-git-send-email-vidyas@nvidia.com>
 <20190415145402.GF29254@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ccaf5077-4fb8-847c-d8b6-6e8a25f27660@nvidia.com>
Date:   Tue, 16 Apr 2019 19:59:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145402.GF29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555424941; bh=x/YYQavugb0lHToFlit4CGFSE2dbDGusuJFCHXPDElo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nlVTCHWBzDqD41kTZrK9VxxndL8GHARMzKr2KR/Rn6UNtPCw4FG73uOjlUmapYBzF
         cW3hLn5UPBOnSUkLmXkKg1H36sxDY4hsz7Kzi9u11w7h0/miNUN73yMwAhHxUizmmb
         1V79gmwbbNrzG7Liuooj/iRC0DLqZJ2OzmewnCWmsDyYqLkj/Zrnu20Vb50Xbic3eI
         lF60/XOMXzGCkBahMtN7Rd2ZUR5yzre14NluUNGziW6paz07/XaCT3pg7kBbSmndEk
         STBHx7loy56SZvz2BWUvxwp+Y5vhWXT3OClMns23yy+huyYUEQQaPLlLbRkQvYxWAu
         82uLge+toY/zQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/2019 8:24 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:34AM +0530, Vidya Sagar wrote:
>> Add support to enable CDM (Configuration Dependent Module) registers check
>> for any data corruption. CDM registers include standard PCIe configuration
>> space registers, Port Logic registers and iATU and DMA registers.
>> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
>> Version 4.90a
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v1]:
>> * This is a new patch in v2 series
>>
>>   Documentation/devicetree/bindings/pci/designware-pcie.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index c124f9bc11f3..728281b5bcd5 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -31,6 +31,10 @@ Optional properties:
>>   - clock-names: Must include the following entries:
>>   	- "pcie"
>>   	- "pcie_bus"
>> +- cdm-check: This is a boolean property and if present enables automatic
>> +   checking of CDM (Configuration Dependent Module) registers for data
>> +   corruption. CDM registers include configuration space registers and iATU
>> +   (internal Address Translation Unit) registers.
> 
> By comparison the commit message also lists "Port Logic" and "DMA"
> registers as being part of the CDM registers. Shouldn't they be part of
> the bindings document as well?
Ok. I'll add them in V3 patch series.

> 
> Perhaps it'd also be a good idea to rename this property to something
> more imperative, like "enable-cdm" or similar.
Ok. I'll go with "enable-cdm-check". I hope that should be fine.

> 
> Thierry
> 
>>   RC mode:
>>   - num-viewport: number of view ports configured in hardware. If a platform
>>     does not specify it, the driver assumes 2.
>> -- 
>> 2.7.4
>>


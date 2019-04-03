Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C361BC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 05:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CCF2171F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 05:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R+SA0FJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDCF33 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:29:29 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6258 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCF33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 01:29:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca444b40000>; Tue, 02 Apr 2019 22:29:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 22:29:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 22:29:27 -0700
Received: from [10.24.47.153] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 05:29:16 +0000
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     <bhelgaas@google.com>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <tiwai@suse.de>, <spujar@nvidia.com>,
        <skomatineni@nvidia.com>, <liviu.dudau@arm.com>, <krzk@kernel.org>,
        <heiko@sntech.de>, <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <5ca06149.1c69fb81.720fd.79e1@mx.google.com>
 <5ef50168-2476-1088-7156-8a4488d7a2e1@nvidia.com>
 <20190401143138.GA4874@ulmo>
 <67f9b726-c075-0291-7777-8f10ecc9e29d@nvidia.com>
 <20190402142031.GC8017@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <418d270d-120e-f33b-a525-a0677ab9343d@nvidia.com>
Date:   Wed, 3 Apr 2019 10:59:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402142031.GC8017@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554269365; bh=wRr9PTtyWUc9cwsS9nPdpWERlocFX5Pk57zfz9m01ww=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R+SA0FJ4iRk6o516Ehov4foBeYj+Fh498F+xfMhsvgA2TH/TkuCgwqOvUubJYLwzp
         MI5bHRBDgnH3exOdUUtiQldR4cQ55lnVhjiMvFBwI++9NHBcSivZaEAEV2Ma7O1qy9
         1/8N8hIrBn7p34Xx1IrcXTyM2nQ/gwq7+gSToeUdhKVuCo/r1bKANFZErm+K2HKCZp
         uYcNj4XnleyHyQxj3njkq3rU/fFBOXwpbyuuV474ez/46gQpE3FWlTAFghj40hx4FW
         iyycojmXBawIqPoS1jsmNUMEW+j6phFBCb9fHpyzHywXNUZijj5Jdxu7LWio0to/QK
         EvKcV/ZMOoRCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/2/2019 7:50 PM, Thierry Reding wrote:
> On Tue, Apr 02, 2019 at 02:46:27PM +0530, Vidya Sagar wrote:
>> On 4/1/2019 8:01 PM, Thierry Reding wrote:
>>> On Mon, Apr 01, 2019 at 04:48:42PM +0530, Vidya Sagar wrote:
>>>> On 3/31/2019 12:12 PM, Rob Herring wrote:
>>>>> On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> [...]
>>>>>> +Optional properties:
>>>>>> +- nvidia,max-speed: limits controllers max speed to this value.
>>>>>> +    1 - Gen-1 (2.5 GT/s)
>>>>>> +    2 - Gen-2 (5 GT/s)
>>>>>> +    3 - Gen-3 (8 GT/s)
>>>>>> +    4 - Gen-4 (16 GT/s)
>>>>>> +- nvidia,init-speed: limits controllers init speed to this value.
>>>>>> +    1 - Gen-1 (2. 5 GT/s)
>>>>>> +    2 - Gen-2 (5 GT/s)
>>>>>> +    3 - Gen-3 (8 GT/s)
>>>>>> +    4 - Gen-4 (16 GT/s)
>>>>>
>>>>> Don't we have standard speed properties?
>>>> Not that I'm aware of. If you come across any, please do let me know and
>>>> I'll change these.
>>>
>>> See Documentation/devicetree/bindings/pci/pci.txt, max-link-speed.
>>> There's a standard of_pci_get_max_link_speed() property that reads it
>>> from device tree.
>> Thanks for the pointer. I'll switch to this in the next patch.
>>
>>>
>>>>> Why do we need 2 values?
>>>> max-speed configures the controller to advertise the speed mentioned through
>>>> this flag, whereas, init-speed gets the link up at this speed and software
>>>> can further take the link speed to a different speed by retraining the link.
>>>> This is to give flexibility to developers depending on the platform.
>>>
>>> This seems to me like overcomplicating things. Couldn't we do something
>>> like start in the slowest mode by default and then upgrade if endpoints
>>> support higher speeds?
>>>
>>> I'm assuming that the maximum speed is already fixed by the IP hardware
>>> instantiation, so why would we want to limit it additionally? Similarly,
>>> what's the use-case for setting the initial link speed to something
>>> other than the lowest speed?
>> You are right that maximum speed supported by hardware is fixed and through
>> max-link-speed DT option, flexibility is given to limit it to the desired speed
>> for a controller on a given platform. As mentioned in the documentation for max-link-speed,
>> this is a strategy to avoid unnecessary operation for unsupported link speed.
>> There is no real use-case as such even for setting the initial link speed, but it is
>> there to give flexibility (for any debugging) to get the link up at a certain speed
>> and then take it to a higher speed at a later point of time. Please note that, hardware
>> as such already has the capability to take the link to maximum speed agreed by both
>> upstream and downstream ports. 'nvidia,init-speed' is only to give more flexibility
>> while debugging. I'm OK to remove it if this is not adding much value here.
> 
> If this is primarily used for debugging or troubleshooting, maybe making
> it a module parameter is a better choice?
> 
> I can see how max-link-speed might be good in certain situations where a
> board layout may mandate that a link speed slower than the one supported
> by the hardware is used, but I can't imagine a case where the initial
> link speed would have to be limited based on the hardware designe.
> 
> Rob, do you know of any other cases where something like this is being
> used?
Fair enough. I'll make max-link-speed as an optional DT parameter and
leave 'nvidia,init-speed' to Rob to decided whether it is OK to have it
or it is not acceptable.

> 
>>>>>> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
>>>>>> +    bit-0 to '1' : disables advertisement of ASPM-L0s
>>>>>> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
>>>>>> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
>>>>>> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
>>>>>> +    bit-3 to '1' : disables advertisement of ASPM-L1.2
>>>>>
>>>>> Seems like these too should be common.
>>>> This flag controls the advertisement of different ASPM states by root port.
>>>> Again, I'm not aware of any common method for this.
>>>
>>> rockchip-pcie-host.txt documents an "aspm-no-l0s" property that prevents
>>> the root complex from advertising L0s. Sounds like maybe following a
>>> similar scheme would be best for consistency. I think we'll also want
>>> these to be non-NVIDIA specific, so drop the "nvidia," prefix and maybe
>>> document them in pci.txt so that they can be more broadly used.
>> Since we have ASPM-L0s, L1, L1.1 and L1.2 states, I prefer to have just one entry
>> with different bit positions indicating which particular state should not be
>> advertised by root port. Do you see any particular advantage to have 4 different options?
>> If having one options is fine, I'll remove "nvidia," and document it in pci.txt.
> 
> I don't care strongly either way. It's really up to Rob to decide.
Rob, please let us know your comments on this also.

> 
> Thierry
> 


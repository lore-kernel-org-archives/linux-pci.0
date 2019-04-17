Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A0C282DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5208920693
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bX0p4W4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfDQS0s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:26:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2819 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfDQS0s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 14:26:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb76fea0002>; Wed, 17 Apr 2019 11:26:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Apr 2019 11:26:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Apr 2019 11:26:45 -0700
Received: from [10.24.71.55] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Apr
 2019 18:26:40 +0000
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document nvidia,plat-gpios
 optional prop
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com> <20190415141654.GA29254@ulmo>
 <b575fd56-0d31-bbe2-deef-5a21d6e4b33e@nvidia.com>
 <20190416153443.GA30777@ulmo>
 <51957dce-5e0b-647b-d6b8-0cc118ee95bc@nvidia.com>
 <20190417151956.GF26626@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <be8d689f-73f7-5418-600a-53a2032aef37@nvidia.com>
Date:   Wed, 17 Apr 2019 23:56:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417151956.GF26626@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555525611; bh=RZqLO4+ia/Ij9K+YUQxwmrM+Kt5NamO1a7apiyOvDCg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=bX0p4W4BnuVlZPsdtplR+OdC2mOPOn/kZWW4kJ1YDKF1/T6gSeXVpkD0mILPf2yJ0
         6Do5UAZzNp57YCkmJq1R0POvfiKL/s2fZ0u2k9ZIpNn4kHNgT90W4uldQxCwgX/wk9
         My2BxQz1vYMa9bshXQnzPQCQ/+RHyfBg7en9xasUiDNbfTs5TyfVt9Omu1G2ITSlB8
         xdC7/01pVbXF0rdL1Wo2Jy4xI1BhkgmW2kJ3AfKD1ntj8wmc0j67hCSigZvG/SMozu
         7UhZIealOGcevrKC4IkV13fx9J7V9Zj70zZ6YS67fxYf1VavzzeohVEwO28Kc7eSLz
         xKzR8Dl9viF4Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17-Apr-19 8:49 PM, Thierry Reding wrote:
> On Wed, Apr 17, 2019 at 04:52:46PM +0530, Manikanta Maddireddy wrote:
>>
>> On 16-Apr-19 9:04 PM, Thierry Reding wrote:
>>> On Mon, Apr 15, 2019 at 11:28:29PM +0530, Manikanta Maddireddy wrote:
>>>> On 15-Apr-19 7:46 PM, Thierry Reding wrote:
>>>>> On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
>>>>>> Document "nvidia,plat-gpios" optional property which supports configuring
>>>>>> of platform specific gpios.
>>>>>>
>>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>>>>>>  1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>>>>>> index fbbd3bcb3435..dca8393b86d1 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>>>>>> @@ -73,6 +73,8 @@ Optional properties:
>>>>>>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
>>>>>>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
>>>>>>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
>>>>>> +- nvidia,plat-gpios: A list of platform specific gpios which controls
>>>>>> +  endpoint's internal regulator or PCIe logic.
>>>>> We discussed this with Vidya during review of the Tegra194 PCIe device
>>>>> tree bindings and arrived at the conclusion that all of the GPIOs that
>>>>> need to be controlled for PCI to work can be modelled as proper device
>>>>> nodes (I think regulator and GPIO-controlled muxes were the only two
>>>>> use-cases for which we need this).
>>>>>
>>>>> Can the same be done for this PCI controller? What use-cases are we
>>>>> talking about?
>>>> In Tegra194 case it is apt to use regulator framework because gpios are used
>>>> to control regulators. However I published this patch to control vendor defined
>>>> gpios in endpoints. For ex: isolate gpio in RTL8111. Since I am not sure if
>>>> regulator framework is apt, I published as gpio patch.
>>>>>>  Required properties on Tegra124 and later (deprecated):
>>>>>>  - phys: Must contain an entry for each entry in phy-names.
>>>>>> @@ -567,6 +569,7 @@ Board DTS:
>>>>>>  		pci@2,0 {
>>>>>>  			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
>>>>>>  			phy-names = "pcie-0";
>>>>>> +			nvidia,plat-gpios = <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
>>>>>>  			status = "okay";
>>>>>>  		};
>>>>>>  	};
>>>>> I recall this being the setup for Jetson Nano and the X.3 GPIO going to
>>>>> an Ethernet device. Let's find out what exactly this GPIO is used for
>>>>> and why we need it to be set up as part of the PCI controller driver
>>>>> rather than the Ethernet device.
>>>>>
>>>>> If it turns out we can't model this other than with a generic GPIO type
>>>>> of property we need a better explanation than the above, and the Jetson
>>>>> Nano use-case would provide that explanation.
>>>>>
>>>>> And if indeed we cannot model this more accurately, I think we should
>>>>> use something like the gpio-hog binding rather than some custom PCI
>>>>> controller property.
>>>>>
>>>>> Thierry
>>>> Yes, in Jetson Nano gpio x.3 is controlling isolate pin of RTL8111.
>>>> RTL8111 datasheet available online says that as long as isolate
>>>> pin is asserted it'll not sample RX lanes and doesn't drive TX lanes.
>>>> Since RTL8111 PCIe IP should be active when PCIe host driver is
>>>> attempting link up, this gpio can be controlled by host driver only.
>>>>
>>>> I didn't go for gpio-hog because this gpio should be asserted
>>>> during suspend, to enable wake on LAN.
>>> I don't see code in gpiolib that would cause this to be deasserted
>>> during suspend.
>>>
>>> Is there ever a need to manipulate this GPIO at all? Or do we just
>>> need to make sure that it's always asserted?
>> Following steps
>> 1) ISOLATEB gpio should be deasserted during boot to enable PCIe section
>> of RTL8111
>> 2) PCIe host driver enumerates RTL8111
>> 3) When suspend is initiated, ISOLATEB gpio should be asserted after PCIe
>> host controller suspend is completed to disable PCIe section of RTL8111
>> and enable Wake on LAN
>> 4) During resume, first ISOLATE gpio should be deasserted to get PCIe link up
> I think it's important that we be very clear here. If ISOLATEB is
> asserted, does that mean the PCIe link is down? Or does it only mean
> that the RTL8111 cannot be enumerated.
>
> If the PCIe link remains down as long as ISOLATEB is asserted, then it
> sounds like there's more going on than this GPIO just keeping the
> RTL8111 from talking on the PCI bus. In that case we would probably have
> to model this as some sort of power regulator for the bus.
>
> However, if the PCIe link can be brought up if the RTL8111 is isolated,
> but if the device can only not be enumerated, then we could still have
> the RTL8111 driver deassert ISOLATEB early during resume. We only have
> to make sure that it happens before any PCI requests are sent to the
> device.
>
> Thierry

RTL8111 will not drive PCIe outputs(except WAKE#) and will not sample PCIe
input as long as ISOLATEB is asserted. So PCIe link up doesn't happen if
ISOLATEB is asserted.

Manikanta

>
>>> The problem with adding this to nvidia,plat-gpios in the PCI root port
>>> node is that there's no context at all, so the PCI host driver can't
>>> really do anything with this, other than perhaps exactly one fixed
>>> operation, but then it's pretty much equivalent to a gpio-hog.
>>>
>>> If we do need control over the pin, I think it might be worth looking at
>>> adding support to gpiolib for initial pin configuration (so that it does
>>> not hog the GPIO, but still configures it). That would allow us to take
>>> the PCI device out of isolation initially and once the device has been
>>> probed we can control the GPIO from the PCI device. That way the device
>>> driver has the necessary context to assert and deassert the pin at the
>>> appropriate time, while still giving us the possibility to make the
>>> device appear on the PCI bus.
>> ISOLATEB gpio disables the PCIe section in RTL8111(Rx is not sampled &
>> doesn't drive Tx), if PCI client driver controls it, then it has
>> to do it after host controller suspend_noirq callback is completed.
>> Only suspend callback available after suspend_noirq is syscore_ops.
>> I didn't go with it because it is take void arguments, so client
>> driver has to maintain global pointers and I see only core drivers
>> like irqchip, clk, etc are using it.
>>
>> Manikanta
>>
>>> As a side-note, I think it would've been better if the ISOLATEB signal
>>> was wired up such that it would've been active by default. That would
>>> mean that if the bootloader and/or OS were not aware of the ISOLATEB
>>> signal, they would still be able to use the Ethernet device. I think
>>> that would've been a more sensible default, especially if the bus that
>>> the device is on requires the signal to be controlled without even
>>> knowing that the device exists.
>>>
>>> Thierry


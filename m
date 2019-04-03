Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB19C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 06:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD521473
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 06:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LdvSTSeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDCGWU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:22:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8937 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCGWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 02:22:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca451150000>; Tue, 02 Apr 2019 23:22:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 23:22:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 02 Apr 2019 23:22:15 -0700
Received: from [10.24.47.153] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 06:22:04 +0000
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <tiwai@suse.de>, <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
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
 <20190328131508.GB5518@ulmo>
 <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
 <20190401150740.GB4874@ulmo>
 <c3190fbe-d197-a810-6bd4-d53c6e375bc5@nvidia.com>
 <20190402143558.GD8017@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <718f077a-1a74-f54f-d31b-eef3fe746114@nvidia.com>
Date:   Wed, 3 Apr 2019 11:52:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402143558.GD8017@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554272533; bh=fRaHntHcecEEYj1OOQue3yQioVsoMci899iCwx81w0Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LdvSTSeQTGf8YdBOJD7MM0WwLsMDY0WNtp05UaKEMwmX0bb9jdWgEcYdVPECNoUMu
         YAdkqhxSPK6ztjKRrzzdkLD7XpAPu4NjNlLpnRiz+nMcTAQjUVkWd8O1+rMwYTJVBV
         5rPDJSPVo4ggI3r7hfaIJdT3OxSRIst1q4JO9jC+o8o01rx5u9S0Ox1e7DVQ+qI6bv
         LUuLRaQU0hMNaXZNDM/pcwB7tAnVnPBIEUkTHIKrq4XWJK1IL+KTp+peqFdFdOQyOI
         R5DE6ojJGC6JD3IuFET80tGQn/6dHgDgdry68SFZlMr7UuScdQszB7oTa2Cb6EczCR
         BLg4cHmtm9xVQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/2/2019 8:05 PM, Thierry Reding wrote:
> On Tue, Apr 02, 2019 at 05:11:25PM +0530, Vidya Sagar wrote:
>> On 4/1/2019 8:37 PM, Thierry Reding wrote:
>>> On Mon, Apr 01, 2019 at 03:31:54PM +0530, Vidya Sagar wrote:
>>>> On 3/28/2019 6:45 PM, Thierry Reding wrote:
>>>>> On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
>>>>>> Add support for Tegra194 PCIe controllers. These controllers are based
>>>>>> on Synopsys DesignWare core IP.
>>>>>>
>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>> ---
>>>>>>     .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++++++++++++++++++
>>>>>>     .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
>>>>>>     2 files changed, 243 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>>>>     create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..31527283a0cd
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>>>> @@ -0,0 +1,209 @@
>>>>>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>>>>>> +
>>>>>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>>>>>> +and thus inherits all the common properties defined in designware-pcie.txt.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>>>>>> +- device_type: Must be "pci"
>>>>>> +- reg: A list of physical base address and length for each set of controller
>>>>>> +  registers. Must contain an entry for each entry in the reg-names property.
>>>>>> +- reg-names: Must include the following entries:
>>>>>> +  "appl": Controller's application logic registers
>>>>>> +  "window1": This is the aperture of controller available under 4GB boundary
>>>>>> +             (i.e. within 32-bit space). This aperture is typically used for
>>>>>> +             accessing config space of root port itself and also the connected
>>>>>> +             endpoints (by appropriately programming internal Address
>>>>>> +             Translation Unit's (iATU) out bound region) and also to map
>>>>>> +             prefetchable/non-prefetchable BARs.
>>>>>> +  "config": As per the definition in designware-pcie.txt
>>>>>
>>>>> I see that you set this to a 256 KiB region for all controllers. Since
>>>>> each function can have up to 4 KiB of extended configuration space, that
>>>>> means you have space to address:
>>>>>
>>>>>        256 KiB = 4 KiB * 8 functions * 8 devices
>>>>>
>>>>> Each bus can have up to 32 devices (including the root port) and there
>>>>> can be 256 busses, so I wonder how this is supposed to work. How does
>>>>> the mapping work for configuration space? Does the controller allow
>>>>> moving this 256 KiB window around so that more devices' configuration
>>>>> space can be accessed?
>>>> We are not using ECAM here instead only pick 4KB region from this 256 KB region
>>>> and program iATU (internal Address Translation Unit) of PCIe with the B:D:F of
>>>> the configuration space that is of interest to be able to view the respective
>>>> config space in that 4KB space. It is a hardware requirement to reserve 256KB of
>>>> space (though we use only 4K to access configuration space of any downstream B:D:F)
>>>
>>> Okay, sounds good. I'm wondering if we should maybe note here that
>>> window1 needs to be a 256 KiB window if that's what the hardware
>>> requires.
>> I'll be removing window1 and window2 as they seem to cause unnecessary confusion
>>
>>>
>>>>>> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Address
>>>>>> +             Translation Unit) registers of the PCIe core are made available
>>>>>> +             fow SW access.
>>>>>> +  "dbi": The aperture where root port's own configuration registers are
>>>>>> +         available
>>>>>
>>>>> This is slightly confusing because you already said in the description
>>>>> of "window1" that it is used to access the configuration space of the
>>>>> root port itself.
>>>>>
>>>>> Is the root port configuration space available via the regular
>>>>> configuration space registers?
>>>> Root port configuration space is hidden by default and 'dbi' property tells us
>>>> where we would like to *view* it. For this, we use a portion of window-1 aperture
>>>> and use it as 'dbi' base to *view* the config space of root port.
>>>> Basically Window-1 and window-2 are the umbrella entries (which I added based on
>>>> suggestion from Stephen Warren <swarren@nvidia.com> ) to give a complete picture of
>>>> number of apertures available and what they are used for. The windows 1 & 2 as such
>>>> are not used by the driver directly.
>>>
>>> So I'm not exactly sure I understand how this works. Does the "dbi"
>>> entry contain a physical address and size of the aperture that we want
>>> to map into a subregion of "window-1"? Is this part of a region where
>>> similar subregions exist for all of the controllers? Could the offset
>>> into such a region be derived from the controller ID?
>> DBI region is not available for SW immediately after power on. Address where we would
>> like to see 'dbi' needs to be programmed in one of the APPL registers. Since window1
>> is one of the apertures (under 4GB boundary) available for each controller (one window1
>> aperture per controller), we are reserving some portion of window1 to view DBI registers.
>> Provided 'window1' is available in DT, 'dbi' can be derived run time also. I added it
>> explicitly to so give more clarity on where it is being reserved (just like how window2
>> aperture usage is explicitly mentioned through 'ranges'). If the correct approach
>> is to have only 'window1' and derive 'dbi' in the code, I'll change it to that way.
>> Please let me know.
> 
> If there are no other requirements other than being in window1, then I
> think it's fine to drop "dbi" here. From what you say elsewhere the
> window1 aperture is 256 KiB and we can partition it as we like, right?
> If so, I don't think there's a need to expose it in a more fine-grained
> way.
window1 size is actually 32MB and we are partitioning it for different purposes
like 'dbi' (to view root port's own config space) and 'config' (to view downstream
devices config space) and 'atu_dma' (to view iATU and DMA registers)

> 
> One exception may be if other values in DT depend on the value. In that
> case it would be good to have them all in DT so that they can be
> validated.
Unfortunately we do have one exception that Designware sub-system expects 'config'
property as a mandatory property. Other implementations might be having that space
as fixed but in Tegra, it can be fit anywhere in window1 (for that matter, in window2
also). So,  since 'config' has to be there to be compliant with Designware core DT
expectations, I think is it better to have others ('dbi' & 'atu_dma') also fixed in DT
and drop 'window1' and 'window2' from DT altogether. (How 'window2' is being used
is already present in 'ranges' property). I hope this should be fine.

> 
> Having this information in two places technically would require us to
> check that the data is consistent. If we allocate from window1 at
> runtime, things become much easier.
> 
> [...]
>>>>>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>>>>>> +
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
>>>>>> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
>>>>>> +    bit-0 to '1' : disables advertisement of ASPM-L0s
>>>>>> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
>>>>>> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
>>>>>> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
>>>>>> +    bit-3 to '1' : disables advertisement of ASPM-L1.2
>>>>>
>>>>> These seem more like configuration options rather than hardware
>>>>> description.
>>>> Yes. Since the platforms like Jetson-Xavier based on T194 are going to go in
>>>> open market, we are providing these configuration options and hence they are
>>>> optional
>>>
>>> Under what circumstances would we want to disable certain ASPM states?
>>> My understanding is that PCI device drivers can already disable
>>> individual ASPM states if they don't support them, so why would we ever
>>> want to disable advertisement of certain ASPM states?
>> Well, this is given to give more flexibility while debugging and given that there is going
>> to be only one config for different platforms in future, it may be possible to have ASPM
>> config enabled by default and having this DT option would give more controlled enablement
>> of ASPM states by controlling the advertisement of ASPM states by root port.
> 
> Again, I think if this is primarily for debugging purposes I think there
> are better ways. If you need to modify and reflash the DTB in order to
> debug, that's suboptimal. Ideally you'd want something that you can just
> enable at runtime (via a module parameter, or a kernel command-line
> option, for example). That will allow you to do some debugging without
> having to rebuild and reflash.Agree that it is good to have controls during run-time. I'll make a note to look into
that in near future. Currently we already have a method to enable or disable ASPM i.e.
all states but there is no method to selectively enable/disable individual states.
Apart from debugging, other use case would be that, when a new platform is designed
and if the platform's POR (Plan Of Record) is to have only certain ASPM states to be
advertised by the root port, having this DT entry comes handy.

> 
>>>>>> +- nvidia,enable-power-down : Enables power down of respective controller and
>>>>>> +    corresponding PLLs if they are not shared by any other entity
>>>>>
>>>>> Wouldn't we want this to be the default? Why keep things powered up if
>>>>> they are not needed?
>>>> There could be platforms (automotive based), where it is not required to power down
>>>> controllers and hence needed a flag to control powering down of controllers
>>>
>>> Is it harmful to power down the controllers on such platforms? It
>>> strikes me as odd to leave something enabled if it isn't needed,
>>> independent of the platform.
>> It is not harmful as such. This is just a flexibility. Also, this might be required for
>> hot-plug feature.
>> Are you saying that we should have controller getting powered down as default and a flag
>> to stop that happening? i.e. something like 'nvidia,disable-power-down' ?
> 
> Yeah, I think by default we should always power down hardware if it
> isn't needed. But I don't see why we would need to disable power down.
> What's the use-case? You say this "might be required for hotplug", so
> it sounds like this is not something that has currently been tested? I
> prefer not to have bindings that are based on guesses, because that is
> likely to result in bindings that don't actually meet the real
> requirements and that becomes nasty to maintain in the long run. So if
> we don't currently have a case where we need to keep the controller
> powered on, let's just disable them by default and drop this from the
> bindings. We can always add this back in a backwards-compatible manner
> if it turns out that we do need it. At that point we'll also have more
> data about the context, so we can design better bindings.
At this point, I also don't have strong reasons to back it up. I'll drop
this for now and see if there comes any strong reason to have this support
back in future.

> 
>>>>>> +Tegra194:
>>>>>> +--------
>>>>>> +
>>>>>> +SoC DTSI:
>>>>>> +
>>>>>> +	pcie@14180000 {
>>>>>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>>>>>
>>>>> It doesn't seem to me like claiming compatibility with "snps,dw-pcie" is
>>>>> correct. There's a bunch of NVIDIA- or Tegra-specific properties below
>>>>> and code in the driver. Would this device be able to function if no
>>>>> driver was binding against the "nvidia,tegra194-pcie" compatible string?
>>>>> Would it work if you left that out? I don't think so, so we should also
>>>>> not list it here.
>>>> It is required for designware specific code to work properly. It is specified
>>>> by ../designware-pcie.txt file
>>>
>>> That sounds like a bug to me. Why does the driver need that? I mean the
>>> Tegra instantiation clearly isn't going to work if the driver matches on
>>> that compatible string, so by definition it is not compatible.
>>>
>>> Rob, was this intentional? Seems like all other users of the DesignWare
>>> PCIe core use the same scheme, so perhaps I'm missing something?
>> This is the standard usage procedure across all Designware based implementations.
>> Probably Rob can give more info on this.
> 
> If everyone does this, I suppose it's fine. Maybe Rob can confirm that
> this is really the way it was meant to be, or whether we should take
> action now before propagating this any further.
> 
> Thierry
> 


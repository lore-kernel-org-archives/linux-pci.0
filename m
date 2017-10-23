Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4507 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdJWRQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2017 13:16:22 -0400
Subject: Re: [PATCH V2 0/7] Tegra PCIe end point config space map code
 refactoring
To: Mikko Perttunen <cyndis@kapsi.fi>, Rob Herring <robh+dt@kernel.org>
CC: Thierry Reding <treding@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1508769312-12465-1-git-send-email-vidyas@nvidia.com>
 <CAL_Jsq+3UAwk5gNgh=s6O1f-MadyGCtADX7pyzX8eUfBqboRfA@mail.gmail.com>
 <fba4fe22-1401-1653-0985-e1ffafb29ded@nvidia.com>
 <1c898f3e-582f-27fe-7e01-f52a8b8ad538@kapsi.fi>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <6f7e9d04-6355-3cc8-fc37-8eb6f482f443@nvidia.com>
Date: Mon, 23 Oct 2017 22:43:04 +0530
MIME-Version: 1.0
In-Reply-To: <1c898f3e-582f-27fe-7e01-f52a8b8ad538@kapsi.fi>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 23 October 2017 09:46 PM, Mikko Perttunen wrote:
> On 10/23/2017 06:24 PM, Vidya Sagar wrote:
>>
>>
>> On Monday 23 October 2017 08:40 PM, Rob Herring wrote:
>>> On Mon, Oct 23, 2017 at 9:35 AM, Vidya Sagar <vidyas@nvidia.com> wrote:
>>>> PCIe host controller in Tegra SoCs has 1GB of aperture available
>>>> for mapping end points config space, IO and BARs. In that, currently
>>>> 256MB is being reserved for mapping end points configuration space
>>>> which leaves less memory space available for mapping end points BARs
>>>> on some of the platforms.
>>>> This patch series attempts to use only 4K space from 1GB aperture to
>>>> access end points configuration space.
>>>>
>>>> Currently, this change benefits T20 and T186 in saving (i.e. 
>>>> repurposed
>>>> to use for BAR mapping) physical space as well as kernel virtual 
>>>> mapping space,
>>>> it saves only kernel virtual address space in T30, T124, T132 and 
>>>> T210.
>>>>
>>>> NOTE: Both driver and DT changes are inter-dependent and hence need 
>>>> to go together
>>> You are breaking compatibility with any other OS.
>>>
>>> Can't this easily be solved within the kernel by adjusting the
>>> resource size? To save the virtual space, you only need patch 1 and
>>> don't need the DT change. The DT change is just for phys address space
>>> for BARs.
>> In case of T20 & T186, DT change is required to re-purpose address 
>> space which otherwise
>> is used for config space mapping to map BARs. In case of other chips, 
>> DT changes
>> are also required because the 4K being used for mapping config space 
>> is taken from the
>> last 4K chunk of 256MB instead of first 4K chunk to align with driver 
>> change.
>
> The kernel must continue to work with older device trees. This is a 
> pretty hard rule.
I think I can come up with a change only in driver to take care of this, 
although, to start with, I may not
be able to give more space for BAR mapping, but we can have a DT-only 
change later on for that.
>
> Mikko
>
>>>> Testing Done on T124, T210 & T186:
>>>>   Enumeration and basic functionality of immediate devices
>>>>   Enumeration of devices behind a PCIe switch
>>>>   Complete 4K configuration space access
>>>>
>>>> Vidya Sagar (7):
>>>>    PCI: tegra: refactor config space mapping code
>>>>    ARM: tegra: limit PCIe config space mapping to 4K for T20
>>>>    ARM: tegra: limit PCIe config space mapping to 4K for T30
>>>>    ARM: tegra: limit PCIe config space mapping to 4K for T124
>>>>    ARM64: tegra: limit PCIe config space mapping to 4K for T132
>>>>    ARM64: tegra: limit PCIe config space mapping to 4K for T210
>>>>    ARM64: tegra: limit PCIe config space mapping to 4K for T186
>>>>
>>>>   arch/arm/boot/dts/tegra124.dtsi          |   2 +-
>>>>   arch/arm/boot/dts/tegra20.dtsi           |   8 +--
>>>>   arch/arm/boot/dts/tegra30.dtsi           |   2 +-
>>>>   arch/arm64/boot/dts/nvidia/tegra132.dtsi |   2 +-
>>>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +--
>>>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi |   2 +-
>>>>   drivers/pci/host/pci-tegra.c             | 109 
>>>> +++++++++----------------------
>>>>   7 files changed, 42 insertions(+), 91 deletions(-)
>>>>
>>>> -- 
>>>> 2.7.4
>>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

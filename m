Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
To: Arnd Bergmann <arnd@arndb.de>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <725110094.6UkMkcy8u7@wuerfel> <566FF621.2040307@ti.com>
 <11176831.mhgJlIuj0S@wuerfel>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56700BC0.7020007@ti.com>
Date: Tue, 15 Dec 2015 18:16:56 +0530
MIME-Version: 1.0
In-Reply-To: <11176831.mhgJlIuj0S@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 15 December 2015 05:25 PM, Arnd Bergmann wrote:
> On Tuesday 15 December 2015 16:44:41 Kishon Vijay Abraham I wrote:
>> Hi Arnd,
>>
>> On Tuesday 15 December 2015 04:26 PM, Arnd Bergmann wrote:
>>> On Tuesday 15 December 2015 14:45:59 Kishon Vijay Abraham I wrote:
>>>> This series is basically to deprecate using phy-omap-control and use
>>>> syscon APIs to program the control module registers.
>>>>
>>>> Changes from v2:
>>>> No changes.
>>>>
>>>> Changes from v1:
>>>> *) cleanup ti_pipe3_probe in multiple steps
>>>> *) other minor cleanups
>>>>
>>>> Changes from [1] in PHY patches include
>>>> *) cleanup ti_pipe3_probe
>>>> *) have mask, power_on and power_off values in usb_phy_data for
>>>>    omap-usb2 phy
>>>>
>>>> The patches have been pushed to
>>>>         git://git.ti.com/linux-phy/linux-phy.git syscon
>>>>
>>>> [1] -> https://lkml.org/lkml/2015/6/23/189
>>>>
>>>> All the testing was done both before applying the dt patches and after
>>>> applying the dt patches (dt patches will be posted shortly).
>>>>
>>>
>>> Can you explain here what the conversion is good for? Why do you
>>> prefer the syscon mapping over a high-level driver in this case?
>>
>> phy-omap-control driver was added when there was no proper
>> infrastructure for doing control module initializations. The
>> phy-omap-control driver is not an 'actual' PHY driver and it
>> was just a hack to do PHY related control module initializations.
>> phy-omap-control is also getting unmanageable with the number of
>> platforms each having number of modules (like USB, SATA, PCIe),
>> using the same driver for control module initializations.
>>
>> Now with SYSCON framework being added to the kernel, phy-omap-control
>> shouldn't be needed and it also provides a uniform API across all the
>> modules to program the control module.
> 
> Ok, so the "phy-control" devices were really just a few registers of
> a system controller device that does a lot of other things as well, right?

right.
> 
> Can you put your description above into the cover-letter for the series,
> and the merge commit?

Sure.

Thanks
Kishon

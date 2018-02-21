Return-Path: <SRS0=fqZp=FP=cavium.com=George.Cherian@kernel.org>
Return-Path: <SRS0=fqZp=FP=cavium.com=George.Cherian@kernel.org>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Huang Ying <ying.huang@intel.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
Date: Wed, 21 Feb 2018 14:58:13 +0530
MIME-Version: 1.0
In-Reply-To: <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,


On 02/21/2018 12:30 AM, Bjorn Helgaas wrote:
> [+cc Huang]
> 
> On Tue, Feb 20, 2018 at 02:54:33AM +0100, Lukas Wunner wrote:
>> On Mon, Feb 19, 2018 at 12:21:56PM +0100, Rafael J. Wysocki wrote:
>>> On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
>>>> On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
>>>>> On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
>>>>>> On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
>>>>>>>> I don't know how this runtime PM works, but maybe Rafael can help
>>>>>>>> us out.
>>
>> This has nothing to do with runtime PM AFAICS.
>>
>> The device seems to be in D3hot on boot, is that correct?
> 
> I actually don't know for sure what device caused the issue or what
> state it was in.  George, if you could clarify that, it would be
> helpful.
> 
I will explain the setup used
To the Cavium ThunderX RC the following PLX device is connected.
PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 
GT/s) Switch
There is no device connected downstream to the PLX switch.

AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms 
since pci_bridge_d3_possible() returns true.

And later pci_sysfs_init() ends up doing a config access of PLX which 
fails with a "synchronous external abort"

> My assumption (possibly incorrect) is that the issue happens when we
> read config space of an endpoint behind a PCIe bridge that is in D3.
> The PCIe portdrv binds to the bridge before the pci_sysfs_init()
> late_initcall happens, and it enables runtime PM on the bridge, so
> it's possible the bridge is in D3 before pci_sysfs_init() happens.
> 
>> The PCI core assumes that unbound devices remain in D0
>> (see comments in pci_pm_runtime_resume() / pci_pm_runtime_suspend()).
> 
> That comment was added by 967577b06241 ("PCI/PM: Keep runtime PM
> enabled for unbound PCI devices"), apparently because "some devices do
> not work again after being put into D3".  That commit mentions
> https://bugzilla.kernel.org/show_bug.cgi?id=48201 but I don't think
> it's completely convincing about the requirement for keeping things in
> D0.
> 
> Even if it's true that some devices don't work after being in D3, that
> doesn't seem like sufficient reason to keep *all* devices on all
> systems in D0.  We would normally use quirks to address device issues
> like this.
> 
>>>>>>> I'm not sure what the question is to be honest.
>>>>>>
>>>>>> My questions are basically "What does the PCI core need to do to make
>>>>>> sure a device is in D0 before it operates on it?  And where do we need
>>>>>> to do that?"
>>
>> When scanning the bus and discovering the device is not in D0,
>> call pci_power_up().  This could probably go into pci_init_pm().
>> Once a driver binds to it, it may choose to runtime suspend it to
>> D3hot again.
> 
> s/pci_init_pm/pci_pm_init/
> 
> That's an interesting idea.  I hadn't thought of the case where a
> device is not in D0 when we enumerate it.  We *do* make sure bridges
> are in D0 before scanning behind them (pci_scan_bridge_extend() calls
> pm_runtime_get_sync()).
> 
> Since enumeration should only perform config accesses, and devices
> must respond to config accesses even when in D3hot, I guess I'm not
> convinced that we need to power up everything (other than bridges)
> during enumeration.
> 
> Bjorn
> 

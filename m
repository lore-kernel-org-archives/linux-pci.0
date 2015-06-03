Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556F1958.5050003@roeck-us.net>
Date: Wed, 03 Jun 2015 08:12:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net> <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon> <556DE1B9.6020100@roeck-us.net> <20150603103235.GC27917@red-moon>
In-Reply-To: <20150603103235.GC27917@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2015 03:32 AM, Lorenzo Pieralisi wrote:
> On Tue, Jun 02, 2015 at 06:02:49PM +0100, Guenter Roeck wrote:
>> On 06/02/2015 07:55 AM, Lorenzo Pieralisi wrote:
>>> Bjorn, Guenter,
>>>
>>> On Wed, May 27, 2015 at 10:04:47PM +0100, Bjorn Helgaas wrote:
>>>> [+cc Lorenzo, Suravee, Will]
>>>>
>>>> I cc'd Lorenzo, Suravee, and Will because Lorenzo is working on calling
>>>> pci_read_bases() from the PCI core instead of from arch code, and there are
>>>> likely some dependencies between these two things.
>>>>
>>>> On Fri, May 22, 2015 at 05:52:16PM -0700, Guenter Roeck wrote:
>>>>> The PCI subsystem always assumes that I/O is supported on PCIe bridges
>>>>> and tries to assign an I/O window to each port even if that is not
>>>>> the case.
>>>>>
>>>>> This may result in messages such as
>>>>>
>>>>> pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff]
>>>>> 					get_res_add_size add_size 1000
>>>>> pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
>>>>> pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
>>>>>
>>>>> for each bridge port, even if a port or its parent does not support
>>>>> I/O in the first place.
>>>>>
>>>>> To avoid this message, check if a port supports I/O before trying to
>>>>> enable it. Also check if port's parent supports I/O, and only modify
>>>>> a port's I/O resource size if both the port and its parent support I/O.
>>>>>
>>>>> If IO is disabled after the initial port scan, the IO base and size
>>>>> registers are set to 0x00f0 to indicate that IO is disabled. A later
>>>>> rescan interprets this as "IO supported" and enables the IO range,
>>>>> even if the parent does not support IO. Handle this situation as well.
>>>>>
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>> ---
>>>>>    drivers/pci/probe.c     | 14 ++++++++++++++
>>>>>    drivers/pci/setup-bus.c |  4 ++--
>>>>>    include/linux/pci.h     |  9 +++++++++
>>>>>    3 files changed, 25 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>> index 6675a7a1b9fc..f4944ef45148 100644
>>>>> --- a/drivers/pci/probe.c
>>>>> +++ b/drivers/pci/probe.c
>>>>> @@ -354,6 +354,20 @@ static void pci_read_bridge_io(struct pci_bus *child)
>>>>>    	base = (io_base_lo & io_mask) << 8;
>>>>>    	limit = (io_limit_lo & io_mask) << 8;
>>>>>
>>>>> +	/* If necessary, check if the bridge supports an I/O aperture */
>>>>> +	if (!io_base_lo && !io_limit_lo) {
>>>>> +		u16 io;
>>>>> +
>>>>> +		if (!pci_parent_supports_io(child))
>>>>> +			return;
>>>>> +
>>>>> +		pci_write_config_word(dev, PCI_IO_BASE, 0xe0f0);
>>>>> +		pci_read_config_word(dev, PCI_IO_BASE, &io);
>>>>> +		pci_write_config_word(dev, PCI_IO_BASE, 0x0);
>>>>> +		if (!io)
>>>>> +			return;
>>>>> +	}
>>>>
>>>> I really like the idea of pushing this into pci_read_bridge_io().
>>>>
>>>> I wonder if we can do the same with pci_read_bridge_mmio_pref(), and
>>>> somehow get rid of pci_bridge_check_ranges() altogether?
>>>>
>>>> I think I looked at doing that a while back, and it seems like there was
>>>> some wrinkle, but I don't remember what it was.
>>>
>>
>> After looking into this some more, I think the wrinkle may be that
>> pci_read_bridge_bases() and thus pci_read_bridge_io() isn't called
>> on probe-only systems (if PCI_PROBE_ONLY is set). A secondary
>
> That's what we would like to change :)
>
> https://lkml.org/lkml/2015/5/21/359

Yes, that should help. I had a brief look last night and concluded
that this would require changes all over the place, which your patch
pretty much confirms. Glad that you are tackling it - changes all over
the place spell trouble and would probably require more time than I have
available to spend on the problem.

>
>> problem is that pci_read_bridge_io() does not enable a resource
>> if it is explicitly disabled (base > limit), but the subsequent call
>> to pci_bridge_check_ranges() unconditionally enables it.
>>
>> Not really sure how to address this; my current code checks IO support
>> in both pci_read_bridge_io() and pci_bridge_check_ranges(). And since
>> pci_read_bridge_io() is not always called, I don't see how it might
>> be possible to get rid of pci_bridge_check_ranges(), or even the check
>> for IO support in pci_bridge_check_ranges().
>>
>>> While at it, do you think it is reasonable to also claim the bridge
>>> windows (resources) in the respective pci_read_bridge_* calls ?
>>>
>>> Is there a reason why we don't/can't do it ? I noticed that on
>>> PROBE_ONLY systems on ARM/ARM64 at the moment we do not claim
>>> the bridge apertures and this is not correct, see below:
>>>
>>> [5.980127] pcieport 0000:00:02.1: can't enable device: BAR 8
>>> [mem 0xbff00000 - 0xbfffffff] not claimed
>>> [5.988056] pcieport: probe of 0000:00:02.1 failed with error -22
>>>
>> Is this when trying my patches or with the current upstream code ?
>
> It is upstream code with a couple of ARM64 related patches not yet
> merged. Still, it shows an issue that must be tackled.
>
> It is not caused by your patches but it can be solved by them.
> On PROBE_ONLY systems, all resources must be claimed (since they
> are not reassigned, hence not claimed by the code that reassigns them),
> otherwise we can't enable a device resources (ie pcibios_enable_device
> calls pci_enable_resources that fails, since resources are not claimed).
>
> That's why we are suggesting claiming the bridge apertures as soon
> as they are read from the base registers, even on PROBE_ONLY systems.
>
> I think that's the only approach Bjorn would accept, otherwise
> we will have to fiddle with PROBE_ONLY on ARM64, and either avoid calling
> pci_enable_resources or avoid checking if a resource is claimed in
> pci_enable_resources, neither solution seems sane to me.
>

Looks like I'll need one of those arm64 systems at some point ;-).

Where is your patch in respect to acceptance ? Would it make sense to
merge it into my code and base my patch(es) on it, or do you expect
major changes which would make that difficult ?

Thanks,
Guenter


Return-Path: <SRS0=uwJQ=KD=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=uwJQ=KD=gmail.com=mr.nuke.me@kernel.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Bjorn Helgaas <helgaas@kernel.org>, Alex_Gagniuc@Dellteam.com
Cc: bhelgaas@google.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
 keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
 ariel.elior@cavium.com, michael.chan@broadcom.com, ganeshgr@chelsio.com,
 tariqt@mellanox.com, jakub.kicinski@netronome.com, talgi@mellanox.com,
 airlied@gmail.com, alexander.deucher@amd.com,
 Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <97a70a71e1034bafbcabc6c4e23577c0@ausx13mps321.AMER.DELL.COM>
 <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <8baf16fb-7e7c-ec59-19ef-a709e164dc94@gmail.com>
Date: Thu, 19 Jul 2018 10:46:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 07/18/2018 04:53 PM, Bjorn Helgaas wrote:
> [+cc Mike (hfi1)]
> 
> On Mon, Jul 16, 2018 at 10:28:35PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>> On 7/16/2018 4:17 PM, Bjorn Helgaas wrote:
>>>> ...
>>>> The easiest way to detect this is with pcie_print_link_status(),
>>>> since the bottleneck is usually the link that is downtrained. It's not
>>>> a perfect solution, but it works extremely well in most cases.
>>>
>>> This is an interesting idea.  I have two concerns:
>>>
>>> Some drivers already do this on their own, and we probably don't want
>>> duplicate output for those devices.  In most cases (ixgbe and mlx* are
>>> exceptions), the drivers do this unconditionally so we *could* remove
>>> it from the driver if we add it to the core.  The dmesg order would
>>> change, and the message wouldn't be associated with the driver as it
>>> now is.
>>
>> Oh, there are only 8 users of that. Even I could patch up the drivers to
>> remove the call, assuming we reach agreement about this change.
>>
>>> Also, I think some of the GPU devices might come up at a lower speed,
>>> then download firmware, then reset the device so it comes up at a
>>> higher speed.  I think this patch will make us complain about about
>>> the low initial speed, which might confuse users.
>>
>> I spoke to one of the PCIe spec writers. It's allowable for a device to
>> downtrain speed or width. It would also be extremely dumb to downtrain
>> with the intent to re-train at a higher speed later, but it's possible
>> devices do dumb stuff like that. That's why it's an informational
>> message, instead of a warning.
> 
> FWIW, here's some of the discussion related to hfi1 from [1]:
> 
>    > Btw, why is the driver configuring the PCIe link speed?  Isn't
>    > this something we should be handling in the PCI core?
> 
>    The device comes out of reset at the 5GT/s speed. The driver
>    downloads device firmware, programs PCIe registers, and co-ordinates
>    the transition to 8GT/s.
> 
>    This recipe is device specific and is therefore implemented in the
>    hfi1 driver built on top of PCI core functions and macros.
> 
> Also several DRM drivers seem to do this (see ),
> si_pcie_gen3_enable()); from [2]:
> 
>    My understanding was that some platfoms only bring up the link in gen 1
>    mode for compatibility reasons.
> 
> [1] https://lkml.kernel.org/r/32E1700B9017364D9B60AED9960492BC627FF54C@fmsmsx120.amr.corp.intel.com
> [2] https://lkml.kernel.org/r/BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com

Downtraining a link "for compatibility reasons" is one of those dumb 
things that devices do. I'm SURPRISED AMD HW does it, although it is 
perfectly permissible by PCIe spec.

>> Another case: Some devices (lower-end GPUs) use silicon (and marketing)
>> that advertises x16, but they're only routed for x8. I'm okay with
>> seeing an informational message in this case. In fact, I didn't know
>> that my Quadro card for three years is only wired for x8 until I was
>> testing this patch.
> 
> Yeah, it's probably OK.  I don't want bug reports from people who
> think something's broken when it's really just a hardware limitation
> of their system.  But hopefully the message is not alarming.

It looks fairly innocent:

[    0.749415] pci 0000:18:00.0: 4.000 Gb/s available PCIe bandwidth, 
limited by 5 GT/s x1 link at 0000:17:03.0 (capable of 15.752 Gb/s with 8 
GT/s x2 link)

>>> So I'm not sure whether it's better to do this in the core for all
>>> devices, or if we should just add it to the high-performance drivers
>>> that really care.
>>
>> You're thinking "do I really need that bandwidth" because I'm using a
>> function called "_bandwidth_". The point of the change is very far from
>> that: it is to help in system troubleshooting by detecting downtraining
>> conditions.
> 
> I'm not sure what you think I'm thinking :)  My question is whether
> it's worthwhile to print this extra information for *every* PCIe
> device, given that your use case is the tiny percentage of broken
> systems.

I think this information is a lot more useful than a bunch of other info 
that's printed. Is "type 00 class 0x088000" more valuable? What about 
"reg 0x20: [mem 0x9d950000-0x9d95ffff 64bit pref]", which is also 
available under /proc/iomem for those curious?

> If we only printed the info in the "bw_avail < bw_cap" case, i.e.,
> when the device is capable of more than it's getting, that would make
> a lot of sense to me.  The normal case line is more questionable.  I
> think the reason that's there is because the network drivers are very
> performance sensitive and like to see that info all the time.

I agree that can be an acceptable compromise.

> Maybe we need something like this:
> 
>    pcie_print_link_status(struct pci_dev *dev, int verbose)
>    {
>      ...
>      if (bw_avail >= bw_cap) {
>        if (verbose)
>          pci_info(dev, "... available PCIe bandwidth ...");
>      } else
>        pci_info(dev, "... available PCIe bandwidth, limited by ...");
>    }
> 
> So the core could print only the potential problems with:
> 
>    pcie_print_link_status(dev, 0);
> 
> and drivers that really care even if there's no problem could do:
> 
>    pcie_print_link_status(dev, 1);

Sounds good. I'll try to push out updated PATCH early next week.

>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> [snip]
>>>> +	/* Look from the device up to avoid downstream ports with no devices. */
>>>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>>>> +		return;
>>>
>>> Do we care about Upstream Ports here?
>>
>> YES! Switches. e.g. an x16 switch with 4x downstream ports could
>> downtrain at 8x and 4x, and we'd never catch it.
> 
> OK, I think I see your point: if the upstream port *could* do 16x but
> only trains to 4x, and two endpoints below it are both capable of 4x,
> the endpoints *think* they're happy but in fact they have to share 4x
> when they could use more.
> 
> Bjorn
> 

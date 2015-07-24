Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38668 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbGXDLU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 23:11:20 -0400
MIME-Version: 1.0
In-Reply-To: <CAC1AzdfwMxLJk9G5x7WSDO9QdaFDpVhCWdNSys5hDho9h1DhEA@mail.gmail.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
	<20150713093518.7e869d07@endymion.delvare>
	<CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
	<20150721165759.GD21967@google.com>
	<CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
	<20150722010950.GE3691@google.com>
	<CAC1AzdeY19ncJVhAOGS2J=tpa2VmnXv0CqO=AYDGY-fP=DiVCw@mail.gmail.com>
	<20150723172438.GB21967@google.com>
	<CAC1AzdfwMxLJk9G5x7WSDO9QdaFDpVhCWdNSys5hDho9h1DhEA@mail.gmail.com>
Date: Thu, 23 Jul 2015 22:11:19 -0500
Message-ID: <CAC1AzdfCuT2LHFPVZpwvSjAvVRSpsWY+eGPAt47kN5YD+5yosA@mail.gmail.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI devices
From: Jordan Hargrave <jharg93@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 9:31 PM, Jordan Hargrave <jharg93@gmail.com> wrote:
> On Thu, Jul 23, 2015 at 12:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Matthew for PCIe-SSD perspective]
>>
>> On Wed, Jul 22, 2015 at 03:07:46PM -0500, Jordan Hargrave wrote:
>>> On Tue, Jul 21, 2015 at 8:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> > On Tue, Jul 21, 2015 at 12:31:35PM -0500, Jordan Hargrave wrote:
>>> >> On Tue, Jul 21, 2015 at 11:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> >> > On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
>>> >> >> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
>>> >> >>
>>> >> >> > Hi Jordan,
>>> >> >> >
>>> >> >> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
>>> >> >> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
>>> >> >> > >
>>> >> >> > > There currently isn't an easy way to determine which PCI devices belong
>>> >> >> > to
>>> >> >> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
>>> >> >> > Slots).
>>> >> >> >
>>> >> >> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
>>> >> >> > same information?
>>> >> >> >
>>> >> >> > --
>>> >> >> > Jean Delvare
>>> >> >> > SUSE L3 Support
>>> >> >> >
>>> >> >>
>>> >> >> You can but it's as not easy to determine the slot number for leaf devices
>>> >> >> on bridges.  Eventually planning on using this for pulling slot number for
>>> >> >> identifying network cards and disk numbering for systemd
>>> >> >
>>> >> > Can you outline the problems with using dmidecode or libsmbios?
>>> >>
>>> >> Neither dmidecode nor libsmbios report the slot number for devices
>>> >> behind bridges in a slot.
>>> >
>>> > True, but it's straightforward to walk up the PCI tree in sysfs, e.g.,
>>> > given a path like /sys/devices/pci0000:00/0000:00:1c.5/0000:03:00.0/, it's
>>> > easy to see what the upstream bridges are.
>>> >
>>> It makes it more complicated I think. You have to check all functions
>>> on all devices as well on the walk to the root.
>>>
>>> Would it look something like this?
>>> while (pdev) {
>>>   if (pdev->bus->number == dslot->bus && PCI_SLOT(pdev->devfn) ==
>>> PCI_SLOT(dslot->devfn) &&
>>>      (pci_pcie_type(pdev) != PCI_ROOT_PORT || PCI_FUNC(pdev->devfn) ==
>>> PCI_FUNC(dslot->devfn))
>>>     return dslot->instance;
>>>   if (!pdev->bus->parent)
>>>     break;
>>>   pdev = pdev->bus->parent->self;
>>> }
>>>
>>> >> I'm wanting to use this sysfs variable to
>>> >> get slot numbers for systemd, so using libsmbios and dmidecode aren't
>>> >> very useful.
>>> >
>>> > If you want this in systemd, I see why you wouldn't want a command like
>>> > dmidecode.  Help me understand the problem with libsmbios.  Is it not
>>> > useful because (a) systemd doesn't want to link with it, or (b) libsmbios
>>> > doesn't have the right information, or (c) something else?
>>> >
>>> Linking with libsmbios would be a problem, and libsmbios doesn't have
>>> this info anyway.
>>>
>>> > It doesn't *look* like this is using any information that is only available
>>> > in the kernel, so in principle it seems like this could be done in
>>> > user-space.
>>> >
>>>
>>> I actually just got an email from someone who needs to determine the
>>> card slot number in their driver... so I've added an external callable
>>> 'pci_get_smbios_slot' function to enable this.
>>>
>>> >> We already report the index for embedded devices in
>>> >> pci-label.c, this code should have gone in at the same time.
>>> >>
>>> >> For example.  The SMBIOS entry for slot 3 is 40:00.0 There is a
>>> >> quad-port NIC in the slot with a bridge at 40:00.0
>>> >>
>>> >> 42:00.0 Bridge (sec=43, sub=45)
>>> >> 43:02.0 Bridge (sec=44, sub=44)
>>> >> 43:04.0 Bridge (sec=45, sub=45)
>>> >> 44:00.0 Ethernet
>>> >> 44:00.1 Ethernet
>>> >> 45:00.0 Ethernet
>>> >> 45:00.1 Ethernet
>>> >>
>>> >> So dmidecode only returns the slot number for 42:00.0 but not any
>>> >> child devices.  This code will provide a 'slot' sysfs variable that
>>> >> reports '3' for all devices under and including the bridge.
>>> >
>>> > What if the card in slot 3 is an adapter leading to an external PCI
>>> > chassis?  Wouldn't we then have a 'slot' file for every card in that
>>> > chassis, all containing '3'?  This sounds confusing, although it is true
>>> > that they all would be connected via the system board slot 3.
>>> >
>>> Yes that is correct.  Unless SMBIOS had a table of the second chassis.
>>>
>>> > Also, we do have the /sys/bus/pci/slots/ hierarchy already.  If we do put
>>> > something like this in the kernel, how would it relate to that hierarchy?
>>> > Could this SMBIOS stuff be integrated into that somehow?
>>> >
>>>
>>> /sys/bus/pci/slots only map a slot to a single PCI device.  systemd
>>> does use /sys/bus/pci/slots but it can't see the slot number on cards
>>> with bridges as the actual slot number is a parent.  And that's not
>>> easily to determine a parent device from the slots interface.  I'd
>>> really like something generic here. I'm also looking for some method
>>> for reporting bay/enclosure ID for PCIe-SSD devices.
>>>
>>> > We have a bit of a hodge-podge of slot names already, and I'd like to
>>> > simplify things if we can.
>>
>> We aren't really converging here yet.
>>
>> We need to figure out exactly what has to be done in the kernel because it
>> can't be done in user-space.  So far, your patch *looks* like it could (in
>> principle) be done in user-space, given a sysfs PCI hierarchy and the
>> SMBIOS information.
>
> It's a pain to do in user space as you have to read DMI information,
> then traverse PCI hierarchy until you find a match.  Every utility or
> code that wants to match a PCI device to a SMBIOS slot must reinvent
> the wheel.  biosdevname has its own code to read the entire SMBIOS
> table. It then reads in all pci devices and attempts to do a mapping.
> Why do this when the kernel already has this info easily available.
>
>>
>> The goal ("determine which PCI devices belong to system slots") is
>> definitely generic and useful.  We have quite a bit of slot stuff already
>> in the kernel, and some is already exposed via sysfs, so if we're still
>> missing what you need, it seems like the current code is off the rails
>> somewhere and should be fixed.
>>
>> Can we explore what you need in a little more detail, with some concrete
>> examples?  I heard:
>>
>>   - Systemd uses /sys/bus/pci/slots but gets the wrong slot information for
>>     cards with bridges on them.  Can you give an example including all the
>>     PCI devices involved and the related /sys/bus/pci/slots info so we can
>>     see exactly what's wrong?
>
> I created a quick and dirty module that populates /sys/bus/pci/slots:
>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/pci.h>
> #include <linux/dmi.h>
>
> static int __init kslot_init(void)
> {
>         const struct dmi_device *dmi;
>         struct dmi_dev_onboard *dslot;
>         struct pci_dev *sdev;
>
>         dmi = NULL;
>         while ((dmi = dmi_find_device(DMI_DEV_TYPE_SYSTEM_SLOT, NULL,
> dmi)) != NULL) {
>                 dslot = dmi->device_data;
>                 sdev = pci_get_domain_bus_and_slot(dslot->segment, dslot->bus,
>                                              dslot->devfn);
>                 if (!sdev)
>                         continue;
>                 pci_create_slot(sdev->bus, dslot->instance, dslot->dev.name,
>                                 NULL);
>                 pci_dev_put(sdev);
>         }
>         return 0;
> }
>
> static void __exit kslot_exit(void)
> {
> }
>
> module_init(kslot_init);
> module_exit(kslot_exit);
>
> MODULE_AUTHOR("jordan_hargrave@dell.com");
> MODULE_LICENSE("GPL");
> ===
>
> # ls -l /sys/bus/pci/slots
> total 0
> drwxr-xr-x 2 root root 0 Jul 23 21:43 PCI1
> drwxr-xr-x 2 root root 0 Jul 23 21:43 PCI2
> drwxr-xr-x 2 root root 0 Jul 23 21:43 PCI3
>
> # for X in /sys/bus/pci/slots/* ; do echo -n "$X = "; cat $X/address; done
> /sys/bus/pci/slots/PCI1 = 0000:41:01
> /sys/bus/pci/slots/PCI2 = 0000:42:02
> /sys/bus/pci/slots/PCI3 = 0000:04:03
>
> So one problem with this already is the string that gets output. It's
> <domain>:<bus>:<slot>   so you still have the problem of what about
> bus 43-45 that are children of bus 42.
>
> So wrote a script:
> #!/usr/bin/bash
> for X in /sys/bus/pci/devices/* ; do
>     RX=$(readlink -f $X)
>     for Z in /sys/bus/pci/slots/* ; do
>         NAME=$(basename $Z)
>         ADDR=$(cat $Z/address | cut -f1-2 -d:)
>         if [[ $RX =~ $ADDR ]] ; then
>             echo $RX,$NAME
>         fi
>     done
> done
>
> for each PCI device you have to iterate all devices in
> /sys/bus/pci/slots, and munge the 'address' to actually find a match
>
> output is:
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0,PCI3 [SMBIOS entry]
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.1,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.2,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.3,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.4,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.5,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.6,PCI3
> /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.7,PCI3
> /sys/devices/pci0000:40/0000:40:01.0/0000:41:00.0,PCI1 [SMBIOS entry]
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0,PCI2 [SMBIOS entry]
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:02.0,PCI2
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:04.0,PCI2
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:02.0/0000:44:00.0,PCI2
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:02.0/0000:44:00.1,PCI2
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:04.0/0000:45:00.0,PCI2
> /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:04.0/0000:45:00.1,PCI2
>
> And I'm not totally convinced this will work on some weird
> configurations I've seen of SMBIOS entries.  as in the B:D:F must
> match, not just the bus number.

Yeah just verified this won't work on this config.

I have a lspci output that defines the following bridges
(segment:bus:dev:func -> secondary:subordinate)
0000:00:01.0 -> 01:01
0000:00:02.0 -> 02:02
0000:00:03.0 -> 03:03 [SMBIOS Slot entry 1]
0000:00:03.2 -> 04:04 [SMBIOS Slot entry 2]
0000:00:1c.0 -> 05:05
0000:00:1c.4 -> 06:06

The SMBIOS table defines the following entries:
Descriptor: MEZZ1  ID:1 0000:00:03.0
Descriptor: MEZZ2  ID:2 0000:00:03.2

creating /sys/bus/pci/slots:
# ls -l /sys/bus/pci/slots/
total 0
drwxr-xr-x 2 root root 0 Jul 23 23:04 MEZZ1
drwxr-xr-x 2 root root 0 Jul 23 23:04 MEZZ2

# for X in /sys/bus/pci/slots/* ; do echo -n "$X = "; cat $X/address; done
/sys/bus/pci/slots/MEZZ1 = 0000:00:01
/sys/bus/pci/slots/MEZZ2 = 0000:00:02

Both entries are showing Bus 0 only... not 0:3.0 and 0:3.2
>
>>
>>   - A driver needs the card slot number.  A slot number seems like a user
>>     interface thing, so I'm surprised that a driver would be concerned with
>>     it.  And of course, SMBIOS is an arch-specific thing, so the driver
>>     would have to be able to get along without the slot number anyway.
>>
> pci_get_smbios_slot would just return -ENODEV or something on systems
> without SMBIOS.
>
>>   - PCIe-SSD bay/enclosure IDs.  Where would these IDs come from, and what
>>     sort of reporting mechanism are you looking for?  How are these
>>     structured?  Is there a separate PCIe device for every bay/enclosure
>>     ID, so there would be a 1:1 mapping from PCIe device to ID?
>>
> On our system the enclosure IDs actually come from IPMI commands.
> However you must query every PCI Bus number in the system to get the
> correct enclosure mapping.  Currently yes there is a 1:1 mapping.
>
>> Bjorn

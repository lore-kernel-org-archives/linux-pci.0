Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150722010950.GE3691@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
	<20150713093518.7e869d07@endymion.delvare>
	<CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
	<20150721165759.GD21967@google.com>
	<CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
	<20150722010950.GE3691@google.com>
Date: Wed, 22 Jul 2015 15:07:46 -0500
Message-ID: <CAC1AzdeY19ncJVhAOGS2J=tpa2VmnXv0CqO=AYDGY-fP=DiVCw@mail.gmail.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI devices
From: Jordan Hargrave <jharg93@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 8:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jul 21, 2015 at 12:31:35PM -0500, Jordan Hargrave wrote:
>> On Tue, Jul 21, 2015 at 11:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
>> >> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> >>
>> >> > Hi Jordan,
>> >> >
>> >> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
>> >> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
>> >> > >
>> >> > > There currently isn't an easy way to determine which PCI devices belong
>> >> > to
>> >> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
>> >> > Slots).
>> >> >
>> >> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
>> >> > same information?
>> >> >
>> >> > --
>> >> > Jean Delvare
>> >> > SUSE L3 Support
>> >> >
>> >>
>> >> You can but it's as not easy to determine the slot number for leaf devices
>> >> on bridges.  Eventually planning on using this for pulling slot number for
>> >> identifying network cards and disk numbering for systemd
>> >
>> > Can you outline the problems with using dmidecode or libsmbios?
>>
>> Neither dmidecode nor libsmbios report the slot number for devices
>> behind bridges in a slot.
>
> True, but it's straightforward to walk up the PCI tree in sysfs, e.g.,
> given a path like /sys/devices/pci0000:00/0000:00:1c.5/0000:03:00.0/, it's
> easy to see what the upstream bridges are.
>
It makes it more complicated I think. You have to check all functions
on all devices as well on the walk to the root.

Would it look something like this?
while (pdev) {
  if (pdev->bus->number == dslot->bus && PCI_SLOT(pdev->devfn) ==
PCI_SLOT(dslot->devfn) &&
     (pci_pcie_type(pdev) != PCI_ROOT_PORT || PCI_FUNC(pdev->devfn) ==
PCI_FUNC(dslot->devfn))
    return dslot->instance;
  if (!pdev->bus->parent)
    break;
  pdev = pdev->bus->parent->self;
}

>> I'm wanting to use this sysfs variable to
>> get slot numbers for systemd, so using libsmbios and dmidecode aren't
>> very useful.
>
> If you want this in systemd, I see why you wouldn't want a command like
> dmidecode.  Help me understand the problem with libsmbios.  Is it not
> useful because (a) systemd doesn't want to link with it, or (b) libsmbios
> doesn't have the right information, or (c) something else?
>
Linking with libsmbios would be a problem, and libsmbios doesn't have
this info anyway.

> It doesn't *look* like this is using any information that is only available
> in the kernel, so in principle it seems like this could be done in
> user-space.
>

I actually just got an email from someone who needs to determine the
card slot number in their driver... so I've added an external callable
'pci_get_smbios_slot' function to enable this.

>> We already report the index for embedded devices in
>> pci-label.c, this code should have gone in at the same time.
>>
>> For example.  The SMBIOS entry for slot 3 is 40:00.0 There is a
>> quad-port NIC in the slot with a bridge at 40:00.0
>>
>> 42:00.0 Bridge (sec=43, sub=45)
>> 43:02.0 Bridge (sec=44, sub=44)
>> 43:04.0 Bridge (sec=45, sub=45)
>> 44:00.0 Ethernet
>> 44:00.1 Ethernet
>> 45:00.0 Ethernet
>> 45:00.1 Ethernet
>>
>> So dmidecode only returns the slot number for 42:00.0 but not any
>> child devices.  This code will provide a 'slot' sysfs variable that
>> reports '3' for all devices under and including the bridge.
>
> What if the card in slot 3 is an adapter leading to an external PCI
> chassis?  Wouldn't we then have a 'slot' file for every card in that
> chassis, all containing '3'?  This sounds confusing, although it is true
> that they all would be connected via the system board slot 3.
>
Yes that is correct.  Unless SMBIOS had a table of the second chassis.

> Also, we do have the /sys/bus/pci/slots/ hierarchy already.  If we do put
> something like this in the kernel, how would it relate to that hierarchy?
> Could this SMBIOS stuff be integrated into that somehow?
>

/sys/bus/pci/slots only map a slot to a single PCI device.  systemd
does use /sys/bus/pci/slots but it can't see the slot number on cards
with bridges as the actual slot number is a parent.  And that's not
easily to determine a parent device from the slots interface.  I'd
really like something generic here. I'm also looking for some method
for reporting bay/enclosure ID for PCIe-SSD devices.

> We have a bit of a hodge-podge of slot names already, and I'd like to
> simplify things if we can.
>
> Bjorn

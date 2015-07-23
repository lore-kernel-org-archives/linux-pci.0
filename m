Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34762 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbbGWRYs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 13:24:48 -0400
Received: by obre1 with SMTP id e1so158979028obr.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 10:24:48 -0700 (PDT)
Date: Thu, 23 Jul 2015 12:24:38 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI
 devices
Message-ID: <20150723172438.GB21967@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
 <20150713093518.7e869d07@endymion.delvare>
 <CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
 <20150721165759.GD21967@google.com>
 <CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
 <20150722010950.GE3691@google.com>
 <CAC1AzdeY19ncJVhAOGS2J=tpa2VmnXv0CqO=AYDGY-fP=DiVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC1AzdeY19ncJVhAOGS2J=tpa2VmnXv0CqO=AYDGY-fP=DiVCw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matthew for PCIe-SSD perspective]

On Wed, Jul 22, 2015 at 03:07:46PM -0500, Jordan Hargrave wrote:
> On Tue, Jul 21, 2015 at 8:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Jul 21, 2015 at 12:31:35PM -0500, Jordan Hargrave wrote:
> >> On Tue, Jul 21, 2015 at 11:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
> >> >> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
> >> >>
> >> >> > Hi Jordan,
> >> >> >
> >> >> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
> >> >> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> >> >> > >
> >> >> > > There currently isn't an easy way to determine which PCI devices belong
> >> >> > to
> >> >> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
> >> >> > Slots).
> >> >> >
> >> >> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
> >> >> > same information?
> >> >> >
> >> >> > --
> >> >> > Jean Delvare
> >> >> > SUSE L3 Support
> >> >> >
> >> >>
> >> >> You can but it's as not easy to determine the slot number for leaf devices
> >> >> on bridges.  Eventually planning on using this for pulling slot number for
> >> >> identifying network cards and disk numbering for systemd
> >> >
> >> > Can you outline the problems with using dmidecode or libsmbios?
> >>
> >> Neither dmidecode nor libsmbios report the slot number for devices
> >> behind bridges in a slot.
> >
> > True, but it's straightforward to walk up the PCI tree in sysfs, e.g.,
> > given a path like /sys/devices/pci0000:00/0000:00:1c.5/0000:03:00.0/, it's
> > easy to see what the upstream bridges are.
> >
> It makes it more complicated I think. You have to check all functions
> on all devices as well on the walk to the root.
> 
> Would it look something like this?
> while (pdev) {
>   if (pdev->bus->number == dslot->bus && PCI_SLOT(pdev->devfn) ==
> PCI_SLOT(dslot->devfn) &&
>      (pci_pcie_type(pdev) != PCI_ROOT_PORT || PCI_FUNC(pdev->devfn) ==
> PCI_FUNC(dslot->devfn))
>     return dslot->instance;
>   if (!pdev->bus->parent)
>     break;
>   pdev = pdev->bus->parent->self;
> }
> 
> >> I'm wanting to use this sysfs variable to
> >> get slot numbers for systemd, so using libsmbios and dmidecode aren't
> >> very useful.
> >
> > If you want this in systemd, I see why you wouldn't want a command like
> > dmidecode.  Help me understand the problem with libsmbios.  Is it not
> > useful because (a) systemd doesn't want to link with it, or (b) libsmbios
> > doesn't have the right information, or (c) something else?
> >
> Linking with libsmbios would be a problem, and libsmbios doesn't have
> this info anyway.
> 
> > It doesn't *look* like this is using any information that is only available
> > in the kernel, so in principle it seems like this could be done in
> > user-space.
> >
> 
> I actually just got an email from someone who needs to determine the
> card slot number in their driver... so I've added an external callable
> 'pci_get_smbios_slot' function to enable this.
> 
> >> We already report the index for embedded devices in
> >> pci-label.c, this code should have gone in at the same time.
> >>
> >> For example.  The SMBIOS entry for slot 3 is 40:00.0 There is a
> >> quad-port NIC in the slot with a bridge at 40:00.0
> >>
> >> 42:00.0 Bridge (sec=43, sub=45)
> >> 43:02.0 Bridge (sec=44, sub=44)
> >> 43:04.0 Bridge (sec=45, sub=45)
> >> 44:00.0 Ethernet
> >> 44:00.1 Ethernet
> >> 45:00.0 Ethernet
> >> 45:00.1 Ethernet
> >>
> >> So dmidecode only returns the slot number for 42:00.0 but not any
> >> child devices.  This code will provide a 'slot' sysfs variable that
> >> reports '3' for all devices under and including the bridge.
> >
> > What if the card in slot 3 is an adapter leading to an external PCI
> > chassis?  Wouldn't we then have a 'slot' file for every card in that
> > chassis, all containing '3'?  This sounds confusing, although it is true
> > that they all would be connected via the system board slot 3.
> >
> Yes that is correct.  Unless SMBIOS had a table of the second chassis.
> 
> > Also, we do have the /sys/bus/pci/slots/ hierarchy already.  If we do put
> > something like this in the kernel, how would it relate to that hierarchy?
> > Could this SMBIOS stuff be integrated into that somehow?
> >
> 
> /sys/bus/pci/slots only map a slot to a single PCI device.  systemd
> does use /sys/bus/pci/slots but it can't see the slot number on cards
> with bridges as the actual slot number is a parent.  And that's not
> easily to determine a parent device from the slots interface.  I'd
> really like something generic here. I'm also looking for some method
> for reporting bay/enclosure ID for PCIe-SSD devices.
> 
> > We have a bit of a hodge-podge of slot names already, and I'd like to
> > simplify things if we can.

We aren't really converging here yet.

We need to figure out exactly what has to be done in the kernel because it
can't be done in user-space.  So far, your patch *looks* like it could (in
principle) be done in user-space, given a sysfs PCI hierarchy and the
SMBIOS information.

The goal ("determine which PCI devices belong to system slots") is
definitely generic and useful.  We have quite a bit of slot stuff already
in the kernel, and some is already exposed via sysfs, so if we're still
missing what you need, it seems like the current code is off the rails
somewhere and should be fixed.

Can we explore what you need in a little more detail, with some concrete
examples?  I heard:

  - Systemd uses /sys/bus/pci/slots but gets the wrong slot information for
    cards with bridges on them.  Can you give an example including all the
    PCI devices involved and the related /sys/bus/pci/slots info so we can
    see exactly what's wrong?

  - A driver needs the card slot number.  A slot number seems like a user
    interface thing, so I'm surprised that a driver would be concerned with
    it.  And of course, SMBIOS is an arch-specific thing, so the driver
    would have to be able to get along without the slot number anyway.

  - PCIe-SSD bay/enclosure IDs.  Where would these IDs come from, and what
    sort of reporting mechanism are you looking for?  How are these
    structured?  Is there a separate PCIe device for every bay/enclosure
    ID, so there would be a 1:1 mapping from PCIe device to ID?

Bjorn

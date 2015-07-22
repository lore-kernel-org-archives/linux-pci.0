Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 20:09:50 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI
 devices
Message-ID: <20150722010950.GE3691@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
 <20150713093518.7e869d07@endymion.delvare>
 <CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
 <20150721165759.GD21967@google.com>
 <CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 12:31:35PM -0500, Jordan Hargrave wrote:
> On Tue, Jul 21, 2015 at 11:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
> >> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
> >>
> >> > Hi Jordan,
> >> >
> >> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
> >> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> >> > >
> >> > > There currently isn't an easy way to determine which PCI devices belong
> >> > to
> >> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
> >> > Slots).
> >> >
> >> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
> >> > same information?
> >> >
> >> > --
> >> > Jean Delvare
> >> > SUSE L3 Support
> >> >
> >>
> >> You can but it's as not easy to determine the slot number for leaf devices
> >> on bridges.  Eventually planning on using this for pulling slot number for
> >> identifying network cards and disk numbering for systemd
> >
> > Can you outline the problems with using dmidecode or libsmbios?
> 
> Neither dmidecode nor libsmbios report the slot number for devices
> behind bridges in a slot.  

True, but it's straightforward to walk up the PCI tree in sysfs, e.g.,
given a path like /sys/devices/pci0000:00/0000:00:1c.5/0000:03:00.0/, it's
easy to see what the upstream bridges are.

> I'm wanting to use this sysfs variable to
> get slot numbers for systemd, so using libsmbios and dmidecode aren't
> very useful.

If you want this in systemd, I see why you wouldn't want a command like
dmidecode.  Help me understand the problem with libsmbios.  Is it not
useful because (a) systemd doesn't want to link with it, or (b) libsmbios
doesn't have the right information, or (c) something else?

It doesn't *look* like this is using any information that is only available
in the kernel, so in principle it seems like this could be done in
user-space.

> We already report the index for embedded devices in
> pci-label.c, this code should have gone in at the same time.
> 
> For example.  The SMBIOS entry for slot 3 is 40:00.0 There is a
> quad-port NIC in the slot with a bridge at 40:00.0
> 
> 42:00.0 Bridge (sec=43, sub=45)
> 43:02.0 Bridge (sec=44, sub=44)
> 43:04.0 Bridge (sec=45, sub=45)
> 44:00.0 Ethernet
> 44:00.1 Ethernet
> 45:00.0 Ethernet
> 45:00.1 Ethernet
> 
> So dmidecode only returns the slot number for 42:00.0 but not any
> child devices.  This code will provide a 'slot' sysfs variable that
> reports '3' for all devices under and including the bridge.

What if the card in slot 3 is an adapter leading to an external PCI
chassis?  Wouldn't we then have a 'slot' file for every card in that
chassis, all containing '3'?  This sounds confusing, although it is true
that they all would be connected via the system board slot 3.

Also, we do have the /sys/bus/pci/slots/ hierarchy already.  If we do put
something like this in the kernel, how would it relate to that hierarchy?
Could this SMBIOS stuff be integrated into that somehow?

We have a bit of a hodge-podge of slot names already, and I'd like to
simplify things if we can.

Bjorn

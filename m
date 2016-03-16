Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58095 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbcCPT3J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 15:29:09 -0400
Date: Wed, 16 Mar 2016 14:29:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI IO resource question.
Message-ID: <20160316192904.GA2703@localhost>
References: <56E987B8.1090904@ti.com>
 <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E9A12F.50008@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 02:08:47PM -0400, Murali Karicheri wrote:
> Bjorn,
> 
> Thanks for your quick response! Please see below some clarification
> and follow up question.
> 
> On 03/16/2016 12:45 PM, Bjorn Helgaas wrote:
> 0x1000]
> > 
> > Obviously if the host bridge doesn't support I/O port space, we will
> > be unable to assign space for I/O BARs, so you will see errors like
> > this.  
> > 
> > We may be able to improve the message and/or make this less noisy.
> > Guenter Roeck looked at a similar issue a while ago, but it's not
> > completely trivial:
> > 
> >   http://lkml.kernel.org/r/20150515172836.GA27797@svl-evodev-groeck.juniper.net
> > 
> > The PCI core should check in pci_enable_device() whether all the
> > device BARs have been assigned.  If not, it should fail.  But if a
> > driver doesn't need I/O space, it can use pci_enable_device_mem() to
> > indicate that it only needs the MEM BARs.  That should succeed even if
> > the I/O BARs aren't assigned.
> > 
> > Bottom line, if you omit I/O space on your host bridge:
> > 
> >   - You will see annoying "no space for" and "failed to assign" messages
> >   - Drivers that don't need I/O ports should still work
> >   - It's far better to have the messages than it was to pretend that
> >     the host bridge supported I/O space when it really didn't.
> > 
> >> [    0.448813] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
> >> [    0.448822] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
> >> [    0.448834] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
> >> [    0.448841] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
> >> [    0.448848] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
> >> [    0.448855] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
> >> [    0.448863] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
> >> [    0.448870] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
> >> [    0.448877] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
> >> [    0.448884] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
> >> [    0.448891] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
> >> [    0.448898] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
> >> [    0.448907] pci 0000:00:00.0: PCI bridge to [bus 01]
> >>
> >>
> >> The original log is below and even with the error, I am able to have SATA
> >> drive function as expected over this PCIe interface.
> >>
> >>
> >> [    0.420648] PCI host bridge /soc/pcie@21020000 ranges:
> >> [    0.420659]   No bus range found for /soc/pcie@21020000, using [bus 00-ff]
> >> [    0.420679]    IO 0x23260000..0x400023263fff -> 0x00000000
> >> [    0.420685] Requested IO range too big, new size set to 64K
> >> [    0.420702]   MEM 0x60000000..0x6fffffff -> 0x60000000
> >> [    0.420713] keystone-pcie 21021000.pcie: error -22: failed to map resource [io  0x0000-0x400000003fff]
> >> [    0.431849] keystone-pcie 21021000.pcie: PCI host bridge to bus 0000:00
> >> [    0.431861] pci_bus 0000:00: root bus resource [bus 00-ff]
> >> [    0.431870] pci_bus 0000:00: root bus resource [io  0x0000-0x400000003fff]
> > 
> > This range is obviously bogus, since it's way too big and not a nice
> > round size.  I guess this is what you're fixing.
> 
> Yes. But from your response, I gather it is better to remove the bogus range.
> I removed the range, and did a read/write test to the hard drive connected 
> to the Marvel SATA that is hooked to the PCIe interface and it still work
> without issues. 

If your bridge doesn't support I/O space, you should definitely remove
the range.

I'm curious about this Marvell SATA device, though.  It is this
device?

  pci 0000:01:00.0: [1b4b:9182] type 00 class 0x010601
  pci 0000:01:00.0: reg 0x10: [io  0x8000-0x8007] 
  pci 0000:01:00.0: reg 0x14: [io  0x8040-0x8043] 
  pci 0000:01:00.0: reg 0x18: [io  0x8100-0x8107] 
  pci 0000:01:00.0: reg 0x1c: [io  0x8140-0x8143] 
  pci 0000:01:00.0: reg 0x20: [io  0x800000-0x80000f]
  pci 0000:01:00.0: reg 0x24: [mem 0x00900000-0x009001ff]
  pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]

If so, it looks like it uses the drivers/ata/ahci.c driver, which uses
pcim_enable_device(), which should require all BARs to be assigned.
(It doesn't look like there is a pcim_enable_device_mem() variant.)

But if you're on an arm or arm64 platform and you have PCI_PROBE_ONLY
set, pcibios_enable_device() doesn't check whether resources are
assigned, so the problem would be masked.  We're trying to remove
PCI_PROBE_ONLY, or at least remove it from paths like this, so this
might become a problem soon.

This might be a reason to add a pcim_enable_device_mem() interface
that ahci_init_one() could use.  It looks like ahci_init_one() doesn't
actually depend on the I/O BAR.

> Another thing to worry about is the customers who are using custom
> fpga pci devices connected to the pcie bus and presently using 
> pci_enable_device() in their driver. So I guess if they fix their driver
> to use pci_enable_device_mem() instead, it should continue to work
> without issues, right? 

Yes.

If the FPGA PCI devices don't have I/O BARs, it doesn't matter whether
the driver uses pci_enable_device() or pci_enable_device_mem().  If
the device has an I/O BAR, but the driver doesn't need it, the driver
should use pci_enable_device_mem().  That will make it more portable.

Bjorn

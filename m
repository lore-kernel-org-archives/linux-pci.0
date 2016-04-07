Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43805 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017AbcDGOnh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Apr 2016 10:43:37 -0400
Date: Thu, 7 Apr 2016 09:43:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrew Wray <awray@lenovo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Martin Mares <mj@ucw.cz>
Subject: Re: FW: lspci doesn't decode physical slot correctly for adapters
 with PLX bridges
Message-ID: <20160407144333.GA5198@localhost>
References: <9B943C44AF111241BB5478325481A9DD288AF8A8@AEMAILMBX03.lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9B943C44AF111241BB5478325481A9DD288AF8A8@AEMAILMBX03.lenovo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin]

Hi Andy,

On Wed, Apr 06, 2016 at 10:53:52PM +0000, Andrew Wray wrote:
> On a Lenovo x3550 M5 system, with a multiport SAS HBA, lspci didn't decode the physical slot for the adapter correctly.
> 
> To clarify, the issue isn't with the dmidecode output, or the ACPI/SMBIOS tables on our systems, or the 'lspci' or 'lspci -t' output, but specficially the output of:
> 
> lspci -s <PCI bus:dev.func> -vvv | grep 'Physical Slot'
> 
> when the PCI bus:dev.func is used for an adapter that has a PLX bridge on it.  That is, the PCI bus:dev.func is used from running lspci | grep <substring of name of adapter> (that is, the PCI bus:dev.func is that of one of the PCI devices on the adapter, not the values for the slot, or the PLX itself).
> 
> The expectation is that if lspci is going to report a physical slot, it needs to back trace the PCI tree to a PCI bus:dev.func that corresponds to a slot, and report the information from there.
> 
> Here's an example:
> 
> In a particular DaAn (node n505) there is an Outback-4 card (N2226 12 Gbps SAS HBA) in slot 2.  The card can be found in lspci as follows:
> 
> > n505:~ # lspci | grep -i LSI
> > 83:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
> > 86:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
> 
> When checking the physical slot with lspci, for the first ASIC on the card (both lines above are from the same adapter), a clearly incorrect slot is shown:
> 
> > n505:~ # lspci -s 83:00.0 -vvv | grep 'Physical Slot'
> >         Physical Slot: 64

Based on sysfs_fill_slots() in lspci, I *think* the "Physical Slot"
comes from /sys/bus/pci/slots.  I'm not too clear on how the kernel
populates that, but at a quick glance, I don't see it looking at the
SMBIOS info.

Can you supply the output of these commands so we can try to figure
out what the kernel is reading from the hardware and how it populates
/sys/bus/pci/slots?

  grep -r . /sys/bus/pci/slots
  lspci -vv

If it's easier to attach these to a kernel.org bugzilla, you can do
that and just include a pointer here.

> Checking lspci -t -vvv, the PCI hierarchy for the card can be seen:
> 
> >  +-[0000:80]-+-02.0-[81-87]----00.0-[82-87]--+-00.0-[83-84]----00.0  LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3
> >  |           |                               +-08.0-[85]--
> >  |           |                               \-09.0-[86-87]----00.0  LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3
> 
> Going back up towards the root, we see 81-87, which is the only match to the dmidecode -t 9 output:

> > ...
> > Handle 0x003A, DMI type 9, 17 bytes
> > System Slot Information
> >       Designation: Slot 2
> >       Type: x16 PCI Express 3 x16
> >       Current Usage: In Use
> >       Length: <OUT OF SPEC>
> >       ID: 2
> >       Characteristics:
> >               3.3 V is provided
> >       Bus Address: 0000:81:00.0
> > ...

> Which then does correspond to slot 2.
> 
> If lspci went back up towards the PCI root to get the 81-87 value, it could have reported the correct PCI slot.

I know the kernel looks at the Physical Slot Number in the PCIe
capability, but I'm not sure it looks at SMBIOS.  So we need to figure
out what it's doing and what it *should* be doing.

Bjorn

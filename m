Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36639 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbHCW1d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 18:27:33 -0400
Received: by ioeg141 with SMTP id g141so159347258ioe.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 15:27:32 -0700 (PDT)
Date: Mon, 3 Aug 2015 17:27:26 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Barry Grussling <barry@grussling.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: Failure to HotPlug if devices not present at boot - no memory
 space
Message-ID: <20150803222726.GB11144@google.com>
References: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
 <CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
 <CABLseQ4eR5DyzSar+TwTOOJkq2_za2t47j-4RYPgQnNrZXmWiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABLseQ4eR5DyzSar+TwTOOJkq2_za2t47j-4RYPgQnNrZXmWiA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Mon, Aug 03, 2015 at 01:33:20PM -0700, Barry Grussling wrote:
> > Can you attach complete dmesg logs and "lspci -vv" output for both
> > cases?  (You can attach them to a kernel.org bugzilla if they're too
> > big for email.)
> >
> 
> Can do:
> https://bugzilla.kernel.org/show_bug.cgi?id=102231
> 
> > The dmesg logs will tell us what space is allocated to the host
> > bridge.  That is generally done by firmware or the bootloader, and
> > Linux doesn't change it.  So if firmware only assigns 0xc0000000 to
> > 0xc59fffff to the host bridge, the current Linux kernel will only
> > assign PCI devices inside that region; it will never expand the
> > region.
> Okay.  That makes sense.
> 
> We are using u-boot.  I don't believe our current u-boot build has any
> PCIe knowledge in it though.

You might have a host bridge driver that knows how to set up the
windows.  Your dmesg logs mention altera_hps2fpga_bridge, which
doesn't seem to be in the upstream kernel, so I don't know what it
does.

Both logs show this:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xcfffffff]
  pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff pref]

which means the top-level apertures are the same regardless of whether
08:00.0 is present at boot.  That means the PCI core should be able to
assign space for the hot-added device, at least in principle.

The log where 08:00.0 is present at boot shows this:

  pci 0000:08:00.0: [1aa9:0013] type 00 class 0x020000
  pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x000fffff] (size  1M)
  pci 0000:08:00.0: reg 0x14: [mem 0x00000000-0x00ffffff] (size 16M)
  pci 0000:08:00.0: reg 0x18: [mem 0x00000000-0x00ffffff] (size 16M)
  pci 0000:08:00.0: reg 0x1c: [mem 0x00000000-0x000003ff] (size  1K)
  pci 0000:08:00.0: reg 0x20: [mem 0x00000000-0x000003ff] (size  1K)
  pci 0000:08:00.0: reg 0x24: [mem 0x00000000-0x000003ff] (size  1K)

so it needs a little over 33M of space.

In the other log ("08:00.0 not present at boot"), we actually *do*
enumerate an 08:00.0 device:

  pci 0000:08:00.0: [1d00:0000] type 00 class 0x00001d
  pci 0000:08:00.0: reg 0x30: [mem 0x00001800-0x00001fff pref]

I don't know what this device is (lspci says "non-VGA unclassified
device") and it only requests 2K of space for an option ROM.  And the
log doesn't include the part where you hot-add the real device --
that's the interesting information should be.

I see that you already boot with "pcie=hpmemsize=256M", but that
doesn't help in this case because it's only used for hotplug bridges,
and 02:0f.0 (the Downstream Port leading to bus 08) is not marked as
hotplug-capable:

  02:0f.0 PCI bridge: PLX Technology, Inc. PEX 8619
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
      SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

I think if you could get the PCI_EXP_SLTCAP_HPC bit set for 02:0f.0,
and you booted with "pcie=hpmemsize=256M", it would likely work.  It's
possible it could be made to work even without that, but in general
it's hard to reserve the right amount of space for a bridge if you
don't know what might be plugged in later.

Bjorn

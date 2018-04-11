Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754892AbeDKVRX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Apr 2018 17:17:23 -0400
Date: Wed, 11 Apr 2018 16:17:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-ID: <20180411211722.GB145698@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
 <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
 <20180410185610.GD24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
 <20180411133334.GA91792@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111738260.18432@math.ut.ee>
 <20180411200143.GA105104@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804112323170.25495@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1804112323170.25495@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2018 at 11:25:06PM +0300, Meelis Roos wrote:
> > Thanks, this is really interesting.  Would you mind replacing the test
> > patch with the following (this applies directly on the upstream
> > kernel, e.g., fd3b36d27566)?
> > 
> > Sorry for the back and forth, but there's a lot going on here that I
> > don't understand.  
> > 
> > I'd like to see the complete dmesg log, /proc/iomem, and "lspci -vv".

Thanks, this helps a lot.  Things I learned or noticed:

1) Sparc exposes raw BAR values instead of CPU resource addresses
   because it implements pci_resource_to_user().  This means that on
   sparc, /sys/devices/pci*/resource and lspci show the raw BAR
   values, unlike most arches.

2) We select the ATI Rage XL device as the default VGA device.  The
   messages maybe could be improved because there's no bridge in the
   path, and the legacy resources are "not available" because the
   device's PCI_COMMAND_MEMORY and PCI_COMMAND_IO bits are disabled at
   boot (and probably enabled by the fb driver):

    pci 0000:00:13.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
    pci 0000:00:13.0: vgaarb: bridge control possible
    pci 0000:00:13.0: vgaarb: setting as boot device (VGA legacy resources not available)

3) With this patch, we do see a conflict between the VGA device and
   the ISA bridge, as I expected:

     pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus address [0x00000000-0xffffffff])
     pci 0000:00:07.0: reg 0x14: [mem 0x1ff00000000-0x1ff000fffff]
     pci 0000:00:13.0: can't claim VGA legacy [mem 0x1ff000a0000-0x1ff000bffff]: address conflict with 0000:00:07.0 [mem 0x1ff00000000-0x1ff000fffff]

I don't know how to resolve this conflict nicely.  Both the ISA bridge
at 00:07.0 and the VGA device at 00:13.0 can claim accesses to the
framebuffer at PCI address 0xa0000.

I don't know what (if anything) is behind the ISA bridge.  Maybe we
could disable it by clearing its PCI_COMMAND_MEMORY and PCI_COMMAND_IO
bits?

My plan for now is to post the "Request legacy VGA framebuffer only
for VGA devices" patch and to write a small vgaarb patch to clarify
the messages.  That will still leave us with the "can't claim VGA
legacy" message unless we can figure out something to do there.

Bjorn

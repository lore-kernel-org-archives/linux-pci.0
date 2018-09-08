Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:50095 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIHRAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Sep 2018 13:00:11 -0400
Date: Sat, 8 Sep 2018 14:14:22 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Drake <drake@endlessm.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        kherbst@redhat.com, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, keith.busch@intel.com,
        mika.westerberg@linux.intel.com, jonathan.derrick@intel.com,
        kugel@rockbox.org, davem@davemloft.net, hkallweit1@gmail.com,
        netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>,
        Luming Yu <luming.yu@intel.com>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
Message-ID: <20180908121422.GA10676@al>
References: <20180907053614.6540-1-drake@endlessm.com>
 <20180907150515.GA28739@al>
 <20180907222647.GD250890@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907222647.GD250890@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 05:26:47PM -0500, Bjorn Helgaas wrote:
> [+cc LKML, Dave, Luming]
> 
> On Fri, Sep 07, 2018 at 05:05:15PM +0200, Peter Wu wrote:
> > On Fri, Sep 07, 2018 at 01:36:14PM +0800, Daniel Drake wrote:
> > <..>
> > > Thomas Martitz reports that this workaround also solves an issue where
> > > the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> > > after S3 suspend/resume.
> > 
> > Where was this claimed? It is not stated in the linked bug:
> > (https://bugs.freedesktop.org/show_bug.cgi?id=105760
> > 
> > > On resume, reprogram the PCI bridge prefetch registers, including the
> > > magic register mentioned above.
> > > 
> > > This matches Win10 behaviour, which also rewrites these registers
> > > during S3 resume (checked with qemu tracing).
> > 
> > Windows 10 unconditionally rewrites these registers (BAR, I/O Base +
> > Limit, Memory Base + Limit, etc. from top to bottom), see annotations:
> > https://www.spinics.net/lists/linux-pci/msg75856.html
> > 
> > Linux has a generic "restore" operation that works backwards from the
> > end of the PCI config space to the beginning, see
> > pci_restore_config_space. Do you have a dmesg where you see the
> > "restoring config space at offset" messages?
> > 
> > Would it be reasonable to unconditionally write these registers in
> > pci_restore_config_dword, like Windows does?
> 
> That sounds reasonable to me.
> 
> We did write them unconditionally, prior to 04d9c1a1100b ("[PATCH]
> PCI: Improve PCI config space writeback") [1].  That commit apparently
> fixed suspend on some laptop.
> 
> But at that time, we restored the config space in order of dword 0, 1,
> 2, ... 15, which means we restored the command register before the
> BARs and windows, and it's conceivable that the problem was the
> ordering, not the rewriting of the same value.
> 
> Only a week later, we reversed the order with 8b8c8d280ab2 ("[PATCH]
> PCI: reverse pci config space restore order") [2], which seems like a
> good idea and even includes a spec reference.  I found similar
> language in the Intel ICH 10 datasheet, sec 14.1.3 [3].
> 
> So it seems reasonable to me to try writing them unconditionally in
> reverse order (the same order we use today).

Some fields are readonly (device/vendor ID), others have side-effects
(write-to-clear semantics like Master Data Parity Error in the Status
register).

So in addition to always write the registers, what about writing only a
subset? Following the logic applied by Windows, for Type-1:

- Restore memory-related stuff:
  - Restore BAR0 (offset 0x10, dword).
  - Restore BAR1 (offset 0x14, dword).
  - Restore I/O Base + Limit (offset 0x1c, WORD, not dword).
  - Restore Memory Base + Limit (offset 0x20, dword).
  - Restore Prefetchable Memory Base + Limit (offset 0x24, dword).
  - Restore Prefetchable Base Upper 32 bits (offset 0x28, dword).
    (+wait for 500us, why?)
  - Restore Prefetchable Limit Upper 32 bits (offset 0x2c, dword).
    (+wait for 500us, why?)
  - Restore I/O Base + Limit Upper 32 bits (offset 0x30, dword).
    (+wait for 500us, why?)
  - Restore Expansion ROM Address (offset 0x38, dword).
- Restore at offset 0x3c:
  - Restore Interrupt Line (offset 0x3c, byte).
  - Restore Bridge Control (offset 0x3e, word).
    (+read value again, why? Some kind of flush?)
- Restore at offset 0x18:
  - Restore Primary Bus Number (offset 0x18, byte).
  - Restore Secondary Bus Number (offset 0x19, byte).
  - Restore Subordinate Bus Number (offset 0x1a, byte).
  - (Restore Secondary Status (offset 0x1b, byte)? Not seen in Windows.)
- Restore at offset 0x0c:
  - Cacheline Size (offset 0x0c, byte).
  - Primary Latency Timer (offset 0x0d, byte).
- Restore at offset 0x04:
  - Restore command register.
    (+wait for 500us)
  - (Actually Windows clears BM+Mem+I/O bits, then sets
    PCIE.DeviceControl=7, PCIE.DeviceControl2=0 and then enables
    BM+Mem+I/O again).
  - Restore (or write to clear?) Status (offset 0x06, word).
- Note that the following fields are omitted (mostly readonly):
  - Device ID + Vendor ID (offset 0x00, dword).
  - Revision ID + Class Code  (offset 0x08, dword).
  - Header Type + BIST (offset 0x0e, byte + byte).
  - Capabilities Pointer + Reserved (offset 0x34, dword).
  - Interrupt Pin (offset 0x3d, byte).

This is more complicated than the current loop, but the logic of writing
addresses first and then configuring others sound reasonable to me.

Kind regards,
Peter

> 
> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=04d9c1a1100b
> [2] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8b8c8d280ab2
> [3] Intel ICH 10 IBL 373635

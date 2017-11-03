Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbdKCNy7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Nov 2017 09:54:59 -0400
Date: Fri, 3 Nov 2017 08:54:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Ruben Guerra Marin <ruben.guerra.marin@axon.tv>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>,
        "bharat.kumar.gogada@xilinx.com" <bharat.kumar.gogada@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Performance issues writing to PCIe in a Zynq
Message-ID: <20171103135457.GA8457@bhelgaas-glaptop.roam.corp.google.com>
References: <1509636637116.27702@axon.tv>
 <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 03, 2017 at 09:12:04AM +0100, Michal Simek wrote:
> On 2.11.2017 16:30, Ruben Guerra Marin wrote:
> > 
> > I have the a Zynq board running petalinux, and it is connected
> > through PCIe to a Virtex Ultrascale board. I configured the
> > Ultrascale for Tandem PCIe, which the second stage bitstream is
> > being programmed from the Zynq board (I crossed compiled the mcap
> > application that Xilinx provides).
> > 
> > This works perfectly, but takes around ~12 seconds to program the
> > second stage bitstream (compressed is ~12 MB), which is quite
> > slow. We also tried debugging the mcap application and pciutils.
> > We found out the operation that takes long to execute: In
> > pciutils, the instruction to actually call the write to the driver
> > (pwrite) takes approximately 6uS, so if you add up this for 12 MB
> > then you can see why it takes so long. Why is this so slow? Is
> > this maybe a problem with the driver?
> > 
> > For testing, I added an ILA to the AXI bus in between the Zynq GP1
> > and the PCIe IP control registers port. I triggered halfway the
> > programming of the bitstream using the mcap program provided by
> > Xilinx. I can see that it is writing to address x358, which
> > according to the *datasheet*
> > (https://www.xilinx.com/Attachment/Xilinx_Answer_64761__UltraScale_Devices.pdf)
> > is the Write Data Register, which is correct (and again, I know
> > the whole bitstream gets programmed correctly).
> > 
> > But what I also see is that a "awvalid" being asserted to the next
> > one it takes 245 cycles, and I can imagine this is why it takes 12
> > seconds to program a 12MB bitstream.

How long do you expect this to take?  What are the corresponding times
on other hardware or other OSes?

It sounds like this programming is done via config accesses, which are
definitely not a fast path, so I don't know if 12s is unreasonably
slow or not.  The largest config write is 4 bytes, which means 12MB
requires 3M writes, and if each takes 6us, that's 18s total.

Most platforms serialize config accesses with a lock, which also slows
things down.  It looks like your hardware might support ECAM, which
means you might be able to remove the locking overhead by using
lockless config (see CONFIG_PCI_LOCKLESS_CONFIG).  This is a new
feature currently only used by x86, and it's currently a system-wide
compile-time switch, so it would require some work for you to use it.

The high bandwidth way to do this would be use a BAR and do PCI memory
writes instead of PCI config writes.  Obviously the adapter determines
whether this is possible.

Bjorn

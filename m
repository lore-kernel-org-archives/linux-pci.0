Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54038 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaBRUPl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 15:15:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 21:15:12 +0100
Message-ID: <3220206.h6hgmMzWTX@wuerfel>
In-Reply-To: <20140218184420.GD2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <20140218182142.GF29304@obsidianresearch.com> <20140218184420.GD2010@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 18:44:20 Will Deacon wrote:
> On Tue, Feb 18, 2014 at 06:21:42PM +0000, Jason Gunthorpe wrote:
> > On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> > > +
> > > +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> > > +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
> >                                            ^^^^^^^^^^^^^^
> > 
> > This probably shouldn't be 0 in the example, nor in your kvm tool
> > output. For example purposes any value will do.
> 
> Hmm, so kvmtool actually provides a PC ioport at 0x0, which is handy since
> there's an 8250 down there. That means we have:
> 
> 0x0    - 0x6200  : Weird PC stuff
> 0x6200 - 0x10000 : PCI IO space
> 
> Should I just change everything to be offset by 0x6200?

Some more comments about this:

* After I looked at the kvmtool code some more, I think it would be nice to
  actually move the I/O space window to a nonzero location, e.g. between the
  PCI space and the AXI space. It's really confusing the way it is, and easy
  to introduce bugs if you have any code that accidentally relies on the
  numbers matching up. For all I can tell, kvmtool should just work fine
  with any definition of ARM_IOPORT_AREA, as long as you apply the trivial
  patch below.

* pci_get_io_space_block() is a very confusing name for a function that
  allocates a memory space block in kvmtool. It seems that KVM_IOPORT_AREA
  is a misnomer for the same reason. Note that PowerPC sets KVM_IOPORT_AREA
  to zero, but has the I/O space window at SPAPR_PCI_IO_WIN_ADDR, 
  which is non-zero.

* It's interesting that you also support I/O space access to the PCI config
  space through PC-Style ports 0cf8-0cff. Not sure if that helps at all,
  but it is another standard way to probe the bus that could easily be
  implemented as an alternative to CAM and ECAM, in a generic PCI host
  driver.

	Arnd

diff --git a/tools/kvm/arm/kvm-cpu.c b/tools/kvm/arm/kvm-cpu.c
index b017994..caf9a57 100644
--- a/tools/kvm/arm/kvm-cpu.c
+++ b/tools/kvm/arm/kvm-cpu.c
@@ -105,7 +105,7 @@ bool kvm_cpu__emulate_mmio(struct kvm *kvm, u64 phys_addr, u8 *data, u32 len,
 		return kvm__emulate_mmio(kvm, phys_addr, data, len, is_write);
 	} else if (arm_addr_in_ioport_region(phys_addr)) {
 		int direction = is_write ? KVM_EXIT_IO_OUT : KVM_EXIT_IO_IN;
-		u16 port = phys_addr & USHRT_MAX;
+		u16 port = (phys_addr - ARM_IOPORT_AREA) & USHRT_MAX;
 		return kvm__emulate_io(kvm, port, data, direction, len, 1);
 	} else if (arm_addr_in_pci_region(phys_addr)) {
 		return kvm__emulate_mmio(kvm, phys_addr, data, len, is_write);


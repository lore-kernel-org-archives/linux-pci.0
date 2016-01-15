Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54098 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639AbcAOVtF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 16:49:05 -0500
Date: Fri, 15 Jan 2016 15:49:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Veal, Bryan E." <bryan.e.veal@intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115214902.GA10272@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <20160115193103.GA2249@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115193103.GA2249@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 11:31:03AM -0800, Veal, Bryan E. wrote:
> On Fri, Jan 15, 2016 at 12:19:38PM -0600, Bjorn Helgaas wrote:
> > I also have a more substantive question about the flags setup.  I
> > think you should not clear IORESOURCE_MEM_64.  The intent of
> > IORESOURCE_MEM_64 is to describe the *capability* of a BAR, not its
> > contents.  But I assume you cleared it for a reason.  vmd->resources[n]
> > are not BARs, so the PCI core won't assign resources to them like it
> > does for BAR, so we shouldn't care about IORESOURCE_MEM_64 for that
> > reason.  Is there some other reason IORESOURCE_MEM_64 makes a
> > difference there?
> 
> I did this to fix an issue in pre-RFC code.

Even though you found this issue before posting the RFC code, I assume
the issue is still relevant in the current code, and you still want to
clear IORESOURCE_MEM_64, right?

> The flag is subtly restrictive in one specific scenario: spec-compliant
> PCIe ports lack the ability to specify a 64-bit, non-prefetchable range.

Right; I think this is just a consequence of PCIe ports being PCI
bridges, and bridges having:

  - optional 32-bit I/O window
  - required 32-bit non-prefetchable memory window
  - optional prefetchable memory window (either 32-bit or 64-bit)

If we have a device with a 64-bit non-prefetchable BAR, we can assign
a 64-bit address if the device is on a root bus and the host bridge
has a 64-bit non-prefetchable window.  Otherwise, the device is below
a P2P bridge and we have to assign space from the 32-bit
non-prefetchable window.

So far this is all standard PCI stuff, not VMD- or even PCIe-specific.

> IORESOURCE_MEM_64 directs the PCI subsystem to put the address into the
> 64-bit *prefetchable* range. 

This is where I get confused.  IORESOURCE_MEM_64 *should* mean "the
hardware register associated with this resource can accommodate a
64-bit value."  If we're using IORESOURCE_MEM_64 to decide whether to
use a prefetchable vs. a non-prefetchable window, that sounds broken.

Can you point me to the relevant code, and maybe give an example?  I'm
pretty sure the code doesn't completely match the spec, and maybe this
is a case where we have to set the flags non-intuitively to get the
desired result.

> Below the port, the "prefetchable" propoerty
> *is* restrictive: the addresses can't be used for non-prefetchable BARs.
> 
> Thus, in the specific case where a 64-bit non-prefetchable VMD bar happens
> to contain a 32-bit address, removing the IORESOURCE_MEM_64 flag allows
> the address resource to be used for *any* non-prefetchable BARs (32-bit or
> 64-bit) downstream.  

If I understand correctly, these VMD BARs (VMD_MEMBAR1 and
VMD_MEMBAR2) effectively become the host bridge windows available for
devices below the VMD.

I infer that if the VMD host bridge window is non-prefetchable and has
IORESOURCE_MEM_64 set, we won't put a 32-bit non-prefetchable BAR in
that window.  That sounds like a bug, but let me be the first to admit
that I don't understand our PCI resource allocation code.

BTW, I forgot to ask about the 0x2000 offset applied to VMD_MEMBAR2.
Can we add a comment about what that offset is doing?

BTW2, is one of these (VMD_MEMBAR1 and VMD_MEMBAR2) prefetchable and
the other non-prefetchable?  If so, a comment would really help.

Bjorn

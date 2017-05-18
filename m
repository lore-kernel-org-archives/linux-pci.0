Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753786AbdEROF4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 May 2017 10:05:56 -0400
Date: Thu, 18 May 2017 09:05:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR
 configuration to be preserved
Message-ID: <20170518140553.GA22106@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9T7vH_LbKfS_40JUbLNK4PYrMi++eKbCq_MzBsuQxUDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu9T7vH_LbKfS_40JUbLNK4PYrMi++eKbCq_MzBsuQxUDQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 11:59:14AM +0100, Ard Biesheuvel wrote:
> On 17 May 2017 at 22:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Apr 11, 2017 at 05:33:11PM +0100, Ard Biesheuvel wrote:
> >> This is a followup to the discussion regarding whether ACPI/arm64 systems
> >> should preserve the PCI configuration performed by the firmware, or always
> >> reconfigure it from scratch.
> >>
> >> This series proposes to put it under the control of the firmware, by invoking
> >> the _DSM method, and preserving the firmware configuration only when it
> >> returns 0.
> >>
> >> Patch #1 is a preparatory bugfix that solves the issue that I/O bridge
> >> windows starting at 0x0 are dismissed when looking for parent resources.
> >>
> >> Patch #2 adds the logic to invoke the _DSM and claim the existing
> >> configuration rather than reallocate it from scratch if it returns '0'
> >>
> >> Ard Biesheuvel (2):
> >>   drivers: pci: do not disregard parent resources starting at 0x0
> >>   arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup
> >>
> >>  arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
> >>  drivers/pci/pci.c        |  2 +-
> >>  include/linux/pci-acpi.h |  7 ++++---
> >>  3 files changed, 23 insertions(+), 6 deletions(-)
> >
> > I applied the first to pci/resource for v4.13.  I didn't do anything
> > with the second because I don't think we have consensus on what the
> > right thing to do is yet.
> 
> Thanks Bjorn.
> 
> Re PCI reconfiguration: currently, the EFI framebuffer is broken on
> all systems where the associated BAR lives on a device that is not on
> bus 0, which is of course everything other than QEMU (which cannot use
> the EFI framebuffer for other reasons when running under KVM)

I don't know much about the EFI framebuffer.  It doesn't look like
efifb.c does any runtime calls to EFI.  Is that code basically just
a way to discover the address & size of the frame buffer from EFI
information?

I don't see the connection to bus 0.  As long as we figure out the
buffer address and configure bridges so the buffer is routed to the
device, the location in the bus hierarchy shouldn't matter.

> So the first question is whether anyone cares. I do, but not deeply:
> the EFI framebuffer, while useful in cases where there is no real GFC
> driver, is a bit of a hack anyway.
> 
> Then we have the question whether we can work around it in another
> way: I already proposed an alternative patch which simply records the
> associated BAR before PCI is reconfigured, and refuses to enable EFIFB
> if the BAR has moves. This is a workaround rather than a real fix, but
> in many cases, the kernel and UEFI appear to arrive at similar
> conclusions regarding where to put the framebuffer BAR, probably
> because of the simple reason that its size (ergo alignment) will cause
> it to be allocated first.

This is reminiscent of an issue with IOMMU descriptions: IIRC, DMAR
and related tables are based on the current bus numbering scheme, and
if we renumber buses, we have to remember the "boot-time to current"
mapping to interpret the tables (I'm not sure we actually do this
today).  Maybe we need some sort of similar mapping for BARs.

> Re _DSM: I think it makes sense to honour it, because it puts the
> allocation under the control of the firmware, which completely removes
> the burden of having to reason about a policy in the kernel. That
> leaves the question which will be the default, but that is of minor
> importance IMO.

I agree; we should try to follow the spec unless we have a good reason
not to, which argues for honoring the _DSM, so I think it's worth a
try.  Booting with "pci=realloc" could override the _DSM and taint the
kernel (because we don't know the effect of reassigning something the
firmware told us not to touch).

Bjorn

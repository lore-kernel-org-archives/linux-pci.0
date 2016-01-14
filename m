Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41409 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbcANTb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 14:31:27 -0500
Date: Thu, 14 Jan 2016 11:27:54 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, david.daney@cavium.com
Subject: Re: [RFC PATCH] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
Message-ID: <20160114192754.GA3381@sean.stalley.intel.com>
References: <20160114172645.23429.9938.stgit@gimli.home>
 <5697EEF8.30406@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5697EEF8.30406@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 14, 2016 at 10:54:48AM -0800, David Daney wrote:
> On 01/14/2016 09:26 AM, Alex Williamson wrote:
> >We've done a pretty good job of abstracting EA from drivers, but there
> >are some properties of BAR Equivalent resources that don't really jive
> >with traditional PCI BARs.  In particular, natural alignment is only
> >encouraged, not required.
> >
> >Why does this matter?  There are drivers like vfio-pci that will
> >happily gobble up the EA abstraction that's been implemented and
> >expose a device using EA to userspace as if those resources are
> >traditional BARs.  Pretty cool.  The vfio API is bus agnostic, so it
> >doesn't care about alignment.  The problem comes with PCI config space
> >emulation where we don't let userspace manipulate the BAR value, but
> >we do emulate BAR sizing.  The abstraction kind of falls apart if
> >userspace gets garbage when they try to size what appears to be a
> >traditional BAR, but is actually a BAR equivalent.
> >
> >We could simply round up the size in vfio to make it naturally
> >aligned, but then we're imposing artificial sizes to the user and we
> >have the discontinuity that BAR size emulation and vfio region size
> >reporting don't agree on the size.  I think what we want to do is
> >expose EA to the user, reporting traditional BARs with BEIs as
> >zero-sized and providing additional regions for the user to access
> >each EA region, whether it has a BEI or not.
> >
> >To facilitate that, a flag indicating whether a PCI resource is a
> >traditional BAR or BAR equivalent seems much nicer than attempting
> >to size the BAR ourselves or deducing it through the EA capability.
> >
> >Thoughts?
> 
> Is the flag exposed to userspace in any way?

Yes. Resources are exposed through a sysfs file.
(/sys/bus/pci/devices/[Device Number]/resource)
This file contains the resource range, as well as the flags.

> I haven't dug into what uses the flags.
> 
> One problem we have seen is with the lspci utility which cannot
> distinguish between SROIV BARs and EA provisioned BARs.
> 
> Would, or could, this be used there?

This flag would let us distinguish between EA BARs & SRIOV BARs in lspci.

When lspci sees a resource in the sysfs file without a matching BAR
in configspace, it assumes that the BAR comes from an SRIOV entry.
This was a good assumption until EA showed up.

The only case in lspci that this flag wouldn't handle is when the
resource is provisioned through EA & SRIOV (ie: BEI 9-14).
lspci would only flag the resource as EA.

-Sean

> 
> David Daney
> 
> 
> >
> >Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >---
> >  drivers/pci/pci.c      |    2 +-
> >  include/linux/ioport.h |    2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >index 314db8c..174c734 100644
> >--- a/drivers/pci/pci.c
> >+++ b/drivers/pci/pci.c
> >@@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
> >
> >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> >  {
> >-	unsigned long flags = IORESOURCE_PCI_FIXED;
> >+	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
> >
> >  	switch (prop) {
> >  	case PCI_EA_P_MEM:
> >diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> >index 24bea08..5acc194 100644
> >--- a/include/linux/ioport.h
> >+++ b/include/linux/ioport.h
> >@@ -105,6 +105,8 @@ struct resource {
> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> >
> >+/* PCI Enhanced Allocation defined BAR equivalent resource */
> >+#define IORESOURCE_PCI_EA_BEI		(1<<5)
> >
> >  /* helpers to define resources */
> >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> >
> 

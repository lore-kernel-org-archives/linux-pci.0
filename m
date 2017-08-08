Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbdHHUpJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 16:45:09 -0400
Date: Tue, 8 Aug 2017 15:45:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v6 1/6] PCI: Move enum pci_interrupt_pin to a new common
 header
Message-ID: <20170808204506.GA21796@bhelgaas-glaptop.roam.corp.google.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
 <20170806000351.17952-2-paul.burton@imgtec.com>
 <20170808202745.GL16580@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808202745.GL16580@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 08, 2017 at 03:27:45PM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 05, 2017 at 05:03:46PM -0700, Paul Burton wrote:
> > We currently have a definition of enum pci_interrupt_pin in a header
> > specific to PCI endpoints - pci-epf.h. In order to allow for use of this
> > enum from PCI host code in a future commit, move its definition to a new
> > pci-common.h header which we'll include from both host & endpoint code.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > 
> > ---
> > 
> > Changes in v6:
> > - New patch.
> > 
> >  include/linux/pci-common.h | 31 +++++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h    |  9 +--------
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >  create mode 100644 include/linux/pci-common.h
> > 
> > diff --git a/include/linux/pci-common.h b/include/linux/pci-common.h
> > new file mode 100644
> > index 000000000000..6a69a2c95ac7
> > --- /dev/null
> > +++ b/include/linux/pci-common.h
> > @@ -0,0 +1,31 @@
> > +/**
> > + * Common PCI definitions
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 of
> > + * the License as published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __LINUX_PCI_COMMON_H__
> > +#define __LINUX_PCI_COMMON_H__
> > +
> > +/**
> > + * enum pci_interrupt_pin - PCI INTx interrupt values
> > + * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
> > + * @PCI_INTERRUPT_INTA: PCI INTA pin
> > + * @PCI_INTERRUPT_INTB: PCI INTB pin
> > + * @PCI_INTERRUPT_INTC: PCI INTC pin
> > + * @PCI_INTERRUPT_INTD: PCI INTD pin
> > + *
> > + * Corresponds to values for legacy PCI INTx interrupts, as can be found in the
> > + * PCI_INTERRUPT_PIN register.
> > + */
> > +enum pci_interrupt_pin {
> > +	PCI_INTERRUPT_UNKNOWN,
> > +	PCI_INTERRUPT_INTA,
> > +	PCI_INTERRUPT_INTB,
> > +	PCI_INTERRUPT_INTC,
> > +	PCI_INTERRUPT_INTD,
> > +};
> 
> Could this (and the new pci_irqd_intx_xlate() added in the next patch)
> go in drivers/pci/pci.h instead?
> 
> If pci_irqd_intx_xlate() needs to be in include/linux/pci.h, is there
> a reason this enum couldn't go there as well?

Also, I'd kind of like to have a PCI_NUM_INTX or similar that all the
drivers could use instead of defining their own.

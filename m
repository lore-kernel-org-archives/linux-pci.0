Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40861 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193Ab2HOT5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Aug 2012 15:57:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / ACPI: Do not request control of ASPM if the BIOS has disabled it
Date: Wed, 15 Aug 2012 22:03:48 +0200
Cc: Len Brown <lenb@kernel.org>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Wei Kong <wkong@novell.com>, Jean Delvare <jdelvare@suse.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
References: <201205242245.45888.rjw@sisk.pl> <CAErSpo4LQsWH7eX=3YNSGUdZjNyMQeyoZPrx2ZUto3gWLYSWEQ@mail.gmail.com>
In-Reply-To: <CAErSpo4LQsWH7eX=3YNSGUdZjNyMQeyoZPrx2ZUto3gWLYSWEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208152203.48377.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 15, 2012, Bjorn Helgaas wrote:
> On Thu, May 24, 2012 at 2:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > We want to report that the kernel supports ASPM to the BIOS even if
> > the BIOS signals us that it doesn't.  So, we need the flags to include
> > (OSC_ACTIVE_STATE_PWR_SUPPORT | OSC_CLOCK_PWR_CAPABILITY_SUPPORT)
> > before calling acpi_pci_osc_support(root, flags) in
> > acpi_pci_root_add() (unless there's a command line telling us that
> > ASPM is not to be supported).
> >
> > However, knowing that the BIOS doesn't support ASPM, we shouldn't
> > request the control of it, so we should remove
> > (OSC_ACTIVE_STATE_PWR_SUPPORT | OSC_CLOCK_PWR_CAPABILITY_SUPPORT)
> > from the flags before calling acpi_pci_osc_control_set() in those
> > cases.  Failing to do so causes the evaluation of _OSC for the PCI
> > root bridge to return error codes on some systems where it should
> > work correctly.
> >
> > Reported-and-tested-by: Wei Kong <wkong@novell.com>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >
> > -stable material, I think.
> 
> Len, since you've applied recent patches in this area, can you take
> care of this, too?

No, please don't.

I'd discussed that with Matthew and we concluded that it would break things
sometimes.  Please disregard it (and sorry for not saying that earlier).

Thanks,
Rafael


> > ---
> >  drivers/acpi/pci_root.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > Index: linux/drivers/acpi/pci_root.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/pci_root.c
> > +++ linux/drivers/acpi/pci_root.c
> > @@ -574,6 +574,10 @@ static int __devinit acpi_pci_root_add(s
> >         if (flags != base_flags)
> >                 acpi_pci_osc_support(root, flags);
> >
> > +       if (!pcie_aspm_enabled())
> > +               flags &= ~(OSC_ACTIVE_STATE_PWR_SUPPORT |
> > +                       OSC_CLOCK_PWR_CAPABILITY_SUPPORT);
> > +
> >         if (!pcie_ports_disabled
> >             && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
> >                 flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
> 
> 


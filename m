Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:50331 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752539Ab2GCURi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 16:17:38 -0400
Date: Tue, 3 Jul 2012 16:17:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: AceLan Kao <acelan.kao@canonical.com>, <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
In-Reply-To: <CAErSpo61zd1Lv9s3CaTNTnmYemkhM=a8Lw_2bm4V=1GipJgzSw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207031605350.29825-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 3 Jul 2012, Bjorn Helgaas wrote:

> On Tue, Jul 3, 2012 at 2:55 AM, AceLan Kao <acelan.kao@canonical.com> wrote:
> > Some of ASUS machines have problem to enter S3.
> 
> This should include a specific description of the problem the user
> sees.  From the code comment, it something like "Attempt to suspend
> some ASUS systems causes hang.  Power cycle required to recover."
> might be appropriate.
> 
> The quirk you added is not specific to ASUS, though, so it must be
> something that's safe on every system using the AMD and ATI devices
> you specified.  I don't know whether that's the case.

Is this the same bug as the one addressed by commit c2fb8a3fa255 (USB: 
add NO_D3_DURING_SLEEP flag and revert 151b61284776be2)?

That bug seemed to occur only when the affected systems were put into 
S3 sleep while an EHCI controller was in power level D3.


> > The root cause of this issue is result from the the BIOS will try to
> > disable USBs which was already disabled by driver.
> > BIOS will to check the EHCI command register, if it's not zero, then

You don't mean "EHCI command register"; you mean "the EHCI controller's 
PCI COMMAND register".  The EHCI command register is a completely 
different register; it's part of the memory-mapped interface rather 
than the PCI config space.

> > BIOS will think the USB is not disabled yet, so it will try to disable
> > USB again.

How do you know this?

Why should disabling an already-disabled USB controller cause the
system to hang?

> > To resolve this, we should clear the EHCI command register before
> > entering S3. And this does no harm to the system, since it'll switch

Is there any reason not to clear the PCI COMMAND register of every PCI 
USB host controller when entering S3?

> > off the power after enter S3, so the value in memory is not important
> > at all.
> 
> System RAM is preserved in the S3 state (ACPI spec sec 7.3.4.4), so I
> don't know how to interpret this statement.
> 
> Please include a bugzilla or problem report URL if you have one.
> 
> I'm not a USB or suspend/resume expert, so please get folks like Alan
> Stern and Rafael Wysocki to take a look at this (cc'd).

This really has nothing to do with USB, except the fact that the 
affected parts are USB host controllers.  It's entirely a PCI issue.

> Please read the comment at the top of pci_ids.h; I don't think you
> need to change that file.
> 
> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> > ---
> >  drivers/pci/quirks.c    |   15 +++++++++++++++
> >  include/linux/pci_ids.h |    2 ++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 194b243a..684cd1f 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2955,6 +2955,21 @@ static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
> >
> > +/*
> > + * ASUS BIOS will check EHCI command register to see if USB if disabled
> > + * or not. BIOS will try to disable USB if the command register is not
> > + * cleared. But, actually, USB is disabled by the driver while entering S3,
> > + * so it'll hang in BIOS when it try to disable USB.

Why does the system hang?  There should be no problem clearing the PCI 
COMMAND register even while the controller is in D3.

Does the BIOS try to access the memory-mapped registers while disabling 
the controller?

> > + * Since it's going to enter S3, so it does no harm to clear the command
> > + * register.
> > + */
> > +static void asus_clear_pci_command(struct pci_dev *dev)
> > +{
> > +       pci_write_config_word(dev, PCI_COMMAND, 0);
> > +}
> > +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON_EHCI, asus_clear_memory_bit);
> > +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_EHCI, asus_clear_memory_bit);

Why not do this for all EHCI controllers?  Or even all PCI devices?

Alan Stern


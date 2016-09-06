Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 6 Sep 2016 10:11:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Duc Dang <dhdang@apm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@codeaurora.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drivers: acpi: fix GIC irq model default PCI IRQ polarity
Message-ID: <20160906151118.GA1214@localhost>
References: <1473084758-7377-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0hHW2ovycYRpyVLxg3As0w9ETiu2nuum8J=Ro5YPk1E4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hHW2ovycYRpyVLxg3As0w9ETiu2nuum8J=Ro5YPk1E4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 05, 2016 at 10:37:29PM +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 5, 2016 at 4:12 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On ACPI ARM based systems the GIC interrupt controller
> > and corresponding interrupt model permit only the high
> > polarity for level interrupts.
> >
> > ACPI firmware describes PCI legacy IRQs through entries
> > in the _PRT objects. Entries in the _PRT can be of two types:
> >
> > - Static: not configurable, trigger/polarity default to level-low,
> >   _PRT entry defines the global GSI interrupt number
> > - Configurable: _PRT interrupt entry contains a reference to the
> >   corresponding PCI interrupt link device (that in turn provides the
> >   interrupt descriptor through its _CRS/_PRS methods)
> >
> > Configurable IRQ entries are not currently allowed by the ACPI
> > specification on ARM, since they can only be used for interrupt
> > pins that are routable, and ARM platforms GIC configurations
> > do not allow dynamic IRQ routing, routing is statically laid out
> > at synthesis time; therefore PCI interrupt links cannot be used
> > for PCI legacy IRQ descriptions in the _PRT on ARM systems.
> >
> > On the other hand, current core ACPI code handling PCI legacy IRQs
> > consider IRQ trigger/polarity for static _PRT entries as level-low.
> >
> > On ARM systems with a GIC interrupt controller and corresponding
> > ACPI interrupt model this does not work in that GIC interrupt
> > controller is only capable of handling level interrupts whose
> > polarity is high (for PCI legacy IRQs - that are level-low by
> > specification - this means that the legacy IRQs are inverted before
> > reaching the interrupt controller pin), resulting in IRQ allocation
> > failures such as:
> >
> > genirq: Setting trigger mode 8 for irq 18 failed (gic_set_type+0x0/0x48)
> >
> > Change the default polarity for PCI legacy IRQs to high on systems
> > booting wth ACPI on platforms with a GIC interrupt controller model,
> > fixing the discrepancy between specification and HW behaviour.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> > Cc: Duc Dang <dhdang@apm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Sinan Kaya <okaya@codeaurora.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/acpi/pci_irq.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > index 2c45dd3..c576a6f 100644
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -411,7 +411,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >         int gsi;
> >         u8 pin;
> >         int triggering = ACPI_LEVEL_SENSITIVE;
> > -       int polarity = ACPI_ACTIVE_LOW;
> > +       /*
> > +        * On ARM systems with the GIC interrupt model, level interrupts
> > +        * are always polarity high by specification; PCI legacy
> > +        * IRQs lines are inverted before reaching the interrupt
> > +        * controller and must therefore be considered active high
> > +        * as default.
> > +        */
> > +       int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> > +                                     ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
> >         char *link = NULL;
> >         char link_desc[16];
> >         int rc;
> > --
> 
> Bjorn, any objections?

Looks OK to me.

I never did figure out exactly what in the ACPI spec prohibited the
use of interrupt links, so a spec reference there would be nice.

Bjorn

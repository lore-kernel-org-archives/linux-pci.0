Return-Path: <marc.zyngier@arm.com>
Return-Path: <marc.zyngier@arm.com>
Date: Thu, 25 Aug 2016 12:18:25 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, patches
 <patches@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 <punit.agrawal@arm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in
 _PRT
Message-ID: <20160825121825.322d8450@arm.com>
In-Reply-To: <CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
	<20160824142723.GA25843@red-moon>
	<20160824193000.GE23914@localhost>
	<20160824213005.1a9300ef@arm.com>
	<CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
Sender: marc.zyngier@foss.arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 24 Aug 2016 15:19:21 -0700
Duc Dang <dhdang@apm.com> wrote:

> On Wed, Aug 24, 2016 at 1:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Wed, 24 Aug 2016 14:30:00 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >  
> >> On Wed, Aug 24, 2016 at 03:27:23PM +0100, Lorenzo Pieralisi wrote:  
> >> > [ +Bjorn, Punit]
> >> >
> >> > On Wed, Aug 24, 2016 at 04:06:13AM -0700, Duc Dang wrote:  
> >> > > [Resend in plain text mode]
> >> > >
> >> > > Hi Lorenzo, Rafael,
> >> > >
> >> > > ACPI 6.1 spec does not specify how to set interrupt polarity and
> >> > > trigger mode in _PRT when the interrupts are static (hardwired to
> >> > > specific interrupt inputs in interrupt controller). In current
> >> > > acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
> >> > > default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
> >> > > ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
> >> > > GICv3 controllers and will cause failures in PCIe AER, PME services
> >> > > (on X-Gene platforms).  
> >>
> >> PCI (not PCIe) r3.0, sec 2.2.6, says "Interrupts on PCI are optional
> >> and defined as 'level sensitive,' asserted low."
> >>
> >> I've heard before that ARM64 does this differently, but I still don't
> >> understand the difference.  Obviously if you plug a legacy PCI card
> >> into an ARM64 system, it's still going to pull INTA# low to assert an
> >> interrupt.  So is there something special about ARM64 that inverts
> >> that, or what?  
> >
> > There is certainly an inverter somewhere on the interrupt path, because
> > the GIC triggers on level high, not level low. But I don't think that's
> > the issue Duc is trying to outline here, because that's not something
> > SW can fix. I'm worried that in his system, the interrupt is edge
> > triggered instead.  
> 
> Yes, there is an inverter in the interrupt path to deliver interrupt to the GIC
> as level-high. X-Gene GIC uses level high for PCI INTx. I myself has been
> lucky when using trigger-rising for PCI INTx in DT boot mode.
> 
> >  
> >>  
> >> > > Is there any way to specify polarity and trigger mode for static
> >> > > interrupts in _PRT?  
> >>
> >> There is no way I'm aware of in _PRT to specify polarity and trigger
> >> mode.  I don't know the history, but my guess is that it would be seen
> >> as superfluous given that the PCI spec requires level, active low.  
> 
> The device still pulls the INTx pin low to trigger interrupt, but the
> interrupt delivered
> to interrupt controller (GIC in this case) is not necessarily to be
> level-low. Current code
> assume level-low mode to program to the interrupt controller for INTx,
> and fails for
> GIC, GICv2m and GICv3.

Well, there's nothing that can't be fixed. The GIC doesn't have a
programmatic notion of what is high or low. It only knows about level
interrupts. But the HW only knows about level_high. Obviously, for
things to work, the integrator has to put an inverter on the line to
cope with level_low.

If the driver code insist on using level_low, we can address this
pretty easily, and just warn about the oddity:

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fc56c3..b3755a3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -306,9 +306,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 
 	/* SPIs have restrictions on the supported types */
-	if (irq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			 type != IRQ_TYPE_EDGE_RISING)
-		return -EINVAL;
+	if (irq >= 32) {
+		unsigned int tmp = type;
+		if (type == IRQ_TYPE_LEVEL_LOW)
+			type = IRQ_TYPE_LEVEL_HIGH;
+		if (type == IRQ_TYPE_EDGE_FALLING)
+			type = IRQ_TYPE_EDGE_RISING;
+		if (tmp != type)
+			pr_warn("Overriding IRQ%d type from %d to %d\n",
+				d->irq, tmp, type);
+	}
 
 	if (gic_irq_in_rdist(d)) {
 		base = gic_data_rdist_sgi_base();
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index c2cab57..0d187dc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -280,9 +280,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 
 	/* SPIs have restrictions on the supported types */
-	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			    type != IRQ_TYPE_EDGE_RISING)
-		return -EINVAL;
+	if (gicirq >= 32) {
+		unsigned int tmp = type;
+		if (type == IRQ_TYPE_LEVEL_LOW)
+			type = IRQ_TYPE_LEVEL_HIGH;
+		if (type == IRQ_TYPE_EDGE_FALLING)
+			type = IRQ_TYPE_EDGE_RISING;
+		if (tmp != type)
+			pr_warn("Overriding IRQ%d type from %d to %d\n",
+				d->irq, tmp, type);
+	}
 
 	return gic_configure_irq(gicirq, type, base, NULL);
 }



Does this work for you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

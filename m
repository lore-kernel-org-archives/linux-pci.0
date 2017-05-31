Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 31 May 2017 12:34:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
Message-ID: <20170531173414.GB4496@bhelgaas-glaptop.roam.corp.google.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
 <8e56647d-3b2d-9bfc-b59e-79a2efaa7826@sigmadesigns.com>
 <20170523170319.GB24431@bhelgaas-glaptop.roam.corp.google.com>
 <b6541fd2-200f-35be-208e-931bb0b5ba49@free.fr>
 <ef36137c-f0d1-23b9-8b91-a6ed87239578@arm.com>
 <aec89b9a-8377-ff39-547c-9e6eaf254fab@free.fr>
 <f1a57255-be75-e8c4-6b8d-0254f4365d61@arm.com>
 <c78b1e79-59e5-0097-989e-1f1e8cd93fc4@arm.com>
 <b10a211d-1f4a-1cc1-7139-9b48a90dd1c6@free.fr>
MIME-Version: 1.0
In-Reply-To: <b10a211d-1f4a-1cc1-7139-9b48a90dd1c6@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 04:18:44PM +0200, Mason wrote:
> On 24/05/2017 12:22, Marc Zyngier wrote:
> > On 24/05/17 11:00, Robin Murphy wrote:
> >> On 23/05/17 20:15, Mason wrote:
> >>> On 23/05/2017 20:03, Robin Murphy wrote:
> >>>> On 23/05/17 18:54, Mason wrote:
> >>>>> On 23/05/2017 19:03, Bjorn Helgaas wrote:
> >>>>>> On Wed, May 17, 2017 at 04:56:08PM +0200, Marc Gonzalez wrote:
> >>>>>>> On 20/04/2017 16:28, Marc Gonzalez wrote:
> >>>>>>>
> >>>>>>>> +static int tango_set_affinity(struct irq_data *data,
> >>>>>>>> +		const struct cpumask *mask, bool force)
> >>>>>>>> +{
> >>>>>>>> +	return -EINVAL;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static struct irq_chip tango_chip = {
> >>>>>>>> +	.irq_ack		= tango_ack,
> >>>>>>>> +	.irq_mask		= tango_mask,
> >>>>>>>> +	.irq_unmask		= tango_unmask,
> >>>>>>>> +	.irq_set_affinity	= tango_set_affinity,
> >>>>>>>> +	.irq_compose_msi_msg	= tango_compose_msi_msg,
> >>>>>>>> +};
> >>>>>>>
> >>>>>>> Hmmm... I'm wondering why .irq_set_affinity is required.
> >>>>>>>
> >>>>>>> static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
> >>>>>>> first calls __irq_can_set_affinity() to check whether
> >>>>>>> desc->irq_data.chip->irq_set_affinity) exists.
> >>>>>>>
> >>>>>>> then calls irq_do_set_affinity(&desc->irq_data, mask, false);
> >>>>>>> which calls chip->irq_set_affinity(data, mask, force);
> >>>>>>> = msi_domain_set_affinity()
> >>>>>>> which calls parent->chip->irq_set_affinity() unconditionally.
> >>>>>>>
> >>>>>>> Would it make sense to test that the callback is implemented
> >>>>>>> before calling it?
> >>>>>>>
> >>>>>>>
> >>>>>>> [    0.723895] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >>>>>>
> >>>>>> I'm not sure what you're asking.
> >>>>>>
> >>>>>> Is this a bug report for the v4 tango driver?
> >>>>>
> >>>>> No.
> >>>>>
> >>>>>> Or are you asking whether msi_domain_set_affinity() should be changed
> >>>>>> to check whether parent->chip->irq_set_affinity is implemented?
> >>>>>
> >>>>> Yes. The way things are implemented now, drivers are forced
> >>>>> to define an irq_set_affinity callback, even if it just returns
> >>>>> an error, otherwise, the kernel crashes, because of the
> >>>>> unconditional function pointer deref. 
> >>>>>
> >>>>>> msi_domain_set_affinity() has called parent->chip->irq_set_affinity()
> >>>>>> without checking since it was added in 2014 by f3cf8bb0d6c3 ("genirq: Add
> >>>>>> generic msi irq domain support"), so if there's a problem here, it's most
> >>>>>> likely in the tango code.
> >>>>>
> >>>>> The issue is having to define an "empty" function.
> >>>>> (Unnecessary code bloat and maintenance.)
> >>>>
> >>>> AFAICS, only one driver (other than this one) implements a "do nothing"
> >>>> set_affinity callback - everyone else who doesn't do anything hardware
> >>>> specific just passes it along via irq_chip_set_affinity_parent().
> >>>
> >>> I counted 4. Where did I mess up?
> >>>
> >>> advk_msi_set_affinity
> >>> altera_msi_set_affinity
> >>> nwl_msi_set_affinity
> >>> vmd_irq_set_affinity
> >>> tango_set_affinity
> >>
> >> Fair point - I went through drivers/irqchip and the various
> >> arch-specific instances and found ls_scfg_msi_set_affinity(), but
> >> somehow skipped over drivers/pci. Anyway, I think the question stands of
> >> why are these handful of drivers *not* using irq_chip_set_affinity_parent()?
> > 
> > Probably because they don't have a parent, in the hierarchical sense.
> > All they have is a chained interrupt (*puke*). Which implies that
> > changing the affinity of one MSI would affect all of them, completely
> > confusing unsuspecting userspace such as irqbalance.
> > 
> >> As an outsider, it naively seems logical that the affinity of an MSI
> >> which just gets translated to a wired interrupt should propagate through
> >> to the affinity of that wired interrupt, but maybe there are reasons not
> >> to; I really don't know.
> > 
> > See above. The main issue is that HW folks haven't understood the actual
> > use of MSIs, and persist in implementing them as an afterthought, based
> > on some cascading interrupt controller design.
> > 
> > Sad. So sad.
> 
> For the record, below is the patch I had in mind:
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 8a3e872798f3..edfc95575a37 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -91,9 +91,11 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
>  {
>         struct irq_data *parent = irq_data->parent_data;
>         struct msi_msg msg;
> -       int ret;
> +       int ret = -EINVAL;
> +
> +       if (parent->chip->irq_set_affinity)
> +               ret = parent->chip->irq_set_affinity(parent, mask, force);
>  
> -       ret = parent->chip->irq_set_affinity(parent, mask, force);
>         if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
>                 BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
>                 irq_chip_write_msi_msg(irq_data, &msg);
> 
> 
> 
> Then, it would be safe to remove "do-nothing" .irq_set_affinity
> callbacks in drivers/pci/host

I assume it's obvious that nobody else is going to take this and run
with it, so nothing will happen with this unless you finish it up by
doing the cleanup (removing the "do-nothing" callbacks) and adding a
changelog and signed-off-by.

This would be more an IRQ patch than a PCI patch, but if I were
reviewing it, I would look for assurance that *all* the no-op
.irq_set_affinity callbacks were cleaned up, not just those in
drivers/pci/host.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

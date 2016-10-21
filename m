Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 20 Oct 2016 19:59:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
Message-ID: <20161021005914.GA31044@localhost>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
 <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost>
 <CAJZ5v0gE8uZ4NfuJVtuzkioJS0TpG2mvgJV3o3j0oM7WsVmh7w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gE8uZ4NfuJVtuzkioJS0TpG2mvgJV3o3j0oM7WsVmh7w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Ondrej Zary <linux@rainbow-software.org>, ravikanth.nalla@hpe.com,
 Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
 Andy Gross <agross@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christopher Covington <cov@codeaurora.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 wim@djo.tudelft.nl, linux-arm-msm@vger.kernel.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 01:17:23AM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 20, 2016 at 12:44 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Oct 18, 2016 at 08:32:44AM -0700, Sinan Kaya wrote:
> >> Sorry, I think I didn't have enough morning coffee.
> >>
> >> Looking at these again and trying to be specific.
> >>
> >> On 10/18/2016 8:20 AM, Sinan Kaya wrote:
> >> > It seems wrong to me that we call acpi_irq_get_penalty() from
> >> >> acpi_irq_penalty_update() and acpi_penalize_isa_irq().  It seems like they
> >> >> should just manipulate acpi_isa_irq_penalty[irq] directly.
> >> >>
> >> >> acpi_irq_penalty_update() is for command-line parameters, so it certainly
> >> >> doesn't need the acpi_irq_pci_sharing_penalty() information (the
> >> >> acpi_link_list should be empty at the time we process the command-line
> >> >> parameters).
> >>
> >> Calling acpi_irq_get_penalty for ISA IRQ is OK as long as it doesn't have
> >> any dynamic IRQ calculation such that acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty.
> >>
> >> If this is broken, then we need special care so that we don't assign
> >> dynamically calcualted sci_penalty back to acpi_isa_irq_penalty[irq]. This
> >> results in returning incorrect penalty as
> >>
> >> acpi_irq_get_penalty = acpi_isa_irq_original_penalty[irq] + 2 * sci_penalty.
> >>
> >> Now that we added sci_penalty into the acpi_irq_get_penalty function,
> >> calling acpi_irq_get_penalty is not correct anymore. This line here needs to
> >> be replaced with acpi_isa_irq_penalty[irq] as you suggested.
> >>
> >>                 if (used)
> >>                         new_penalty = acpi_irq_get_penalty(irq) +
> >>                                         PIRQ_PENALTY_ISA_USED;
> >>                 else
> >>                         new_penalty = 0;
> >>
> >>                 acpi_isa_irq_penalty[irq] = new_penalty;
> >>
> >>
> >> >>
> >> >> acpi_penalize_isa_irq() is telling us that a PNP or ACPI device is using
> >> >> the IRQ -- this should modify the IRQ's penalty, but it shouldn't depend on
> >> >> the acpi_irq_pci_sharing_penalty() value at all.
> >> >>
> >>
> >> Same problem here. This line will be broken after the sci_penalty change.
> >>
> >>                 acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> >>                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
> >
> > I think the fragility of this code is an indication that we have a
> > design problem, so I want to step back from the nitty gritty details
> > for a bit and look at the overall design.
> >
> > Let me restate the overall problem: We have a PCI device connected to
> > an interrupt link.  The interrupt link can be connected to one of
> > several IRQs, and we want to choose one of those IRQs to minimize IRQ
> > sharing.
> >
> > That means we need information about which IRQs are used.
> > Historically we've started with a compiled-in table of common ISA IRQ
> > usage, and we also collect information about which IRQs are used and
> > which *might* be used.  So we have the following inputs:
> >
> >   - Compiled-in ISA IRQ usage: the static acpi_isa_irq_penalty[]
> >     values.  ACPI is *supposed* to tell us about all these usages, so
> >     I don't know why we have the table.  But it's been there as long
> >     as I can remember.  The table is probably x86-specific, but we
> >     keep it in the supposedly generic pci_link.c.
> >
> >   - The "acpi_irq_isa=" and "acpi_irq_pci=" command-line overrides via
> >     acpi_irq_pci().  I suppose these are for cases where we can't
> >     figure things out automatically.  I would resist adding parameters
> >     like this today (I would treat the need for them as a bug and look
> >     for a fix or a quirk), but we might be stuck with these.
> >
> >   - SCI information from the ACPI FADT (acpi_penalize_sci_irq()).
> >
> >   - PNPBIOS and PNPACPI device IRQ usage from _CRS and _PRS via
> >     acpi_penalize_isa_irq().  This is only for IRQs 0-15, and it does
> >     NOT include interrupt link (PNP0C0F) devices because we don't
> >     handle them as PNPACPI devices.  I think this is related to the
> >     fact that PNP0C0F doesn't appear in acpi_pnp_device_ids[].
> >
> >   - For non-PNP0C0F, non-PNPACPI devices, we completely ignore IRQ
> >     information from _CRS and _PRS.  This seems sub-optimal and
> >     possibly buggy.
> >
> >   - Interrupt link (PNP0C0F) IRQ usage from _CRS and _PRS via
> >     acpi_irq_penalty_init().  This is only for IRQs 0-15, and we only
> >     call this on x86.  If _PRS exists, we penalize each possible IRQ.
> >     If there's no _PRS but _CRS contains an active IRQ, we penalize
> >     it.
> >
> >   - Interrupt link (PNP0C0F) IRQ usage from _CRS and _PRS when
> >     enabling a new link.  In acpi_irq_pci_sharing_penalty(), we
> >     penalize an IRQ if it appears in _CRS or _PRS of any link device
> >     in the system.
> >
> >     For IRQs 0-15, this overlaps with the penalization done at
> >     boot-time by acpi_irq_penalty_init(): if a device has _PRS, we'll
> >     add the "possible" penalty twice (once in acpi_irq_penalty_init()
> >     and again in acpi_irq_pci_sharing_penalty()), and the "using"
> >     penalty once (in acpi_irq_pci_sharing_penalty()).
> >
> >     If a device has no _PRS but has _CRS, the "using" penalty is
> >     applied twice (once in once in acpi_irq_penalty_init() and again
> >     in acpi_irq_pci_sharing_penalty())
> >
> > I think this whole thing is baroque and grotesque.
> 
> While I agree, I also would like the regression introduced here to be
> fixed ASAP.
> 
> So do you want me to revert all of the changes made here so far and start over?

You're right, of course.  We need to fix the regression first, then
worry about longer-term changes.  I don't think we necessarily need to
fix *all* the issues with the current scheme, because most of them
have been there forever and I don't think people are tripping over
them.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46021 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeAEJwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jan 2018 04:52:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so1369036wme.4
        for <linux-pci@vger.kernel.org>; Fri, 05 Jan 2018 01:52:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102141321.GE10536@red-moon>
References: <1513181317-19914-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20171220170307.GC1709@red-moon> <CAFZiPx1VVLii9hnTZCih8tu5cxvzX4ENgVGy9-WwpaG7vWyUWg@mail.gmail.com>
 <20180102141321.GE10536@red-moon>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 5 Jan 2018 15:22:12 +0530
Message-ID: <CAFZiPx3+c5=pcUhyDAKEvBypLC7t9mW4o+O+2t481sw8AXtb+g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, robh@kernel.org,
        devicetree@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,

On Tue, Jan 2, 2018 at 7:43 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 22, 2017 at 01:29:00PM +0530, Subrahmanya Lingappa wrote:
>
> [...]
>
> > > > +static void mobiveil_pcie_isr(struct irq_desc *desc)
> > > > +{
> > > > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > +     struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
> > > > +     struct device *dev = &pcie->pdev->dev;
> > > > +     u32 intr_status;
> > > > +     unsigned long shifted_status;
> > >
> > > Why not u32 ?
> > >
> > for_each_set_bit() api warns about the variable not being unsigned
> > long. So used the same to take out the warning.
> >
> >
> > > > +     u32 bit, virq;
> > > > +     u32 val, mask;
> > > > +
> > > > +     chained_irq_enter(chip, desc);
> > > > +
> > > > +     /* read INTx status */
> > > > +     val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > > > +     mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> > > > +     intr_status = val & mask;
> > > > +
> > > > +     /*
> > > Handle INTx */
> > > > +     if (intr_status & PAB_INTP_INTX_MASK) {
> > > > +             shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > >
> > > Why can't you reuse val to read the status and create shifted_status
> > > from it ?
> > >
> > > eg
> > >
> > > shifted_status = val << PAB_INTA_POS;
> > > csr_writel(pcie, shifted_status, PAB_INTP_AMBA_MISC_STAT);
> > >
> > > Just a hint to make the loop more readable. BTW, I do not think that
> > > writing shifted_status into that register is OK, see below.
> > >
> > > > +             do {
> > > > +                     for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > > > +
> > > > +                             /* clear interrupts */
> > > > +                             csr_writel(pcie, shifted_status <<
> > > PAB_INTA_POS,
> > > > +
> > > PAB_INTP_AMBA_MISC_STAT);
> > >
> > > Should not you clear just the interrupt you are about to handle ?
> >
> > PAB_INTP_AMBA_MISC_STAT register has INTA, INTB, INTC, INTD status
> > bits at positions 5,6,7 and 8,
> > they are RW1C bits, so writing 1 to this bit clears the status.
> > So here the status read was written back to it to clear.
>
> Understood - the point is that IIUC you should clear just the IRQ (bit)
> that you are handling at each iteration not all at once.
>
Understood

>
> What do PAB_INTP_AMBA_MISC_STAT[4:0] represent then ?

0 : PCIE to AXI Mailbox Ready
This bit is set by hardware when a PCIE-to-AXI mailbox is ready with
data to be transferred to PCI-Express host.
1 : Reserved
2 : Reserved
3 : Reserved
4 : Vendor Defined Message Received
This bit is set by hardware when an vendor defined message is
received on the PEX link.

5 : INTA Received
6 : INTB Received
7 : INTC Received
8 : INTD Received
9-31: Other
root port
error status bits
>
>
> > > > +                             virq = irq_find_mapping(pcie->intx_domain,
> > > > +                                     bit + 1);
> > > > +                             if (virq)
> > > > +
> > > generic_handle_irq(virq);
> > > > +                             else
> > > > +                                     dev_err_ratelimited(dev,
> > > > +                                             "unexpected IRQ, INT%d\n",
> > > > +                                             bit);
> > > > +
> > > > +                     }
> > > > +
> > > > +                     shifted_status = csr_readl(pcie,
> > > > +                                             PAB_INTP_AMBA_MISC_STAT);
> > > > +
> > > > +             } while ((shifted_status >>  PAB_INTA_POS) != 0);
> > >
> > > I do not understand this. Can you explain to me how the
> > > register at:
> > >
> > > PAB_INTP_AMBA_MISC_STAT
> > >
> > > works ?
> > >
> > just repeating what explained before, to ease the readablility.
> > PAB_INTP_AMBA_MISC_STAT register has INTA, INTB, INTC, INTD status
> > bits at positions 5,6,7 and 8,
> > they are RW1C bits, so writing 1 to this bit clears the status.
> >
> > >
> > > A patch for mediatek has been posted:
> > >
> > > https://patchwork.ozlabs.org/patch/851181/
> > >
> > > It looks like this loop may suffer from the same issue, so please do
> > > have a look.
> > >
> > I will clear the the interrupt after
> >
> > its hadled by generic_handle_irq()
> > .
> > right ?
>
> Where ? Can you explain please what every bit in
>
> PAB_INTP_AMBA_MISC_STAT
>
> represent ?
>
Please see the list above


> > > On top of that, most of the operations you are carrying out here
> > > can be done automatically by making them part of the struct irq_chip
> > > methods (ie acking IRQs, masking IRQs, etc, see below).
> > >
> > Any side effects of keeping this code as is ?
>
> Yes, that it will take us more effort to convert it to the usage
> I describe above - which is how it is expected to be written.
>
Ok, I'll convert this by making these operations as part of

irq_chip methods
>
> [...]
>
> > > > +/* routine to setup the INTx related data */
> > > > +static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> > > > +             irq_hw_number_t hwirq)
> > > > +{
> > > > +     irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > >
> > > IIUC, the host bridge acts as an INTX/MSI controller/multiplexer.
> > >
> > > So, instead of relying on
> > > dummy_irq_chip, you should create your own
> > > irq_chip with the methods that you require (eg irq_ack(), irq_mask(),
> > > irq_compose_msi_msg()) and use that as bottom irq_chip for both
> > > INTX and MSI domains.
> > >
> > > That's why I asked you to have a look at pcie-tango.c (except that there
> > > INTX aren't supported but the basic idea does not change) and implement
> > > IRQ domains handling like that same driver.
> > >
> > are there any disadvantages of keeping dummy_irq_chip, as I see quite
> > a few host bridge
> >
> > drivers including
> > otehr two major soft IP drivers from altera and xilinx with similar
> > MSI implementaion.
>
> See above, this is a new driver, the existing IP drivers will have to
> be converted eventually, new code should set an example not add more
> burden to code refactoring.
>
Agreed, I will follow the tango driver approach to remove dummy_irq_chip.
>
> Lorenzo



Thanks,
Subrahmanya

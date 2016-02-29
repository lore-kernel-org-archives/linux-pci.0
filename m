Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Feb 2016 16:34:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Message-ID: <20160229223453.GA12162@localhost>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost>
 <56D4A53A.1070708@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D4A53A.1070708@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 03:08:26PM -0500, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 2/29/2016 2:24 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 18, 2016 at 08:19:41AM -0500, Sinan Kaya wrote:
> >> A crash has been observed when assigning penalty on x86 systems.
> >>
> >> It looks like this problem happens on x86 platforms with IOAPIC and an SCI
> >> interrupt override in the ACPI table with interrupt number greater than
> >> 16. (22 in this example)
> >>
> >> The bug has been introduced by "ACPI, PCI, irq: remove interrupt count
> >> restriction" commit. The code was using kmalloc to resize the interrupt
> >> list. In this use case, the set penalty call is coming from early phase
> >> and the heap is not initialized yet.
> >> ...

> >> Besides from the use case above, there is one more situation where
> >> set_penalty is being called from the init context like. There is support
> >> for setting the penalty through kernel command line.
> >>
> >> Adding support to be called from early context for limited number of
> >> interrupts.
> > 
> > I can't believe this whole IRQ penalty thing needs to be so
> > complicated.
> > 
> > The only time we actually use the penalty information is when we're
> > attaching a driver to a PCI device, i.e., in this path:
> > 
> >   pci_device_probe
> >     pcibios_alloc_irq
> >       pcibios_enable_irq
> > 
> > That happens pretty late, so there's no "can't allocate memory during
> > early boot" problem.
> 
> Correct, this is the path that code is intended for.
> 
> > I bet the only thing that might happen early enough to be an issue is
> > the acpi_penalize_sci_irq() thing, which is a special case that
> > doesn't need to be handled generically.
> 
> The second use case is the kernel command line. See the bottom of the code, 
> there are routines there to go get the penalty information from command line.

Right.  But if we don't *use* the information until later, there's
probably no need to parse the command line and set it up so early.

> How would you like to proceed ?
> 
> - merge this to the original patch
> - remove the acpi_penalize_sci_irq code to somewhere else.
> - what about the kernel command line?

There's so much code there, that I think all the code obscures the
fact that there's almost nothing really happening.  In broad outline,
I think we care about:

  - the legacy ISA IRQs, i.e., the contents of acpi_irq_isa_penalty[]
  - acpi_irq_isa= from command line
  - acpi_irq_pci= from command line
  - which IRQ is used for SCI
  - number of PCI Interrupt Link devices sharing an IRQ

I doubt we need any dynamic allocation at all to manage this.  We
already have the acpi_irq_isa_penalty[] table statically allocated.
The SCI IRQ is one word.  I bet the command-line stuff is only
useful for the 16 ISA IRQs and could be merged into
acpi_irq_isa_penalty[].  Same for acpi_penalize_isa_irq() and
acpi_isa_irq_available().  We could easily compute the
number of links sharing an IRQ by traversing acpi_link_list.

I think only x86 cares about the first three items (legacy ISA IRQs
and command-line args).  This should be reflected in the code.  Only
x86 calls acpi_irq_penalty_init(), but that's pretty non-obvious.

I think it would be better to completely rewrite this penalty stuff
than to keep making it more complicated by fixing things in the
existing design.

> >> Reported-by: Nalla, Ravikanth <ravikanth.nalla@hpe.com>
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >> ---
> >>  drivers/acpi/pci_link.c | 19 +++++++++++++++----
> >>  1 file changed, 15 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> >> index fa28635..14fe3ca 100644
> >> --- a/drivers/acpi/pci_link.c
> >> +++ b/drivers/acpi/pci_link.c
> >> @@ -47,6 +47,7 @@ ACPI_MODULE_NAME("pci_link");
> >>  #define ACPI_PCI_LINK_FILE_INFO		"info"
> >>  #define ACPI_PCI_LINK_FILE_STATUS	"state"
> >>  #define ACPI_PCI_LINK_MAX_POSSIBLE	16
> >> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024
> >>  
> >>  static int acpi_pci_link_add(struct acpi_device *device,
> >>  			     const struct acpi_device_id *not_used);
> >> @@ -473,6 +474,8 @@ struct irq_penalty_info {
> >>  };
> >>  
> >>  static LIST_HEAD(acpi_irq_penalty_list);
> >> +static struct irq_penalty_info early_irq_infos[ACPI_PCI_LINK_MAX_EARLY_IRQINFO];
> >> +static int early_irq_info_counter;
> >>  
> >>  static int acpi_irq_get_penalty(int irq)
> >>  {
> >> @@ -507,10 +510,17 @@ static int acpi_irq_set_penalty(int irq, int new_penalty)
> >>  		}
> >>  	}
> >>  
> >> -	/* nope, let's allocate a slot for this IRQ */
> >> -	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
> >> -	if (!irq_info)
> >> -		return -ENOMEM;
> >> +	if (!acpi_gbl_permanent_mmap) {
> >> +		if (early_irq_info_counter < ARRAY_SIZE(early_irq_infos))
> >> +			irq_info = &early_irq_infos[early_irq_info_counter++];
> >> +		else
> >> +			return -ENOMEM;
> >> +	} else {
> >> +		/* nope, let's allocate a slot for this IRQ */
> >> +		irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
> >> +		if (!irq_info)
> >> +			return -ENOMEM;
> >> +	}
> >>  
> >>  	irq_info->irq = irq;
> >>  	irq_info->penalty = new_penalty;
> >> @@ -968,3 +978,4 @@ void __init acpi_pci_link_init(void)
> >>  	register_syscore_ops(&irqrouter_syscore_ops);
> >>  	acpi_scan_add_handler(&pci_link_handler);
> >>  }
> >> +
> >> -- 
> >> 1.8.2.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

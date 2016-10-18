Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
Date: Tue, 18 Oct 2016 08:20:55 -0700
MIME-Version: 1.0
In-Reply-To: <20161018135912.GD18903@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2016 6:59 AM, Bjorn Helgaas wrote:
>> However, this function only gets called if the IRQ number is greater than
>> > 16 and acpi_irq_get_penalty function gets called before ACPI start in
>> > acpi_isa_irq_available and acpi_penalize_isa_irq functions. We can't rely
>> > on iterating the link list.

Maybe, I am missing context here. I can add this paragraph to the commit. 

When we started cleaning the code we got rid of the acpi_irq_penalty_init function
in favor of acpi_irq_pci_sharing_penalty function as it does have some fair
amount of code duplication.

I tried putting back the acpi_irq_pci_sharing_penalty function into the ISA
IRQ path again during the debug and the machine died way too early. We couldn't
collect any debug message.

This is telling me that we can't even iterate the link list when these two API
is called. ISA IRQ need to be handled with special care due to calling order.


> It seems wrong to me that we call acpi_irq_get_penalty() from
> acpi_irq_penalty_update() and acpi_penalize_isa_irq().  It seems like they
> should just manipulate acpi_isa_irq_penalty[irq] directly.
> 
> acpi_irq_penalty_update() is for command-line parameters, so it certainly
> doesn't need the acpi_irq_pci_sharing_penalty() information (the
> acpi_link_list should be empty at the time we process the command-line
> parameters).
> 
> acpi_penalize_isa_irq() is telling us that a PNP or ACPI device is using
> the IRQ -- this should modify the IRQ's penalty, but it shouldn't depend on
> the acpi_irq_pci_sharing_penalty() value at all.
> 

acpi_irq_get_penalty function knows how to deal with ISA IRQ. So, it is harmless
to call it. Also, reading the acpi_isa_irq_penalty array directly isn't also right.
It doesn't contain the SCI penalty. So, it returns incorrect penalty value.

The rule of thumb is:
- all PCI/SCI penalty reads need to go through acpi_isa_irq_penalty function
- all ISA penalty writes need to go through acpi_isa_irq_penalty array directly.
- we do not support modifying the PCI IRQ penalties greater than the ISA IRQ numbers.
The original code supported this.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

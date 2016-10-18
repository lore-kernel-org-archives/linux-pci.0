Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
Date: Tue, 18 Oct 2016 08:32:44 -0700
MIME-Version: 1.0
In-Reply-To: <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Sorry, I think I didn't have enough morning coffee.

Looking at these again and trying to be specific.

On 10/18/2016 8:20 AM, Sinan Kaya wrote:
> It seems wrong to me that we call acpi_irq_get_penalty() from
>> acpi_irq_penalty_update() and acpi_penalize_isa_irq().  It seems like they
>> should just manipulate acpi_isa_irq_penalty[irq] directly.
>> 
>> acpi_irq_penalty_update() is for command-line parameters, so it certainly
>> doesn't need the acpi_irq_pci_sharing_penalty() information (the
>> acpi_link_list should be empty at the time we process the command-line
>> parameters).

Calling acpi_irq_get_penalty for ISA IRQ is OK as long as it doesn't have
any dynamic IRQ calculation such that acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty.

If this is broken, then we need special care so that we don't assign
dynamically calcualted sci_penalty back to acpi_isa_irq_penalty[irq]. This
results in returning incorrect penalty as

acpi_irq_get_penalty = acpi_isa_irq_original_penalty[irq] + 2 * sci_penalty.

Now that we added sci_penalty into the acpi_irq_get_penalty function,
calling acpi_irq_get_penalty is not correct anymore. This line here needs to
be replaced with acpi_isa_irq_penalty[irq] as you suggested.

                if (used)
                        new_penalty = acpi_irq_get_penalty(irq) +
                                        PIRQ_PENALTY_ISA_USED;
                else
                        new_penalty = 0;

                acpi_isa_irq_penalty[irq] = new_penalty;


>> 
>> acpi_penalize_isa_irq() is telling us that a PNP or ACPI device is using
>> the IRQ -- this should modify the IRQ's penalty, but it shouldn't depend on
>> the acpi_irq_pci_sharing_penalty() value at all.
>> 

Same problem here. This line will be broken after the sci_penalty change.

                acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
                  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

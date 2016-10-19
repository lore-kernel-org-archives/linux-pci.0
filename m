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
Message-ID: <ea7399f8-8cfa-7671-f258-c42edd663106@codeaurora.org>
Date: Wed, 19 Oct 2016 15:24:05 -0700
MIME-Version: 1.0
In-Reply-To: <20161018135912.GD18903@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 10/18/2016 6:59 AM, Bjorn Helgaas wrote:
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

I posted v4 with this change and also went back to the original implementation
for sharing penalty calculation whether the IRQ is ISA or PCI.

Let us know what you think. 

I also realized that calculating sharing penalty while the link object is not 
initialized is not right.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

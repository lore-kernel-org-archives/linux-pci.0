Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl
Subject: Re: [PATCH V2 0/3] ACPI,PCI,IRQ: revert penalty calculation for SCI
Date: Tue, 11 Oct 2016 23:55:30 +0200
Message-ID: <16782518.MvPkQ6RUZe@vostro.rjw.lan>
In-Reply-To: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 04, 2016 05:15:16 PM Sinan Kaya wrote:
> Restoring the old behavior for IRQ < 256 and the dynamic penalty behavior
> will remain effective for IRQ >= 256.
> 
> By the time ACPI gets initialized, this code tries to determine an
> IRQ number based on penalty values in this array. It will try to locate
> the IRQ with the least penalty assignment so that interrupt sharing is
> avoided if possible.
> 
> A couple of notes about the external APIs:
> 1. These API can be called before the ACPI is started. Therefore, one
> cannot assume that the PCI link objects are initialized for calculating
> penalties.
> 2. The polarity and trigger information passed via the
> acpi_penalize_sci_irq from the BIOS may not match what the IRQ subsystem
> is reporting as the call might have been placed before the IRQ is
> registered by the interrupt subsystem.
> 
> The reverted changes were in the direction to remove these external API and
> try to calculate the penalties at runtime for the ISA, SCI as well as PCI
> IRQS. This didn't work out well with the existing platforms.
> 
> Changes from V1 (https://lkml.org/lkml/2016/10/1/106):
> * Commit message updates
> 
> Sinan Kaya (3):
>   Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
>   ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
>   Revert "ACPI,PCI,IRQ: remove SCI penalize function"
> 
>  arch/x86/kernel/acpi/boot.c |  1 +
>  drivers/acpi/pci_link.c     | 71 ++++++++++++++++++++++-----------------------
>  include/linux/acpi.h        |  1 +
>  3 files changed, 37 insertions(+), 36 deletions(-)
> 

I've queued up the series, but still waiting on Bjorn's response.

Thanks,
Rafael


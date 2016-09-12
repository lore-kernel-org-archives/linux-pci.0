Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Punit Agrawal <punit.agrawal@arm.com>,
        Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2] drivers: acpi: fix GIC irq model default PCI IRQ polarity
Date: Tue, 13 Sep 2016 00:16:45 +0200
Message-ID: <1512953.mRIMTKV6b1@vostro.rjw.lan>
In-Reply-To: <1473180663-20590-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1473180663-20590-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, September 06, 2016 05:51:03 PM Lorenzo Pieralisi wrote:
> On ACPI ARM based systems the GIC interrupt controller
> and corresponding interrupt model permit only the high
> polarity for level interrupts.
> 
> ACPI firmware describes PCI legacy IRQs through entries
> in the _PRT objects. Entries in the _PRT can be of two types:
> 
> - Static: not configurable, trigger/polarity default to level-low,
>   _PRT entry defines the global GSI interrupt number
> - Configurable: _PRT interrupt entry contains a reference to the
>   corresponding PCI interrupt link device (that in turn provides the
>   interrupt descriptor through its _CRS/_PRS methods)
> 
> Configurable IRQ entries are not currently allowed by the ACPI
> specification on ARM since they can only be used for interrupt pins that
> are routable, as per ACPI specifications (version 6.1, 6.2.13):
> 
> "[...] There are two ways that _PRT can be used. Typically, the
> interrupt input that a given PCI interrupt is on is configurable. For
> example, a given PCI interrupt might be configured for either IRQ 10 or
> 11 on an 8259 interrupt controller. In this model, each interrupt is
> represented in the ACPI namespace as a PCI Interrupt Link Device. [...]"
> 
> ARM platforms GIC configurations do not allow dynamic IRQ routing,
> since routing is statically laid out at synthesis time; therefore PCI
> interrupt links cannot be used for PCI legacy IRQ descriptions in the
> _PRT on ARM systems.
> 
> On the other hand, current core ACPI code handling PCI legacy IRQs
> consider IRQ trigger/polarity for static _PRT entries as level-low.
> 
> On ARM systems with a GIC interrupt controller and corresponding
> ACPI interrupt model this does not work in that GIC interrupt
> controller is only capable of handling level interrupts whose
> polarity is high (for PCI legacy IRQs - that are level-low by
> specification - this means that the legacy IRQs are inverted before
> reaching the interrupt controller pin), resulting in IRQ allocation
> failures such as:
> 
> genirq: Setting trigger mode 8 for irq 18 failed (gic_set_type+0x0/0x48)
> 
> Change the default polarity for PCI legacy IRQs to high on systems
> booting wth ACPI on platforms with a GIC interrupt controller model,
> fixing the discrepancy between specification and HW behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Duc Dang <dhdang@apm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Applied.

Thanks,
Rafael


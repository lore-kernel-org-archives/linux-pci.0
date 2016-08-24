Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Aug 2016 15:27:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        patches <patches@apm.com>, bhelgaas@google.com,
        punit.agrawal@arm.com
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160824142723.GA25843@red-moon>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ +Bjorn, Punit]

On Wed, Aug 24, 2016 at 04:06:13AM -0700, Duc Dang wrote:
> [Resend in plain text mode]
> 
> Hi Lorenzo, Rafael,
> 
> ACPI 6.1 spec does not specify how to set interrupt polarity and
> trigger mode in _PRT when the interrupts are static (hardwired to
> specific interrupt inputs in interrupt controller). In current
> acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
> default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
> ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
> GICv3 controllers and will cause failures in PCIe AER, PME services
> (on X-Gene platforms).
> 
> Is there any way to specify polarity and trigger mode for static
> interrupts in _PRT? If not, can we introduce a _weak_ hook to specify
> default polarity and trigger mode for for ARM64 PCIe INTx in
> drivers/acpi/pci_irq.c?

Is there any reason why we can NOT use interrupt links (PNP0C0F) and
related resources to describe those interrupts (I know that the spec
says they can be used just for configurable IRQs but I suspect that was
influenced by legacy x86 platforms) ? I think Rafael and Bjorn have a
bit more visibility into why the interrupt links were specified that
way (and I do not have enough x86 background to understand why the legacy
IRQ routing was specified this way in ACPI - which was obviously biased
by how x86 HW works).

Lorenzo

> 
> Regards,
> Duc Dang.
> 

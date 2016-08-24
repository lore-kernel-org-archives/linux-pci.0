Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Aug 2016 16:26:41 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rafael Wysocki <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        patches <patches@apm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in
 _PRT
Message-ID: <20160824162641.06a9438a@arm.com>
In-Reply-To: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 24 Aug 2016 04:06:13 -0700
Duc Dang <dhdang@apm.com> wrote:

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

A weak symbol is going to affect all arm64 platforms, which then would
need to be quirked accordingly depending on the PCIe controller being
used. This feels very cumbersome, and probably unmaintainable in the
long run.

I'd rather explore Lorenzo's option of using interrupt links to
describe this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

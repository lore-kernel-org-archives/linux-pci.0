Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Aug 2016 14:30:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Duc Dang <dhdang@apm.com>, Rafael Wysocki <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>, patches <patches@apm.com>,
        bhelgaas@google.com, punit.agrawal@arm.com
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160824193000.GE23914@localhost>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
 <20160824142723.GA25843@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160824142723.GA25843@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 24, 2016 at 03:27:23PM +0100, Lorenzo Pieralisi wrote:
> [ +Bjorn, Punit]
> 
> On Wed, Aug 24, 2016 at 04:06:13AM -0700, Duc Dang wrote:
> > [Resend in plain text mode]
> > 
> > Hi Lorenzo, Rafael,
> > 
> > ACPI 6.1 spec does not specify how to set interrupt polarity and
> > trigger mode in _PRT when the interrupts are static (hardwired to
> > specific interrupt inputs in interrupt controller). In current
> > acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
> > default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
> > ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
> > GICv3 controllers and will cause failures in PCIe AER, PME services
> > (on X-Gene platforms).

PCI (not PCIe) r3.0, sec 2.2.6, says "Interrupts on PCI are optional
and defined as 'level sensitive,' asserted low."

I've heard before that ARM64 does this differently, but I still don't
understand the difference.  Obviously if you plug a legacy PCI card
into an ARM64 system, it's still going to pull INTA# low to assert an
interrupt.  So is there something special about ARM64 that inverts
that, or what?

> > Is there any way to specify polarity and trigger mode for static
> > interrupts in _PRT? 

There is no way I'm aware of in _PRT to specify polarity and trigger
mode.  I don't know the history, but my guess is that it would be seen
as superfluous given that the PCI spec requires level, active low.

Obviously I'm missing something important.

Bjorn

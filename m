Return-Path: <SRS0=Fe65=6I=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Fe65=6I=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
From: Mason <slash.tmp@free.fr>
Message-ID: <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
Date: Wed, 5 Jul 2017 01:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170703181128.GD4902@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 03/07/2017 20:11, Russell King - ARM Linux wrote:

> I don't think there's an easy solution to this problem - and I'm not
> sure that stop_machine() can be made to work in this path (which
> needs a process context).  I have a suspicion that the Sigma Designs
> PCI implementation is just soo insane that it's never going to work
> reliably in a multi-SoC kernel without introducing severe performance
> issues for everyone else.

If I remember correctly, this is the second HW block from
tango that has been deemed "too insane for Linux".

The first one was the DMA engine, which doesn't interrupt
when a transfer is done, but when a new transfer may be
programmed. (Though there is a simple work-around for
this one, if we give up command pipelining.)

Do larger SoC vendors have HW devs working closely with
Linux devs, to avoid these design bloopers?

Regards.

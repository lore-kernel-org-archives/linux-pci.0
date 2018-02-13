Return-Path: <helgaas@kernel.org>
Date: Tue, 13 Feb 2018 12:44:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kallol Biswas <ndprkm@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@gmail.com>
Subject: Re: enabling multiple MSI vectors for a DS port
Message-ID: <20180213184435.GE75542@bhelgaas-glaptop.roam.corp.google.com>
References: <CAP8qiGCNN4xgfDAtQf7H2rpBLJuLyWet0z6rau5WG7kVBj_NTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP8qiGCNN4xgfDAtQf7H2rpBLJuLyWet0z6rau5WG7kVBj_NTg@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Kallol,

On Tue, Feb 13, 2018 at 10:21:04AM -0800, Kallol Biswas wrote:
> Hi Bjorn,
>             I am facing an interrupt generation issue when single MSI
> is shared by both dpc and hotplug interrupt.
> 
> The DS port is multi-MSI capable. What I have noticed that if I move
> the switch (with DS port) and OS disk to a different system multiple
> MSI vectors are allocated and dpc isr and hotplug isr are on different
> vectors.
> 
> It seems that BIOS controls allocation of MSI vectors. Is there anyway
> to force linux kernel to allocate multiple vectors when port is
> capable?

BIOS doesn't control the allocation of MSI vectors.  That's done by
Linux in pcie_init_service_irqs(), and it depends on many things: what
services are supported by Linux (hotplug, PME, AER, DPC), which ones
Linux is allowed to use (based on the ACPI _OSC method, so this part
can be influenced by the BIOS), etc.

If you can share the "lspci -vv" and dmesg output for these two
systems, we can probably work out what's going on.

Things should *work* even if DPC and hotplug need to share an
interrupt.  If that doesn't work, that's a Linux bug that should be
fixed.

Bjorn

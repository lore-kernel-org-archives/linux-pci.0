Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <01f41dd8-e8e6-f880-cad8-5cb83bf0a167@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <4059f88f-0f70-38c2-f2f9-58dd2bd5b280@free.fr>
Date: Fri, 3 Mar 2017 12:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <01f41dd8-e8e6-f880-cad8-5cb83bf0a167@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2017 17:36, Marc Zyngier wrote:

> Mason: while the kernel has generic support for dealing with MSI, there
> is not standardization at the interrupt controller level, so you do have
> to write your own driver, and wire it in the rest of the framework.
> 
> I suggest you look at things like drivers/pci/host/pcie-altera-msi.c,
> which has an extremely simple implementation. You can use this as a
> starting point for your own driver.

Thanks Marc,

I'll have a close look at the Altera driver.

I'm having a hard time understanding 3 different kinds of interrupts:

  1. MSI (message-signalled interrupts)
  2. legacy interrupts
  3. custom interrupts

I mostly understand MSI. When a device needs attention from the CPU,
it sends a specific packet over the PCIe data link to a specific
PCI bus address, which the PCIe controller knows to interpret as
an interrupt request, so it raises the appropriate signal to
interrupt the CPU.

Legacy interrupts are the old-style PCI interrupts, when a device
expects to have an actual physical interrupt line to the PCI
controller, correct? The controller then forwards the interrupt
request to the CPU, as with MSIs.

Custom interrupts, I'm not sure. Here's the list:

system_error : indicates that the interrupt is triggered by a system error, signaled by the lower layers.
dma_rd_int : interrupt is triggered by DMA read availability.
dma_wr_int : interrupt is triggered by DMA write availability.
cpl_ur : interrupt is triggered by unsupported completion request.
cpl_crs : interrupt is triggered by configuration request retry status.
cpl_ca : interrupt is triggered by completer abort event.
cpl_timeout : interrupt is triggered by a completion timeout event.
pci_intx : one of selected legacy interrupts INTx is triggered. 

Notes:

It appears that legacy interrupts are supported through this
custom register.

I think I might be able to ignore DMA for the time being.

cpl_* interrupts look somewhat standard, yet the PCI framework
cannot know they exist, since they are in some random MMIO register.
I'm confused about these and system_error. I guess I can ignore
them at first, or just print a message when they trigger, to try
to figure out what to do with them.


I suppose the interrupt controller I'm supposed to write needs
to handle all 3 types of interrupts?

Regards.

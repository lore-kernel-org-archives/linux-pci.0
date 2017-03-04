Return-Path: <SRS0=XfhS=2N=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=XfhS=2N=arm.com=marc.zyngier@kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mason <slash.tmp@free.fr>,  linux-pci <linux-pci@vger.kernel.org>,  Linux ARM <linux-arm-kernel@lists.infradead.org>,  Will Deacon <will.deacon@arm.com>,  David Daney <david.daney@cavium.com>,  Rob Herring <robh@kernel.org>,  "Thierry Reding" <treding@nvidia.com>,  Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,  Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
Subject: Re: Using the generic host PCIe driver
In-Reply-To: <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
	(Bjorn Helgaas's message of "Fri, 3 Mar 2017 14:04:07 -0600")
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
	<8643c952-e915-bcd1-390e-9d4001789872@free.fr>
	<20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
	<347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
	<20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
	<98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
	<20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
	<258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
	<20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
	<8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
	<20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
Date: Sat, 04 Mar 2017 10:50:36 +0000
Message-ID: <87fuit2u4j.fsf@on-the-bus.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 03 2017 at  8:04:07 pm GMT, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Mar 03, 2017 at 06:18:02PM +0100, Mason wrote:
>> In fact, I thought I could ignore that BAR, but it is apparently NOT
>> the case, as MSIs are supposed to be sent *within* the BAR of the root.
>
> I don't know much about this piece of the MSI puzzle, but maybe Marc
> can enlighten us.  If this Root Port is the target of MSIs and the
> Root Port turns them into some sort of interrupt on the CPU side, I
> can see how this might make sense.

There is a whole range of PCIe RC that require to be programmed with the
doorbell address. It can be any address, but the kernel has to make sure
it is not something you will ever DMA to, as the RC is unlikely to
forward the transaction after having matched it.

> I think it's unusual for the PCI core to assign the MSI target using a
> BAR, though.  I think this means you'll have to implement your
> arch_setup_msi_irq() or .irq_compose_msi_msg() method such that it 
> looks up that BAR value, since you won't know it at build-time.

A common trick is to set the doorbell address to a well known value,
such as the base address for the PCIe RC itself. Of course, that only
works if the RC doesn't forward writes to the doorbell. Otherwise, any
RAM address will do, provided that it is not something we'd expect to
DMA to.

Thanks,

        M.
-- 
Jazz is not dead, it just smell funny.

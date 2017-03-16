Return-Path: <SRS0=f67S=2Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=f67S=2Z=free.fr=slash.tmp@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
From: Mason <slash.tmp@free.fr>
Subject: Legacy PCI interrupt support in PCIe host driver
Message-ID: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
Date: Thu, 16 Mar 2017 16:40:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am writing code for my platform's PCI Express controller.

I am stuck at the legacy PCI interrupt handling.

Interrupt requests are routed like this:

Cortex A9 MP <-- GIC(v1?) <-- system_intc <-- PCIe_root_complex

The PCIe root complex drives two interrupt signals to the system_intc

1) system_intc 54 = non-MSI interrupts
2) system_intc 55 = MSI interrupts

I think the MSI handling mostly works (although it's 340 lines long,
which seems excessive for such a common task; maybe the maintainers
will spot lots of redundant code when I submit).

As for non-MSI interrupts, there are 8 possible sources:

  system_error
  dma_read_ready
  dma_write_ready
  unsupported completion request
  configuration request retry status
  completer abort event
  completion timeout event
  legacy interrupt asserted (any of the 4 legacy interrupts)

Basically, I need to deal with the first 7 interrupts "internally"
in my PCIe root complex driver. But the last interrupt, I need to
"forward" it to the proper ISR (e.g. XHCI ISR).

For the "internal" handling, I think I need to register my own ISR
with the IRQF_SHARED flag. Then other drivers will be able to
register their ISR on the same interrupt line.

But how do I tell the PCI core that it's supposed to use interrupt 54
for legacy interrupts?

Here is my current DT:

		msi0: msi@2e080 {
			compatible = "sigma,msi";
			reg = <0x2e04c 0x40>;
			interrupt-parent = <&irq0>;
			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
			msi-controller;
			num-vectors = <32>;
		};

		pcie@30000000 {
			compatible = "sigma,smp8759-pcie";
			reg = <0x30000000 SZ_4M>, <0x2e02c 4>;
			device_type = "pci";
			bus-range = <0 3>;
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
			ranges = <0x02000000 0x0 0x00400000  0x30400000  0x0 SZ_60M>;
			msi-parent = <&msi0>;
			interrupt-parent = <&irq0>;
			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
		};


I traced the action into pdev_fixup_irq()
which calls of_irq_parse_and_map_pci()

How do I tell Linux that
- All the legacy PCI interrupts are muxed to a single line
- And this line is routed to system interrupt 54

Ooooooh... Wait...

Is this what interrupt-map is used for?

http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping

Regards.

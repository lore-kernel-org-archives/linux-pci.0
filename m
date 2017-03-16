Return-Path: <SRS0=f67S=2Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=f67S=2Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Legacy PCI interrupt support in PCIe host driver
From: Mason <slash.tmp@free.fr>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>
References: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
Message-ID: <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
Date: Thu, 16 Mar 2017 18:33:09 +0100
MIME-Version: 1.0
In-Reply-To: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 16/03/2017 16:40, Mason wrote:

> Here is my current DT:
> 
> 		msi0: msi@2e080 {
> 			compatible = "sigma,msi";
> 			reg = <0x2e04c 0x40>;
> 			interrupt-parent = <&irq0>;
> 			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
> 			msi-controller;
> 			num-vectors = <32>;
> 		};
> 
> 		pcie@30000000 {
> 			compatible = "sigma,smp8759-pcie";
> 			reg = <0x30000000 SZ_4M>, <0x2e02c 4>;
> 			device_type = "pci";
> 			bus-range = <0 3>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			#interrupt-cells = <1>;
> 			ranges = <0x02000000 0x0 0x00400000  0x30400000  0x0 SZ_60M>;
> 			msi-parent = <&msi0>;
> 			interrupt-parent = <&irq0>;
> 			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
> 		};
> 
> 
> I traced the action into pdev_fixup_irq()
> which calls of_irq_parse_and_map_pci()
> 
> How do I tell Linux that
> - All the legacy PCI interrupts are muxed to a single line
> - And this line is routed to system interrupt 54
> 
> Ooooooh... Wait...
> 
> Is this what interrupt-map is used for?
> 
> http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping

I added this to my pcie@30000000 node:

	interrupt-map = <0 0 0 1 &irq0 54 IRQ_TYPE_LEVEL_HIGH>;

to map INTA to system IRQ 54.

And now it works much better :-)

# cat /proc/interrupts 
           CPU0       
 19:       1529     GIC-0  29 Edge      twd
 20:        125      irq0   1 Level     serial
 22:          0      irq0  54 Level     tutu, xhci-hcd:usb1

About shared ISRs. Are they supposed to return IRQ_HANDLED
if and only if they handled something?

Will that stop the next ISR from being called?

I guess if two interrupts fire at the same time, we'll
just take two separate exceptions?

Regards.

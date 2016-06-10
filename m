Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54238 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcFJV4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 17:56:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
Date: Fri, 10 Jun 2016 23:57:49 +0200
Message-ID: <5441564.aSMx8kbhED@wuerfel>
In-Reply-To: <m3oa79bbi1.fsf@t19.piap.pl>
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com> <7440319.e8dDgNlZLB@wuerfel> <m3oa79bbi1.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, June 10, 2016 12:10:14 PM CEST Krzysztof Hałasa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > Before that, we were always setting both mrrs and mps. As we don't know
> > who uses PCIE_BUS_PEER2PEER, maybe another option would be to add yet
> > another pcie_bus_config value for this particular quirk?
> 
> It would be a safe approach.
> Or, maybe another non-pcie_bus_config thing, I don't know (so
> the pcie_bus_config is left for the user).
> 
> > I started the DT conversion a long time ago (see the DT parsing in
> > arch/arm/mach-cns3xxx/core.c) but I never had any hardware to test
> > on, and it was at a time when we didn't even have DT support in all
> > the subsystems.
> >
> > I'd definitely help you get the rest of the DT support in place if
> > you can test it. This is now the only SMP platform and one of
> > the last users of GIC and l2x0 that does not use DT, so I'd love
> > to see that converted just so we can remove the legacy probing from
> > those drivers.
> 
> Ok. Is there a DT skeleton file somewhere, so I can try to boot the
> board (without Laguna extras) in DT mode?
> At first, I only need CPU + RAM + console serial port.

I'd start by copying the relevant nodes from
arch/arm/boot/dts/arm-realview-pb11mp.dts, which is the closest
I can think of. I've put together something completely untested
below.

The key part is to have the correct "compatible" property in the
root node, which must list the actual machine before listing
"cavium,cns3420" to match the machine descriptor in
arch/arm/mach-cns3xxx/core.c

The RAM will be filled from the atags compatibility code
(but it makes sense to list it anyway), and the serial port
is not even needed in the first iteration if you heave
CONFIG_DEBUG_CNS3XXX set.


> > Converting what we have in mainline should be fairly straightforward,
> > but there is more code in 
> > target/linux/cns3xxx/files/arch/arm/mach-cns3xxx/laguna.c that requires
> > more work, in particular we need to come up with a way to handle
> > the laguna_net_data and laguna_info structures, which have some of
> > the same data that is normall in DT.
> 
> I assume adding this to U-Boot should be acceptable (for Gateworks,
> too). They are already doing this to their i.MX6 line Ventana.

Ok, if U-Boot can convert the configuration into the right DT
properties, that is ideal.

> > Also, the gpio driver doesn't
> > have a trivial conversion to DT and requires some work to define
> > a binding and implement that.
> 
> GPIO is a bit less important ATM, since the boards can boot without it.

Ok.


	Arnd

---
/dts-v1/;
#include <dt-bindings/interrupt-controller/irq.h>
#include <dt-bindings/gpio/gpio.h>
#include "skeleton.dtsi"

/ {
	model = "Cavium CNS3420 validation board";
	compatible = "cavium,cns3420";
	interrupt-parent = <&gic>;

	chosen { };

	aliases {
		serial0 = &serial;
	};

	memory {
		/* 256MB at address 0 */
		reg = <0x00000000 0x10000000>;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;
		enable-method = "cavium,cns3420-smp";

		cpu@0 {
			device_type = "cpu";
			compatible = "arm,arm11mpcore";
			reg = <0>;
			next-level-cache = <&L2>;
		};

		cpu@1 {
			device_type = "cpu";
			compatible = "arm,arm11mpcore";
			reg = <1>;
			next-level-cache = <&L2>;
		};
	};

	/* Primary TestChip GIC synthesized with the CPU */
	gic: interrupt-controller@1f000100 {
		compatible = "arm,arm11mp-gic";
		#interrupt-cells = <3>;
		#address-cells = <1>;
		interrupt-controller;
		reg = <0x90001000 0x1000>,
		      <0x90000100 0x100>;
	};

	L2: l2-cache {
		compatible = "arm,l220-cache";
		reg = <0x92002000 0x1000>;
		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
		cache-unified;
		cache-level = <2>;
		/* all of the below are probably wrong and
		   have to be fixed before we can use l2x0_of_init */
		cache-size = <1048576>; // 1MB
		cache-sets = <4096>;
		cache-line-size = <32>;
		arm,shared-override;
		arm,parity-enable;
		arm,outer-sync-disable;
	};

	scu@1f000000 {
		compatible = "arm,arm11mp-scu";
		reg = <0x90000000 0x100>;
	};

	flash@10000000 {
		/* 128MiB NOR Flash memory */
		compatible = "cfi-flash";
		reg = <0x10000000 0x08000000>;
		bank-width = <2>;

		partition@00000000 {
			label = "uboot";
			reg = <0 0x00040000>;
		};

		partition@00040000 {
			label = "kernel";
			reg = <0x00040000 0x004c0000>;
        	};

		partition@00500000 {
			label = "filesystem";
			reg = <0x00500000 0x07000000>;
        	};

		partition@07500000 {
			label = "filesystem2";
			reg = <0x07500000 0x00ae0000>;
        	};

		partition@07fe0000 {
			label = "ubootenv";
			reg = <0x07fe0000 0x00020000>;
        	};
        };

	soc {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		ranges;

		serial0: serial@78000000 {
			compatible = "ns16550a";
			reg = <0x78000000 0x1000>;
			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
			regshift = <2>;
			clocks = <&uartclk>;
		};
	};
};


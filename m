Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:55978 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3CZV1t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:27:49 -0400
Date: Tue, 26 Mar 2013 22:27:44 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130326222744.54e9fc82@skate>
In-Reply-To: <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130326163421.GA30255@obsidianresearch.com>
	<20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thierry,

On Tue, 26 Mar 2013 21:16:54 +0100, Thierry Reding wrote:

> > Thierry: Did you settle on using assigned-addresses? Can you share the
> > final binding for your driver?
> 
> Yes, I have the final bindings ready and I was waiting for Andrew's new
> version of the ranges parsing patch before sending the next (and
> hopefully final) version of the series. He posted that patch now so I
> should have something ready soon.

I will also rebase my patch set on top of Andrew's latest version of
the of/pci ranges parsing patch.

> For now here's what I currently use for DT:
> 
> 	pcie-controller {
> 		compatible = "nvidia,tegra20-pcie";
> 		device_type = "pci";
> 		reg = <0x80003000 0x00000800   /* PADS registers */
> 		       0x80003800 0x00000200   /* AFI registers */
> 		       0x90000000 0x10000000>; /* configuration space */
> 		reg-names = "pads", "afi", "cs";
> 		interrupts = <0 98 0x04   /* controller interrupt */
> 		              0 99 0x04>; /* MSI interrupt */
> 		interrupt-names = "intr", "msi";
> 
> 		bus-range = <0x00 0xff>;
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 
> 		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
> 			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
> 			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
> 			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
> 			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */
> 
> 		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
> 			 <&tegra_car 118>;
> 		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
> 		status = "disabled";
> 
> 		pci@1,0 {
> 			device_type = "pci";
> 			assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
> 			reg = <0x000800 0 0 0 0>;
> 			status = "disabled";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			nvidia,num-lanes = <2>;
> 		};
> 
> 		pci@2,0 {
> 			device_type = "pci";
> 			assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
> 			reg = <0x001000 0 0 0 0>;
> 			status = "disabled";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			nvidia,num-lanes = <2>;
> 		};
> 	};
> 
> I think that has everything that we discussed previously.

Hum, ok. I must admit I'm rather confused as to how this would map to
the Marvell PCIe case. What we're discussing is how to encode the MMIO
registers area that corresponds to each PCIe interface. For now, I've
used a single "reg" property in the parent node, with one entry per
PCIe interface:

                pcie-controller {
                        compatible = "marvell,armada-xp-pcie";
                        status = "disabled";
                        device_type = "pci";

                        #address-cells = <3>;
                        #size-cells = <2>;

                        msi-parent = <&msi>;
                        bus-range = <0x00 0xff>;

                        reg = <0xd0040000 0x2000>, <0xd0042000 0x2000>,
                              <0xd0044000 0x2000>, <0xd0048000 0x2000>,
                              <0xd004C000 0x2000>, <0xd0080000 0x2000>,
                              <0xd0082000 0x2000>, <0xd0084000 0x2000>,
                              <0xd0088000 0x2000>, <0xd008C000 0x2000>;

                        reg-names = "pcie0.0", "pcie2.0",
                                  "pcie0.1", "pcie0.2",
                                  "pcie0.3", "pcie1.0",
                                  "pcie3.0", "pcie1.1",
                                  "pcie1.2", "pcie1.3";

                        ranges = <0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
                                  0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */

                        pcie@1,0 {
                                device_type = "pci";
                                reg = <0x0800 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 58>;
                                marvell,pcie-port = <0>;
                                marvell,pcie-lane = <0>;
                                clocks = <&gateclk 5>;
                                status = "disabled";
                        };

                        pcie@2,0 {
                                device_type = "pci";
                                reg = <0x1000 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 59>;
                                marvell,pcie-port = <0>;
                                marvell,pcie-lane = <1>;
                                clocks = <&gateclk 6>;
                                status = "disabled";
                        };


and so now the suggestions is to do:

                pcie-controller {
                        compatible = "marvell,armada-xp-pcie";
                        status = "disabled";
                        device_type = "pci";

                        #address-cells = <3>;
                        #size-cells = <2>;

                        msi-parent = <&msi>;
                        bus-range = <0x00 0xff>;

			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000 /* Port 0.0 registers */
				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000 /* Port 2.0 registers */
				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000 /* Port 0.1 registers */
				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000 /* Port 0.2 registers */
				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000 /* Port 0.3 registers */
				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000 /* Port 1.0 registers */
				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000 /* Port 3.0 registers */
				  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000 /* Port 1.1 registers */
				  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000 /* Port 1.2 registers */
				  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000 /* Port 1.3 registers */
				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
                                  0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */

                        pcie@1,0 {
                                device_type = "pci";
				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
                                reg = <0x0800 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 58>;
                                marvell,pcie-port = <0>;
                                marvell,pcie-lane = <0>;
                                clocks = <&gateclk 5>;
                                status = "disabled";
                        };

                        pcie@2,0 {
                                device_type = "pci";
				assigned-addresses = <0x82001000 0 0xd0042000 0 0x2000>;
                                reg = <0x1000 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 59>;
                                marvell,pcie-port = <0>;
                                marvell,pcie-lane = <1>;
                                clocks = <&gateclk 6>;
                                status = "disabled";
                        };

			[...]

		};

Is this correct? Thierry, Jason, if you could confirm my understanding,
that would be great. I could then rework and resend the patch set.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

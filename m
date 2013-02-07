Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43779 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab3BGPvX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 10:51:23 -0500
Date: Thu, 7 Feb 2013 15:51:17 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207155117.GA19666@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com>
 <20130207153750.0fef1192@skate>
MIME-Version: 1.0
In-Reply-To: <20130207153750.0fef1192@skate>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 07, 2013 at 02:37:50PM +0000, Thomas Petazzoni wrote:
> Dear Andrew Murray,
> 
> On Tue, 29 Jan 2013 13:22:04 +0000, Andrew Murray wrote:
> 
> > > +       /*
> > > +        * Build an laddr array that describes the PCI device in a
> > > DT
> > > +        * way
> > > +        */
> > > +       laddr[0] = cpu_to_be32(port->devfn << 8);
> > > +       laddr[1] = laddr[2] = 0;
> > > +       intspec = cpu_to_be32(pin);
> > > +
> > > +       ret = of_irq_map_raw(port->dn, &intspec, 1, laddr, &oirq);
> > > +       if (ret) {
> > > +               dev_err(&pcie->pdev->dev,
> > > +                       "%s: of_irq_map_raw() failed, %d\n",
> > > +                       __func__, ret);
> > > +               return ret;
> > > +       }
> > 
> > Are you able to replace the above code with a call to of_irq_map_pci?
> > I'm not sure which approach is better. The of_irq_map_pci function
> > doesn't require the pin argument and instead uses the DT and/or
> > performs its own pin swizzling. I guess this means that if there are
> > PCIe devices in the DT tree that does any thing strange with pins
> > then it would be reflected in the IRQ you get. I've found that you
> > will also need to provide an implementation of
> > pcibios_get_phb_of_node for this to work correctly (see my RFC bios32
> > patch).
> 
> I tried to do so, but it doesn't work properly. Let me explain what I
> did and the behavior that I observe.
> 
> First of all, I didn't reimplement the pcibios_get_phb_of_node(), but
> instead, as Thierry Reding suggested, simply implemented the
> hw_pci.scan() function as follows:

I've not had any time to test Thierry's solution to avoid implementing
pcibios_get_phb_of_node - but it did seem to work for him and seem correct
at the time.

> 
> static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> {
> 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
> 	return pci_scan_root_bus(&pcie->pdev->dev, sys->busnr,
> 				 &mvebu_pcie_ops, sys, &sys->resources);
> }
> 
> This allows to pass the "struct device *" pointer, which ultimately
> allows the PCI devices to carry a pointer to the corresponding DT node.
> 
> The DT representing my PCIe controller and its interfaces is the
> following:
> 
> 		pcie-controller {
> 			compatible = "marvell,armada-370-xp-pcie";
> 			status = "disabled";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			bus-range = <0x00 0xff>;
> 
> 			ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
> 				  0x00001000 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
> 				  0x81000000 0 0	  0xc0000000 0 0x00010000   /* downstream I/O */
> 				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> 
> 			#interrupt-cells = <1>;
> 			interrupt-map-mask = <0xf800 0 0 1>;
> 			interrupt-map = <0x0800 0 0 1 &mpic 58 /* port 0.0 */
> 					 0x1000 0 0 1 &mpic 62>; /* port 1.0 */
> 
> 			pcie@0,0 {
> 				device_type = "pciex";
> 				reg = <0x0800 0 0xd0040000 0 0x2000>;
> 				#address-cells = <3>;
> 				#size-cells = <2>;
> 				marvell,pcie-port = <0>;
> 				marvell,pcie-lane = <0>;
> 				clocks = <&gateclk 5>;
> 				status = "disabled";
> 			};
> 
> 			pcie@1,0 {
> 				device_type = "pciex";
> 				reg = <0x1000 0 0xd0080000 0 0x2000>;
> 				#address-cells = <3>;
> 				#size-cells = <2>;
> 				marvell,pcie-port = <1>;
> 				marvell,pcie-lane = <0>;
> 				clocks = <&gateclk 9>;
> 				status = "disabled";
> 			};
> 		};
> 
> So we have two PCIe interfaces. lspci shows the following output:
> 
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 01:00.0 Network controller: Intel Corporation Ultimate N WiFi Link 5300
> 02:00.0 USB controller: ASMedia Technology Inc. Device 1040
> 
> So:
> 
>  * On bus 0, we have two PCI-to-PCI bridges. Those are emulated in
>    software and allow the Marvell PCIe driver to get dynamic assignment
>    of address decoding windows. The entries in the interrupt-map DT
>    property match the bus number and slot number of those PCI-to-PCI
>    bridges.
> 
>  * On bus 1, we have the real PCIe device connected to the first PCIe
>    interface. This bus 1 is made "visible" thanks to the 00:01.0
>    PCI-to-PCI bridge.
> 
>  * On bus 2, we have the real PCIe device connected to the second PCIe
>    interface. This bus 2 is made "visible" thanks to the 00:02.0
>    PCI-to-PCI bridge.
> 
> Now, when I call the of_irq_map_pci() function, the problem is that the
> "struct pci_dev" that it receives is the one corresponding to the
> particular PCIe device we're interested in. And this "struct pci_dev"
> has a non-NULL pointer to the "struct device_node" representing
> "pcie0,0" or "pci0,1" above. Since the "struct device_node" is
> non-NULL, of_irq_map_pci() builds a laddr[] with the bus number and
> devfn of this device: bus number is 1, devfn is 0. And this doesn't
> match with the interrupt-map that is in my DT, which associates the
> interrupts numbers with the PCI-to-PCI bridges rather than the devices
> themselves.
> 
> To me, the "struct pci_dev" representing the real PCIe devices should
> have a NULL "struct device_node" pointer, because those device are not
> represented in the DT. If this was the case, then the of_irq_map_pci()
> would go one level up in the PCI hierarchy, find the "struct pci_dev"
> that corresponds to the PCI-to-PCI bridge, which generates an laddr[]
> having a bus number a devfn value matching the interrupt-map property.

Yes this is my current understanding.

> 
> If I do the following hack in of_irq_map_pci(), then everything works
> nicely:
> 
>                 } else {
>                         /* We found a P2P bridge, check if it has a node */
>                         ppnode = pci_device_to_OF_node(ppdev);
> +                       if (pdev->bus->number != 0)
> +                               ppnode = NULL;
>                 }
> 
> 
> What this hack does is that if we are not on bus 0, it means that the
> pci_dev is a real PCIe device, and therefore we force the code to
> asssume it does not have a DT reference.
> 
> Isn't there a problem here in the PCI/DT code ? Is it normal that a
> PCIe device that isn't described in the DT carries a non-NULL struct
> device_node pointer?

I would suggest the issue isn't in the PCI/DT code. This is what I see
with my implementation (which uses an implementation of
pcibios_get_phb_of_node) - I'd like to believe this is correct behaviour:

- of_irq_map_pci is called for an endpoint (5:0:0), its pdev->dev.of_node
  is NULL. As I don't have a representation of this endpoint in my DT the
  of_irq_map_pci code proceeds to walk the fabric.
- Starting with the pdev for 5:0:0, of_irq_map_pci sees it has a parent
  (downstream switch bridge), in this case pdev(5:0:0)->bus->self->dev.of_node
  is NULL, due to this swizzling occurs and we walk the parent's bus (bus 2)
- This continues to bus 1 and then bus 0 where of_irq_map_pci realises that
  it has no parent (its the host bridge). Due to the implementation of
  pcibios_get_phb_of_node a of_node is produced, this is then used to construct
  a lspec (for bus number 0).

The of_irq_map_pci code stops walking as soon as it finds a function in the
tree that has a device node. This suggests that if you represent a bridge
you must also include an interrupt-map. The problem here is that you have
represented a bridge but not included a map.

I can think of three solutions:

1. Something like this:

                 } else {
                         /* We found a P2P bridge, check if it has a node */
                         ppnode = pci_device_to_OF_node(ppdev);
 +                       if (ppnode doesnt have an interrupt-map)//if (pdev->bus->number != 0)
 +                               ppnode = NULL;
                 }

2. Remove the bridges from the DT? Or remove the map from pcie-controller and
   add a map each to pcie@0,1 and pcie@1,1?

3. Change the mask of your map so that it doesn't care about bus numbers. I
   have a map that looks like this:

                interrupt-map-mask = <0 0 0 7>;
                interrupt-map = <0 0 0 1 ... //anything coming in on INTA
                                 0 0 0 2 ... //anything coming in on INTB
                                 0 0 0 3 ... ...
                                 0 0 0 4 ... ...

Andrew Murray

> 
> If you need some more details about the problem, do not hesitate to ask.
> 
> Thanks a lot for your help,
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 


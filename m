Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45374 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab3A2PIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:08:17 -0500
Date: Tue, 29 Jan 2013 15:08:03 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129150803.GA29817@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com>
 <20130129144522.44ed7373@skate>
 <20130129140522.GA24310@arm.com>
 <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
 <20130129152937.53ec9a9b@skate>
 <20130129150201.GA24101@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20130129150201.GA24101@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 03:02:01PM +0000, Thierry Reding wrote:
> On Tue, Jan 29, 2013 at 03:29:37PM +0100, Thomas Petazzoni wrote:
> > Dear Thierry Reding,
> > 
> > On Tue, 29 Jan 2013 15:20:15 +0100, Thierry Reding wrote:
> > 
> > > If at all possible I think the right thing to do is reuse the generic
> > > pcibios_get_phb_of_node() implementation. On Tegra this turned out to
> > > require a minimal change to the DT bindings of the root port nodes to
> > > make sure they provide the correct address in the reg property.
> > 
> > Could you detail the change that was needed? The DT bindings I use for
> > the Marvell PCIe driver are very, very similar to the ones you use for
> > Tegra, since I basically inspired my entire DT binding on your work.
> > And still, I think of_irq_map_pci() wasn't working for me.
> 
> Now that I think about it, there were a few more changes needed.
> For one, the reg property of the root port nodes need to be in the
> format specified by the PCI DT binding. That is, 3 cells for the
> address and 2 cells for the size.
> 
> So I end up with something like this:
> 
> 	pcie-controller {
> 		...
> 
> 		ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00001000 /* port 0 registers */
> 			  0x00001000 0 0x80001000 0x80001000 0 0x00001000 /* port 1 registers */
> 			  ...>;
> 
> 		pci@1,0 {
> 			reg = <0x000800 0 0x80000000 0 0x1000>;
> 			...
> 		};
> 
> 		pci@2,0 {
> 			reg = <0x001000 0 0x80001000 0 0x1000>;
> 			...
> 		};
> 	};
> 
> So what happens here is that for each root port (pci@1,0 and pci@2,0),
> the reg property is translated into the parent address space via the
> pcie-controller's ranges property. pci@1,0 gets the memory region
> 0x80000000-0x80000fff and pci@2,0 gets 0x80001000-0x80001fff. (These are
> actually windows through which the configuration space of the root ports
> is accessed.)
> 
> At the same time this reg property maps both devices into the PCI
> address space at addresses 0:01.0 and 0:02.0 respectively.
> 
> The second change is that you can't rely on ARM's default implementation
> of the bus scan operation, which calls pci_scan_root_bus(), passing in a
> NULL as the struct device which acts as the bus' parent. So on Tegra I
> added a custom implementation which calls pci_create_root_bus(), passing
> in the struct device of the PCI host bridge, whose .of_node field will
> be set to the pcie-controller node above. Incidentally this also fixed
> another issue where the PCI core and ARM's pci_common_init() both
> eventually end up calling pci_bus_add_devices(). I don't remember the
> exact symptoms but I think this was causing resource conflicts during
> the second enumeration or so.
> 
> Because a proper struct device with the correct .of_node field is passed
> into pci_create_root_bus(), the generic pcibios_get_phb_of_node() will
> know how to find it by looking at bus->bridge->parent->of_node. After
> that the generic matching code will search the bridge (pcie-controller)
> node's children and relate them to the struct pci_dev by devfn. This is
> done in pci_set_of_node() defined in drivers/pci/of.c, which calls
> of_pci_find_child_device() from drivers/of/of_pci.c.
> 
> This is quite convoluted, but I hope it helps.

Thanks this is very helpful. I will see if this lets me avoid implementing
pcibios_get_phb_of_node.

Thanks,

Andrew Murray


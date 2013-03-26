Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62105 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab3CZVKY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:10:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to interrupt controller driver
Date: Tue, 26 Mar 2013 21:10:15 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com> <201303261838.23246.arnd@arndb.de> <20130326214613.30fbdddf@skate>
In-Reply-To: <20130326214613.30fbdddf@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201303262110.15582.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 26 Mar 2013 18:38:22 +0000, Arnd Bergmann wrote:
> 
> > >     Note that both the parent and the child node need to have the
> > >     'interrupt-controller' empty property:
> > >     
> > >       * The interrupt-controller property is needed in the main
> > >     interrupt controller node (interrupt-controller@d0020000)
> > > because the of_irq_init() function skips nodes that are matching
> > > the given compatible string, but that don't have the
> > > interrupt-controller property.
> > >     
> > >      * The interrupt-controller property is needed in the child
> > >     interrupt controller node (main-intc@d0020000) otherwise the
> > >     resolution done by of_irq_map_one() doesn't work.
> > 
> > If you add compatible properties to the children, that would work
> > I suppose.
> 
> To which children? Only to the main-intc children? If so,
> armada_370_xp_mpic_of_init() would be called with a 'device_node *'
> that points to the main-intc, correct? Then it would have to go back up
> in the Device Tree to find the msi node? It's doable of course, but
> sounds strange, no?

I was thinking of registering two init functions as well.

> To me, the topology of the hardware is really that a single device
> provides two features: the main interrupt controller and the MSI
> interrupt controller. But I will adapt to whatever DT binding you
> propose.

My preference would be to have no sub-nodes but rather make the
code deal with an interrupt controller that has an interrupt domain
for regular IRQs but can also handle MSI.

> > I still wonder if the real solution shouldn't instead be to make the
> > irq domain code MSI aware. For instance, you don't really need a
> > cell to describe an interrupt because the interrupt number is
> > not a hardware property. So an MSI using device doesn't really
> > needs an "msis" or "interrupts" property, just an "msi-parent",
> > and we can add code to handle as a separate domain even if you
> > have a single device node that can do both level and message
> > interrupts.
> 
> So the msi-parent property should point to the single mpic node? But
> then the IRQ domain for MSI cannot be registered on this single MPIC
> node. Then, what would be the first argument of:
> 
>         armada_370_xp_msi_domain =
>                 irq_domain_add_linear(msi_node, PCI_MSI_DOORBELL_NR,
>                                       &armada_370_xp_msi_irq_ops, NULL);
> 
> and how would the PCIe driver get a pointer to this IRQ domain? (In the
> currently proposed code, it just does a irq_find_host(), which sounded
> very simple and straightforward).

I guess one way would be to have a single domain that is responsible
for the controller and handles both MSI and legacy interrupts. That
could probably be done without changes to the interrupt domain code.

Another option would be to add an irq_domain_add_msi() function that
creates a domain which is also tied to the same device node but does
not interact with it when going through the legacy interrupts.
You could then add a matching msi_find_host() or irq_find_msi_host()
function to return the domain.

> To clarify: I really don't mind reworking the code, but unfortunately
> "make the IRQ domain code MSI aware" is too vague for me to understand
> the direction you're thinking of.

I don't have specific code in mind yet, mainly playing around with the
possibilities for now.

	Arnd

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:50807 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755065Ab3DIIMH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 04:12:07 -0400
Date: Tue, 9 Apr 2013 09:11:19 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130409081119.GA30736@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 08, 2013 at 11:28:58PM +0100, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> >
> >  #endif /* LINUX_MSI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 2461033a..6aca43ea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -416,6 +416,7 @@ struct pci_bus {
> >         struct resource busn_res;       /* bus numbers routed to this bus */
> >
> >         struct pci_ops  *ops;           /* configuration access functions */
> > +       struct msi_chip *msi;           /* MSI controller */
> 
> "msi" seems like a too-generic name here; it suggests an interrupt or
> IRQ, not a controller.
> 
> I'm not sure this is the correct place for it.  Having it in the
> struct pci_bus means you need arch code to fill it in, e.g., you added
> it in mvebu_pcie_scan_bus() in patch 09/11.  There's no good way to do
> that for arches that use pci_scan_root_bus(), which is the direction
> I'd like to go.
> 
> I think it probably should go in sysdata instead.  That would mean you
> can't really do generic weak setup/tear-down functions, because they
> wouldn't know how to pull the MSI controller info out of the
> arch-specific sysdata.  But there are so many levels of weak-ness
> going on there, maybe it would be a good thing to get rid of one :)

But generic setup/tear-down functions would allow for architecture
independent MSI controllers. This would be useful for MSI controllers that
are unrelated to PCI host controllers or a specific architecture. It would
make drivers sit more comfortably in drivers/irqchip or drivers/pci/host. Also
having the msi_chip in struct pci_bus could allow there to exist multiple
MSI controllers on a PCI fabric and is consistent with pci_ops.

Assuming the MSI controller is represented in the device tree and there is a
relationship between the controller and the host bridge
(phandle/interrupt-parent) then as Thierry suggested[1] previously you could call
something like of_find_msi_chip_by_node(node) to locate an msi_chip from a
device node. Could this look up exist in pci_scan_root_bus via its struct
device.of_node? Perhaps pci_create_root_bus can be changed to take a parameter
for msi_chip alongside the ops parameter? The of_find_msi_chip_by_node could
walk up the device tree until it finds an MSI controller.

In the case where device tree isn't used - then I guess the weakly defined
arch_ callbacks would be replaced with the architectures existing
implementation. Or perhaps if MSI controllers are registered (msi_chip_add)
then pci_scan_root_bus could use the first controller it finds.

Also I believe pci_alloc_child_bus function would need to be changed to add
"b->msi = msi" to inherit msi_chip for child buses in the above patch?

Andrew Murray

[1] http://lkml.org/lkml/2013/3/25/67

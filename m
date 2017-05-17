Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdEQNp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 May 2017 09:45:56 -0400
Date: Wed, 17 May 2017 14:46:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robert Richter <robert.richter@cavium.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [RFC/RFT PATCH v2 3/3] PCI/ACPI: Add ACPI
 pci_bus_find_numa_node() implementation
Message-ID: <20170517134654.GA8497@red-moon>
References: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
 <20170515132205.19622-4-lorenzo.pieralisi@arm.com>
 <20170516151529.GC658@rric.localdomain>
 <20170516180200.GA24458@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170516180200.GA24458@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 16, 2017 at 07:02:00PM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 16, 2017 at 05:15:29PM +0200, Robert Richter wrote:
> > On 15.05.17 14:22:05, Lorenzo Pieralisi wrote:
> > > The introduction of pci_bus_find_numa_node(pci_bus) allows at PCI
> > > host bridge registration to detect the NUMA node for a given
> > > struct pci_bus.dev. Implement an ACPI method that, through
> > > the struct pci_bus.bridge ACPI companion, retrieve and return
> > > the NUMA node corresponding to a given struct pci_bus.dev.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/pci-acpi.c | 20 ++++++++++++++++++++
> > >  drivers/pci/pci.c      |  2 +-
> > >  include/linux/pci.h    |  6 ++++++
> > >  3 files changed, 27 insertions(+), 1 deletion(-)
> > > 
> > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index e9803c1..451342d 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5406,7 +5406,7 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> > >  
> > >  int pci_bus_find_numa_node(struct pci_bus *bus)
> > >  {
> > > -	return NUMA_NO_NODE;
> > > +	return acpi_disabled ? NUMA_NO_NODE : acpi_pci_bus_find_numa_node(bus);
> > 
> > I looked into how this works with devicetree.
> > 
> > With ACPI it is set directly in pci_register_host_bridge() with
> > set_dev_node().
> > 
> > For the DT case the set_dev_node call sets it to NUMA_NO_NODE first.
> > Since in DT the bridge is a platform device which has the node id
> > assigned already (if there is one), the bus' node id is set later in
> > device_add() when deriving it from the parent device which is the
> > bridge. So this should work.
> 
> Which also means that the node propagation for bus->dev in patch 2 can
> be probably removed :), the problem with ACPI is setting the node
> for the host bridge which in DT is done by default at platform device
> creation, the rest is done by the core already there is not any need
> to propagate it again when child busses are created (they take their
> node from the parent).

More explicitly, I think the whole series should work also with the diff
below applied on top of it. Side note: for consistency, I do not think
that adding a DT counterpart to pci_bus_find_numa_node() would hurt.

Thanks !
Lorenzo

-- >8 --
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 76c089f..cf0692c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -862,7 +862,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	 */
 	child->dev.class = &pcibus_class;
 	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
-	set_dev_node(&child->dev, dev_to_node(&parent->dev));
+
 	/*
 	 * Set up the primary, secondary and subordinate
 	 * bus numbers.

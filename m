Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755638AbdLOULE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 15:11:04 -0500
Date: Fri, 15 Dec 2017 14:11:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Joao Pinto' <Joao.Pinto@synopsys.com>,
        'Ley Foon Tan' <lftan@altera.com>,
        'Shawn Lin' <shawn.lin@rock-chips.com>,
        'Michal Simek' <michal.simek@xilinx.com>,
        'Jim Quinlan' <jim2101024@gmail.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, rfi@lists.rocketboards.org,
        linux-rockchip@lists.infradead.org
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
Message-ID: <20171215201100.GX30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
 <000f01d375d4$17e9c830$47bd5890$@gmail.com>
 <20171215190426.GW30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215190426.GW30595@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 15, 2017 at 01:04:26PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 15, 2017 at 01:39:50PM -0500, Jingoo Han wrote:
> > On Thursday, December 14, 2017 5:58 PM, Bjorn Helgaas wrote:
> > > In the PCI config access path, the *_pcie_valid_device() functions in
> > > the dwc, altera, rockchip, and xilinx drivers all check whether the
> > > link is up.

Sorry, Shawn, I included rockchip by mistake; it doesn't actually check for
link-up.  I'll try to remember to remove you and linux-rockchip from
the cc list of future emails.

> > > I think this is racy because the link may go down after we check but
> > > before we perform the config access.
> > > 
> > > What would blow up if we removed the *_pcie_link_up() checks?
> > 
> > The original intention is to avoid config access before link up.
> > 
> > Also, I did not find any racy condition as you mentioned.
> > However, if you think that we need to prevent the racy condition,
> > someone can send a patch or add comments.
> 
> Here's the race:
> 
>   pci_read_config_word
>     ...
>       dw_pcie_rd_conf
>         dw_pcie_valid_device
>           dw_pcie_link_up        # returns true; link currently up
>                                  <-- link goes down for unrelated reason
>         dw_pcie_rd_other_conf
>           dw_pcie_read
>             readl                # issue config read
> 
> The readl() that issues the config read in the PCIe domain races with
> the link-down event.  If the readl() completes first, everything works
> as expected.  If the link-down happens first, I don't know what
> happens.  This is the core of my question.
> 
> The hardware *should* do something sane because link-down is an
> asynchronous event that is unrelated to the config read and may happen
> at any time.  It's just part of the PCIe environment and the spec
> defines mechanisms for dealing with and reporting the situation.

To make this concrete, the patch I would propose is below.  This isn't
for merging yet; just for discussion and testing.

Jim mentioned that the Broadcom STB host controller effects a
synchronous or asynchronous abort when doing a config access when the
link or power has gone down on the Endpoint.  Possibly there's a
similar issue on DesignWare, Altera, and Xilinx.

I think the best way to handle that is to figure out how to deal with
the abort cleanly.  Using a test like *_pcie_link_up() to try to avoid
it is a 99% solution that means we'll see rare failures that are very
difficult to reproduce and debug.

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 81e2157a7cfb..3dcdcdd6aa37 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -524,14 +524,6 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 				int dev)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	/* If there is no link, then there is no device */
-	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pci))
-			return 0;
-	}
-
 	/* access only one slot on each root port */
 	if (bus->number == pp->root_bus_nr && dev > 0)
 		return 0;
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 5cc4f594d79a..17ba6cce9bd0 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -140,12 +140,6 @@ static void tlp_write_tx(struct altera_pcie *pcie,
 static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 				     struct pci_bus *bus, int dev)
 {
-	/* If there is no link, then there is no device */
-	if (bus->number != pcie->root_bus_nr) {
-		if (!altera_pcie_link_up(pcie))
-			return false;
-	}
-
 	/* access only one slot on each root port */
 	if (bus->number == pcie->root_bus_nr && dev > 0)
 		return false;
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 65dea98b2643..db94df5db148 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -218,12 +218,6 @@ static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct nwl_pcie *pcie = bus->sysdata;
 
-	/* Check link before accessing downstream ports */
-	if (bus->number != pcie->root_busno) {
-		if (!nwl_pcie_link_up(pcie))
-			return false;
-	}
-
 	/* Only one device down on each root port */
 	if (bus->number == pcie->root_busno && devfn > 0)
 		return false;
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 7b5325990f5e..3cdb99708342 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -163,11 +163,6 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct xilinx_pcie_port *port = bus->sysdata;
 
-	/* Check if link is up when trying to access downstream ports */
-	if (bus->number != port->root_busno)
-		if (!xilinx_pcie_link_up(port))
-			return false;
-
 	/* Only one device down on each root port */
 	if (bus->number == port->root_busno && devfn > 0)
 		return false;

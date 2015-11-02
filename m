Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59889 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbbKBVGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Nov 2015 16:06:54 -0500
Date: Mon, 2 Nov 2015 15:06:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 6/6] PCI: layerscape: add ls_pcie_msi_host_init
Message-ID: <20151102210650.GA17552@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
 <20151021213416.GJ1583@localhost>
 <20151022162130.GA21237@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151022162130.GA21237@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Your reply was *still* base64-encoded and thus rejected by the vger
mailing lists.

Minghuan wrote:
> On Thu, Oct 22, 2015 at 11:21:30AM -0500, Bjorn Helgaas wrote:
> > Minghuan wrote:
> > > On Wed, Oct 21, 2015 at 04:34:16PM -0500, Bjorn Helgaas wrote:
> > > > Hi Minghuan,
> > > > 
> > > > On Fri, Oct 16, 2015 at 03:19:20PM +0800, Minghuan Lian wrote:
> > > > > Layerscape PCIe has its own MSI implementation. The patch registers
> > > > > ls_pcie_msi_host_init() to avoid using Designware's MSI.
> > > > > 
> > > > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > > > ---
> > > > > Change log
> > > > > v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a
> > > > > 
> > > > >  drivers/pci/host/pci-layerscape.c | 17 +++++++++++++++++
> > > > >  1 file changed, 17 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> > > > > index c53692a..8fac6c8 100644
> > > > > --- a/drivers/pci/host/pci-layerscape.c
> > > > > +++ b/drivers/pci/host/pci-layerscape.c
> > > > > @@ -150,14 +150,31 @@ static void ls_pcie_host_init(struct pcie_port *pp)
> > > > >  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
> > > > >  }
> > > > >  
> > > > > +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> > > > > +				 struct msi_controller *chip)
> > > > > +{
> > > > > +	struct device_node *msi_node;
> > > > > +	struct device_node *np = pp->dev->of_node;
> > > > > +
> > > > > +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> > > > > +	if (!msi_node) {
> > > > > +		dev_err(pp->dev, "failed to find msi-parent\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > 
> > > > I don't see how this can be right.  I think it's OK if you want to enforce
> > > > the presence of "msi-parent", but the other implementations of
> > > > .msi_host_init (ks_dw_pcie_msi_host_init() and the default implementation
> > > > in dw_pcie_host_init()) both set pp->irq_domain and call
> > > > irq_create_mapping().
> > > > 
> > > > You don't do either of those, so I don't see how MSIs can work, because I
> > > > assume the generic DesignWare code will depend on pp->irq_domain.  If
> > > > you're planning to add more Layerscape-specific MSI support later, I think
> > > > you should wait and include this patch with that work.
> > 
> > > Regarding MSI, both LS1021a and LS1043a use SCFG to implement it. I have submitted patch:
> > > https://patchwork.kernel.org/patch/7411131/
> > > https://patchwork.kernel.org/patch/7411141/
> > 
> > > While ls2085a use ITS for it, we just re-use the ITS driver.
> > 
> > > I notice some platform MSI driver files were placed in pci/host
> > > folder not irqchip.  If it is ok, I would like to change driver
> > > folder and re-submitted the MSI patch.
> > 
> > I suppose you're referring to drivers/pci/host/pci-xgene-msi.c.  
> > That file doesn't really have much PCI stuff in it.  It does call
> > pci_msi_create_irq_domain(), but that's really the only PCI interface or
> > data structure it uses.  So I don't know if drivers/pci/host or
> > drivers/irqchip is the best place for it and for your
> > irq-ls-scfg-msi.c.
> > 
> > The connection between pci-xgene-msi.c and pci-xgene.c is not very
> > clear to me, and that's sort of what I'm complaining about here.
> > You're overriding a default MSI initialization method.  Usually that
> > means you do the same thing as the default method, but in a different
> > way.  You aren't doing the same thing at all, which makes the code
> > hard to review.
> > 
> > Maybe a comment about how the MSI controller gets connected to devices
> > below this host bridge would be enough.

> 1. We need to define callback function msi_host_init() to avoid the
> running desginware MSI related code Because our PCIe controller do not
> enable this feature.
> 
> 2. we do not need to do anything such as bus->msi= ls_scfg_msi Because
> with the latest code, when PCIe controller device is created
> of_msi_configure() will be called and MSI domain pointed by
> 'msi-parent' will be bound  to the device. pci_msi_get_domain(struct
> pci_dev *dev) -> dev_get_msi_domain(&dev->dev) will return this MSI
> domain.
> 
> 3. I will add a comment in the next version.

Don't bother, I added a comment and applied the patch like this:


commit 90cbdf8412d206f65ece3dcc53230e673da569c6
Author: Minghuan Lian <Minghuan.Lian@freescale.com>
Date:   Fri Oct 16 15:19:20 2015 +0800

    PCI: layerscape: Add ls_pcie_msi_host_init()
    
    Layerscape PCIe has its own MSI implementation.
    
    Register ls_pcie_msi_host_init() to avoid using DesignWare's MSI.
    
    [bhelgaas: add comment]
    Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 6a9fa8a..1677890 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -150,14 +150,37 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
 }
 
+static int ls_pcie_msi_host_init(struct pcie_port *pp,
+				 struct msi_controller *chip)
+{
+	struct device_node *msi_node;
+	struct device_node *np = pp->dev->of_node;
+
+	/*
+	 * The MSI domain is set by the generic of_msi_configure().  This
+	 * .msi_host_init() function keeps us from doing the default MSI
+	 * domain setup in dw_pcie_host_init() and also enforces the
+	 * requirement that "msi-parent" exists.
+	 */
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(pp->dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pcie_host_ops ls1021_pcie_host_ops = {
 	.link_up = ls1021_pcie_link_up,
 	.host_init = ls1021_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct pcie_host_ops ls_pcie_host_ops = {
 	.link_up = ls_pcie_link_up,
 	.host_init = ls_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct ls_pcie_drvdata ls1021_drvdata = {

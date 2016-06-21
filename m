Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53958 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbcFUQtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 12:49:52 -0400
Date: Tue, 21 Jun 2016 11:49:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window
 resources
Message-ID: <20160621164947.GA7603@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ@mail.gmail.com>
 <20160621142623.GA29966@localhost>
 <20160621154100.GA4782@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621154100.GA4782@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 06:41:00PM +0300, Valentine Barshak wrote:
> On Tue, Jun 21, 2016 at 09:26:23AM -0500, Bjorn Helgaas wrote:
> > [+cc Valentine]
> > 
> 
> Hi Bjorn,
> 
> > Hi Geert,
> > 
> > Thanks a lot for testing this, and sorry for the breakage.
> > 
> > On Tue, Jun 21, 2016 at 12:41:31PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Jun 7, 2016 at 1:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > > > Request host bridge window resources so they appear in ioport_resource and
> > > > iomem_resource and are reflected in /proc/ioports and /proc/iomem.
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > > >  drivers/pci/host/pci-rcar-gen2.c |    4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> > > > index 9980a4b..617a6b2 100644
> > > > --- a/drivers/pci/host/pci-rcar-gen2.c
> > > > +++ b/drivers/pci/host/pci-rcar-gen2.c
> > > > @@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
> > > >         struct rcar_pci_priv *priv = sys->private_data;
> > > >         void __iomem *reg = priv->reg;
> > > >         u32 val;
> > > > +       int ret;
> > > >
> > > >         pm_runtime_enable(priv->dev);
> > > >         pm_runtime_get_sync(priv->dev);
> > > > @@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
> > > >         /* Add PCI resources */
> > > >         pci_add_resource(&sys->resources, &priv->io_res);
> > > >         pci_add_resource(&sys->resources, &priv->mem_res);
> > > > +       ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > >
> > > >         /* Setup bus number based on platform device id / of bus-range */
> > > >         sys->busnr = priv->busnr;
> > > 
> > > This patch (commit 1bd019707b7c9249d34c5d348f1ef75eb4d83e89 in pci/next)
> > > broke PCI on r8a7791/koelsch. Dmesg differences are:
> > > 
> > >  pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
> > > -pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > -pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
> > > -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
> > 
> > This is probably a result of this code in drivers/pci/host/pci-rcar-gen2.c:
> > 
> >         /*
> >          * The controller does not support/use port I/O,
> >          * so setup a dummy port I/O region here.
> >          */
> >         priv->io_res.start = priv->mem_res.start;
> >         priv->io_res.end = priv->mem_res.end;
> >         priv->io_res.flags = IORESOURCE_IO;
> > 
> > We try to avoid adding dummy regions like this, but maybe we missed
> > this one.  I haven't found any email discussion about it yet, so I
> > don't know what the reason for this one is.  Valentine, do you
> > remember?
> 
> I do not, but I think I've found something in my mailbox.
> Below is the quote from the original conversation with:
> (Re: [PATCH] pci: Add R-Car Gen2 internal PCI support)
> 
> [quote starts]
>  >>+    priv->mem_res = *mem_res;
>  >>+    /*
>  >>+     * The controller does not support/use port I/O,
>  >>+     * so setup a dummy port I/O region here.
>  >>+     */
>  >>+    priv->io_res.start = priv->mem_res.start;
>  >>+    priv->io_res.end = priv->mem_res.end;
>  >>+    priv->io_res.flags = IORESOURCE_IO;
>  >>
>  > I don't understand this.  There's no requirement (at least as far as the
>  > PCI core is concerned) to supply an I/O aperture at all, and I think it
>  > would be better if you didn't.
>  >
>  > Oh, I see ... maybe pcibios_init_resources() forces you to have an
>  > I/O resource to avoid having it give you a default one?  And I
>  > suppose that since you have several host bridges, these dummy I/O
>  > regions have to be distinct.  Ugh.  Well, I guess this is something
>  > you'd have to fix here or in the ARM code, it's up to you what to do.
> 
>  Exactly. This is to avoid assigning default I/O resources.
> [quote ends]

Oh, right, now I remember.  Thanks for digging that out.

I propose the patches below to remove the requirement for having an
I/O space.  Any chance one of you could test them?


commit 8387e687f72747b994c54e29e31861f0db07eb0c
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jun 21 10:54:29 2016 -0500

    ARM: Make PCI I/O space optional
    
    For callers of pci_common_init_dev(), we previously always required a PCI
    I/O port resource.  If the caller's ->setup() function had added an I/O
    resource, we used that; otherwise, we added a default 64K I/O port space
    for it.
    
    There are PCI host bridges that do not support I/O port space, and we
    should not add fictitious spaces for them.
    
    If a caller sets struct hw_pci.io_optional, assume it is responsible for
    adding any I/O port resource it desires, and do not add any default I/O
    port space.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 0070e85..2d88af5 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -22,6 +22,7 @@ struct hw_pci {
 	struct msi_controller *msi_ctrl;
 	struct pci_ops	*ops;
 	int		nr_controllers;
+	unsigned int	io_optional:1;
 	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 05e61a2..65f12ef 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -410,7 +410,8 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+static int pcibios_init_resource(int busnr, struct pci_sys_data *sys,
+				 int io_optional)
 {
 	int ret;
 	struct resource_entry *window;
@@ -420,6 +421,14 @@ static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 			 &iomem_resource, sys->mem_offset);
 	}
 
+	/*
+	 * If a platform says I/O port support is optional, we don't add
+	 * the default I/O space.  The platform is responsible for adding
+	 * any I/O space it needs.
+	 */
+	if (io_optional)
+		return 0;
+
 	resource_list_for_each_entry(window, &sys->resources)
 		if (resource_type(window->res) == IORESOURCE_IO)
 			return 0;
@@ -466,7 +475,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (ret > 0) {
 			struct pci_host_bridge *host_bridge;
 
-			ret = pcibios_init_resources(nr, sys);
+			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
 				kfree(sys);
 				break;

commit eeb4d6cdf8960c484c5a6eb9b310145b75a59ec1
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jun 21 09:19:34 2016 -0500

    PCI: rcar: Drop gen2 dummy I/O port region
    
    Previously we added a dummy I/O port region even though the R-Car
    controller doesn't support PCI port I/O.  This resulted in bogus root bus
    resources like this:
    
      pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
    
    Drop the unused dummy I/O port region and set struct hw_pci.io_optional so
    the ARM PCI code doesn't add a default one for us.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 9980a4b..ddf7765 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -97,7 +97,6 @@
 struct rcar_pci_priv {
 	struct device *dev;
 	void __iomem *reg;
-	struct resource io_res;
 	struct resource mem_res;
 	struct resource *cfg_res;
 	unsigned busnr;
@@ -273,7 +272,6 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		rcar_pci_setup_errirq(priv);
 
 	/* Add PCI resources */
-	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
 
 	/* Setup bus number based on platform device id / of bus-range */
@@ -371,14 +369,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->mem_res = *mem_res;
-	/*
-	 * The controller does not support/use port I/O,
-	 * so setup a dummy port I/O region here.
-	 */
-	priv->io_res.start = priv->mem_res.start;
-	priv->io_res.end = priv->mem_res.end;
-	priv->io_res.flags = IORESOURCE_IO;
-
 	priv->cfg_res = cfg_res;
 
 	priv->irq = platform_get_irq(pdev, 0);
@@ -421,6 +411,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw_private[0] = priv;
 	memset(&hw, 0, sizeof(hw));
 	hw.nr_controllers = ARRAY_SIZE(hw_private);
+	hw.io_optional = 1;
 	hw.private_data = hw_private;
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;

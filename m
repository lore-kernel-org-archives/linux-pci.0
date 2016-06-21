Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Jun 2016 09:26:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window
 resources
Message-ID: <20160621142623.GA29966@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Valentine Barshak <valentine.barshak@cogentembedded.com>,
 linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Valentine]

Hi Geert,

Thanks a lot for testing this, and sorry for the breakage.

On Tue, Jun 21, 2016 at 12:41:31PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 7, 2016 at 1:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Request host bridge window resources so they appear in ioport_resource and
> > iomem_resource and are reflected in /proc/ioports and /proc/iomem.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pci-rcar-gen2.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> > index 9980a4b..617a6b2 100644
> > --- a/drivers/pci/host/pci-rcar-gen2.c
> > +++ b/drivers/pci/host/pci-rcar-gen2.c
> > @@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
> >         struct rcar_pci_priv *priv = sys->private_data;
> >         void __iomem *reg = priv->reg;
> >         u32 val;
> > +       int ret;
> >
> >         pm_runtime_enable(priv->dev);
> >         pm_runtime_get_sync(priv->dev);
> > @@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
> >         /* Add PCI resources */
> >         pci_add_resource(&sys->resources, &priv->io_res);
> >         pci_add_resource(&sys->resources, &priv->mem_res);
> > +       ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
> > +       if (ret < 0)
> > +               return ret;
> >
> >         /* Setup bus number based on platform device id / of bus-range */
> >         sys->busnr = priv->busnr;
> 
> This patch (commit 1bd019707b7c9249d34c5d348f1ef75eb4d83e89 in pci/next)
> broke PCI on r8a7791/koelsch. Dmesg differences are:
> 
>  pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
> -pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> -pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
> -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]

This is probably a result of this code in drivers/pci/host/pci-rcar-gen2.c:

        /*
         * The controller does not support/use port I/O,
         * so setup a dummy port I/O region here.
         */
        priv->io_res.start = priv->mem_res.start;
        priv->io_res.end = priv->mem_res.end;
        priv->io_res.flags = IORESOURCE_IO;

We try to avoid adding dummy regions like this, but maybe we missed
this one.  I haven't found any email discussion about it yet, so I
don't know what the reason for this one is.  Valentine, do you
remember?

Can you try the patch below (apply it before the 1bd019707b7c patch
that broke things)?


commit b64dc28f5f2b3afe47ee4a42fb79db84ec4227f8
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jun 21 09:19:34 2016 -0500

    PCI: rcar: Drop gen2 dummy I/O port region
    
    Previously we added a dummy I/O port region even though the R-Car
    controller doesn't support PCI port I/O.  This resulted in bogus root bus
    resources like this:
    
      pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
    
    Drop the unused dummy I/O port region.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 9980a4b..53ae619 100644
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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

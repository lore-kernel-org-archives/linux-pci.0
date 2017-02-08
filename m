Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Feb 2017 14:48:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
Message-ID: <20170208204831.GA2206@bhelgaas-glaptop.roam.corp.google.com>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru>
 <20170128204407.GA20550@bhelgaas-glaptop.roam.corp.google.com>
 <CAK3bHNV-O+k1rHSj-KTKOBNNDXpWxp7rXw8bi7ve7-T9qqs8dw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK3bHNV-O+k1rHSj-KTKOBNNDXpWxp7rXw8bi7ve7-T9qqs8dw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Shawn, Wenrui for rockchip error path issue]

Hi Abylay,

On Sun, Jan 29, 2017 at 09:40:38PM -0500, Abylay Ospan wrote:
> Hi Bjorn,
> 
> yes, this is still actual. I didn't seen any other patches/followups about
> this problem (am i missed some ?).
> Seems like this issue affects following drivers too:
> 
> drivers/pci/host/pcie-designware.c
> drivers/pci/host/pcie-rockchip.c
> drivers/pci/host/pcie-xilinx.c
> drivers/pci/host/pcie-xilinx-nwl.c
> drivers/pci/host/pci-host-common.c
>  -> drivers/pci/host/pci-thunder-ecam.c
>  -> drivers/pci/host/pci-thunder-pem.c
>  -> drivers/pci/host/pci-host-generic.c
> drivers/pci/host/pci-versatile.c
> drivers/pci/host/pci-xgene.c
> 
> so, I think we need more general fix for this issue. May be inside
> 'iproc_pcie_setup' (or deeper in 'devm_request_pci_bus_resources') or
> fix all drivers listed above. what is better ?
> 
> If better to fix all this drivers then my original patch is actual and
> need to be approved. If it's better to make more general fix then
> please let me know - I will prepare one.

This looks like an object lifetime issue.  The struct resource for
each host bridge window must live as long as the host bridge itself,
i.e., until we free the window list in pci_release_host_bridge_dev().

This is a problem in iproc_pcie_bcma_probe(), because the "res_mem"
window is on the stack and is deallocated when iproc_pcie_bcma_probe()
returns.

I didn't look at all the drivers you listed above, but I think the
first three are OK in this respect:

  dw_pcie_host_init
    LIST_HEAD(res)                            # on stack
    of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base)
      res = kzalloc()                         # different "res" from above!
      pci_add_resource_offset(resources, res, ...)
    devm_request_pci_bus_resources(&pdev->dev, &res)
    pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops, pp, &res)
    error:
      pci_free_resource_list(&res)
    
  rockchip_pcie_probe
    LIST_HEAD(res)                            # on stack
    of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff, &res, &io_base)
    devm_request_pci_bus_resources(dev, &res)
    pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res)
    
  xilinx_pcie_probe
    LIST_HEAD(res)                            # on stack
    of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff, &res, &iobase)
    devm_request_pci_bus_resources(dev, &res)
    pci_create_root_bus(dev, 0, &xilinx_pcie_ops, port, &res)
    error:
      pci_free_resource_list(&res)

The *LIST_HEAD* is on the stack, but the individual resources are
allocated by kzalloc inside of_pci_get_host_bridge_resources(), and
pci_create_root_bus_msi() links the "res" list into its own
bridge->windows list.

In rockchip_pcie_probe(), we are missing the pci_free_resource_list()
that we should have in the error path, but that's a slightly different
problem.

If there are other drivers with this problem, I think each driver
should be fixed, similar to this patch for iproc.

> 2017-01-28 15:44 GMT-05:00 Bjorn Helgaas <helgaas@kernel.org>:
> 
> > On Fri, Jan 13, 2017 at 02:58:41AM +0300, Abylay Ospan wrote:
> > > Resource allocated on stack was saved by 'devm_request_resource' to
> > > global 'iomem_resource' but become invalid after 'iproc_pcie_bcma_probe'
> > exit.
> > > So the global 'iomem_resource' was poisoned. This may cause kernel crash
> > > or second PCIe bridge registration failure.
> > >
> > > Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two
> > PCIe wifi
> > > adapters (b43 BCM4331 and ath10k QCA988X).
> > >
> > > Signed-off-by: Abylay Ospan <aospan@netup.ru>
> > ...

> > > ---
> > >  drivers/pci/host/pcie-iproc-bcma.c | 18 ++++++++----------
> > >  drivers/pci/host/pcie-iproc.h      |  2 ++
> > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pcie-iproc-bcma.c
> > b/drivers/pci/host/pcie-iproc-bcma.c
> > > index bd4c9ec..28f9b89 100644
> > > --- a/drivers/pci/host/pcie-iproc-bcma.c
> > > +++ b/drivers/pci/host/pcie-iproc-bcma.c
> > > @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device
> > *bdev)
> > >  {
> > >       struct device *dev = &bdev->dev;
> > >       struct iproc_pcie *pcie;
> > > -     LIST_HEAD(res);
> > > -     struct resource res_mem;
> > >       int ret;
> > >
> > >       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_device
> > *bdev)
> > >       }
> > >
> > >       pcie->base_addr = bdev->addr;
> > > +     INIT_LIST_HEAD(&pcie->resources);
> > >
> > > -     res_mem.start = bdev->addr_s[0];
> > > -     res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> > > -     res_mem.name = "PCIe MEM space";
> > > -     res_mem.flags = IORESOURCE_MEM;
> > > -     pci_add_resource(&res, &res_mem);
> > > +     pcie->res_mem.start = bdev->addr_s[0];
> > > +     pcie->res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> > > +     pcie->res_mem.name = "PCIe MEM space";
> > > +     pcie->res_mem.flags = IORESOURCE_MEM;
> > > +     pcie->res_mem.child = NULL;
> > > +     pci_add_resource(&pcie->resources, &pcie->res_mem);
> > >
> > >       pcie->map_irq = iproc_pcie_bcma_map_irq;
> > >
> > > -     ret = iproc_pcie_setup(pcie, &res);
> > > +     ret = iproc_pcie_setup(pcie, &pcie->resources);
> > >       if (ret)
> > >               dev_err(dev, "PCIe controller setup failed\n");
> > >
> > > -     pci_free_resource_list(&res);
> > > -
> > >       bcma_set_drvdata(bdev, pcie);
> > >       return ret;
> > >  }
> > > diff --git a/drivers/pci/host/pcie-iproc.h
> > b/drivers/pci/host/pcie-iproc.h
> > > index 04fed8e..866d649 100644
> > > --- a/drivers/pci/host/pcie-iproc.h
> > > +++ b/drivers/pci/host/pcie-iproc.h
> > > @@ -105,6 +105,8 @@ struct iproc_pcie {
> > >
> > >       bool need_msi_steer;
> > >       struct iproc_msi *msi;
> > > +     struct resource res_mem;
> > > +     struct list_head resources;

This looks good to me, but I don't think it's necessary to keep the
list_head in the struct iproc_pcie.  It should be safe to use
"LIST_HEAD(res)" on the stack like the other drivers do.  Can you
verify that and get an ack from Ray, Scott, or Jon?

> > >  };
> > >
> > >  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> 
> 
> -- 
> Abylay Ospan,
> NetUP Inc.
> http://www.netup.tv

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

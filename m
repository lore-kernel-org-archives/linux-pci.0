Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 25 May 2017 15:56:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC/RFT PATCH 03/18] PCI: Introduce pci_scan_root_bus_bridge()
Message-ID: <20170525205643.GA9474@bhelgaas-glaptop.roam.corp.google.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-4-lorenzo.pieralisi@arm.com>
 <CAK8P3a0HmrrYBP5em1s4VOY4Tb6=bwOrDDN6K8rPp8OEXtpMtA@mail.gmail.com>
 <20170502171501.GA5545@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170502171501.GA5545@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, Simon Horman <horms@verge.net.au>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ray, Scott, Jon]

On Tue, May 02, 2017 at 06:15:01PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Apr 28, 2017 at 02:28:38PM +0200, Arnd Bergmann wrote:
> > On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > Current pci_scan_root_bus() interface is made up of two main
> > > code paths:
> > >
> > > - pci_create_root_bus()
> > > - pci_scan_child_bus()
> > >
> > > pci_create_root_bus() is a wrapper function that allows to create
> > > a struct pci_host_bridge structure, initialize it with the passed
> > > parameters and register it with the kernel.
> > >
> > > As the struct pci_host_bridge require additional struct members,
> > > pci_create_root_bus() parameters list has grown in time, making
> > > it unwieldy to add further parameters to it in case the struct
> > > pci_host_bridge gains more members fields to augment its functionality.
> > >
> > > Since PCI core code provides functions to allocate struct
> > > pci_host_bridge, instead of forcing the pci_create_root_bus() interface
> > > to add new parameters to cater for new struct pci_host_bridge
> > > functionality, it is more suitable to add an interface in PCI
> > > core code to scan a PCI bus straight from a struct pci_host_bridge
> > > created and customized by each specific PCI host controller driver.
> > >
> > > Add a pci_scan_root_bus_bridge() function to allow PCI host controller
> > > drivers to create and initialize struct pci_host_bridge and scan
> > > the resulting bus.
> > >
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Good idea, yes. To avoid growing the number of interfaces too
> > much, should we change the existing users of pci_register_host_bridge
> > in host drivers over to this entry point, and make the other one
> > local to probe.c then?
> 
> Yes, the problem is that there are drivers (ie pcie-iproc.c) that
> require the struct pci_bus (created by pci_register_host_bridge())
> to fiddle with it to check link status and THEN scan the bus (so
> the pci_register_host_bridge() call can't be embedded in the scan
> interface - the driver requires struct pci_bus for pci_ops to work
> before scanning the bus itself).

I think code like iproc_pcie_check_link() that requires a struct
pci_bus before we even scan the bus is lame.  I think the driver
should be able to bring up the link before telling the PCI core about
the bridge.  Aardvark uses a typical pattern:

  advk_pcie_probe
    advk_pcie_setup_hw
      advk_pcie_wait_for_link
    pci_scan_root_bus

I would rather see iproc restructured along that line than add a
callback.

That would require replacing the pci_bus_read_config uses in
iproc_pcie_check_link() with something different, maybe iproc-internal 
accessors.  Slightly messy, but I think doable.

> I will see how I can accommodate this change because you definitely
> have a point.
> 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 7e4ffc4..c7a7f72 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2412,6 +2412,44 @@ void pci_bus_release_busn_res(struct pci_bus *b)
> > >                         res, ret ? "can not be" : "is");
> > >  }
> > >
> > > +int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
> > > +{
> > > +       struct resource_entry *window;
> > > +       bool found = false;
> > > +       struct pci_bus *b;
> > > +       int max, bus, ret;
> > > +
> > > +       if (!bridge)
> > > +               return -EINVAL;
> > > +
> > > +       resource_list_for_each_entry(window, &bridge->windows)
> > > +               if (window->res->flags & IORESOURCE_BUS) {
> > > +                       found = true;
> > > +                       break;
> > > +               }
> > > +
> > > +       ret = pci_register_host_bridge(bridge);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       b = bridge->bus;
> > > +       bus = bridge->busnr;
> > > +
> > > +       if (!found) {
> > > +               dev_info(&b->dev,
> > > +                "No busn resource found for root bus, will use [bus %02x-ff]\n",
> > > +                       bus);
> > > +               pci_bus_insert_busn_res(b, bus, 255);
> > > +       }
> > > +
> > > +       max = pci_scan_child_bus(b);
> > > +
> > > +       if (!found)
> > > +               pci_bus_update_busn_res_end(b, max);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > 
> > We probably want an EXPORT_SYMBOL() here as well.
> 
> Yep, sure.
> 
> Thanks for having a look !
> 
> Lorenzo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

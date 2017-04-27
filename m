Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60165 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752692AbdD0InN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2017 04:43:13 -0400
Message-ID: <1493282584.13947.6.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: dwc: fall back to legacy IRQs when multiple
 devices are attached
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        patchwork-lst@pengutronix.de
Date: Thu, 27 Apr 2017 10:43:04 +0200
In-Reply-To: <CAJ+vNU0AEZtc+DaYSV7S1LtXCncVh9nV4hG7BtYxJE=m6-80EA@mail.gmail.com>
References: <20170426181502.770-1-l.stach@pengutronix.de>
         <CAJ+vNU0AEZtc+DaYSV7S1LtXCncVh9nV4hG7BtYxJE=m6-80EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 26.04.2017, 14:11 -0700 schrieb Tim Harvey:
> On Wed, Apr 26, 2017 at 11:15 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > The DWC host does not support legacy PCI IRQs and MSIs at the same time,
> > so we need to fall back to using only legacy IRQs if there is a chance
> > that multiple devices with differing MSI capabilities are connected to
> > the host. The only configuration where MSIs can be safely used is when
> > the device below the host bridge is not a bridge, i.e. the only device
> > connected to this host.
> >
> > By disallowing MSI allocation when multiple devices might be attached
> > we get those configurations in a working state. The only configurations
> > that depend on MSIs being available, that I am aware of, are some
> > embedded devices with a PCIe attached FPGA, that is incapable of
> > generating PCI legacy IRQs. Those are kept working by allowing MSIs
> > when only a single device is attached to the host.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 24 ++++++++++++++++++++++--
> >  drivers/pci/dwc/pcie-designware.h      |  1 +
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 5ba334938b52..be2b2762c944 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -92,6 +92,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
> >                             (u32)(msi_target & 0xffffffff));
> >         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> >                             (u32)(msi_target >> 32 & 0xffffffff));
> > +
> > +       pp->msi_disabled = false;
> >  }
> >
> >  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> > @@ -136,9 +138,11 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> >  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> >  {
> >         int irq, pos0, i;
> > -       struct pcie_port *pp;
> > +       struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
> > +
> > +       if (pp->msi_disabled)
> > +               return -EINVAL;
> >
> > -       pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
> >         pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
> >                                        order_base_2(no_irqs));
> >         if (pos0 < 0)
> > @@ -410,6 +414,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                 goto error;
> >         }
> >
> > +       /*
> > +        * The DWC host does not support legacy PCI IRQs and MSIs at the same
> > +        * time, so we need to fall back to using only legacy IRQs if there is
> > +        * a chance that multiple devices with differing MSI capabilities are
> > +        * connected to the host. The only configuration where MSIs can be
> > +        * safely used is when the device below the host bridge is not a bridge,
> > +        * i.e. the only device connected to this host.
> > +        */
> > +       child = list_first_entry(&bus->children, struct pci_bus, node);
> > +       if (!list_empty(&child->devices)) {
> > +               struct pci_dev *dev = list_first_entry(&child->devices,
> > +                                                      struct pci_dev, bus_list);
> > +               if (pci_is_bridge(dev))
> > +                       pp->msi_disabled = true;
> > +       }
> > +
> >         if (pp->ops->scan_bus)
> >                 pp->ops->scan_bus(pp);
> >
> > diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> > index cd3b8713fe50..741bc31f8947 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -140,6 +140,7 @@ struct pcie_port {
> >         struct irq_domain       *irq_domain;
> >         unsigned long           msi_data;
> >         DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > +       bool                    msi_disabled;
> >  };
> >
> >  struct dw_pcie_ops {
> > --
> > 2.11.0
> >
> 
> Lucas,
> 
> Legacy interrupts are still not firing with this.

Can you provide me the output of "cat /proc/interrupts" and "lspci -t"
on your system? I've tested this change on the GW54xx and legacy IRQs
seemed to work there.

Regards,
Lucas

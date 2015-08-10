Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36225 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbHJWjD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 18:39:03 -0400
Received: by igbij6 with SMTP id ij6so79474047igb.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 15:39:01 -0700 (PDT)
Date: Mon, 10 Aug 2015 17:38:57 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH v2 2/2] PCI: designware: implement multivector MSI irq
 setup
Message-ID: <20150810223857.GC13982@google.com>
References: <1437662976-27188-1-git-send-email-l.stach@pengutronix.de>
 <1437662976-27188-2-git-send-email-l.stach@pengutronix.de>
 <CAHM4w1=Sz1xJ1OGc9xAMVCv8hMLwnWmGrkRLHdqpdC7EgzEbpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHM4w1=Sz1xJ1OGc9xAMVCv8hMLwnWmGrkRLHdqpdC7EgzEbpQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 04, 2015 at 08:41:15PM +0530, Pratyush Anand wrote:
> On Thu, Jul 23, 2015 at 8:19 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Allows to set up and use multiple MSI irqs per device.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Thanks Lucas, I'm hoping for a little refactoring as Pratyush suggests
and maybe a third patch to fill in the upper bytes of the message?  Or
do those look not feasible?

Bjorn

> > ---
> > The ifdef is needed to avoid a compile error on
> > !CONFIG_PCI_MSI, as msi_list is only part of pci_dev
> > when the kernel is compiled with MSI support.
> >
> > v2: move ifdeffery inside single function
> > ---
> >  drivers/pci/host/pcie-designware.c | 43 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 69486be7181e..52c600327805 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -286,6 +286,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> >         }
> >
> >         *pos = pos0;
> > +       desc->nvec_used = no_irqs;
> > +       desc->msi_attrib.multiple = order_base_2(no_irqs);
> > +
> >         return irq;
> >
> >  no_valid_irq:
> > @@ -323,6 +326,45 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> >         return 0;
> >  }
> >
> > +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> > +                            int nvec, int type)
> > +{
> > +#ifdef CONFIG_PCI_MSI
> > +       int irq, pos;
> > +       struct msi_desc *desc;
> > +       struct msi_msg msg;
> > +       struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> > +
> > +       /* MSI-X interrupts are not supported */
> > +       if (type == PCI_CAP_ID_MSIX)
> > +               return -EINVAL;
> > +
> > +       WARN_ON(!list_is_singular(&pdev->msi_list));
> > +       desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
> > +
> 
> Probably existing function dw_msi_setup_irq() can be re-factored and code after
> this line can be reused from refactored function, as they are almost same.
> 
> > +       irq = assign_irq(nvec, desc, &pos);
> > +       if (irq < 0)
> > +               return irq;
> > +
> > +       if (pp->ops->get_msi_addr)
> > +               msg.address_lo = pp->ops->get_msi_addr(pp);
> > +       else
> > +               msg.address_lo = virt_to_phys((void *)pp->msi_data);
> > +       msg.address_hi = 0x0;
> > +
> 
> Although, not specific to this patch, but since we are now going to have
> ARM64 support for DW as well, so it would be nice to fill msg.address_hi
> with upper bytes rather hard-coding as 0.
> 
> > +       if (pp->ops->get_msi_data)
> > +               msg.data = pp->ops->get_msi_data(pp, pos);
> > +       else
> > +               msg.data = pos;
> > +
> > +       pci_write_msi_msg(irq, &msg);
> > +
> > +       return 0;
> 
> ~Pratyush

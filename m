Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbDHJKu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 05:10:50 -0400
Message-ID: <1428484245.2809.20.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: designware: implement multiple MSI irq setup
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	kernel@pengutronix.de, linux-pci@vger.kernel.org
Date: Wed, 08 Apr 2015 11:10:45 +0200
In-Reply-To: <1427714234.3370.8.camel@pengutronix.de>
References: <1425922388-30464-1-git-send-email-l.stach@pengutronix.de>
	 <1425922388-30464-2-git-send-email-l.stach@pengutronix.de>
	 <20150320220753.GN26935@google.com>
	 <1427714234.3370.8.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Am Montag, den 30.03.2015, 13:17 +0200 schrieb Lucas Stach:
> Am Freitag, den 20.03.2015, 17:07 -0500 schrieb Bjorn Helgaas:
> > On Mon, Mar 09, 2015 at 06:33:08PM +0100, Lucas Stach wrote:
> > > Allows to properly set up multiple MSI irqs per device.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > The ifdef is needed to avoid a compile error on
> > > !CONFIG_PCI_MSI, as msi_list is only part of pci_dev
> > > when the kernel is compiled with MSI support.
> > > ---
> > >  drivers/pci/host/pcie-designware.c | 46 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > > 
> > > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > > index 1f4ea6f2d910..8a15ea2e8eab 100644
> > > --- a/drivers/pci/host/pcie-designware.c
> > > +++ b/drivers/pci/host/pcie-designware.c
> > > @@ -269,6 +269,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> > >  	}
> > >  
> > >  	*pos = pos0;
> > > +	desc->nvec_used = no_irqs;
> > > +	desc->msi_attrib.multiple = order_base_2(no_irqs);
> > > +
> > >  	return irq;
> > >  
> > >  no_valid_irq:
> > > @@ -305,6 +308,48 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> > >  
> > >  	return 0;
> > >  }
> > > +#ifdef CONFIG_PCI_MSI
> > > +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> > > +			     int nvec, int type)
> > > +{
> > > +	int irq, pos;
> > > +	struct msi_desc *desc;
> > > +	struct msi_msg msg;
> > > +	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> > > +
> > > +	/* MSI-X interrupts are not supported */
> > > +	if (type == PCI_CAP_ID_MSIX)
> > > +		return -EINVAL;
> > > +
> > > +	WARN_ON(!list_is_singular(&pdev->msi_list));
> > > +	desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
> > > +
> > > +	irq = assign_irq(nvec, desc, &pos);
> > > +	if (irq < 0)
> > > +		return irq;
> > > +
> > > +	if (pp->ops->get_msi_addr)
> > > +		msg.address_lo = pp->ops->get_msi_addr(pp);
> > > +	else
> > > +		msg.address_lo = virt_to_phys((void *)pp->msi_data);
> > > +	msg.address_hi = 0x0;
> > > +
> > > +	if (pp->ops->get_msi_data)
> > > +		msg.data = pp->ops->get_msi_data(pp, pos);
> > > +	else
> > > +		msg.data = pos;
> > > +
> > > +	pci_write_msi_msg(irq, &msg);
> > > +
> > > +	return 0;
> > > +}
> > > +#else
> > > +static int dw_msi_setup_irqs(struct msi_chip *chip, struct pci_dev *pdev,
> > > +			     int nvec, int type)
> > > +{
> > > +	return -ENOSYS;
> > > +}
> > 
> > Seems strange that we need even this stub function when we don't have
> > CONFIG_PCI_MSI.  Is there some way we can fix this so dw_pcie_msi_chip is
> > only defined when we have CONFIG_PCI_MSI?
> > 
> I would rather not do this. We try to keep as much code as possible to
> at least see some compile coverage, even if the options are not set by
> using the IS_ENABLED() macro instead of ifdefs. All other MSI related
> code compiles even without CONFIG_PCI_MSI being set.
> 
> The problem with the above function is that the msi_list member of
> struct pci_device is only declared if CONFIG_PCI_MSI is set. So of you
> really want to get rid of the above stub, my preferred solution would be
> to remove the ifdef in struct pci_device, so we can compile the code
> regardless of the config options.
> 
I'm waiting on your feedback on the above issue. Would you be OK with
changing the common struct pci_device to allow for more compile
coverage?

If not I would like if you could take those patches as is.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |


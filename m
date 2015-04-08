Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34937 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbbDHSym (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 14:54:42 -0400
Received: by obbfy7 with SMTP id fy7so153179953obb.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 11:54:41 -0700 (PDT)
Date: Wed, 8 Apr 2015 13:54:38 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] PCI: designware: implement multiple MSI irq setup
Message-ID: <20150408185438.GB30967@google.com>
References: <1425922388-30464-1-git-send-email-l.stach@pengutronix.de>
 <1425922388-30464-2-git-send-email-l.stach@pengutronix.de>
 <20150320220753.GN26935@google.com>
 <1427714234.3370.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427714234.3370.8.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Thomas]

[Thomas, this is just FYI.  The previous patch adds

+       int (*setup_irqs)(struct msi_controller *chip, struct pci_dev *dev,
+                         int nvec, int type);

to struct msi_controller.]

On Mon, Mar 30, 2015 at 01:17:14PM +0200, Lucas Stach wrote:
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

Is it really a goal to compile code for disabled config options?  I see
that a lot of the host drivers do that, especially for MSI-related code,
and the lack of #ifdefs might be an advantage.  But I don't think we want
code for disabled config options to appear in the object file, and I'm not
sure it improves readability for human readers who lose the #ifdef clues.

> The problem with the above function is that the msi_list member of
> struct pci_device is only declared if CONFIG_PCI_MSI is set. So of you
> really want to get rid of the above stub, my preferred solution would be
> to remove the ifdef in struct pci_device, so we can compile the code
> regardless of the config options.

No, I don't really want to remove the #ifdef in struct pci_device, because
if CONFIG_PCI_MSI is disabled, there's no reason to include the space in
the structure.  For one config option, it's not a big deal, but it doesn't
scale well if we apply the same rule to all config options.

But since these patches don't change the disabled config option strategy,
I'll apply them mostly as-is, given an ack from Mohit and/or Jingoo.

Bjorn

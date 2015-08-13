Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38376 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbbHMOQe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2015 10:16:34 -0400
Message-ID: <1439475392.13210.19.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/5] PCI: designware: set up high part of MSI target
 address
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 13 Aug 2015 16:16:32 +0200
In-Reply-To: <CAHM4w1kKu1rbONmWvE2UnEWXNaY+b73JXwB6Af+_KD6CfpKL8w@mail.gmail.com>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	 <1439372036-15303-6-git-send-email-l.stach@pengutronix.de>
	 <CAHM4w1kKu1rbONmWvE2UnEWXNaY+b73JXwB6Af+_KD6CfpKL8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I'm going to respin this patch to fix it regarding Pratyushs comment.

In such a situation do you prefer a repost of the whole series or rather
just have the single fixed patch reposted?

Regards,
Lucas

Am Mittwoch, den 12.08.2015, 21:05 +0530 schrieb Pratyush Anand:
> On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Set up the high part of the MSI target address in order to allow the
> > MSI target to reside above the 4GB mark on 64bit and PAE systems.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/host/pcie-designware.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 74034395cf2a..fcb798e47c30 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -299,12 +299,15 @@ no_valid_irq:
> >  static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
> >  {
> >         struct msi_msg msg;
> > +       u64 msi_target;
> >
> >         if (pp->ops->get_msi_addr)
> > -               msg.address_lo = pp->ops->get_msi_addr(pp);
> > +               msi_target = pp->ops->get_msi_addr(pp);
> >         else
> > -               msg.address_lo = virt_to_phys((void *)pp->msi_data);
> > -       msg.address_hi = 0x0;
> > +               msi_target = virt_to_phys((void *)pp->msi_data);
> > +
> > +       msg.address_lo = (u32)(msi_target & 0xffffffff);
> > +       msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> >
> >         if (pp->ops->get_msi_data)
> >                 msg.data = pp->ops->get_msi_data(pp, pos);
> 
> Other than above, dw_pcie_msi_init also need to be fixed
> for PCIE_MSI_ADDR_HI.

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |


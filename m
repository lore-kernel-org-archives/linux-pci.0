Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60435 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaFMOVx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jun 2014 10:21:53 -0400
Message-ID: <1402669218.4802.3.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: allow MSI chip providers to implement their
 own multiple MSI setup
From: Lucas Stach <l.stach@pengutronix.de>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de,
	Marek =?UTF-8?Q?Va=C5=A1ut?= <marex@denx.de>,
	Richard Zhu <richard.zhu@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Pratyush ANAND <pratyush.anand@st.com>
Date: Fri, 13 Jun 2014 16:20:18 +0200
In-Reply-To: <CAHM4w1kfsVbcNquK4t1NJqYRc9Qrjg6JYNJuAV=cpZ81Zm-pnw@mail.gmail.com>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
	 <1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
	 <CAHM4w1kfsVbcNquK4t1NJqYRc9Qrjg6JYNJuAV=cpZ81Zm-pnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush,

Am Freitag, den 13.06.2014, 11:12 +0530 schrieb Pratyush Anand:
>  Hi Lucas,
> 
> 
> On Thu, Jun 5, 2014 at 8:16 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/msi.c   | 3 +++
> >  include/linux/msi.h | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 27a7e67ddfe4..c45399d3061a 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -68,9 +68,12 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> >
> >  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> >  {
> > +       struct msi_chip *chip = dev->bus->msi;
> >         struct msi_desc *entry;
> >         int ret;
> >
> > +       if (chip && chip->setup_irqs)
> 
> I think, you should also check here for nvec > 1

No, nvec == 1 is just a special case and is perfectly valid.
> 
> > +               return chip->setup_irqs(chip, dev, nvec, type);
> 
> Before return, shouldn't we set chip_data for all desc->irq?

Setting chip_data is done in the MSI irq domains map callback and is the
same for single or multiple MSI setup. No need to do anything special
here.

> >         /*
> >          * If an architecture wants to support multiple MSI, it needs to
> >          * override arch_setup_msi_irqs()
> 
> This comment can be modified like "If an architecture wants
> to support multiple MSI, it needs to either override arch_setup_msi_irqs()
> or provide support of setup_irqs."
> 
Right, I'll extend that comment for v2.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33735 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab3KZVTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 16:19:51 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: [PATCH] Kernel oops from pci_disable_msi
Date: Tue, 26 Nov 2013 22:19:49 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Eric Nelson'" <Eric.Nelson@boundarydevices.com>,
	"'Troy Kisky'" <troy.kisky@boundarydevices.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <1385118399.3944.32.camel@bnilsen-HP> <cmu-lmtpd-32538-1385137032-0@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-32538-1385137032-0@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311262219.49115.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,
[...]

> > > Thank you for your effort!
> > > I reproduced this kernel panic on Exynos platform with LAN card.
> > > And then, I tested your patch and checked this kernel panic is
> > > resolved.
> > > 
> > > Marek Vasut,
> > > Will you test Bjørn Erik Nilsen's patch with your i.MX platform?
> > > 
> > > Pratyush Anand,
> > > Would you confirm Bjørn Erik Nilsen's patch?
> > > 
> > > I will do more extensive testing.
> > > Thank you.
> > 
> > The patch does indeed fix the crash, but there are more subtle issues
> > lurking around. I noticed how irq numbers were constantly increasing and
> > I found at least one stupid mistake that I made.
> > 
> > > -             irq_set_msi_desc(irq + i, desc);
> > > +             irq_set_msi_desc_off(irq + i, i, desc);
> > 
> > That should be 'irq_set_msi_desc_off(irq, i, desc)'
> > 
> > (I'm really puzzled why this didn't cause other oops ...)
> > 
> > I also realized that teardown() is only called for the irq returned from
> > setup(), which kind of makes sense since the others are destroyed() in
> > the first call to teardown. This means we need to iterate all irqs in
> > the same fashion as we allocate in setup/assign_irq. Basically unrolling
> > what was done there.
> > 
> > I'm hacking on this solution now but it doesn't quite take me to where I
> > want at the moment, so it would be nice if someone with a better
> > understanding of the code could pitch in.
> 
> I gave it another shot and now it starts to look like something. At
> least I get consistent irq numbers and my system is very stable in
> general.
> 
> My new patch does exactly the opposite in teardown() of what is done in
> setup(), which in itself is a good sign.
> 
> --- pcie-designware.c.orig      2013-11-21 14:02:03.656007695 +0100
> +++ pcie-designware.c   2013-11-22 16:32:30.360954591 +0100
> @@ -242,11 +242,15 @@ static int assign_irq(int no_irqs, struc
>         if (!irq)
>                 goto no_valid_irq;
> 
> +       /*
> +        * irq_domain_add_linear (called from dw_pcie_host_init)
> pre-allocates +        * descs so there is no need to call irq_alloc_descs
> here. +        */
> +
>         i = 0;
>         while (i < no_irqs) {
>                 set_bit(pos0 + i, pp->msi_irq_in_use);
> -               irq_alloc_descs((irq + i), (irq + i), 1, 0);
> -               irq_set_msi_desc(irq + i, desc);
> +               irq_set_msi_desc_off(irq, i, desc);

Why do you not allocate the descs anymore ?

>                 /*Enable corresponding interrupt in MSI interrupt
> controller */ res = ((pos0 + i) / 32) * 12;
>                 bit = (pos0 + i) % 32;
> @@ -266,7 +270,7 @@ no_valid_irq:
> 
>  static void clear_irq(unsigned int irq)
>  {
> -       int res, bit, val, pos;
>         struct irq_desc *desc;
>         struct msi_desc *msi;
>         struct pcie_port *pp;
> @@ -281,18 +285,28 @@ static void clear_irq(unsigned int irq)
>                 return;
>         }
> 
> +       /* undo what was done in assign_irq */
>         pos = data->hwirq;
> +       nvec = 1 << msi->msi_attrib.multiple;
> 
> -       irq_free_desc(irq);
> -
> -       clear_bit(pos, pp->msi_irq_in_use);
> +       i = 0;
> +       while (i < nvec) {
> +               clear_bit(pos + i, pp->msi_irq_in_use);
> +               irq_set_msi_desc_off(irq, i, NULL);
> +               /* Disable corresponding interrupt on MSI interrupt
> controller */ +               res = ((pos + i) / 32) * 12;
> +               bit = (pos + i) % 32;
> +               dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> &val); +               val &= ~(1 << bit);
> +               dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> val); +               ++i;
> +       }
> 
> -       /* Disable corresponding interrupt on MSI interrupt controller */
> -       res = (pos / 32) * 12;
> -       bit = pos % 32;
> -       dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -       val &= ~(1 << bit);
> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +       msi->msg.address_lo = 0;
> +       msi->msg.address_hi = 0;
> +       msi->msg.data = 0;
> +       msi->irq = 0;
> +       msi->msi_attrib.multiple = 0;
>  }
> 
>  static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
> @@ -320,15 +334,14 @@ static int dw_msi_setup_irq(struct msi_c
>         if (irq < 0)
>                 return irq;
> 
> -       msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
> -       msg_ctr |= msgvec << 4;
> -       pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
> -                               msg_ctr);
>         desc->msi_attrib.multiple = msgvec;
> -
>         msg.address_lo = virt_to_phys((void *)pp->msi_data);
>         msg.address_hi = 0x0;
>         msg.data = pos;
> +       /*
> +        * write_msi_msg() will update PCI_MSI_FLAGS so there
> +        * is no need to explicitly call pci_write_config here
> +        */
>         write_msi_msg(irq, &msg);
> 
>         return 0;
> 
> 
> Best regards,
> 
> Bjørn Erik Nilsen

Can you try using 'git send-email' for submitting subsequent patches please?

The patch works back and forth, I can 'remove' the card with:

echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove

and then 'rescan' the card with:

echo 1 > /sys/bus/pci/devices/0000:00:00.0/rescan

Tested-by: Marek Vasut <marex@denx.de>

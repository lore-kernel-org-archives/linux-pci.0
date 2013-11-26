Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30943 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530Ab3KZLVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 06:21:40 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWV001QKBK31I50@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 26 Nov 2013 20:21:39 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: =?UTF-8?Q?'Bj=C3=B8rn_Erik_Nilsen'?= <ben@datarespons.no>,
	'Marek Vasut' <marex@denx.de>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Eric Nelson' <Eric.Nelson@boundarydevices.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com>
 <201311201302.57210.marex@denx.de>
 <cmu-lmtpd-23243-1384949805-3@frontend1.mail.m-online.net>
 <201311201457.09154.marex@denx.de> <1385036087.3945.28.camel@bnilsen-HP>
 <1385039987.6020.5.camel@bnilsen-HP>
 <16.79.22145.6305E825@epmailin9.samsung.com>
 <000501cee75f$a8ccda70$fa668f50$%han@samsung.com>
 <1385118399.3944.32.camel@bnilsen-HP>
 <7D.78.31634.B838F825@epmailin2.samsung.com>
In-reply-to: <7D.78.31634.B838F825@epmailin2.samsung.com>
Subject: Re: [PATCH] Kernel oops from pci_disable_msi
Date: Tue, 26 Nov 2013 20:21:38 +0900
Message-id: <001701ceea99$acc0dea0$06429be0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, November 23, 2013 1:17 AM, Bjørn Erik Nilsen wrote:
> On Fri, 2013-11-22 at 12:06 +0100, Bjørn Erik Nilsen wrote:

[....]

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

Hi Bjørn Erik Nilsen,

I tested this patch with Exynos platform.
I checked that the kernel panic is resolved.

By the way, would you change your mail to text mode?
Your mails have not been submitted to PCI-mailing list.

Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I
Would you review Bjørn Erik Nilsen's new patch?

> --- pcie-designware.c.orig      2013-11-21 14:02:03.656007695 +0100
> +++ pcie-designware.c   2013-11-22 16:32:30.360954591 +0100
> @@ -242,11 +242,15 @@ static int assign_irq(int no_irqs, struc
>         if (!irq)
>                 goto no_valid_irq;
> 
> +       /*
> +        * irq_domain_add_linear (called from dw_pcie_host_init) pre-allocates
> +        * descs so there is no need to call irq_alloc_descs here.
> +        */
> +
>         i = 0;
>         while (i < no_irqs) {
>                 set_bit(pos0 + i, pp->msi_irq_in_use);
> -               irq_alloc_descs((irq + i), (irq + i), 1, 0);
> -               irq_set_msi_desc(irq + i, desc);
> +               irq_set_msi_desc_off(irq, i, desc);
>                 /*Enable corresponding interrupt in MSI interrupt controller */
>                 res = ((pos0 + i) / 32) * 12;
>                 bit = (pos0 + i) % 32;
> @@ -266,7 +270,7 @@ no_valid_irq:
> 
>  static void clear_irq(unsigned int irq)
>  {
> -       int res, bit, val, pos;

The build errors happens.
Thus, the following lines are necessary

+       int res, bit, pos, nvec, i;
+       u32 val;

Best regards,
Jingoo Han

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
> +               /* Disable corresponding interrupt on MSI interrupt controller */
> +               res = ((pos + i) / 32) * 12;
> +               bit = (pos + i) % 32;
> +               dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +               val &= ~(1 << bit);
> +               dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +               ++i;
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


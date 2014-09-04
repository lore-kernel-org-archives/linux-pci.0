Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:38197 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbaIDNUl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 09:20:41 -0400
Received: by mail-qg0-f47.google.com with SMTP id z60so9829357qgd.20
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 06:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Sep 2014 07:20:19 -0600
Message-ID: <CAErSpo5kEVSKmZn9CxZ=G=PbnKcAaso=ZwCwp=aEvJsnS_AKyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: designware: change MSI-related pcie_host_ops
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 4, 2014 at 12:45 PM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> 1. Change original get_msi_data() to get_msi_addr(), since this
> function returns MSI message address.
> 2. Add a new function get_msi_data() to return MSI message data.

This looks like two patches: one that merely renames a function, with
no functional change at all, and a second that adds a new function.
Please split them.

> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 11 ++++++++---
>  drivers/pci/host/pcie-designware.h |  3 ++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 52bd3a1..c84913e 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -373,12 +373,17 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
>          */
>         desc->msi_attrib.multiple = msgvec;
>
> -       if (pp->ops->get_msi_data)
> -               msg.address_lo = pp->ops->get_msi_data(pp);
> +       if (pp->ops->get_msi_addr)
> +               msg.address_lo = pp->ops->get_msi_addr(pp);
>         else
>                 msg.address_lo = virt_to_phys((void *)pp->msi_data);
>         msg.address_hi = 0x0;
> -       msg.data = pos;
> +
> +       if (pp->ops->get_msi_data)
> +               msg.data = pp->ops->get_msi_data(pp, pos);
> +       else
> +               msg.data = pos;
> +
>         write_msi_msg(irq, &msg);
>
>         return 0;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index daf81f9..7f08807 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -73,7 +73,8 @@ struct pcie_host_ops {
>         void (*host_init)(struct pcie_port *pp);
>         void (*msi_set_irq)(struct pcie_port *pp, int irq);
>         void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -       u32 (*get_msi_data)(struct pcie_port *pp);
> +       u32 (*get_msi_addr)(struct pcie_port *pp);
> +       u32 (*get_msi_data)(struct pcie_port *pp, int pos);
>  };
>
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

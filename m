Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33888 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbbHLPJM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:09:12 -0400
Received: by lbbtg9 with SMTP id tg9so11345885lbb.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 08:09:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439372036-15303-3-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	<1439372036-15303-3-git-send-email-l.stach@pengutronix.de>
Date: Wed, 12 Aug 2015 20:39:10 +0530
Message-ID: <CAHM4w1mnt__D-hOWqPFGHCYu5YFtVQqfAcYSb1Qdm4H6kbrKuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PCI: designware: factor out MSI msg setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Factor out the PCI MSI message setup from the single MSI setup
> function. This will be reused by the multivector MSI setup.
>
> No functional change yet.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be7181e..0ec435c56a8b 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -293,19 +293,9 @@ no_valid_irq:
>         return -ENOSPC;
>  }
>
> -static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> -                       struct msi_desc *desc)
> +static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
>  {
> -       int irq, pos;
>         struct msi_msg msg;
> -       struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> -
> -       if (desc->msi_attrib.is_msix)
> -               return -EINVAL;
> -
> -       irq = assign_irq(1, desc, &pos);
> -       if (irq < 0)
> -               return irq;
>
>         if (pp->ops->get_msi_addr)
>                 msg.address_lo = pp->ops->get_msi_addr(pp);
> @@ -319,6 +309,22 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>                 msg.data = pos;
>
>         pci_write_msi_msg(irq, &msg);
> +}
> +
> +static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> +                       struct msi_desc *desc)
> +{
> +       int irq, pos;
> +       struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +
> +       if (desc->msi_attrib.is_msix)
> +               return -EINVAL;
> +
> +       irq = assign_irq(1, desc, &pos);
> +       if (irq < 0)
> +               return irq;
> +
> +       dw_msi_setup_msg(pp, irq, pos);

I had thought of assign_irq also as part of new function with
an additional argument nvec.
But then dw_msi_setup_msg name would not be justified.So.

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

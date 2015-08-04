Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35776 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbHDPLR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 11:11:17 -0400
Received: by labsr2 with SMTP id sr2so9462713lab.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 08:11:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437662976-27188-2-git-send-email-l.stach@pengutronix.de>
References: <1437662976-27188-1-git-send-email-l.stach@pengutronix.de>
	<1437662976-27188-2-git-send-email-l.stach@pengutronix.de>
Date: Tue, 4 Aug 2015 20:41:15 +0530
Message-ID: <CAHM4w1=Sz1xJ1OGc9xAMVCv8hMLwnWmGrkRLHdqpdC7EgzEbpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: designware: implement multivector MSI irq setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	patchwork-lst@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 8:19 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Allows to set up and use multiple MSI irqs per device.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> The ifdef is needed to avoid a compile error on
> !CONFIG_PCI_MSI, as msi_list is only part of pci_dev
> when the kernel is compiled with MSI support.
>
> v2: move ifdeffery inside single function
> ---
>  drivers/pci/host/pcie-designware.c | 43 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be7181e..52c600327805 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -286,6 +286,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>         }
>
>         *pos = pos0;
> +       desc->nvec_used = no_irqs;
> +       desc->msi_attrib.multiple = order_base_2(no_irqs);
> +
>         return irq;
>
>  no_valid_irq:
> @@ -323,6 +326,45 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>         return 0;
>  }
>
> +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> +                            int nvec, int type)
> +{
> +#ifdef CONFIG_PCI_MSI
> +       int irq, pos;
> +       struct msi_desc *desc;
> +       struct msi_msg msg;
> +       struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +
> +       /* MSI-X interrupts are not supported */
> +       if (type == PCI_CAP_ID_MSIX)
> +               return -EINVAL;
> +
> +       WARN_ON(!list_is_singular(&pdev->msi_list));
> +       desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
> +

Probably existing function dw_msi_setup_irq() can be re-factored and code after
this line can be reused from refactored function, as they are almost same.

> +       irq = assign_irq(nvec, desc, &pos);
> +       if (irq < 0)
> +               return irq;
> +
> +       if (pp->ops->get_msi_addr)
> +               msg.address_lo = pp->ops->get_msi_addr(pp);
> +       else
> +               msg.address_lo = virt_to_phys((void *)pp->msi_data);
> +       msg.address_hi = 0x0;
> +

Although, not specific to this patch, but since we are now going to have
ARM64 support for DW as well, so it would be nice to fill msg.address_hi
with upper bytes rather hard-coding as 0.

> +       if (pp->ops->get_msi_data)
> +               msg.data = pp->ops->get_msi_data(pp, pos);
> +       else
> +               msg.data = pos;
> +
> +       pci_write_msi_msg(irq, &msg);
> +
> +       return 0;

~Pratyush

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38729 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbbCTWH6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 18:07:58 -0400
Received: by igbqf9 with SMTP id qf9so279841igb.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 15:07:57 -0700 (PDT)
Date: Fri, 20 Mar 2015 17:07:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] PCI: designware: implement multiple MSI irq setup
Message-ID: <20150320220753.GN26935@google.com>
References: <1425922388-30464-1-git-send-email-l.stach@pengutronix.de>
 <1425922388-30464-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425922388-30464-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 09, 2015 at 06:33:08PM +0100, Lucas Stach wrote:
> Allows to properly set up multiple MSI irqs per device.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> The ifdef is needed to avoid a compile error on
> !CONFIG_PCI_MSI, as msi_list is only part of pci_dev
> when the kernel is compiled with MSI support.
> ---
>  drivers/pci/host/pcie-designware.c | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 1f4ea6f2d910..8a15ea2e8eab 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -269,6 +269,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>  	}
>  
>  	*pos = pos0;
> +	desc->nvec_used = no_irqs;
> +	desc->msi_attrib.multiple = order_base_2(no_irqs);
> +
>  	return irq;
>  
>  no_valid_irq:
> @@ -305,6 +308,48 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>  
>  	return 0;
>  }
> +#ifdef CONFIG_PCI_MSI
> +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> +			     int nvec, int type)
> +{
> +	int irq, pos;
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +
> +	/* MSI-X interrupts are not supported */
> +	if (type == PCI_CAP_ID_MSIX)
> +		return -EINVAL;
> +
> +	WARN_ON(!list_is_singular(&pdev->msi_list));
> +	desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
> +
> +	irq = assign_irq(nvec, desc, &pos);
> +	if (irq < 0)
> +		return irq;
> +
> +	if (pp->ops->get_msi_addr)
> +		msg.address_lo = pp->ops->get_msi_addr(pp);
> +	else
> +		msg.address_lo = virt_to_phys((void *)pp->msi_data);
> +	msg.address_hi = 0x0;
> +
> +	if (pp->ops->get_msi_data)
> +		msg.data = pp->ops->get_msi_data(pp, pos);
> +	else
> +		msg.data = pos;
> +
> +	pci_write_msi_msg(irq, &msg);
> +
> +	return 0;
> +}
> +#else
> +static int dw_msi_setup_irqs(struct msi_chip *chip, struct pci_dev *pdev,
> +			     int nvec, int type)
> +{
> +	return -ENOSYS;
> +}

Seems strange that we need even this stub function when we don't have
CONFIG_PCI_MSI.  Is there some way we can fix this so dw_pcie_msi_chip is
only defined when we have CONFIG_PCI_MSI?

> +#endif
>  
>  static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>  {
> @@ -317,6 +362,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>  
>  static struct msi_controller dw_pcie_msi_chip = {
>  	.setup_irq = dw_msi_setup_irq,
> +	.setup_irqs = dw_msi_setup_irqs,
>  	.teardown_irq = dw_msi_teardown_irq,
>  };
>  
> -- 
> 2.1.4
> 

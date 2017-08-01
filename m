Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33267 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdHARNC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 13:13:02 -0400
Received: by mail-wr0-f180.google.com with SMTP id v105so9456002wrb.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 10:13:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN7O0+L8ergfE1_Thow2Lz+5UnhLvQO_LmEqhh=XqKfiu3m8XA@mail.gmail.com>
References: <CAN7O0+L8ergfE1_Thow2Lz+5UnhLvQO_LmEqhh=XqKfiu3m8XA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 1 Aug 2017 12:12:39 -0500
Message-ID: <CAErSpo58kndyFLOnq-85HK8NnYOG2mMkn3HzRP_+FKPY0La7AQ@mail.gmail.com>
Subject: Re: MSI-X support with Synopsys DesignWare IP core driver
To: vidya sagar <sagar.tv@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This was a multi-part message with HTML, which I think causes the
mailing list to automatically drop it.  Please post this as plain text
with a changelog and signed-off-by and copy the DesignWare maintainers
(Jingoo and Joao, cc'd).

On Tue, Aug 1, 2017 at 12:28 AM, vidya sagar <sagar.tv@gmail.com> wrote:
> Hi,
> As you might be knowing it already, in the current pcie-designware.c , there
> is no support for MSI-X
> Although there is no native support from Synopsys IP as well to have 2048
> interrupts, we can at least have basic support to get MSI-X also allocated
> (along with MSI) as many as possible in the system at that point. Of course,
> all these interrupts will have the same address to which downstream devices
> need to initiate mem-write transactions. Though it doesn't leverage one of
> the advantages of having MSI-X over MSI, it at least avoids drivers falling
> back to legacy interrupts when the card doesn't support MSI. Some of the
> Intel NVMe cards are examples here. Legacy interrupt being a shared
> interrupt, it unnecessarily triggers all other shared ISRs to be called
> whenever there is a legacy interrupt.
>
> I have the following patch which enables MSI-X support also. Would like to
> have your comments on this.
>
>
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> index af8f6e9..9086253 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -406,9 +406,6 @@ static int dw_msi_setup_irq(struct msi_controller *chip,
> struct pci_dev *pdev,
>      int irq, pos;
>      struct pcie_port *pp = pdev->bus->sysdata;
>
> -    if (desc->msi_attrib.is_msix)
> -        return -EINVAL;
> -
>      irq = assign_irq(1, desc, &pos);
>      if (irq < 0)
>          return irq;
> @@ -426,9 +423,16 @@ static int dw_msi_setup_irqs(struct msi_controller
> *chip, struct pci_dev *pdev,
>      struct msi_desc *desc;
>      struct pcie_port *pp = pdev->bus->sysdata;
>
> -    /* MSI-X interrupts are not supported */
> -    if (type == PCI_CAP_ID_MSIX)
> -        return -EINVAL;
> +    if (type == PCI_CAP_ID_MSIX) {
> +        for_each_pci_msi_entry(desc, pdev) {
> +            irq = arch_setup_msi_irq(pdev, desc);
> +            if (irq < 0)
> +                return irq;
> +            if (irq > 0)
> +                return -ENOSPC;
> +        }
> +        return 0;
> +    }
>
>      WARN_ON(!list_is_singular(&pdev->dev.msi_list));
>      desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
>

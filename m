Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:49535 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934161AbaFTHhp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jun 2014 03:37:45 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so3197770qcr.16
        for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2014 00:37:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com>
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
	<1399892270-25021-2-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 20 Jun 2014 09:37:44 +0200
Message-ID: <CAG374jDD+yUiBgJFpkmpgAa+Z7+v+ANo6V90YQnhTuftm2np+Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: host: rcar: Add Renesas R-Car PCIe driver
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

Just a question...

On 12 May 2014 12:57, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> This PCIe Host driver currently does not support MSI, so cards
> fall back to INTx interrupts.
>

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/pci/host/Kconfig     |   6 +
>  drivers/pci/host/Makefile    |   1 +
>  drivers/pci/host/pcie-rcar.c | 768 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 775 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rcar.c
>
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> new file mode 100644
> index 0000000..3c524b9
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rcar.c

> +static void rcar_pcie_enable(struct rcar_pcie *pcie)
> +{
> +       struct platform_device *pdev = to_platform_device(pcie->dev);
> +
> +       rcar_pci.nr_controllers = 1;
> +       rcar_pci.private_data = (void **)&pcie;
> +
> +       pci_common_init_dev(&pdev->dev, &rcar_pci);
> +#ifdef CONFIG_PCI_DOMAINS
> +       rcar_pci.domain++;
> +#endif
> +}
> +

How does it work when you have 2 PCIe DT node ?
(because for my point of view pci_common_init_dev() can't be called twice)

void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
{
    struct pci_sys_data *sys;
    LIST_HEAD(head);

    pci_add_flags(PCI_REASSIGN_ALL_RSRC);
    if (hw->preinit)
        hw->preinit();
    pcibios_init_hw(parent, hw, &head);
...

static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
                struct list_head *head)
{
    struct pci_sys_data *sys = NULL;
    int ret;
    int nr, busnr;

    for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
        sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
        if (!sys)
            panic("PCI: unable to allocate sys data!");

#ifdef CONFIG_PCI_DOMAINS
        sys->domain  = hw->domain;
#endif
        sys->busnr   = busnr;
...

the issue is that sys->busnr always starts to zero ...

how did you fix this problem?

Thanks.
Best Regards

Gabriel.

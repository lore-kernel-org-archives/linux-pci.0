Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33372 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483AbbFDWHS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:07:18 -0400
Received: by qkhg32 with SMTP id g32so31489635qkh.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:07:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Jun 2015 17:06:57 -0500
Message-ID: <CAErSpo6=-s7gZx8dC7JfEtPeL6p-ep97AS8n7EDewvh79dzehw@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: imx6: Rename imx6_pcie_start_link() to imx6_pcie_establish_link()
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[oops, sorry, I used Pratyush's old email address.  I just forwarded
them to his updated address, but if you respond to any of these
patches, please update his address to "Pratyush Anand
<pratyush.anand@gmail.com>"]

On Thu, Jun 4, 2015 at 5:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Rename imx6_pcie_start_link() to imx6_pcie_establish_link() to follow the
> convention of other DesignWare-based host drivers.  No functional change.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-imx6.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..8cc0123 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -359,7 +359,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
>         return dw_handle_msi_irq(pp);
>  }
>
> -static int imx6_pcie_start_link(struct pcie_port *pp)
> +static int imx6_pcie_establish_link(struct pcie_port *pp)
>  {
>         struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>         uint32_t tmp;
> @@ -432,7 +432,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>
>         dw_pcie_setup_rc(pp);
>
> -       imx6_pcie_start_link(pp);
> +       imx6_pcie_establish_link(pp);
>
>         if (IS_ENABLED(CONFIG_PCI_MSI))
>                 dw_pcie_msi_init(pp);
>

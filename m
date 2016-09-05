Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34382 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbcIEDMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2016 23:12:38 -0400
Received: by mail-vk0-f65.google.com with SMTP id x187so2773849vkx.1
        for <linux-pci@vger.kernel.org>; Sun, 04 Sep 2016 20:11:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160823221001.16374.62205.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160823221001.16374.62205.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Mon, 5 Sep 2016 08:41:47 +0530
Message-ID: <CAHM4w1kNY9iavDjm2OtDn8tTA3G9Gx_L=L7jU+RsNhq=E3fUDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: designware: Rename dw_pcie_valid_config() to dw_pcie_valid_device()
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>, Jingoo Han <jingoohan1@gmail.com>,
        rfi@lists.rocketboards.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 24, 2016 at 3:40 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Rename dw_pcie_valid_config() to dw_pcie_valid_device() and use the result
> directly as a boolean value instead of testing against 0.
>
> No functional change intended; for readability only.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

> ---
>  drivers/pci/host/pcie-designware.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 12afce1..d09f376 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -657,8 +657,8 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>         return ret;
>  }
>
> -static int dw_pcie_valid_config(struct pcie_port *pp,
> -                               struct pci_bus *bus, int dev)
> +static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
> +                               int dev)
>  {
>         /* If there is no link, then there is no device */
>         if (bus->number != pp->root_bus_nr) {
> @@ -685,7 +685,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  {
>         struct pcie_port *pp = bus->sysdata;
>
> -       if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> +       if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
>                 *val = 0xffffffff;
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>         }
> @@ -701,7 +701,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  {
>         struct pcie_port *pp = bus->sysdata;
>
> -       if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> +       if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>
>         if (bus->number == pp->root_bus_nr)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

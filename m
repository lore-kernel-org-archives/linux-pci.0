Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36398 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdI0I4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 04:56:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170923061841.6123-1-treding@nvidia.com>
References: <20170923061841.6123-1-treding@nvidia.com>
From: vidya sagar <sagar.tv@gmail.com>
Date: Wed, 27 Sep 2017 14:26:04 +0530
Message-ID: <CAN7O0+LZFJJJmw8gXXEkHjuUhtCJeynjxitqDiLS902NJSr7dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: tegra: Use generic accessors where possible
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 23, 2017 at 11:48 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> The Tegra PCI host controller can generate configuration space accesses
> with byte, word and dword granularity for devices. Only root ports can't
> have their configuration space accessed in this way.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 9c40da54f88a..e8e1ddbaabc9 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -491,12 +491,32 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>         return addr;
>  }
>
> +static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +                                 int where, int size, u32 *value)
> +{
> +       if (bus->number == 0)
> +               return pci_generic_config_read32(bus, devfn, where, size,
> +                                                value);
> +
> +       return pci_generic_config_read(bus, devfn, where, size, value);

Since T20, T30 and T124 had issues with 8-bit and 16-bit end point
config accesses, generic accessors should be used only for T210

> +}
> +
> +static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +                                  int where, int size, u32 value)
> +{
> +       if (bus->number == 0)
> +               return pci_generic_config_write32(bus, devfn, where, size,
> +                                                 value);
> +
> +       return pci_generic_config_write(bus, devfn, where, size, value);

same as above.

> +}
> +
>  static struct pci_ops tegra_pcie_ops = {
>         .add_bus = tegra_pcie_add_bus,
>         .remove_bus = tegra_pcie_remove_bus,
>         .map_bus = tegra_pcie_map_bus,
> -       .read = pci_generic_config_read32,
> -       .write = pci_generic_config_write32,
> +       .read = tegra_pcie_config_read,
> +       .write = tegra_pcie_config_write,
>  };
>
>  static unsigned long tegra_pcie_port_get_pex_ctrl(struct tegra_pcie_port *port)
> --
> 2.14.1
>

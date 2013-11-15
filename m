Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47507 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3KOVQm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 16:16:42 -0500
Received: by mail-ie0-f172.google.com with SMTP id to1so5743835ieb.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2013 13:16:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384548866-13141-9-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org> <1384548866-13141-9-git-send-email-swarren@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Nov 2013 14:16:21 -0700
Message-ID: <CAErSpo7ZP-1qkBYjdNYRPz3Z3rHL_tUOY3fNi4nvTfFmcdEEOQ@mail.gmail.com>
Subject: Re: [PATCH 08/31] pci: tegra: use reset framework
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com,
	pdeschrijver@nvidia.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 15, 2013 at 1:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
>
> The old Tegra-specific API used a struct clock to represent the module
> to reset. Some of the clocks retrieved during probe() were only used for
> reset purposes, and indeed aren't even true clocks. So, there's no need
> to get() them any more.
>
> Cc: treding@nvidia.com
> Cc: pdeschrijver@nvidia.com
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Feel free to merge this through whatever tree is appropriate.  If I
were applying this, I would be looking for an ack from Thierry in
addition to mine.

> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/pci/host/pci-tegra.c | 49 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 0afbbbc55c81..174a5bc2d993 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -39,6 +39,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/tegra-cpuidle.h>
> @@ -259,10 +260,13 @@ struct tegra_pcie {
>
>         struct clk *pex_clk;
>         struct clk *afi_clk;
> -       struct clk *pcie_xclk;
>         struct clk *pll_e;
>         struct clk *cml_clk;
>
> +       struct reset_control *pex_rst;
> +       struct reset_control *afi_rst;
> +       struct reset_control *pcie_xrst;
> +
>         struct tegra_msi msi;
>
>         struct list_head ports;
> @@ -858,7 +862,7 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>         pads_writel(pcie, value, PADS_CTL);
>
>         /* take the PCIe interface module out of reset */
> -       tegra_periph_reset_deassert(pcie->pcie_xclk);
> +       reset_control_deassert(pcie->pcie_xrst);
>
>         /* finally enable PCIe */
>         value = afi_readl(pcie, AFI_CONFIGURATION);
> @@ -891,9 +895,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>
>         /* TODO: disable and unprepare clocks? */
>
> -       tegra_periph_reset_assert(pcie->pcie_xclk);
> -       tegra_periph_reset_assert(pcie->afi_clk);
> -       tegra_periph_reset_assert(pcie->pex_clk);
> +       reset_control_assert(pcie->pcie_xrst);
> +       reset_control_assert(pcie->afi_rst);
> +       reset_control_assert(pcie->pex_rst);
>
>         tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>
> @@ -921,9 +925,9 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>         const struct tegra_pcie_soc_data *soc = pcie->soc_data;
>         int err;
>
> -       tegra_periph_reset_assert(pcie->pcie_xclk);
> -       tegra_periph_reset_assert(pcie->afi_clk);
> -       tegra_periph_reset_assert(pcie->pex_clk);
> +       reset_control_assert(pcie->pcie_xrst);
> +       reset_control_assert(pcie->afi_rst);
> +       reset_control_assert(pcie->pex_rst);
>
>         tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>
> @@ -958,7 +962,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>                 return err;
>         }
>
> -       tegra_periph_reset_deassert(pcie->afi_clk);
> +       reset_control_deassert(pcie->afi_rst);
>
>         err = clk_prepare_enable(pcie->afi_clk);
>         if (err < 0) {
> @@ -996,10 +1000,6 @@ static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
>         if (IS_ERR(pcie->afi_clk))
>                 return PTR_ERR(pcie->afi_clk);
>
> -       pcie->pcie_xclk = devm_clk_get(pcie->dev, "pcie_xclk");
> -       if (IS_ERR(pcie->pcie_xclk))
> -               return PTR_ERR(pcie->pcie_xclk);
> -
>         pcie->pll_e = devm_clk_get(pcie->dev, "pll_e");
>         if (IS_ERR(pcie->pll_e))
>                 return PTR_ERR(pcie->pll_e);
> @@ -1013,6 +1013,23 @@ static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
>         return 0;
>  }
>
> +static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
> +{
> +       pcie->pex_rst = devm_reset_control_get(pcie->dev, "pex");
> +       if (IS_ERR(pcie->pex_rst))
> +               return PTR_ERR(pcie->pex_rst);
> +
> +       pcie->afi_rst = devm_reset_control_get(pcie->dev, "afi");
> +       if (IS_ERR(pcie->afi_rst))
> +               return PTR_ERR(pcie->afi_rst);
> +
> +       pcie->pcie_xrst = devm_reset_control_get(pcie->dev, "pcie_x");
> +       if (IS_ERR(pcie->pcie_xrst))
> +               return PTR_ERR(pcie->pcie_xrst);
> +
> +       return 0;
> +}
> +
>  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  {
>         struct platform_device *pdev = to_platform_device(pcie->dev);
> @@ -1025,6 +1042,12 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>                 return err;
>         }
>
> +       err = tegra_pcie_resets_get(pcie);
> +       if (err) {
> +               dev_err(&pdev->dev, "failed to get resets: %d\n", err);
> +               return err;
> +       }
> +
>         err = tegra_pcie_power_on(pcie);
>         if (err) {
>                 dev_err(&pdev->dev, "failed to power up: %d\n", err);
> --
> 1.8.1.5
>

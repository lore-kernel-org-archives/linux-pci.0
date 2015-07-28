Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1438080345-7233-4-git-send-email-lftan@altera.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-4-git-send-email-lftan@altera.com>
Date: Tue, 28 Jul 2015 11:45:50 -0500
Message-ID: <CADhT+weU=VB=fQxXsXeF-0WjQj5rofeCDhV1LfbFWOm-7Oem0w@mail.gmail.com>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
From: Dinh Nguyen <dinh.linux@gmail.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Linux List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 5:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
> This patch adds the Altera PCIe host controller driver.
>
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  drivers/pci/host/Kconfig       |   9 +
>  drivers/pci/host/Makefile      |   1 +
>  drivers/pci/host/pcie-altera.c | 576 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 586 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-altera.c
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 675c2d1..af19039 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -145,4 +145,13 @@ config PCIE_IPROC_BCMA
>           Say Y here if you want to use the Broadcom iProc PCIe controller
>           through the BCMA bus interface
>
> +config PCIE_ALTERA
> +       bool "Altera PCIe controller"
> +       depends on ARCH_SOCFPGA
> +       depends on OF

I don't think you need this, "depends on ARCH_SOCFPGA" should already
have taken care of this.

> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> +       help
> +         Say Y here if you want to enable PCIe controller support for Altera
> +         SoCFPGA family of SoCs.
> +
>  endmenu

<snip>

> +
> +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> +{
> +       u8 loop;
> +       struct tlp_rp_regpair_t tlp_rp_regdata;
> +
> +       for (loop = TLP_LOOP; loop > 0; loop--) {
> +
> +               tlp_read_rx(pcie, &tlp_rp_regdata);
> +
> +               if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
> +
> +                       if (value)
> +                               *value = tlp_rp_regdata.reg0;
> +
> +                       return PCIBIOS_SUCCESSFUL;
> +               }

Remove all the unnecessary newlines in this function.
> +       }
> +
> +       return -ENOENT;
> +}
> +

<snip>

> +
> +static struct platform_driver altera_pcie_driver = {
> +       .probe          = altera_pcie_probe,
> +       .remove         = altera_pcie_remove,
> +       .driver = {
> +               .name   = "altera-pcie",
> +               .owner  = THIS_MODULE,

Don't need to set owner anymore as this will get populated by the driver core.

Dinh

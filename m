Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
From: Dmitry Shmidt <dimitrysh@google.com>
Date: Tue, 8 May 2018 14:31:02 -0700
Message-ID: <CAH7ZN-zOwCqzzmKxkCeLt+z2FCpMrxnu5a8s8Os-fSsuS2R01w@mail.gmail.com>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
To: Yao Chen <chenyao11@huawei.com>
Cc: songxiaowei <songxiaowei@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-pci@vger.kernel.org,
        "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>,
        "<linux-arm-kernel@lists.infradead.org>"
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Guodong Xu <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 8, 2018 at 12:03 AM, Yao Chen <chenyao11@huawei.com> wrote:
> This patch adds kirin pcie msi feature.
>
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
>  drivers/pci/dwc/pcie-kirin.c              | 38 +++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ec3eb8e..4ef684f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -872,6 +872,8 @@
>                                   0x0 0x02000000>;
>                         num-lanes = <1>;
>                         #interrupt-cells = <1>;
> +                       interrupts = <0 283 4>;
> +                       interrupts-names = "msi";

Possible typo? Should be interrupt-names = "msi";

>                         interrupt-map-mask = <0xf800 0 0 7>;
>                         interrupt-map = <0x0 0 0 1
>                                          &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a0..2319c9c 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
>         return 0;
>  }
>
> +static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +       struct pcie_port *pp = arg;
> +
> +       return dw_handle_msi_irq(pp);
> +}
> +
> +static void kirin_pcie_msi_init(struct pcie_port *pp)
> +{
> +       dw_pcie_msi_init(pp);
> +}
> +
> +static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
> +{
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               kirin_pcie_msi_init(pp);
> +}
> +
>  static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>         kirin_pcie_establish_link(pp);
> +       kirin_pcie_enable_interrupts(pp);
>
>         return 0;
>  }
> @@ -448,6 +467,25 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>                                       struct platform_device *pdev)
>  {
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +               if (!pci->pp.msi_irq) {
> +                       dev_err(&pdev->dev, "failed to get msi irq\n");
> +                       return -ENODEV;
> +               }
> +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +                                      kirin_pcie_msi_irq_handler,
> +                                      IRQF_SHARED | IRQF_NO_THREAD,
> +                                      "kirin_pcie_msi", &pci->pp);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to request msi irq\n");
> +                       return ret;
> +               }
> +       }
> +
> +       pci->pp.root_bus_nr = -1;
>         pci->pp.ops = &kirin_pcie_host_ops;
>
>         return dw_pcie_host_init(&pci->pp);
> --
> 1.9.1
>

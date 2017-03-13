Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E2047A8C1@FRAEML521-MBX.china.huawei.com>
References: <20170310174045.GB24571@leverpostej> <EE11001F9E5DDD47B7634E2F8A612F2E2047A8C1@FRAEML521-MBX.china.huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Mar 2017 09:48:51 +0100
Message-ID: <CAMuHMdWcs_X-T=0zSTB5R0s-f8uk3MbKNj4-62XMGDXb-jO1iQ@mail.gmail.com>
Subject: Re: Bad DT binding (hisi-pcie-almost-ecam)
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 9:14 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> About the name to use here from what you suggest we should use
> "hisilicon,hip06-pcie-almost-ecam" and re-use it for hip07 SoC.
> To be honest I would prefer it either as it is now or to modify the
> driver as:
>
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index 52f1e3f..7527b4c 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -381,7 +381,11 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {
>
>   static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
>          {
> -           .compatible = "hisilicon,pcie-almost-ecam",
> +         .compatible = "hisilicon,pcie-almost-ecam-hip06",

Shouldn't that be "hisilicon,hip06-pcie-almost-ecam"?

> +         .data           = (void *) &hisi_pcie_platform_ops,
> + },
> + {
> +         .compatible = "hisilicon,pcie-almost-ecam-hip07",

Shouldn't that be "hisilicon,hip07-pcie-almost-ecam"?

>                  .data       = (void *) &hisi_pcie_platform_ops,
>          },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

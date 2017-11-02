Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46164 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdKBJN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 05:13:26 -0400
MIME-Version: 1.0
In-Reply-To: <20171031223936.27549-15-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com> <20171031223936.27549-15-niklas.cassel@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Nov 2017 10:13:25 +0100
Message-ID: <CAK8P3a1yGwyZPzd2-usqLe=BiQpdFsyyFOhpP1ZyaCb16rzCSQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] PCI: dwc: artpec6: Add support for endpoint mode
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 31, 2017 at 11:39 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

It seems like you are missing a changelog text. Please explain what
your work is good for
in any patch you send.

> V3:
> * Removed ifdefs around match table and match table data.
> * Removed ifdefs in probe, use dummy implementations instead.

I think there is room for more of the same ;-)

>
> +#ifdef CONFIG_PCIE_ARTPEC6_HOST
>  static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
>  {
>         struct dw_pcie *pci = artpec6_pcie->pci;
> @@ -231,11 +257,92 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>
>         return 0;
>  }
> +#else
> +static inline int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
> +                                       struct platform_device *pdev)
> +{
> +       return -ENODEV;
> +}
> +#endif


Can you try replacing the #ifdef with


        if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
                 return -ENODEV;

at the start of artpec6_pcie_enable_interrupts? I think that would improve
readability here.

> +static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
> +                              struct platform_device *pdev)
> +{
> +       int ret;
> +       struct dw_pcie_ep *ep;
> +       struct resource *res;
> +       struct device *dev = &pdev->dev;
> +       struct dw_pcie *pci = artpec6_pcie->pci;

The same trick should work here with the other symbol.

        Arnd

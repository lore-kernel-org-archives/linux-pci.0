Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170512015105.32653-1-songxiaowei@hisilicon.com>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 May 2017 22:29:17 +0200
Message-ID: <CAK8P3a0MFBW9NGN6oanH+x0YzbXznjUfk0B-pd_Fh-+8+5W3iA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin SoC
To: Song Xiaowei <songxiaowei@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>, niklas.cassel@axis.com,
        Duc Dang <dhdang@apm.com>, liudongdong3@huawei.com,
        puck.chen@hisilicon.com, Guodong Xu <guodong.xu@linaro.org>,
        wangbinghui@hisilicon.com, suzhuangluan@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 12, 2017 at 3:51 AM, Song Xiaowei <songxiaowei@hisilicon.com> wrote:
> From: songxiaowei <songxiaowei@hisilicon.com>

Looks good overall, just a few details:

Please fix your ~/.gitconfig to contain the same real name ("Song Xiaowei"
instead of "songxiaowei") that you use for sending the emails.

> +
> +static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> +{
...
> +       reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
> +       while (reg_val & pipe_clk_stable) {
> +               udelay(100);
> +               if (time == 0) {
> +                       dev_err(kirin_pcie->pci->dev, "PIPE clk is not stable\n");
> +                       return -EINVAL;
> +               }
> +               time--;
> +               reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
> +       }

If this is not called with interrupts disabled, please use a
sleeping function (e.g. msleep(1)) as the delay and compare
against ktime_before() to see how much total time has expired
when waiting for a timeout, instead of using a counter.

> diff --git a/drivers/pci/dwc/pcie-kirin.h b/drivers/pci/dwc/pcie-kirin.h
> new file mode 100644
> index 000000000000..ad9a3b427298
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-kirin.h
> @@ -0,0 +1,79 @@
> +/*
> + * PCIe host controller driver for Kirin 960 SoCs
> + *
> + * Copyright (C) 2015 Huawei Electronics Co., Ltd.
> + *             http://www.huawei.com
> + *
> + * Author: Xiaowei Song <songxiaowei@huawei.com>

The header is only used in one .c file, so just remove it and
add the contents to that file.

    Arnd

Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Wed, 31 Aug 2016 13:45:24 +0200
Message-ID: <4925807.5nZM1s8II1@wuerfel>
In-Reply-To: <1472644094-82731-2-git-send-email-liudongdong3@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <1472644094-82731-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
> +
> +/* HipXX PCIe host only supports 32-bit config access */
> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
> +                             u32 *val)
> +{
> +       u32 reg;
> +       u32 reg_val;
> +       void *walker = &reg_val;
> +
> +       walker += (where & 0x3);
> +       reg = where & ~0x3;
> +       reg_val = readl(reg_base + reg);
> +
> +       if (size == 1)
> +               *val = *(u8 __force *) walker;
> +       else if (size == 2)
> +               *val = *(u16 __force *) walker;

What is the __force for?

> +       else if (size == 4)
> +               *val = reg_val;
> +       else
> +               return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +       return PCIBIOS_SUCCESSFUL;

It looks like you are reimplementing pci_generic_config_read32/pci_generic_config_write32
read here, better use them directly.

	Arnd

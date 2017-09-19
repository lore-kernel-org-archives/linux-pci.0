Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33674 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdISM3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2017 08:29:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170919104939.3313-1-lorenzo.pieralisi@arm.com>
References: <20170919104939.3313-1-lorenzo.pieralisi@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Sep 2017 14:29:05 +0200
Message-ID: <CAK8P3a3C=hD3Goo_=aCwWWUA_mAAPBL1Oii94Ed1y=cK6hiG8w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix PCI host bridge map_irq() hook section mismatches
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steve French <smfrench@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 19, 2017 at 12:49 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Commit 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
> bridge IRQ mapping hooks") allowed to move the PCI irq fixup to the new
> host bridge map/swizzle_irq() hooks mechanism. Those hooks can also be
> called after boot completed - with all __init/__initdata/__initconst
> sections freed by the kernel -  therefore functions called by them (and
> the data they refer to) must not be marked as
> __init/__initdata/__initconst lest compilation triggers section
> mismatches warnings.
>
> Fix all the boards files map_irq() hooks by simply removing the
> respective __init/__initdata/__initconst section markers and by
> adding another persistent hook IRQ map for the txx9 board files.
>
> Fixes: 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
> bridge IRQ mapping hooks")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Aside from one typo

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
> index 0bd2a1e..499da2d 100644
> --- a/arch/mips/txx9/generic/pci.c
> +++ b/arch/mips/txx9/generic/pci.c
> @@ -386,9 +386,10 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>         return 0;
>  }
>
> -int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +static int (*txx9_pci_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> +int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
> -       return txx9_board_vec->pci_map_irq(dev, slot, pin);
> +       return txx9_map_irq(dev, slot, pin);
>  }
>
>  char * (*txx9_board_pcibios_setup)(char *str) __initdata;

s/pcibios_map_irq/txx9_pci_map_irq/

      Arnd

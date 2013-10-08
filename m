Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45161 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab3JHXOy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 19:14:54 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so17098ieb.40
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 16:14:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380929453-15428-3-git-send-email-dengcheng.zhu@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com> <1380929453-15428-3-git-send-email-dengcheng.zhu@imgtec.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 17:14:33 -0600
Message-ID: <CAErSpo4mWXhfgvxWkYtD6GqtuSHZ26HZ0vTnf5NTZo6W+U04LQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/quirks: Rename piix4_[io|mem]_quirk to add acpi
To: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <james.hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 4, 2013 at 5:30 PM, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com> wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> Rename piix4_[io|mem]_quirk to piix4_acpi_[io|mem]_quirk because these 2
> functions only deal with the function 3 (power management) of PIIX4.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

I don't really see the point in patches 2-4.  We end up with 50 more
lines of code.  Most of this is new #defines.  They do add names where
before we only had numbers, which *sounds* attractive, but it looks
like each #define is used only once, and it's in chipset-dependent
code where a careful reader has to compare every line with the spec
anyway.  Adding a #define means you have to look at the definition,
the use, and the spec.  Without the #define, you only have to look at
the code and the spec.  I don't think it's worth it.

Bjorn

> ---
>  drivers/pci/quirks.c |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3e7e489..a2b66c3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -380,7 +380,8 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,     PCI_DEVICE_ID_AL_M7101,         quirk_ali7101_acpi);
>
> -static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
> +static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
> +                               unsigned int port, unsigned int enable)
>  {
>         u32 devres;
>         u32 mask, size, base;
> @@ -406,7 +407,8 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
>         dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base, base + size - 1);
>  }
>
> -static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
> +static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
> +                                unsigned int port, unsigned int enable)
>  {
>         u32 devres;
>         u32 mask, size, base;
> @@ -447,23 +449,23 @@ static void quirk_piix4_acpi(struct pci_dev *dev)
>         /* Device resource A has enables for some of the other ones */
>         pci_read_config_dword(dev, 0x5c, &res_a);
>
> -       piix4_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
> -       piix4_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
> +       piix4_acpi_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
> +       piix4_acpi_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
>
>         /* Device resource D is just bitfields for static resources */
>
>         /* Device 12 enabled? */
>         if (res_a & (1 << 29)) {
> -               piix4_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
> -               piix4_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
> +               piix4_acpi_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
> +               piix4_acpi_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
>         }
>         /* Device 13 enabled? */
>         if (res_a & (1 << 30)) {
> -               piix4_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
> -               piix4_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
> +               piix4_acpi_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
> +               piix4_acpi_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
>         }
> -       piix4_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
> -       piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
> +       piix4_acpi_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
> +       piix4_acpi_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,  PCI_DEVICE_ID_INTEL_82371AB_3,  quirk_piix4_acpi);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,  PCI_DEVICE_ID_INTEL_82443MX_3,  quirk_piix4_acpi);
> --
> 1.7.1
>
>

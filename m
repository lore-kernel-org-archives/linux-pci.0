Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:65459 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934735Ab3E1RZw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 13:25:52 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so10317613oag.37
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 10:25:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369728226-25936-1-git-send-email-wangyijing@huawei.com>
References: <1369728226-25936-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 11:25:31 -0600
Message-ID: <CAErSpo4VU2+vTLBQNtzfJD-GQ1uxJkL61Fanrn8+Bv6pHBminQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Replace printks with appropriate pr_*()
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 2:03 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Replace deprecated printk(KERN_ERR...) with pr_err() in pci-acpi.c
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pci-acpi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied to pci/misc for v3.11, thanks.

> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e4b1fb2..6c15d6a 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -376,12 +376,12 @@ static int __init acpi_pci_init(void)
>         int ret;
>
>         if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
> -               printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
> +               pr_info("ACPI FADT declares the system doesn't support MSI, so disable it\n");
>                 pci_no_msi();
>         }
>
>         if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
> -               printk(KERN_INFO"ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
> +               pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
>                 pcie_no_aspm();
>         }
>
> --
> 1.7.1
>
>

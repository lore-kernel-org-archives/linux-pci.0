Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33224 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab3FCVJu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 17:09:50 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so8249586obb.14
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2013 14:09:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370265391-18236-1-git-send-email-jiang.liu@huawei.com>
References: <CAErSpo5mtYxWkVn+DTT4Sswp0RkWBM=prhtViMJ+KoLpOMY1hw@mail.gmail.com>
 <1370265391-18236-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 3 Jun 2013 15:09:29 -0600
Message-ID: <CAErSpo7ZU4GY+3iZA=R7oGyzk8oCwVtpmYjODH6=Ts65tJC88Q@mail.gmail.com>
Subject: Re: [PATCH] PCI, ACPI: use dev_printk() to keep messages consistent
To: Jiang Liu <liuj97@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 3, 2013 at 7:16 AM, Jiang Liu <liuj97@gmail.com> wrote:
> As pointed out by Bjorn that acpi_handle_printk() generates messages
> like "ACPI: \_SB_.PCI0: xxxxx" and dev_printk() generates messages
> like "acpi PNP0A08:00: xxxx", so use dev_printk() to keep messages
> consistent when possible.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> Hi Bjorn,
>         Could you please help to fold this patch onto "PCI/ACPI: Use
> acpi_handle_print() and pr_xxx() to print messages" of branch
> "pci/jiang-remove-global-list"?

Done.  I also changed one acpi_handle_print() in
handle_root_bridge_insertion() where we do have a device.  This is in
my "next" branch for v3.11.

Thanks!

>  drivers/acpi/pci_root.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 73a934d..4a8f5b4 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -388,7 +388,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>         status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
>                                        &segment);
>         if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -               acpi_handle_err(handle, "can't evaluate _SEG\n");
> +               dev_err(&device->dev,  "can't evaluate _SEG\n");
>                 result = -ENODEV;
>                 goto end;
>         }
> @@ -404,8 +404,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
>                  * can do is assume [_BBN-0xFF] or [0-0xFF].
>                  */
>                 root->secondary.end = 0xFF;
> -               acpi_handle_warn(handle,
> -                                FW_BUG "no secondary bus range in _CRS\n");
> +               dev_warn(&device->dev,
> +                        FW_BUG "no secondary bus range in _CRS\n");
>                 status = acpi_evaluate_integer(handle, METHOD_NAME__BBN,
>                                                NULL, &bus);
>                 if (ACPI_SUCCESS(status))
> @@ -413,7 +413,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>                 else if (status == AE_NOT_FOUND)
>                         root->secondary.start = 0;
>                 else {
> -                       acpi_handle_err(handle, "can't evaluate _BBN\n");
> +                       dev_err(&device->dev, "can't evaluate _BBN\n");
>                         result = -ENODEV;
>                         goto end;
>                 }
> @@ -451,9 +451,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
>          */
>         root->bus = pci_acpi_scan_root(root);
>         if (!root->bus) {
> -               acpi_handle_err(handle,
> -                           "Bus %04x:%02x not present in PCI namespace\n",
> -                           root->segment, (unsigned int)root->secondary.start);
> +               dev_err(&device->dev,
> +                       "Bus %04x:%02x not present in PCI namespace\n",
> +                       root->segment, (unsigned int)root->secondary.start);
>                 result = -ENODEV;
>                 goto end;
>         }
> @@ -511,8 +511,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
>                                 "ACPI _OSC request failed (%s), "
>                                 "returned control mask: 0x%02x\n",
>                                 acpi_format_exception(status), flags);
> -                       acpi_handle_info(handle,
> -                                        "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
> +                       dev_info(&device->dev,
> +                                "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
>                         pcie_no_aspm();
>                 }
>         } else {
> --
> 1.8.1.2
>

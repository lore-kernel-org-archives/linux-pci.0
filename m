Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49994 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab2ILT7n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2012 15:59:43 -0400
Received: by lbbgj3 with SMTP id gj3so1442072lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2012 12:59:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1347459869-5709-1-git-send-email-jiang.liu@huawei.com>
References: <CAErSpo5ZQmzusUMuB7TobCH-Bzw=r78h8SGQ88-WqaH7nRSXkQ@mail.gmail.com>
 <1347459869-5709-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Sep 2012 13:59:21 -0600
Message-ID: <CAErSpo6tKygUM3LrAC7a48aY2AQFmD0T-eR5Z76_ULwey1pv0w@mail.gmail.com>
Subject: Re: [PATCH] eeepc-laptop: fix device reference count leakage in eeepc_rfkill_hotplug()
To: Jiang Liu <liuj97@gmail.com>
Cc: huxinwei@huawei.com, Jiang Liu <jiang.liu@huawei.com>,
	linux-pci@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>,
	Matthew Garrett <mjg@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2012 at 8:24 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Fix a device reference count leakage issue in function
> eeepc_rfkill_hotplug().

This looks good to me, but it needs a Signed-off-by and probably
should go through something other than the PCI tree.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/platform/x86/eeepc-laptop.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index dab91b4..5ca2641 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -610,12 +610,12 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>
>                 if (!bus) {
>                         pr_warn("Unable to find PCI bus 1?\n");
> -                       goto out_unlock;
> +                       goto out_put_dev;
>                 }
>
>                 if (pci_bus_read_config_dword(bus, 0, PCI_VENDOR_ID, &l)) {
>                         pr_err("Unable to read PCI config space?\n");
> -                       goto out_unlock;
> +                       goto out_put_dev;
>                 }
>
>                 absent = (l == 0xffffffff);
> @@ -627,7 +627,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>                                 absent ? "absent" : "present");
>                         pr_warn("skipped wireless hotplug as probably "
>                                 "inappropriate for this model\n");
> -                       goto out_unlock;
> +                       goto out_put_dev;
>                 }
>
>                 if (!blocked) {
> @@ -635,7 +635,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>                         if (dev) {
>                                 /* Device already present */
>                                 pci_dev_put(dev);
> -                               goto out_unlock;
> +                               goto out_put_dev;
>                         }
>                         dev = pci_scan_single_device(bus, 0);
>                         if (dev) {
> @@ -650,6 +650,8 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>                                 pci_dev_put(dev);
>                         }
>                 }
> +out_put_dev:
> +               pci_dev_put(port);
>         }
>
>  out_unlock:
> --
> 1.7.9.5
>

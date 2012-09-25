Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61982 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab2IYIf2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:35:28 -0400
MIME-Version: 1.0
In-Reply-To: <1348561590-28067-11-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	<1348561590-28067-11-git-send-email-yinghai@kernel.org>
Date: Tue, 25 Sep 2012 16:35:27 +0800
Message-ID: <CAOLK0pzmP6bZqPJTi6h2XqbX72gb79VKMYObegP1X3xmEX3TJA@mail.gmail.com>
Subject: Re: [PATCH 10/29] PCI, USB: remove find_bridge in acpi_bus_type
From: Lan Tianyu <lantianyu1986@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2012/9/25 Yinghai Lu <yinghai@kernel.org>:
> The struct member is not used anymore, remove it.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/core/usb-acpi.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 8947b20..a6ea613 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -102,7 +102,6 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
>
>  static struct acpi_bus_type usb_acpi_bus = {
>         .bus = &usb_bus_type,
> -       .find_bridge = NULL,
>         .find_device = usb_acpi_find_device,
>  };
>
HI Yinghai:
                 This member has been populated in the usb-next tree.

http://git.kernel.org/?p=linux/kernel/git/gregkh/usb.git;a=commit;h=d557542421da643358201664903e67fd01dfca1a
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Best regards
Tianyu Lan
